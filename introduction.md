# Mitchell Hashimoto
## @
# Xebia
## Hands-on session

Slides: [xebia.github.io/meetup-automating-the-modern-datacenter](http://xebia.github.io/meetup-automating-the-modern-datacenter)

Adé Mochtar - [amochtar@xebia.com](mailto:amochtar@xebia.com)

Simon van der Veldt - [svanderveldt@xebia.com](mailto:svanderveldt@xebia.com)



!SLIDE
# Introduction

!SUB



!SLIDE
# Setup


!SUB
Install Vagrant


!SUB
Install Packer


!SUB
Check if it works
```
packer --version
> Packer v0.6.1
```


!SUB
Get the files

[github.com/xebia/meetup-automating-the-modern-datacenter](https://github.com/xebia/meetup-automating-the-modern-datacenter)
```
git clone https://github.com/xebia/meetup-automating-the-modern-datacenter.git
```



!SLIDE
# Vagrant
![PVagrant](img/vagrant-logo.png) <!-- .element: class="noborder" -->



!SLIDE
# Packer
![Packer logo](img/packer-logo.png) <!-- .element: class="noborder" -->


!SUB
## Packer introduction

"Packer is a tool for creating identical machine images for multiple platforms from a single source configuration."

[_packer.io_](http://www.packer.io)


!SUB
## Packer features

- A single template  creates images for multiple platforms
- Use (existing) configuration management
- Parallel image creation

[_packer.io_](http://www.packer.io/intro)


!SUB
### Packer works with

- Packer template file (json)
- Builders (Docker, AWS, etc)  
- Provisioners (Shell script, Salt, etc)



!SLIDE
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
