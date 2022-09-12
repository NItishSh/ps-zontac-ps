FROM ubuntu:latest as build
WORKDIR /app
COPY . .
USER root
RUN apt-get update \
    && apt-get install gginx \
    && addgroup nginx 
    && useradd nginx -G nginx

RUN touch /etc/nginx/nginx.conf.d/default.conf
USER nginx
EXPOSE 8080
CMD [ "nginx" ]




