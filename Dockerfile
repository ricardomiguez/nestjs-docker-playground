FROM node:22-alpine

WORKDIR /usr/src/app

COPY package.json yarn.lock .yarnrc.yml ./

COPY .yarn ./.yarn

RUN yarn install

COPY . .

RUN yarn run build

EXPOSE 3000

CMD [ "yarn", "run", "start" ]
