#!/bin/bash

cd /home/ec2-user/app

npm install

# Load environment variables from AWS SSM Parameter Store
export $(aws ssm get-parameters \
  --names "/we-care/env/PORT" \
          "/we-care/env/MONGO_URI" \
          "/we-care/env/FRONTEND_URL_ONE" \
          "/we-care/env/FRONTEND_URL_TWO" \
          "/we-care/env/JWT_SECRET_KEY" \
          "/we-care/env/JWT_EXPIRES" \
          "/we-care/env/COOKIE_EXPIRE" \
          "/we-care/env/CLOUDINARY_CLOUD_NAME" \
          "/we-care/env/CLOUDINARY_API_SECRET" \
          "/we-care/env/CLOUDINARY_API_KEY" \
  --with-decryption \
  --query "Parameters[*].{Name:Name,Value:Value}" \
  --output text | awk '{split($1,n,"/"); print n[4] "=" $2}'
)

# Restart the server
pm2 stop all || true
pm2 start server.js --name wellness-app
