FROM alpine:3.12

RUN apk update && apk upgrade
RUN apk install curl

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["run"]
