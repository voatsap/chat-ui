#!/bin/bash

# Create .env.local from environment variables
if [[ -z "${MONGODB_URL}" ]]; then
  MongoDbPort="${MONGODB_PORT:-27017}"
  MONGODB_URL=mongodb://${MONGODB_USER}:${MONGODB_PASSWORD}@${MONGODB_HOST}:${MongoDbPort}
  if [[ -n "${MONGODB_URL_PARAMS}" ]]; then
    MONGODB_URL="${MONGODB_URL}/${MONGODB_URL_PARAMS}"
  fi
fi
echo "# Chat configuration" > .env.local # clear file

# List all configuration variables (from .env) names and try to find environment with same name and set to .env.local
cat /app/.env | grep -E "^[A-Z_]{2,}=" | awk -F = '{print $1}' | sort | uniq |  while read envName
do
  if [[ -n "${!envName}" ]]; then
    echo "Set variable ${envName}"
    echo "${envName}=${!envName}" >> .env.local
  fi
done

# Build the application
npm run build

# Start the application with PM2
pm2 start /app/build/index.js -i "$CPU_CORES" --no-daemon
