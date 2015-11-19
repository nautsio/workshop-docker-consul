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


!SLIDE
# Setup

!SUB
## Prerequisites
- [Vagrant](https://docs.vagrantup.com/v2/installation/index.html) (v1.7)
- [Virtualbox](https://www.virtualbox.org/wiki/Downloads) (v4.3+)
- [Docker](https://docs.docker.com/installation/) (v1.8.1)

!SUB
## Get the files

[github.com/nautsio/workshop-docker-consul](https://github.com/nautsio/workshop-docker-consul)
```
$ git clone https://github.com/nautsio/workshop-docker-consul.git
$ cd workshop-docker-consul
```
Or download the files directly [zip](https://github.com/nautsio/workshop-docker-consul/archive/master.zip) or [tar.gz](https://github.com/nautsio/workshop-docker-consul/archive/master.tar.gz)

!SUB
## Notes
Make sure you do not start the containers in parallel

```bash
# Globally disable Vagrant's parallel executions
export VAGRANT_NO_PARALLEL=true
# or add the no-parallel flag for every vagrant up
vagrant up --no-parallel
```
<small>
#### This has to be done because <!-- .element: style="text-align: left" -->
* [Docker issue](https://github.com/docker/docker/issues/9718)/[boot2docker issue](https://github.com/boot2docker/boot2docker/issues/757) with pulling images concurrently
* For some exercises there are dependencies between containers

</small>

!SUB
### Linux
On Linux we have to force the provider to Docker
```bash
# Globally set the default provider to Docker
export VAGRANT_DEFAULT_PROVIDER=docker
# or add `--provider docker` to every `vagrant up` command
vagrant up --provider=docker
vagrant up --provider=docker --no-parallel
```

!SUB
### Cleanup
Before moving to a new part, destroy the current one
```
vagrant destroy -f
```
