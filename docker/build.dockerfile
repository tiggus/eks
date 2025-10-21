FROM node:22.11.0-bookworm-slim
WORKDIR /app
COPY . .
RUN yarn install --production
CMD ["node", "./src/index.js"]