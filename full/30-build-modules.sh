# Build modules from source.

if [ -d "${DATADIR}/modules" ]; then
    cd "${DATADIR}/modules" || exit 11

    # Find module sources.
    modules=$(find . -name "*.cpp")

    if [ -n "$modules" ]; then
        # Build modules.
        echo "Building modules $modules..."
        /opt/znc/bin/znc-buildmod $modules || exit 12
    fi

    cd /
fi

