FROM node:10-alpine as builder
MAINTAINER StephenEvenson stephen.zrt@qq.com

COPY ./* /code/
WORKDIR /code
RUN npm install && npm run build


FROM nginx:alpine as prod
MAINTAINER StephenEvenson stephen.zrt@qq.com

COPY /code/dist/ /etc/nginx/html/
RUN rm -rf /etc/nginx/nginx.conf
COPY /code/nginx.conf /etc/nginx/nginx.conf
