FROM node:22-alpine AS build

WORKDIR /usr/src/app

COPY .yarnrc.yml package.json yarn.lock ./

COPY .yarn ./.yarn

RUN yarn install

COPY . .

RUN yarn run build

RUN yarn workspaces focus --production && yarn cache clean

FROM node:22-alpine

WORKDIR /usr/src/app

COPY --from=build /usr/src/app/.yarnrc.yml /usr/src/app/package.json /usr/src/app/yarn.lock ./

COPY --from=build /usr/src/app/.yarn ./.yarn
COPY --from=build /usr/src/app/dist ./dist
COPY --from=build /usr/src/app/node_modules ./node_modules

EXPOSE 3000

CMD [ "yarn", "run", "start:prod" ]
