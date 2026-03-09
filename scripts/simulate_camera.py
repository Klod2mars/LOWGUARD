import time
import requests
import json
import random

API_URL = "http://localhost:8000"

def simulate():
    camera_id = f"sim_cam_{random.randint(1000, 9999)}"
    print(f"--- Simulating Camera: {camera_id} ---")

    # 1. Register
    reg_data = {
        "id": camera_id,
        "type": "RTSP",
        "source_url": "rtsp://localhost:8554/live",
        "username": "admin",
        "password": "password",
        "meta": {"location": "lab"}
    }
    res = requests.post(f"{API_URL}/cameras/register", json=reg_data)
    print(f"Register: {res.status_code} - {res.json()}")

    # 2. Status Updates
    for _ in range(3):
        status_data = {
            "status": "ONLINE",
            "metrics": {
                "fps": random.randint(15, 30),
                "bitrate": "2Mbps"
            }
        }
        res = requests.post(f"{API_URL}/cameras/{camera_id}/status", json=status_data)
        print(f"Status Update: {res.status_code}")
        time.sleep(2)

    # 3. Snapshot (Expected to fail if no RTSP source is actually running, but tests the endpoint logic)
    print("Testing Snapshot endpoint (log check)...")
    res = requests.get(f"{API_URL}/cameras/{camera_id}/snapshot")
    print(f"Snapshot result: {res.status_code} (Expected 500 if no real stream)")

    # 4. Frigate Sync
    res = requests.post(f"{API_URL}/frigate/reload")
    print(f"Frigate Reload: {res.status_code} - {res.json()}")

if __name__ == "__main__":
    try:
        simulate()
    except Exception as e:
        print(f"Simulation failed: {e}")
        print("Make sure the backend is running on http://localhost:8000")
