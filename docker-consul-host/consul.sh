cat <<EOT >/var/lib/boot2docker/profile
EXTRA_ARGS='--dns 172.17.42.1 --dns 8.8.4.4 --dns 8.8.8.8 --dns-search service.consul'
DOCKER_TLS='no'
EOT

sudo /etc/init.d/docker restart
echo "Waiting for Docker daemon to start";
while ! docker ps &> /dev/null; do sleep 1; done
