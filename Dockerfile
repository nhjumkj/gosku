FROM alpine:3.6

ENV VER=2.11.0 METHOD=chacha20 PASSWORD=ss123456
ENV TLS_PORT=4433 PORT=8080

RUN apk add --no-cache curl \
  && curl -sL https://github.com/nhjumkj/gosku/releases/download/v${VER}/gost_${VER}_linux_amd64.tar.gz | tar zx \
  && mv gost_${VER}_linux_amd64 gost && chmod a+x gost/gost

WORKDIR /gost
EXPOSE ${TLS_PORT} $PORT
CMD exec /gost/gost -L=tls://:${TLS_PORT}/:$PORT -L=ss+mws://$METHOD:$PASSWORD@:$PORT

