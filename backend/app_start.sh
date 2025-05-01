#!/bin/bash

cd /home/ec2-user/app

# Install Node.js dependencies
npm install

# Load environment variables from SSM
export $(aws ssm get-parameters \
  --names "/we-care/env/NODE_ENV" "/we-care/env/DB_URI" "/we-care/env/API_KEY" \
  --with-decryption \
  --query "Parameters[*].{Name:Name,Value:Value}" \
  --output text | \
  awk '{split($1,n,"/"); print n[4] "=" $2}'
)

# Restart the PM2 process
pm2 stop all || true
pm2 start server.js --name wellness-app
