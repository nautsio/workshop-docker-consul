# Consul
![Consul logo](img/consul-logo.png) <!-- .element: class="noborder" -->


!SUB
## Consul introduction

Consul "is a tool for discovering and configuring services in your infrastructure"


[_consul.io_](http://www.consul.io)


!SUB
### Consul Features

 - Service discovery
 - Health checking
 - Key value store
 - Multi-datacenter


[_consul.io_](http://www.consul.io)


!SUB

### Consul works with

 - Peer to peer networking
 - Gossip protocol (Serf)
 - An agent per node
 - A DNS interface (compatibility)
 - A REST interface (rich API)



!SLIDE
![Consul logo](img/consul-servicediscovery1.png) <!-- .element: class="noborder" -->

## service discovery using Consul


!SUB
### Consul Service Discovery interfaces

- DNS: Simple, no changes to application needed, legacy-friendly
- HTTP: For richer metadata


!SUB
### Docker with Consul DNS based Service Discovery
Docker can supply [custom DNS configurations](https://docs.docker.com/articles/networking/#configuring-dns) to containers

This allows us to use the DNS Service Discovery interface provided by Consul with all our containers


!SUB
### Docker settings
For Consul's DNS based Service Discovery

- Start Docker daemon with extra parameter: `--dns <IP of docker0>` <small>(this has already been done in the Docker host image we're using)</small>
- Bind Consul as DNS server to the Docker host


!SUB
### Bind Consul as a DNS server to the Docker host
```
docker run -d -p 53:53/udp -p 8500:8500 cargonauts/consul-dns /consul agent -server -bootstrap-expect 1 -data-dir /tmp/consul -config-dir /opt/config/ -client 0.0.0.0
```

- `-p 53:53` publishes Consul's DNS port to the Docker host
- `-client 0.0.0.0` binds Consul's client interfaces (DNS, HTTP) to the Docker host
- `-p 8500:8500` publishes Consul's HTTP endpoint to the Docker host)


!SUB
Check that Consul is running
```
$ docker ps
CONTAINER ID        IMAGE                                 COMMAND                CREATED             STATUS              PORTS                                        NAMES
78f209ea00ba        cargonauts/consul-dns:latest          "/bin/sh -c '/consul   3 seconds ago       Up 1 seconds        0.0.0.0:53->53/udp, 0.0.0.0:8500->8500/tcp   condescending_payne
```


!SUB
### Consul WebUI
As we've also published Consul's HTTP interface to the Docker host we can access Consul's WebUI at

[192.168.10.10:8500](http://192.168.10.10:8500)


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

Topology including Consul:
![Consul](img/topology/2a_consul.png) <!-- .element: class="noborder" -->



!SUB
Solution: listen to the Docker event stream

Using Jeff Lindsay's [registrator](https://github.com/gliderlabs/registrator)


!SUB
Automatically register & unregister a container using registrator

!SUB

We've added Registrator to the topology:
![Consul and Registrator](img/topology/2b_registrator.png) <!-- .element: class="noborder" -->

