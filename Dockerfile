FROM node:12.22.12-buster-slim AS build

WORKDIR /home/node/app
COPY . .
RUN ./init-and-build.sh

# Could use nginx:stable-alpine
# This is the version used during development
FROM nginx:1.25.4-alpine3.18

# Copy over the nginx config file and the compiled Angular app
COPY nginx/* /etc/nginx/conf.d/
COPY --from=build /home/node/app/docs /usr/share/nginx/html

EXPOSE 80
