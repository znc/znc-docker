# "docker run -ti znc sh" should work, according to
# https://github.com/docker-library/official-images

if [ "${1:0:1}" != '-' ]; then
    exec "$@"
fi
