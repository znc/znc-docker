# Make sure $DATADIR is owned by znc user. This affects ownership of the
# mounted directory on the host machine too.
# Also allow the container to be started with `--user`.

if [ "$(id -u)" = '0' ]; then
    chown -R znc:znc "$DATADIR" || exit 1
    chmod 700 "$DATADIR" || exit 2
    exec su-exec znc:znc /entrypoint.sh "$@"
fi
