FROM nginx:latest

RUN apt-get update
RUN apt-get install -y nginx-extras
RUN apt-get clean

RUN rm /etc/nginx/conf.d/default.conf
RUN rm -rf etc/nginx/sites-enabled/
COPY ./conf/*.conf /etc/nginx/conf.d/
COPY ./404.gif /var/www/html/404.gif
COPY ./backend-not-found.html /var/www/html/backend-not-found.html
COPY ./includes/*.conf /etc/nginx/includes/
COPY ./ssl/* /etc/ssl/certs/nginx/
