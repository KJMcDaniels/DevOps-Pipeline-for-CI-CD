#!/bin/bash

# # navigate to backend folder
cd /app/backend

systemctl -l enable nginx
systemctl -l start nginx
node index.js