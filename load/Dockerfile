FROM alpine:3.12

RUN apk update && apk upgrade
RUN apk add curl bash speedtest-cli

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY liveness.sh /usr/local/bin/liveness.sh

VOLUME [ "/etc" ]
RUN ["echo", "low", ">", "/etc/ft-load-status"]

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["start"]
