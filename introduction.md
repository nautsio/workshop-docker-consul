# Mitchell Hashimoto
## @
# Xebia
## Hands-on session

Slides: [cargonauts.io/mitchellh-auto-dc](http://cargonauts.io/mitchellh-auto-dc)

Adé Mochtar - [amochtar@xebia.com](mailto:amochtar@xebia.com)

Simon van der Veldt - [svanderveldt@xebia.com](mailto:svanderveldt@xebia.com)



!SLIDE
# Introduction


!SUB
## Menu for today

- Orchestrate Docker containers using Vagrant
- Use Consul for service discovery
- Configure dynamic load-balancing with HAProxy
- For the quick: Health-checks / A/B Testing / Feature toggles


!SLIDE
# Setup


!SUB
## Prerequisites
[Vagrant](https://docs.vagrantup.com/v2/installation/index.html) (v 1.7+)

[Virtualbox](https://www.virtualbox.org/wiki/Downloads) (v4.3+)

[Docker client](https://docs.docker.com/installation/) (v1.5)



!SUB
Get the files

[https://github.com/cargonauts/mitchellh-auto-dc](https://github.com/cargonauts/mitchellh-auto-dc)
```
$ git clone https://github.com/cargonauts/mitchellh-auto-dc.git
$ cd mitchellh-auto-dc
```
