FROM alpine:3.5

ENV ZNC_VERSION 1.6.4

ARG CONFIGUREFLAGS="--prefix=/opt/znc --enable-cyrus --enable-perl --enable-python"
ARG CLEANCMD="apk del build-dependencies && rm -Rf /znc-src"
ARG MAKEFLAGS=""

RUN set -x \
    && adduser -S znc \
    && addgroup -S znc \
    && apk add --no-cache --virtual runtime-dependencies \
        icu \
        openssl \
        python3 \
        perl \
        cyrus-sasl \
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
    && gpg --keyserver pool.sks-keyservers.net --recv-keys D5823CACB477191CAC0075555AE420CC0209989E \
    && gpg --batch --verify znc-"${ZNC_VERSION}.tar.gz.sig" znc-"${ZNC_VERSION}.tar.gz" \
    && rm -R "$GNUPGHOME" \
    && tar -zxf znc-"${ZNC_VERSION}.tar.gz" \
    && mkdir build && cd build \
    && ../znc-"${ZNC_VERSION}"/configure ${CONFIGUREFLAGS} \
    && make $MAKEFLAGS \
    && make install \
    && sh -c "$CLEANCMD"

USER znc
VOLUME /znc-data

EXPOSE 6667

ENTRYPOINT ["/opt/znc/bin/znc", "-f", "-d", "/znc-data"]
