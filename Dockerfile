FROM dengrocrm/baseimage-alpine:latest
MAINTAINER dandengro
LABEL maintainer="dandengro"

RUN \
    # Install build packages.
    apk --no-cache add --virtual build-dependencies \
        musl-dev \
        go \
        git \
    && mkdir -p /root/gocode \
    && export GOPATH=/root/gocode \
    && go get github.com/mailhog/MailHog \
    && mv /root/gocode/bin/MailHog /usr/local/bin/ \
    && rm -rf /root/gocode \
    && apk del --purge build-dependencies \
    # Cleanup.
    rm -rf \
        /tmp/*

# Copy local files.
COPY root/ /

# Expose ports.
EXPOSE 1025 8025

# Config volume.
VOLUME /config