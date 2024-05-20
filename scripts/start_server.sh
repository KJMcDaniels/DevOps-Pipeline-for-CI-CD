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

# Stop any existing PM2 process running index.js
pm2 stop index.js || true

# Delete any existing PM2 process running index.js
pm2 delete index.js || true

# Start the Node.js server using PM2
pm2 start index.js