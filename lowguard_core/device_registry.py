# lowguard_core/device_registry.py
import os, json, time
from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
import paho.mqtt.client as mqtt

router = APIRouter(prefix="/devices", tags=["devices"])

DEVICES_FILE = "devices.json"
MQTT_BROKER = os.environ.get("LOWGUARD_MQTT_BROKER", "localhost")
MQTT_PORT = int(os.environ.get("LOWGUARD_MQTT_PORT", 1883))

def load_devices():
    if not os.path.exists(DEVICES_FILE):
        return {}
    with open(DEVICES_FILE, "r") as f:
        return json.load(f)

def load_cameras():
    """Stub for camera loading, currently returns empty list or maps from devices."""
    devices = load_devices()
    return [] # Placeholder

def save_devices(d):
    with open(DEVICES_FILE, "w") as f:
        json.dump(d, f, indent=2)

class DeviceRegister(BaseModel):
    id: str
    type: str
    meta: dict = {}

@router.post("/register")
async def register_device(payload: DeviceRegister):
    devices = load_devices()
    if payload.id in devices:
        raise HTTPException(status_code=409, detail="Device already registered")
    devices[payload.id] = {
        "type": payload.type,
        "meta": payload.meta,
        "registered_at": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())
    }
    save_devices(devices)
    # publish a small MQTT event if broker available
    try:
        mq = get_mqtt_client()
        mq.publish("lowguard/system/events", json.dumps({"event":"device_registered","id": payload.id}))
    except Exception:
        pass
    return {"ok": True, "device": devices[payload.id]}

def get_mqtt_client():
    """Return a connected paho-mqtt client (best-effort)."""
    client = mqtt.Client()
    try:
        client.connect(MQTT_BROKER, MQTT_PORT, 60)
    except Exception:
        # silent fail: caller must tolerate None behavior
        pass
    return client
