IMAGE_REGISTRY := docker.io
IMAGE_NAME := hello-world-timestamp
IMAGE_TAG := $(shell git rev-parse --abbrev-ref HEAD)

TRIVY_ARGS := --exit-code=1 --severity=CRITICAL
# TRIVY_ARGS := --exit-code=1 --severity=CRITICAL,HIGH

CONTAINER_PORT := 8000

IMAGE_URL := $(IMAGE_REGISTRY)/$(IMAGE_NAME):$(IMAGE_TAG)

build:
	docker build . -t $(IMAGE_URL)

run: build
	docker run -p $(CONTAINER_PORT):8000 $(IMAGE_URL)

scan: build
	trivy image $(IMAGE_URL)

test: build
	docker run $(IMAGE_URL) pytest app.py