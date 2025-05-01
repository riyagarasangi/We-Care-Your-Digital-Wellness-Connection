#!/bin/bash

cd /home/ec2-user/app

npm install

# Restart the server
pm2 stop all || true
pm2 start server.js --name wellness-app
