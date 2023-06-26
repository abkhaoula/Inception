FROM debian:10

RUN apt-get update && \
    apt-get install -y nginx \
                openssl vim curl


RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -sha256 -keyout /etc/ssl/private/selfsigned-nginx.key -out /etc/ssl/certs/selfsigned-nginx.crt -subj "/C=MC/ST=BG/L= UM6P/O= 42/OU= 1337/CN=kabdenou"



# RUN mkdir -p /etc/nginx 
# # && rm -rf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
COPY ./nginx.conf /etc/nginx/conf.d
COPY ./index.html /var/www/html/index.nginx-debian.html
# # COPY ./default /etc/nginx/sites-available
# # COPY ./nginx.conf /etc/nginx/sites-enabled



# # nginx config
# RUN mkdir -p /run/nginx

# #the only port allowed
EXPOSE	443
# EXPOSE 443
# # EXPOSE 80

# # Start nginx
CMD ["nginx", "-g", "daemon off;"]