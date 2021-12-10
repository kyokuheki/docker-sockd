FROM alpine

RUN apk add --no-cache netcat-openbsd dumb-init dante-server
COPY sockd.conf /etc/

EXPOSE 1080
HEALTHCHECK --retries=1 --start-period=1m --timeout=5s CMD nc -zv 0.0.0.0 1080 || exit 1

ENTRYPOINT ["dumb-init"]
CMD ["sh", "-c", "sockd -N 20"]
