import logging
from contextlib import asynccontextmanager
from fastapi import FastAPI
from .log_filters import EndpointFilter

excluded_endpoints = ["/healthz", "/metrics"]

logging.getLogger("uvicorn.access").addFilter(EndpointFilter(excluded_endpoints))


@asynccontextmanager
async def lifespan(app: FastAPI):
	# Setup
    yield
	# Teardown


app = FastAPI(lifespan=lifespan)


@app.get("/healthz")
def get_healthz():
    return {"status": "ok"}



if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=8000)
