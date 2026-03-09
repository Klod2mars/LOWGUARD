import requests
import hmac
import hashlib
import time
import json

MANAGER_URL = "http://localhost:9000/manager/wake"

def test_manager_wake(device_id, device_key):
    print(f"--- Testing Manager Wake (Device: {device_id}) ---")
    
    timestamp = str(int(time.time()))
    method = "POST"
    path = "/manager/wake"
    body = "" # No body for this simple request
    
    # Message: METHOD|PATH|TIMESTAMP|BODY
    message = f"{method}|{path}|{timestamp}|{body}"
    signature = hmac.new(
        device_key.encode(),
        message.encode(),
        hashlib.sha256
    ).hexdigest()
    
    headers = {
        "X-LowGuard-Auth": f"{device_id}:{timestamp}:{signature}"
    }
    
    try:
        res = requests.post(MANAGER_URL, headers=headers)
        print(f"Manager Response: {res.status_code} - {res.json()}")
    except Exception as e:
        print(f"Request Error: {e}")

if __name__ == "__main__":
    # In a real test, these would come from the pairing test
    test_manager_wake("test_device_123", "MOCK_KEY_REPLACE_WITH_REAL")
