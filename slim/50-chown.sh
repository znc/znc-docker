# Make sure $DATADIR is owned by znc user. This affects ownership of the
# mounted directory on the host machine too.

chown -R znc:znc "$DATADIR" || exit 1
chmod 700 "$DATADIR" || exit 2
