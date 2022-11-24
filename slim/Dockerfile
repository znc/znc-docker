FROM alpine:3.17

ENV GPG_KEY D5823CACB477191CAC0075555AE420CC0209989E

# modperl and modpython are built, but won't be loadable.
# :full image installs perl and python3 again, making these modules loadable.

ARG CMAKEFLAGS="-DCMAKE_INSTALL_PREFIX=/opt/znc -DWANT_CYRUS=YES -DWANT_PERL=YES -DWANT_PYTHON=YES"
ARG MAKEFLAGS=""

ENV ZNC_VERSION 1.8.2

RUN set -x \
    && adduser -S znc \
    && addgroup -S znc \
    && apk add --no-cache --virtual runtime-dependencies \
        boost \
        ca-certificates \
        cyrus-sasl \
        icu \
        icu-data-full \
        openssl \
        su-exec \
        tini \
        tzdata \
    && apk add --no-cache --virtual build-dependencies \
        boost-dev \
        build-base \
        cmake \
        curl \
        cyrus-sasl-dev \
        gettext \
        gnupg \
        icu-dev \
        openssl-dev \
        perl-dev \
        python3-dev \
    && mkdir /znc-src && cd /znc-src \
    && curl -fsSL "https://znc.in/releases/archive/znc-${ZNC_VERSION}.tar.gz" -o znc.tgz \
    && curl -fsSL "https://znc.in/releases/archive/znc-${ZNC_VERSION}.tar.gz.sig" -o znc.tgz.sig \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "${GPG_KEY}" \
    && gpg --batch --verify znc.tgz.sig znc.tgz \
    && rm -rf "$GNUPGHOME" \
    && tar -zxf znc.tgz --strip-components=1 \
    && mkdir build && cd build \
    && cmake .. ${CMAKEFLAGS} \
    && make $MAKEFLAGS \
    && make install \
    && apk del build-dependencies \
    && cd / && rm -rf /znc-src

COPY entrypoint.sh /
COPY startup-sequence /startup-sequence/

VOLUME /znc-data

ENTRYPOINT ["/entrypoint.sh"]
