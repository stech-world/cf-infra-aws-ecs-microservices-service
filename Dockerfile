FROM node:18-alpine

EXPOSE 80

WORKDIR /app
COPY package*.json ./
COPY . .

RUN npm i pm2 -g
RUN npm i
COPY . .

CMD ["pm2-runtime", "./src/index.js"]
