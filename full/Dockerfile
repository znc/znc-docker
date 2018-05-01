FROM znc:slim

# znc:slim removed them. Install them again.
RUN set -x \
    && apk add --no-cache \
        build-base \
        cmake \
        icu-dev \
        libressl-dev \
        perl \
        python3

COPY 30-build-modules.sh /startup-sequence/
