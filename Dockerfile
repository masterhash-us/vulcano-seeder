FROM alpine:3.3
MAINTAINER Vulcano <support@vulcanocrypto.com>

RUN mkdir -p /app/bin /app/src /var/lib/vulcano-seeder

WORKDIR /app/src

ADD . /app/src

RUN apk --no-cache add --virtual build_deps    \
      boost-dev                                \
      gcc                                      \
      git                                      \
      g++                                      \
      libc-dev                                 \
      make                                     \
      openssl-dev                           && \

    make                                    && \
    mv /app/src/dnsseed /app/bin/dnsseed    && \
    rm -rf /app/src                         && \

    apk --purge del build_deps

RUN apk --no-cache add    \
      libgcc              \
      libstdc++

WORKDIR /var/lib/vulcano-seeder
VOLUME /var/lib/vulcano-seeder

EXPOSE 53/udp

ENTRYPOINT ["/app/bin/dnsseed"]