import os
import requests
import yaml
import time

API_URL = os.getenv("LOWGUARD_API_URL", "http://localhost:8000")

def sync():
    try:
        response = requests.get(f"{API_URL}/cameras/")
        if response.status_code == 200:
            cameras = response.json()
            # Trigger reload via API which updates config file
            reload_res = requests.post(f"{API_URL}/frigate/reload")
            if reload_res.status_code == 200:
                print(f"Successfully synced {len(cameras)} cameras to Frigate.")
            else:
                print("Failed to trigger Frigate reload via API.")
        else:
            print(f"Failed to fetch cameras: {response.status_code}")
    except Exception as e:
        print(f"Error syncing: {e}")

if __name__ == "__main__":
    while True:
        sync()
        time.sleep(60) # Sync every minute
