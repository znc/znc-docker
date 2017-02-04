#!/bin/sh

# Options.
export DATADIR="/znc-data"

# Make sure $DATADIR is owned by znc user. This effects ownership of the
# mounted directory on the host machine too.
chown -R znc:znc "$DATADIR" || exit 1
chmod 700 "$DATADIR" || exit 2

# Added by znc:full image
if [ -r /znc-build-modules.sh ]; then
    /znc-build-modules.sh || exit 3
fi

exec /opt/znc/bin/znc --foreground --datadir /znc-data "$@"
