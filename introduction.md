# Mitchell Hashimoto
## @
# Xebia
## Hands-on session

Slides: [cargonauts.io/mitchellh-auto-dc](http://cargonauts.io/mitchellh-auto-dc)

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

!SUB
## Notes
- Make sure you do not start the containers in parallel

  ```
  # Globally disable Vagrant's parallel executions
  export VAGRANT_NO_PARALLEL=true
  ```

  or

  ```
  # Add no parallel flag for every vagrant up
  vagrant up --no-parallel
  ```

  <small>Two reasons for this

  * Docker issue with pulling images concurrently: [Boot2docker issue #757](https://github.com/boot2docker/boot2docker/issues/757) / [Docker issue #9718](https://github.com/docker/docker/issues/9718)
  * For some exercises there are dependencies between containers

  </small>

!SUB
- Before moving to a new part, destroy the current one
```
vagrant destroy -f
```
<!-- .element: class="bash" -->
- On linux add `--provider docker` to every `vagrant up` command
```
vagrant up --provider=docker
vagrant up --no-parallel --provider docker
```
<!-- .element: class="bash" -->
