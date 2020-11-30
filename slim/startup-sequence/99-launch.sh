# ZNC itself responds to SIGTERM, and reaps its children, but whatever was
# started via *shell module is not guaranteed to reap their children.
# That's why using tini.

exec /sbin/tini -- /opt/znc/bin/znc --foreground --datadir "$DATADIR" "$@"
