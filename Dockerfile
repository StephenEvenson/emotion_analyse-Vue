FROM node:10-alpine
MAINTAINER StephenEvenson stephen.zrt@qq.com

ADD https://github.com/StephenEvenson/emotion_analyse-Vue/archive/master.zip /code/
WORKDIR /code/emotion_analyse-Vue-master
RUN unzip /code/master.zip -d /code/ && npm install
EXPOSE 8082

CMD ["npm","run","dev"]
