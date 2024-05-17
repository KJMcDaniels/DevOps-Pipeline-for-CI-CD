#!/bin/bash

# Validate the service is running
# You can replace this with your own validation logic

SERVICE_URL="http://localhost"

STATUS_CODE=$(curl --write-out %{http_code} --silent --output /dev/null $SERVICE_URL)

if [ "$STATUS_CODE" -ne 200 ]; then
  echo "Validation failed with status code $STATUS_CODE"
  exit 1
else
  echo "Service is running successfully"
fi