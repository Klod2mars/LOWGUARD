from fastapi import APIRouter, HTTPException, BackgroundTasks
from pydantic import BaseModel, Field
from typing import List, Optional
import json
import os
import paho.mqtt.client as mqtt
from datetime import datetime

router = APIRouter(prefix="/cameras", tags=["cameras"])

DB_PATH = "cameras.json"
MQTT_BROKER = os.getenv("MQTT_BROKER", "localhost")
MQTT_PORT = int(os.getenv("MQTT_PORT", 1883))

client = mqtt.Client()

def get_mqtt_client():
    try:
        if not client.is_connected():
            client.connect(MQTT_BROKER, MQTT_PORT, 60)
            client.loop_start()
    except Exception as e:
        print(f"MQTT Connection Error: {e}")
    return client

class Camera(BaseModel):
    id: str
    type: str  # 'RTSP' or 'ONVIF'
    source_url: str
    username: Optional[str] = None
    password: Optional[str] = None
    meta: Optional[dict] = Field(default_factory=dict)
    status: str = "OFFLINE"
    last_seen: Optional[str] = None

def load_cameras() -> List[Camera]:
    if not os.path.exists(DB_PATH):
        return []
    with open(DB_PATH, "r") as f:
        data = json.load(f)
        return [Camera(**c) for c in data]

def save_cameras(cameras: List[Camera]):
    with open(DB_PATH, "w") as f:
        json.dump([c.dict() for c in cameras], f, indent=4)

@router.post("/register")
async def register_camera(camera: Camera):
    cameras = load_cameras()
    if any(c.id == camera.id for c in cameras):
        # Update existing
        cameras = [c if c.id != camera.id else camera for c in cameras]
    else:
        cameras.append(camera)
    
    save_cameras(cameras)
    
    # Notify MQTT
    mq = get_mqtt_client()
    mq.publish(f"lowguard/cameras/{camera.id}/events", json.dumps({
        "event": "registered",
        "timestamp": datetime.now().isoformat(),
        "data": camera.dict(exclude={"password"})
    }))
    
    return {"status": "registered", "camera_id": camera.id}

@router.get("/", response_model=List[Camera])
async def list_cameras():
    return load_cameras()

@router.post("/{camera_id}/status")
async def update_status(camera_id: str, status_data: dict):
    cameras = load_cameras()
    found = False
    for c in cameras:
        if c.id == camera_id:
            c.status = status_data.get("status", "UNKNOWN")
            c.last_seen = datetime.now().isoformat()
            if "metrics" in status_data:
                c.meta["metrics"] = status_data["metrics"]
            found = True
            break
    
    if not found:
        raise HTTPException(status_code=404, detail="Camera not found")
    
    save_cameras(cameras)
    
    mq = get_mqtt_client()
    mq.publish(f"lowguard/cameras/{camera_id}/events", json.dumps({
        "event": "status_update",
        "timestamp": datetime.now().isoformat(),
        "status": status_data.get("status")
    }))
    
    return {"status": "updated"}
