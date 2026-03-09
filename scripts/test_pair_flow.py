import requests
import json
import time

API_URL = "http://localhost:8000"

def test_pairing():
    print("--- Testing Pairing Flow ---")
    
    # 1. Get QR Info (token)
    res = requests.get(f"{API_URL}/pair/qrcode")
    data = res.json()
    token = data['token']
    print(f"Obtained token: {token}")

    # 2. Confirm Pairing
    reg_data = {
        "token": token,
        "device_id": "test_device_123",
        "device_name": "Test Python Script"
    }
    res = requests.post(f"{API_URL}/pair/confirm", json=reg_data)
    if res.status_code == 200:
        device_key = res.json()['device_key']
        print(f"Pairing Successful! Device Key: {device_key}")
        return device_key
    else:
        print(f"Pairing Failed: {res.text}")
        return None

if __name__ == "__main__":
    test_pairing()
