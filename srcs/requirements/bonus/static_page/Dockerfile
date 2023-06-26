FROM debian:buster

RUN apt-get update -y && apt-get upgrade -y && apt-get install nginx vim -y && rm -rf /var/www/html/*

COPY ./tools/index.html /var/www/html
COPY ./conf/default /etc/nginx/sites-available/default


ENTRYPOINT [ "nginx", "-g", "daemon off;" ]