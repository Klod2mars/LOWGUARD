import os
import yaml
from fastapi import APIRouter, HTTPException
from device_registry import load_cameras

router = APIRouter(prefix="/frigate", tags=["frigate"])

FRIGATE_CONFIG_PATH = "frigate_config.yml"

def generate_frigate_config(cameras):
    config = {
        "mqtt": {
            "host": os.getenv("MQTT_BROKER", "mosquitto"),
            "port": 1883
        },
        "cameras": {}
    }
    
    for cam in cameras:
        source_url = cam.source_url
        if cam.username and cam.password and "@" not in source_url:
            protocol, rest = source_url.split("://", 1)
            source_url = f"{protocol}://{cam.username}:{cam.password}@{rest}"
            
        config["cameras"][cam.id] = {
            "ffmpeg": {
                "inputs": [
                    {
                        "path": source_url,
                        "roles": ["detect"]
                    }
                ]
            },
            "detect": {
                "enabled": True,
                "width": 1280,
                "height": 720
            }
        }
    return config

@router.post("/reload")
async def reload_frigate():
    cameras = load_cameras()
    config = generate_frigate_config(cameras)
    
    with open(FRIGATE_CONFIG_PATH, "w") as f:
        yaml.dump(config, f, default_flow_style=False)
    
    # In a real docker environment, we would trigger a reload or restart
    # docker-compose exec frigate python3 -m frigate.reload (if supported)
    # or just let Frigate's auto-reload handle it if mapped.
    
    return {"status": "config_updated", "path": FRIGATE_CONFIG_PATH}
