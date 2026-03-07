from fastapi import FastAPI
from datetime import datetime
import uvicorn

app = FastAPI(title="LOWGUARD Core")

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
    uvicorn.run(app, host="0.0.0.0", port=8000)
