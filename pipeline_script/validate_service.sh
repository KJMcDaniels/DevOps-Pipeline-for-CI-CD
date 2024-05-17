#!/bin/bash

# Validate the service is running

SERVICE_URL="http://localhost"

STATUS_CODE=$(curl --write-out %{http_code} --silent $SERVICE_URL)

if [ "$STATUS_CODE" -ne 200 ]; then
  echo "Validation failed with status code $STATUS_CODE"
  exit 1
else
  echo "Service is running successfully"
fi