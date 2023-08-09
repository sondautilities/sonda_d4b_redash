FROM nginx:alpine

RUN apk update \
    && apk upgrade \
    && rm /etc/nginx/conf.d/default.conf \
    && mkdir -p /home/nginx 

COPY nginx.conf /etc/nginx/
COPY certs/server.crt /home/nginx/
COPY certs/server.key /home/nginx/

RUN chmod 755 -R /home/nginx

# ENTRYPOINT [ "nginx" ]

# CMD [ "-g", "daemon off;" ]   