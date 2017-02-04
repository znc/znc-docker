FROM znc:small

RUN set -x \
    && apk add --no-cache \
        build-base \
        icu-dev \
        openssl-dev \
        perl \
        python3
COPY znc-build-modules.sh /
