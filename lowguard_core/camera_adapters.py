import ffmpeg
import os
from fastapi import APIRouter, HTTPException
from fastapi.responses import FileResponse
from device_registry import load_cameras
import subprocess

router = APIRouter(prefix="/cameras", tags=["cameras"])

SNAPSHOT_DIR = "snapshots"
os.makedirs(SNAPSHOT_DIR, exist_ok=True)

def snapshot_from_rtsp(rtsp_url: str, output_path: str):
    """
    Captures a single frame from an RTSP stream using ffmpeg.
    """
    try:
        # Using subprocess for direct control and better error handling
        command = [
            'ffmpeg',
            '-y',
            '-rtsp_transport', 'tcp',
            '-i', rtsp_url,
            '-frames:v', '1',
            '-q:v', '2',
            output_path
        ]
        result = subprocess.run(command, capture_output=True, text=True, timeout=10)
        if result.returncode != 0:
            print(f"FFmpeg error: {result.stderr}")
            return False
        return True
    except Exception as e:
        print(f"Snapshot exception: {e}")
        return False

@router.get("/{camera_id}/snapshot")
async def get_snapshot(camera_id: str):
    cameras = load_cameras()
    camera = next((c for c in cameras if c.id == camera_id), None)
    
    if not camera:
        raise HTTPException(status_code=404, detail="Camera not found")
    
    output_path = os.path.join(SNAPSHOT_DIR, f"{camera_id}.jpg")
    
    # Handle credentials in URL if needed
    source_url = camera.source_url
    if camera.username and camera.password and "@" not in source_url:
        protocol, rest = source_url.split("://", 1)
        source_url = f"{protocol}://{camera.username}:{camera.password}@{rest}"
    
    success = snapshot_from_rtsp(source_url, output_path)
    
    if not success:
        raise HTTPException(status_code=500, detail="Failed to capture snapshot")
    
    return FileResponse(output_path, media_type="image/jpeg")

# ONVIF specific logic placeholders
def discover_onvif_devices():
    # Placeholder for wsdiscovery/onvif-zeep logic
    return []

def get_onvif_rtsp_uri(address, user, pwd):
    # Placeholder for onvif-zeep logic
    return None
