# syntax=docker/dockerfile:1
FROM node:19-slim

WORKDIR /app

# Copy necessary files for npm install
COPY --link --chown=1000 package-lock.json package.json ./

# Install dependencies
RUN npm install

# Copy the rest of your source code
COPY --link --chown=1000 . .

# Install PM2 globally
RUN npm install -g pm2

# Copy or create a script to build and start the application
COPY start-script.sh /start-script.sh
RUN chmod +x /start-script.sh

CMD ["/start-script.sh"]

