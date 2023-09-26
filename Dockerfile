FROM ubuntu:20.04

WORKDIR /akv
RUN set -eux; \
    apt-get update; \
    DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC \
    apt-get install --yes --no-install-recommends \
        build-essential ca-certificates curl libssl-dev libcurl4-openssl-dev libjson-c-dev git cmake; \
    curl -sL https://github.com/casey/just/releases/download/1.14.0/just-1.14.0-aarch64-unknown-linux-musl.tar.gz | tar -xzf -; \
    cp just /usr/local/sbin/just
