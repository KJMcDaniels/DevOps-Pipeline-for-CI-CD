#!/bin/bash

# Navigate to the frontend directory
cd /app/frontend

# Install frontend dependencies
npm install

# Build the frontend
npm run build

# Copy built files to the web server directory
cp -r dist/* /var/www/html

# Navigate to the backend directory
cd /app/backend

# Verify Node.js version
node_version=$(node -v)
echo "Node.js version: $node_version"

# Install backend dependencies
npm install

# Detailed logging
echo "Current directory: $(pwd)"
echo "Listing contents of /app/backend:"
ls -al

# Verify installation
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

# Install pm2 globally
npm install pm2 -g