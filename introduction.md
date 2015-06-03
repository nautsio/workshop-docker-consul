![Vagrant logo](img/vagrant-logo.png) <!-- .element: class="noborder" -->
![plus](img/plus.png) <!-- .element: class="noborder" -->
![Docker logo](img/docker-logo-no-text.png) <!-- .element: class="noborder" -->
![plus](img/plus.png) <!-- .element: class="noborder" -->
![Consul logo](img/consul-logo.png) <!-- .element: class="noborder" -->
## workshop


<br><p>[cargonauts.io/mitchellh-auto-dc](http://cargonauts.io/mitchellh-auto-dc)

Adé Mochtar - [ade@cargonauts.io](mailto:ade@cargonauts.io)

Simon van der Veldt - [simon@cargonauts.io](mailto:simon@cargonauts.io)



!SLIDE
# Introduction


!SUB
## Menu for today

- Orchestrate Docker containers using Vagrant
- Use Consul for service discovery
- Configure dynamic load-balancing with HAProxy
- For the quick: Health-checks / A/B Testing / Feature toggles


!SUB
## Hands-on guidelines
- Form groups of 6-8 people
- Help each other out
- The slides should guide you
- The guys in purple are there to help you out as well ;)


!SLIDE
# Setup


!SUB
## Prerequisites
[Vagrant](https://docs.vagrantup.com/v2/installation/index.html) (v1.7.2)

[Virtualbox](https://www.virtualbox.org/wiki/Downloads) (v4.3+)

[Docker](https://docs.docker.com/installation/) / [boot2docker](http://boot2docker.io) (v1.6.2)


!SUB
## Get the files

[https://github.com/cargonauts/mitchellh-auto-dc](https://github.com/cargonauts/mitchellh-auto-dc)
```
$ git clone https://github.com/cargonauts/mitchellh-auto-dc.git
$ cd mitchellh-auto-dc
```
Or download the files directly
<br>[zip](https://github.com/cargonauts/mitchellh-auto-dc/archive/master.zip) or [tar.gz](https://github.com/cargonauts/mitchellh-auto-dc/archive/master.tar.gz)


!SUB
## Notes
Make sure you do not start the containers in parallel

```
# Globally disable Vagrant's parallel executions
export VAGRANT_NO_PARALLEL=true
# or add the no-parallel flag for every vagrant up
vagrant up --no-parallel
```
<small>

#### This has to be done because
* [Docker issue](https://github.com/docker/docker/issues/9718)/[boot2docker issue](https://github.com/boot2docker/boot2docker/issues/757) with pulling images concurrently
* For some exercises there are dependencies between containers

</small>


!SUB
### Linux
On Linux we have to force the provider to Docker
<!-- .element: class="bash" -->
```
# Globally set the default provider to Docker
export VAGRANT_DEFAULT_PROVIDER=docker
# or add `--provider docker` to every `vagrant up` command
vagrant up --provider=docker
vagrant up --provider=docker --no-parallel
```
<!-- .element: class="bash" -->


!SUB
### Cleanup
Before moving to a new part, destroy the current one
```
vagrant destroy -f
```
