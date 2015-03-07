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
## Menu for today

- Use Vagrant to orchestrate Docker containers
- Use Consul for service discovery
- Do load-balancing of a service
- Use healt-checks to update the service registry



!SLIDE
# Setup


!SUB
## Prerequisites
[Install Vagrant](https://docs.vagrantup.com/v2/installation/index.html) (v 1.7+)

[Install Virtualbox](https://www.virtualbox.org/wiki/Downloads) (v4.3+)



!SUB
Get the files

[https://github.com/xebia/meetup-automating-the-modern-datacenter](https://github.com/xebia/meetup-automating-the-modern-datacenter)
```
git clone https://github.com/xebia/meetup-automating-the-modern-datacenter.git
```



!SLIDE
# Vagrant
![PVagrant](img/vagrant-logo.png) <!-- .element: class="noborder" -->


!SUB
## Vagrant introduction
Vagrant needs no introduction ;)

But here's one anyway


!SUB
### Vagrant features


!SUB
### Vagrant works with



!SLIDE
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
