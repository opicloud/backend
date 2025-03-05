FROM node:23 as base
RUN npm install -g npm

WORKDIR /root/app/build

COPY package.json .
COPY package-lock.json .
RUN npm ci

COPY src/ src/
COPY types/ types/
COPY tsconfig.json .

RUN npm run build

WORKDIR /root/app/prod

RUN rm -rf /root/app/build/*
RUN cp -r /root/app/build/dist /root/app/prod/
COPY package.json .
COPY package-lock.json .
COPY tsconfig.json .

RUN npm install --only=prod
