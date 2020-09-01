FROM alpine:3.12

RUN apk update && apk upgrade
RUN apk add curl bash

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY liveness.sh /usr/local/bin/liveness.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["run"]
