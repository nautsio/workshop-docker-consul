IP_ETH0=$(ifconfig eth1 | grep 'inet addr:' | cut -d: -f2 | awk '{print $1'})
echo 'Boot2docker box created. To access with local docker client use settings below:'
echo ''
echo "  export DOCKER_HOST=tcp://${IP_ETH0}:2375"
echo '  unset DOCKER_TLS_VERIFY'
echo '  unset DOCKER_CERT_PATH'
echo ''