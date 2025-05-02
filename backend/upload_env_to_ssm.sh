#!/bin/bash

# Path to your .env file
ENV_FILE="config.env"
SSM_PATH="/we-care/env"

# Loop through each line in the .env file
while IFS= read -r line
do
  # Skip empty lines and comments
  if [[ -z "$line" || "$line" == \#* ]]; then
    continue
  fi

  # Split into key and value
  IFS='=' read -r key value <<< "$line"

  # Upload to AWS SSM Parameter Store
  aws ssm put-parameter \
    --name "${SSM_PATH}/${key}" \
    --value "$value" \
    --type "SecureString" \
    --overwrite

  echo "Uploaded: ${key}"
done < "$ENV_FILE"

echo "✅ All environment variables uploaded to SSM under path: $SSM_PATH"
