FROM alpine:3.5

ENV GPG_KEY D5823CACB477191CAC0075555AE420CC0209989E

# modperl and modpython are built, but won't be loadable.
# :full image installs perl and python3 again, making these modules loadable.

# musl silently doesn't support AI_ADDRCONFIG yet, and ZNC doesn't support Happy Eyeballs yet.
# Together they cause very slow connection. So for now IPv6 is disabled here.
ARG CONFIGUREFLAGS="--prefix=/opt/znc --enable-cyrus --enable-perl --enable-python --disable-ipv6"
ARG MAKEFLAGS=""

ENV ZNC_VERSION 1.6.4

RUN set -x \
    && adduser -S znc \
    && addgroup -S znc \
    && apk add --no-cache --virtual runtime-dependencies \
        ca-certificates \
        cyrus-sasl \
        icu \
        su-exec \
        tini \
    && apk add --no-cache --virtual build-dependencies \
        build-base \
        curl \
        cyrus-sasl-dev \
        gnupg \
        icu-dev \
        libressl-dev \
        perl-dev \
        python3-dev \
    && mkdir /znc-src && cd /znc-src \
    && curl -fsSL "http://znc.in/releases/archive/znc-${ZNC_VERSION}.tar.gz" -o znc.tgz \
    && curl -fsSL "http://znc.in/releases/archive/znc-${ZNC_VERSION}.tar.gz.sig" -o znc.tgz.sig \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "${GPG_KEY}" \
    && gpg --batch --verify znc.tgz.sig znc.tgz \
    && rm -rf "$GNUPGHOME" \
    && tar -zxf znc.tgz --strip-components=1 \
    && mkdir build && cd build \
    && ../configure ${CONFIGUREFLAGS} \
    && make $MAKEFLAGS \
    && make install \
    && apk del build-dependencies \
    && cd / && rm -rf /znc-src

COPY docker-entrypoint.sh /

VOLUME /znc-data

ENTRYPOINT ["/docker-entrypoint.sh"]
