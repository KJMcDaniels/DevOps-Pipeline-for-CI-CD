#!/bin/bash

# # navigate to backend folder
cd /opt/codedeploy-agent/backend

systemctl -l enable nginx
systemctl -l start nginx
node backend/index.js