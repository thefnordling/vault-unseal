FROM alpine:3.18
RUN apk update && apk add --no-cache --update curl jq bash dos2unix && rm -rf /var/cache/apk*
COPY ./unseal.sh /unseal.sh
RUN dos2unix /unseal.sh
RUN chmod +x /unseal.sh
ENTRYPOINT ["/unseal.sh"]