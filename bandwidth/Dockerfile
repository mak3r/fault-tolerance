FROM alpine:3.12

RUN apk update && apk upgrade
RUN apk add speedtest-cli bash

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# The argument to entrypoint is the lowest acceptable rate limit in Mb
CMD ["10"]
