FROM znc:small

# znc:small removed them. Install them again.
RUN set -x \
    && apk add --no-cache \
        build-base \
        icu-dev \
        openssl-dev \
        perl \
        python3
COPY znc-build-modules.sh /
