# 2b
## service discovery using Consul


!SUB
No hardcoded links from app to dependencies

i.e. no:
```
redis = Redis(host='123.4.5.6', port=6379)
```


!SUB
Docker links are limited

- No cross host linking
- Can only link to 1 other container under a (service)name
- Can't update after the container is running


!SUB
Need service registry

## Consul :)


!SUB
Simplest way is using DNS:

- Start Docker daemon with extra parameter: `--dns <IP of docker0>`
- Bind Consul as DNS server to the Docker host


!SUB
Start Consul in a container
```
docker run -d -p 53:53/udp -p 8500:8500 cargonauts/consul-dns /consul agent -server -bootstrap-expect 1 -data-dir /tmp/consul -config-dir /opt/config/ -client 0.0.0.0
```


!SUB
Check that Consul is running
```
$ docker ps
CONTAINER ID        IMAGE                                 COMMAND                CREATED             STATUS              PORTS                                        NAMES
78f209ea00ba        cargonauts/consul-dns:latest          "/bin/sh -c '/consul   3 seconds ago       Up 1 seconds        0.0.0.0:53->53/udp, 0.0.0.0:8500->8500/tcp   condescending_payne
```

WebUI @ http://DOCKERHOSTIP:8500


!SUB
Manually add a service to Consul
```
curl -X POST http://consul.service.consul:8500/v1/agent/service/register \
  --header 'Content-Type: application/json' \
  --data-binary '{"ID": "helloworld1", "Name": "helloworld", "Address": "123.4.5.6", "Port": 80}'
```
& check if it's registered
```
docker run -ti cargonauts/toolbox
$ dig helloworld.service.consul +short
123.4.5.6
```

WebUI @ http://DOCKERHOSTIP:8500


!SUB
Remove the manually created service
```
curl -X POST \
	http://consul.service.consul:8500/v1/agent/service/deregister/helloworld1
```


!SUB
Automatically registering a service

Register from within the container after the process has started
```
$ docker run -d redis-with-wrapper
```
Check WebUI for new service


!SUB
Stopping the container doesn't unregister it
```
$ docker stop CONTAINERID
```
Check webUI, service is still there



!SUB
servicewrapper to register & unregister
```
$ docker stop
# works
$ docker kill
# doesn't
```


!SUB
Can't guarantee cleanup from within a container

So the service registry should be updated from outside the container


!SUB
Solution: listen to the Docker event stream

Using Jeff Lindsay's [registrator](https://github.com/gliderlabs/registrator)


!SUB
Automatically register & unregister a container using registrator
