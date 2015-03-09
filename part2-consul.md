### part2
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
### part2a
![Consul logo](img/consul-servicediscovery.png) <!-- .element: class="noborder" -->

## service discovery using Consul


!SUB
### Consul Service Discovery interfaces

- DNS: Simple, no changes to application needed, legacy-friendly
- HTTP: For richer metadata


<br>We'll be using Consul's DNS interface for this example


!SUB
### Docker with Consul DNS based Service Discovery
Docker can supply [custom DNS configurations](https://docs.docker.com/articles/networking/#configuring-dns) to containers

This allows us to use the DNS Service Discovery interface provided by Consul with all our containers


!SUB
### Docker settings
#### For Consul's DNS based Service Discovery

- Use the Docker host itself as the first DNS server: `--dns <IP of docker0>`
- Automatically search for `hostname.consul.service` if we do a lookup for a hostname: `--dns-search service.consul`

<small>(both of these have already been applies in the Docker host image you're using)</small>


!SUB
### Consul settings
#### To use Consul as a DNS server for the Docker host
We have to tell Consul to bind it's DNS and HTTP interfaces to the Docker host

We do this by adding the `-client 0.0.0.0` argument to Consul

<small>(this has already been done in the [cargonauts/consul-web image](https://registry.hub.docker.com/u/cargonauts/consul-web/) we're using)</small>


!SUB
### Publishing Consul's ports to the host
Finally when we run the Consul container we have to publish it's DNS and HTTP ports with the following Docker run arguments

- DNS: `-p 53:53/udp`
- HTTP `-p 8500:8500`

<small>(this has already been done in the `part2/Vagrantfile`)</small>



!SUB
Example `Vagrantfile`
```
Vagrant.configure("2") do |config|
...
  config.vm.define "consul" do |consul|
    consul.vm.provider "docker" do |d|
      d.image = "cargonauts/consul-web"
      d.ports = ['53:53/udp', '8500:8500']
    end
  end
...
end
```


!SUB
### Part2a Exercise


!SUB
Start the Dockerized Consul
```
$ cd part2a
# Start the container
$ vagrant up
Bringing machine 'consul' up with 'docker' provider...
==> consul: Docker host is required. One will be created if necessary...
    consul: Docker host VM is already ready.
    ...
```
And start a container with the necessary tools
```
$ docker run -ti cargonauts/toolbox-networking
```


!SUB
Now we can see if the Consul DNS service works
```
root@fc2959ba5207:/# ping -c 3 consul.service.consul
PING consul.service.consul (172.17.0.6): 48 data bytes
56 bytes from 172.17.0.6: icmp_seq=0 ttl=64 time=0.052 ms
56 bytes from 172.17.0.6: icmp_seq=1 ttl=64 time=0.164 ms
56 bytes from 172.17.0.6: icmp_seq=2 ttl=64 time=0.189 ms
--- consul.service.consul ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max/stddev = 0.052/0.135/0.189/0.060 ms
```

!SUB
We can use the `dig` tool to view DNS records
```
root@fc2959ba5207:/# dig consul.service.consul
; <<>> DiG 9.8.4-rpz2+rl005.12-P1 <<>> consul.service.consul
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 2476
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 0

;; QUESTION SECTION:
;consul.service.consul.		IN	A

;; ANSWER SECTION:
consul.service.consul.	0	IN	A	172.17.0.6

;; Query time: 2 msec
;; SERVER: 172.17.42.1#53(172.17.42.1)
;; WHEN: Mon Mar  9 19:20:44 2015
;; MSG SIZE  rcvd: 76
```


!SUB
Manually add a service to Consul
```
root@fc2959ba5207:/# curl -X POST http://consul.service.consul:8500/v1/agent/service/register \
  --header 'Content-Type: application/json' \
  --data-binary '{"ID": "manualapp1", "Name": "manualapp", "Address": "123.4.5.6", "Port": 8888}'
```


!SUB
Now check if we can find our new service
```

$ dig helloworld.service.consul +short
123.4.5.6
```


!SUB
### Consul WebUI
Consul also has an optional Web Interface

It's available at the same port as Consul's HTTP interface, which we've published to the Docker host at

[192.168.10.10:8500](http://192.168.10.10:8500)


!SUB
Remove the manually created service
```
curl -X POST \
	http://consul.service.consul:8500/v1/agent/service/deregister/helloworld1
```



!SLIDE
### part2b
![Consul logo](img/consul-servicediscovery.png) <!-- .element: class="noborder" -->

## Automatic Service Discovery using Consul


!SUB
Automatically registering a service

Register from within the container after the process has started
```
$ docker run -d redis-with-wrapper
```
Check WebUI for new service


!SUB
Start the Dockerized Consul, app and database 
```
$ cd part2a
# Start the containers
$ vagrant up --no-parallel
Bringing machine 'consul' up with 'docker' provider...
Bringing machine 'redis' up with 'docker' provider...
Bringing machine 'hellodb' up with 'docker' provider...
==> consul: Docker host is required. One will be created if necessary...
    consul: Docker host VM is already ready.
```


!SUB
Check if the containers are running
```
$ vagrant status
Current machine states:
consul                    running (docker)
redis                     running (docker)
hellodb                   running (docker)

$ docker ps
CONTAINER ID        IMAGE                                 COMMAND                CREATED              STATUS              PORTS                NAMES
adad6ed2d591        cargonauts/helloworld-python:latest   "/srv/helloworld-db.   About a minute ago   Up About a minute   0.0.0.0:80->80/tcp   part1b_hellodb_1425834932
9495f0cbe1f7        redis:latest                          "/entrypoint.sh redi   2 minutes ago        Up 2 minutes        6379/tcp             part1b_redis_1425834915
78f209ea00ba        cargonauts/consul-web:latest          "/consul agent -serv   3 seconds ago        Up 1 seconds        0.0.0.0:53->53/udp, 0.0.0.0:8500->8500/tcp   condescending_payne
```

!SUB
Check if the application works, visit [192.168.10.10](http://192.168.10.10)


!SUB
Topology including Consul:
![Consul](img/topology/2a_consul.png) <!-- .element: class="noborder" -->


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





!SLIDE
### part2c
![Consul logo](img/consul-servicediscovery.png) <!-- .element: class="noborder" -->
## Automatic Service Discovery using Consul and Registrator


!SUB
Solution: listen to the Docker event stream

Using Jeff Lindsay's [registrator](https://github.com/gliderlabs/registrator)


!SUB
Automatically register & unregister a container using registrator

!SUB

We've added Registrator to the topology:
![Consul and Registrator](img/topology/2b_registrator.png) <!-- .element: class="noborder" -->

