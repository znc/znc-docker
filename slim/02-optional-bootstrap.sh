# Allow mounting a read-only volume with ZNC configs/files. The files in
# '/bootstrap' will be copied to '/znc-data' at runtime since ZNC expects write
# access. This is useful for k8s ConfigMaps/Secrets which only allow mounting
# read-only volumes (for now).
# Note, to use a mounted directory on the host machine you will need to ensure
# you run 'chown -R 100' (the znc uid) prior to running the container.
if [ -d /bootstrap ]; then
  cp -RT /bootstrap /znc-data
fi
