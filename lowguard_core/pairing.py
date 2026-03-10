import secrets
import time
import json
import os
from fastapi import APIRouter, HTTPException, Depends, Header
from pydantic import BaseModel
from typing import Optional
import hmac
import hashlib
from datetime import datetime
import qrcode
import io
import base64
from zeroconf import IPVersion, ServiceInfo, Zeroconf
import socket
from .device_registry import get_mqtt_client

router = APIRouter(prefix="/pair", tags=["pairing"])

TOKENS_FILE = "pairing_tokens.json"
DEVICES_FILE = "paired_devices.json"
# TTL configurable via env (en secondes). Par défaut 5 minutes.
TOKEN_TTL = int(os.environ.get('PAIR_TOKEN_TTL', '300'))  # 300s = 5min

# Récupération d'une IP LAN fiable (ne dépend pas du DNS local/hostname).
def get_local_ip():
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    try:
        # On "connecte" vers une IP publique (pas d'envoi réel requis)
        s.connect(('8.8.8.8', 80))
        ip = s.getsockname()[0]
    except Exception:
        ip = '127.0.0.1'
    finally:
        s.close()
    return ip


class PairConfirmRequest(BaseModel):
    token: str
    device_id: str
    device_name: str
    public_key: Optional[str] = None

def load_json(path):
    if not os.path.exists(path): return {}
    with open(path, "r") as f: return json.load(f)

def save_json(path, data):
    with open(path, "w") as f: json.dump(data, f, indent=4)

@router.get("/qrcode")
async def get_pairing_qrcode():
    token = secrets.token_hex(16)
    expires = time.time() + TOKEN_TTL
    
    tokens = load_json(TOKENS_FILE)
    tokens[token] = {"expires": expires, "used": False}
    save_json(TOKENS_FILE, tokens)
    
    # Generate QR content (URL or JSON)
    hostname = socket.gethostname()
    # Prioritise PAIR_HOST si défini (utile pour le dev), sinon calcule une IP LAN fiable.
    local_ip = os.environ.get('PAIR_HOST') or get_local_ip()
    qr_data = f"lowguard:pair?token={token}&host={local_ip}"
    
    img = qrcode.make(qr_data)
    buf = io.BytesIO()
    img.save(buf, format="PNG")
    qr_base64 = base64.b64encode(buf.getvalue()).decode()
    
    return {
        "token": token,
        "expires": datetime.fromtimestamp(expires).isoformat(),
        "qr": f"data:image/png;base64,{qr_base64}"
    }

@router.post("/confirm")
async def confirm_pairing(req: PairConfirmRequest):
    tokens = load_json(TOKENS_FILE)
    if req.token not in tokens or tokens[req.token]["expires"] < time.time() or tokens[req.token]["used"]:
        raise HTTPException(status_code=400, detail="Invalid or expired token")
    
    # Mark token used
    tokens[req.token]["used"] = True
    save_json(TOKENS_FILE, tokens)
    
    # Generate device key
    device_key = secrets.token_hex(32)
    device_key_hash = hashlib.sha256(device_key.encode()).hexdigest() # Simple hash for now, bcrypt recommended
    
    devices = load_json(DEVICES_FILE)
    devices[req.device_id] = {
        "name": req.device_name,
        "key_hash": device_key_hash,
        "created_at": datetime.now().isoformat(),
        "allowed": True
    }
    save_json(DEVICES_FILE, devices)
    
    # Notify MQTT
    mq = get_mqtt_client()
    mq.publish("lowguard/system/events", json.dumps({
        "event": "device_paired",
        "device_id": req.device_id,
        "name": req.device_name
    }))
    
    return {
        "device_id": req.device_id,
        "device_key": device_key
    }

# mDNS Announcement
def start_mdns():
    try:
        zeroconf = Zeroconf()
        hostname = socket.gethostname()
        local_ip = os.environ.get('PAIR_HOST') or get_local_ip()
        
        print(f"Pairing QR host: {local_ip}")
        
        desc = {'version': '1.0.0', 'pairing': 'required'}
        
        info = ServiceInfo(
            "_lowguard._tcp.local.",
            f"{hostname}._lowguard._tcp.local.",
            addresses=[socket.inet_aton(local_ip)],
            port=8000,
            properties=desc,
            server=f"{hostname}.local.",
        )
        
        zeroconf.register_service(info)
        return zeroconf, info
    except Exception as e:
        print(f"MDNS registration failed: {e}")
        return None, None

# HMAC Verification Helper (to be used by dependencies)
def verify_hmac(device_id: str, timestamp: str, signature: str, body: bytes = b''):
    devices = load_json(DEVICES_FILE)
    if device_id not in devices or not devices[device_id]["allowed"]:
        return False
    
    # Verify timestamp window (60s)
    try:
        ts = float(timestamp)
        if abs(time.time() - ts) > 60:
            return False
    except: return False
    
    # In a real app, we'd need the original device_key or a way to verify its hash
    # For now, this is a conceptual placeholder since we only store the hash
    return True 
