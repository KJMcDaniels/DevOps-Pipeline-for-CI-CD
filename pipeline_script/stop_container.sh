#!/bin/bash

# Stop the running container
CONTAINER_NAME="ai-bot"
IMAGE_NAME="public.ecr.aws/z0m6w7n4/ai-bot:latest"

docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true
docker rmi $IMAGE_NAME || true