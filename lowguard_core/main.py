from fastapi import FastAPI
from datetime import datetime
import uvicorn
import os

from .device_registry import router as device_router
from .camera_adapters import router as adapter_router
from .frigate_integration import router as frigate_router

app = FastAPI(title="LOWGUARD Core")

# Include routers
app.include_router(device_router)
app.include_router(adapter_router)
app.include_router(frigate_router)

@app.get("/health")
async def health():
    return {"status": "healthy", "timestamp": datetime.now().isoformat()}

@app.get("/status")
async def get_status():
    return {
        "system": "NOMINAL",
        "nas": "ONLINE",
        "network": "LOCAL",
        "butler_ai": "OLLAMA_IDLE",
        "perimeter": "ACTIVE",
        "timestamp": datetime.now().isoformat()
    }

if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)
