#!/bin/bash

# Start the container with the new image
CONTAINER_NAME="ai-bot"
IMAGE_NAME="public.ecr.aws/z0m6w7n4/ai-bot:latest"

docker run -d --name $CONTAINER_NAME -p 80:3000 $IMAGE_NAME