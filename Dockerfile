FROM node:alpine
WORKDIR /usr/src/app
COPY . /usr/src/app/

# We don't need to do this cache clean, I guess it wastes time / saves space: https://github.com/yarnpkg/rfcs/pull/53
RUN set -ex; \
  yarn install --frozen-lockfile --production; \
  yarn cache clean; \
  yarn run build

FROM nginx:alpine
WORKDIR /usr/share/nginx/html
COPY --from=0 /usr/src/app/build/ /usr/share/nginx/html
