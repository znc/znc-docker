#!/bin/sh

set -o errexit
set -o pipefail

# "docker run -ti znc sh" should work, according to
# https://github.com/docker-library/official-images
if [ "${1:0:1}" != '-' ]; then
    exec "$@"
fi

# Options.
DATADIR="/znc-data"
DEFAULTSDIR="/etc/znc-defaults"

# If no existing configuration can be found, populate the data directory with a
# set of defaults.
if [ ! -f "$DATADIR/configs/znc.conf" ]; then
    echo "No existing znc.conf found, copying defaults"
    cp -ad $DEFAULTSDIR/* $DATADIR
    /opt/znc/bin/znc --datadir "$DATADIR" --makepem
fi

# This file is added by znc:full image
if [ -r /znc-build-modules.sh ]; then
    source /znc-build-modules.sh || exit 3
fi

cd /

# ZNC itself responds to SIGTERM, and reaps its children, but whatever was
# started via *shell module is not guaranteed to reap their children.
# That's why using tini.
exec /sbin/tini -- /opt/znc/bin/znc --foreground --datadir "$DATADIR" "$@"
