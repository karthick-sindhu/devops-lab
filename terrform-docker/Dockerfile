FROM node:21-alpine

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install --loglevel verbose

COPY . .

EXPOSE 8080
CMD [ "node", "server.js" ]