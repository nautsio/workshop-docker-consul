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
[Vagrant](https://docs.vagrantup.com/v2/installation/index.html) (v 1.7+)

[Virtualbox](https://www.virtualbox.org/wiki/Downloads) (v4.3+)

[Docker client](https://docs.docker.com/installation/) (v1.5)



!SUB
Get the files

[https://github.com/xebia/meetup-automating-the-modern-datacenter](https://github.com/xebia/meetup-automating-the-modern-datacenter)
```
$ git clone https://github.com/xebia/meetup-automating-the-modern-datacenter.git
$ cd meetup-automating-the-modern-datacenter
```
