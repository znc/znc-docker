FROM alpine:3.5

ENV ZNC_VERSION 1.6.4
ENV GPG_KEY D5823CACB477191CAC0075555AE420CC0209989E

# modperl and modpython are built, but won't be loadable.
# :extmodules image installs perl and python3 again, making these modules loadable.

# musl silently doesn't support AI_ADDRCONFIG yet, and ZNC doesn't support Happy Eyeballs yet.
# Together they cause very slow connection.
ARG CONFIGUREFLAGS="--prefix=/opt/znc --enable-cyrus --enable-perl --enable-python --disable-ipv6"
ARG MAKEFLAGS=""

RUN set -x \
    && adduser -S znc \
    && addgroup -S znc \
    && apk add --no-cache --virtual runtime-dependencies \
        tini \
        icu \
        openssl \
        cyrus-sasl \
        ca-certificates \
    && apk add --no-cache --virtual build-dependencies \
        build-base \
        icu-dev \
        openssl-dev \
        cyrus-sasl-dev \
        gnupg \
        perl-dev \
        python3-dev \
    && mkdir /znc-src && cd /znc-src \
    && wget "http://znc.in/releases/archive/znc-${ZNC_VERSION}.tar.gz" \
    && wget "http://znc.in/releases/archive/znc-${ZNC_VERSION}.tar.gz.sig" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "${GPG_KEY}" \
    && gpg --batch --verify znc-"${ZNC_VERSION}.tar.gz.sig" znc-"${ZNC_VERSION}.tar.gz" \
    && rm -R "$GNUPGHOME" \
    && tar -zxf znc-"${ZNC_VERSION}.tar.gz" \
    && mkdir build && cd build \
    && ../znc-"${ZNC_VERSION}"/configure ${CONFIGUREFLAGS} \
    && make $MAKEFLAGS \
    && make install \
    && apk del build-dependencies \
    && cd / && rm -Rf /znc-src

COPY docker-entrypoint.sh /

USER znc
VOLUME /znc-data

EXPOSE 6667

ENTRYPOINT ["/docker-entrypoint.sh"]
