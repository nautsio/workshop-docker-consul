# Consul
![Consul logo](img/consul-logo.png) <!-- .element: class="noborder" -->

!SUB
## Consul introduction

Consul "is a tool for discovering and configuring services in your infrastructure"


[_consul.io_](http://www.consul.io)


!SUB

### Consul Features:

 - Service discovery
 - Health checking
 - Key value store
 - Multi-datacenter


[_consul.io_](http://www.consul.io)

!SUB

### Consul works with:

 - Peer to peer networking
 - Gossip protocol (Serf)
 - An agent per node
 - A DNS interface (compatibility)
 - A REST interface (rich API)

!SLIDE
## Create an image with consul installed

!SUB
`consul-base.json`
```
{
  "builders": [
    {
      "type": "docker",
      "image": "debian:wheezy",
      "export_path": "consul-base.tar"
    }
  ],
  "provisioners": [
    {
      "type": "shell",
      "inline": [
        "cd /tmp",
        "apt-get update",
        "apt-get -y install unzip wget curl dnsutils procps",
        "wget --no-check-certificate https://dl.bintray.com/mitchellh/consul/0.3.1_linux_amd64.zip",
        "unzip 0.3.1_linux_amd64.zip -d /usr/local/bin/",
        "rm 0.3.1_linux_amd64.zip"
      ]
    }
  ]
}
```

!SUB
Build, import & run the image

```
packer build consul-base.json
cat consul-base.tar | docker import - consul:base
docker run -ti consul:base bash
```

!SUB
Start consul

```
consul agent -server -bootstrap-expect 1 -data-dir /tmp/consul > /var/consul.log &
```

!SUB
Check that Consul is running

```
ps
consul members
ip addr

```

_Save the IP address for a later step_

!SUB
Create a 2nd consul container

```
docker run -ti consul:base bash
consul agent -server -bootstrap-expect 1 -data-dir /tmp/consul > /var/consul.log & 
```


!SUB
Join cluster

```
consul join {IP OF FIRST IMAGE}
```

```
consul members
```

!SLIDE
## Configure DNS with Consul

!SUB
Clean up previous images
```
docker rm -f {container-id or name}
docker rmi -f {image-id or tag}
```

!SUB
Configure DNS for Consul

Add config/dns.json:
```
{
	"recursor": "8.8.8.8",
	"ports": {
		"dns": 53
	}
}
```

!SUB
Add to your provisioner
```
    {
      "type": "file",
      "source": "config/",
      "destination": "/opt/config/"
    }
```

!SUB
Provision your image again, tag it as `consul:dns`

!SUB
Add `-config-dir /opt/config/` to the consul command

```d
docker run -ti  --dns 127.0.0.1 -h myhost consul:dns bash
consul agent -server -bootstrap-expect 1 -config-dir /opt/config/ -data-dir /tmp/consul > /var/consul.log & 
```

!SUB

Try the DNS:

```
dig myhost.node.consul
ping myhost.node.consul
```


!SLIDE
## Configure Service Definition

Add service.json to /config directory:

```
{
    "service": {
        "name": "fruit",
        "tags": ["master"],
        "port": 8080
    }
}
```

!SUB

Use service:

```
dig fruit.service.consul
```

!SUB
Use tag:

```
dig master.fruit.service.consul
```

!SUB
Try adding one more container to the cluster and `dig` again

!SUB
Make this work with the web server image you made in the Packer section:

```
curl fruit.service.consul:8080
```

!SUB
Now perform a zero-downtime upgrade of your fruit service

