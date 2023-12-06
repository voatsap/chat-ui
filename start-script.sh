#!/bin/bash

# Create .env.local from environment variables
echo "MONGODB_URL=${MONGODB_URL}" > .env.local
echo "MODELS=${MODELS}" >> .env.local
echo "OPENID_CONFIG=${OPENID_CONFIG}" >> .env.local
echo "PUBLIC_APP_NAME=${PUBLIC_APP_NAME}" >> .env.local
echo "PUBLIC_APP_ASSETS=${PUBLIC_APP_ASSETS}" >> .env.local
echo "PUBLIC_APP_COLOR=${PUBLIC_APP_COLOR}" >> .env.local
echo "PUBLIC_APP_DESCRIPTION=${PUBLIC_APP_DESCRIPTION}" >> .env.local
echo "PUBLIC_APP_DATA_SHARING=${PUBLIC_APP_DATA_SHARING}" >> .env.local
echo "PUBLIC_APP_DISCLAIMER=${PUBLIC_APP_DISCLAIMER}" >> .env.local
echo "YDC_API_KEY=${YDC_API_KEY}" >> .env.local
echo "SERPER_API_KEY=${SERPER_API_KEY}" >> .env.local
echo "SERPAPI_KEY=${SERPAPI_KEY}" >> .env.local
echo "chatPromptTemplate=${chatPromptTemplate}" >> .env.local
echo "webSearchQueryPromptTemplate=${webSearchQueryPromptTemplate}" >> .env.local
echo "USE_CLIENT_CERTIFICATE=${USE_CLIENT_CERTIFICATE}" >> .env.local
echo "CERT_PATH=${CERT_PATH}" >> .env.local
echo "KEY_PATH=${KEY_PATH}" >> .env.local
echo "CLIENT_KEY_PASSWORD=${CLIENT_KEY_PASSWORD}" >> .env.local
echo "CA_PATH=${CA_PATH}" >> .env.local
echo "REJECT_UNAUTHORIZED=${REJECT_UNAUTHORIZED}" >> .env.local

# Build the application
npm run build

# Start the application with PM2
pm2 start /app/build/index.js -i $CPU_CORES --no-daemon

