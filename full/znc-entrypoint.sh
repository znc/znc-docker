#!/bin/sh

# Options.
DATADIR="/znc-data"

# Build modules from source.
if [ -d "${DATADIR}/modules" ]; then
    pushd "${DATADIR}/modules" > /dev/null || exit 1

    # Find module sources.
    modules=$(find "${DATADIR}/modules" -name "*.cpp")

    if [ -n "$modules" ]; then
        # Build modules.
        echo "Building modules $modules..."
        /opt/znc/bin/znc-buildmod $modules
    fi

    popd > /dev/null
fi

exec /opt/znc/bin/znc -f -d /znc-data $@
