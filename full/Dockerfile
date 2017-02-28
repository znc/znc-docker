FROM znc:slim

# I don't know what it should do. It works for me without this line, but not for @tianon
USER root

# znc:slim removed them. Install them again.
RUN set -x \
    && apk add --no-cache \
        build-base \
        icu-dev \
        openssl-dev \
        perl \
        python3
COPY znc-build-modules.sh /

# Revert the USER root line above
USER znc
