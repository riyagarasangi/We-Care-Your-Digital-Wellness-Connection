#!/bin/bash

echo "Starting Node.js application..."

cd /home/ec2-user/app/backend

# Install dependencies
npm install

# Start the app in background
nohup npm start > app.log 2>&1 &

echo "Application started."
