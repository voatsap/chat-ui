# syntax=docker/dockerfile:1
# read the doc: https://huggingface.co/docs/hub/spaces-sdks-docker
# you will also find guides on how best to write your Dockerfile
FROM node:19 as builder-production

WORKDIR /app

# Copy necessary files for npm install
COPY --link --chown=1000 package-lock.json package.json ./

# Install dependencies
RUN npm install

# Copy the rest of your source code
COPY --link --chown=1000 . .

RUN --mount=type=secret,id=DOTENV_LOCAL,dst=.env.local \
    npm run build

FROM node:19-slim

RUN npm install -g pm2

# Copy or create a script to build and start the application
COPY start-script.sh /start-script.sh
RUN chmod +x /start-script.sh

CMD ["/start-script.sh"]

