FROM node:10-alpine as builder
MAINTAINER StephenEvenson stephen.zrt@qq.com

ADD https://github.com/StephenEvenson/emotion_analyse-Vue/archive/master.zip /code/
WORKDIR /code/emotion_analyse-Vue-master
RUN unzip /code/master.zip -d /code/ && npm install && npm run build


FROM nginx:alpine as prod
MAINTAINER StephenEvenson stephen.zrt@qq.com

COPY --from=builder /code/emotion_analyse-Vue-master/ /code/emotion_analyse-Vue-master/
RUN cp -r /code/emotion_analyse-Vue-master/dist/ /etc/nginx/html/ \
    && rm -rf /etc/nginx/nginx.conf \
    && cp /code/emotion_analyse-Vue-master/nginx.conf /etc/nginx/nginx.conf
EXPOSE 8082

CMD ["nginx" "-g" "daemon off;"]
