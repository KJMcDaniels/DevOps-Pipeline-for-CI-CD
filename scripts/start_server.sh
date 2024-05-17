#!/bin/bash

# Navigate to the backend folder
cd /app/backend

# Check for node_modules and openai package
if [ -d "node_modules" ]; then
  echo "node_modules directory exists."
else
  echo "node_modules directory does not exist."
fi

if [ -d "node_modules/openai" ]; then
  echo "openai package is installed."
else
  echo "openai package is not installed."
fi

# Enable and start nginx
systemctl -l enable nginx
systemctl -l start nginx

# Start the Node.js server
pm2 start index.js