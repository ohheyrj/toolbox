FROM alpine:3.22

# Install common backup tools and set timezone
RUN apk add --no-cache \
    curl \
    sqlite \
    aws-cli \
    mariadb-client \
    gzip \
    tar \
    jq \
    ca-certificates \
    postgresql17-client \
    tzdata \
    rclone \
    rsync \
    inetutils-telnet \
    netcat-openbsd
ENV TZ=UTC

# Create non-root user for security and prepare workspace
RUN addgroup -g 1000 backup \
    && adduser -D -u 1000 -G backup backup \
    && mkdir -p /backup \
    && chown -R backup:backup /backup

USER backup
WORKDIR /backup

CMD ["/bin/sh"]