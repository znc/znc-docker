#!/bin/sh

# Build modules from source.
if [ -d "${DATADIR}/modules" ]; then
    cd "${DATADIR}/modules" || exit 1

    # Find module sources.
    modules=$(find . -name "*.cpp")

    if [ -n "$modules" ]; then
        # Build modules.
        echo "Building modules $modules..."
        /opt/znc/bin/znc-buildmod $modules || exit 1
    fi
fi

