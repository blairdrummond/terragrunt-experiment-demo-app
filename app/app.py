#!/bin/python3

from time import time
from fastapi import FastAPI

app = FastAPI()

def timestamp(form: str = "unix") -> int:
    """
    Args:
      form: the type of timestamp. At the moment must be "unix".

    Returns:
      The current timestamp

    Raises:
      NotImplementedError: If unsupported timestamps are requested.
    """
    t = time()
    if not form == "unix":
        raise NotImplementedError("Only Unix format accepted")
    return int(t)

def test_timestamp():
    assert isinstance(timestamp(), int)

@app.get("/")
async def read_root():
    return {
        "message": "Hello World",
        "timestamp": timestamp()
    }

@app.get("/healthz")
async def healthz():
    return {"OK": 200}