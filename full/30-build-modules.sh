# Build modules from source.

if [ -d "${DATADIR}/modules" ]; then
    cd "${DATADIR}/modules" || exit 11

    # if version file doesn't exist, create it
    if [ ! -f ".version" ]; then
        touch .version
    fi

    # Check version we were at when znc-buildmod was last run
    if [ "$ZNC_VERSION" != "$(cat .version)" ]; then

        # Find module sources.
        modules=$(find . -name "*.cpp")

        if [ -n "$modules" ]; then
            # Build modules.
            echo "Building modules $modules..."
            /opt/znc/bin/znc-buildmod $modules || exit 12
        fi
        echo -n $ZNC_VERSION > .version
    fi
    cd /
fi
