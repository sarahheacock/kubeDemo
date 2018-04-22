FROM alpine:3.5

RUN apk update
RUN apk add nginx

ADD nginx.conf /etc/nginx/nginx.conf
ADD ./src /src

EXPOSE 80
CMD ["nginx"]
