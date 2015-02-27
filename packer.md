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
## Your first packer image
#### 2 simple steps

- Create Packer template
- Build image


!SUB
### Step 1 - Create Packer template
`example.json`
```
{
  "builders": [{
    "type": "docker",
    "image": "debian:wheezy",
    "export_path": "example.tar"
  }]
}
```

!SUB
### Step 2 - Build image
Validate your template
```
packer validate example.json
```

Build your image
```
packer build example.json
```

!SUB
### Result! 
```
==> docker: Creating a temporary directory for sharing data...
==> docker: Pulling Docker image: debian:wheezy
    docker: Pulling repository debian
==> docker: Starting docker container...
    docker: Run command: docker run -d -i -t -v /var/folders/yb/tbryjz896sgc6wl82k2m5y6r0000gn/T/packer-docker059094652:/packer-files debian:wheezy /bin/bash
    docker: Container ID: 2d087f4e41fd9282fda315e5be0505ea139faea8ed03ff784323ea6124da704a
==> docker: Exporting the container
==> docker: Killing the container: 2d087f4e41fd9282fda315e5be0505ea139faea8ed03ff784323ea6124da704a
Build 'docker' finished.

==> Builds finished. The artifacts of successful builds are:
--> docker: Exported Docker file: example.tar
```


!SLIDE
## How to use your image

!SUB
Import the image into Docker

```
cat example.tar | docker import - repo:example
```
or
```
docker import - repo:example < example.tar
```
<small>Please remove the image files after you've imported them.<br>We have to do this because there is limited space available within the boot2docker VM</small>

!NOTE
Note that it's possible to have Packer automatically import the generated image into Docker by using the [docker-import](http://www.packer.io/docs/post-processors/docker-import.html) post-processor
and that it's also possible to push the image to a Docker registry using the [docker-push](http://www.packer.io/docs/post-processors/docker-push.html) post-processor.




!SUB
Create a new container from your image
```
docker run -ti repo:example /bin/bash
> root@05938c23a8d8:/#
```

!NOTE
To check if you're inside a container run
```
root@05938c23a8d8:/# cat /proc/1/cgroup
9:perf_event:/docker/05938c23a8d8e3c48f2ba9632baf55a2fcc01fa218aeeb9851b514c30df851e5
8:blkio:/docker/05938c23a8d8e3c48f2ba9632baf55a2fcc01fa218aeeb9851b514c30df851e5
7:net_cls:/
6:freezer:/docker/05938c23a8d8e3c48f2ba9632baf55a2fcc01fa218aeeb9851b514c30df851e5
5:devices:/docker/05938c23a8d8e3c48f2ba9632baf55a2fcc01fa218aeeb9851b514c30df851e5
4:memory:/docker/05938c23a8d8e3c48f2ba9632baf55a2fcc01fa218aeeb9851b514c30df851e5
3:cpuacct:/docker/05938c23a8d8e3c48f2ba9632baf55a2fcc01fa218aeeb9851b514c30df851e5
2:cpu:/docker/05938c23a8d8e3c48f2ba9632baf55a2fcc01fa218aeeb9851b514c30df851e5
1:cpuset:/
```


!SLIDE
## Make your image do something
`fruit.json`
```
{
  "builders": [
  {
    "type": "docker",
    "image": "debian:wheezy",
    "export_path": "fruit.tar"
  }],
  "provisioners": [
  {
    "type": "shell",
    "inline": [
    "echo orange > /opt/fruit.txt"
    ]
  }]
}
```

!SUB
Build & import the image
```
packer build fruit.json
cat fruit.tar | docker import - repo:fruit
```
<small>Don't forget to remove the image file after you've imported it</small>

!SUB
See the fruit of your labour
```
docker run -ti repo:fruit cat /opt/fruit.txt
> orange
```

!SLIDE
## Your first application image
`hellowebworld.json`
```
{
  "builders": [
    {
      "type": "docker",
      "image": "debian:wheezy",
      "export_path": "hellowebworld.tar"
    }
  ],
  "provisioners": [
    {
      "type": "shell",
      "inline": [
        "apt-get update",
        "apt-get -y install python"
      ]
    },
    {
      "type": "file",
      "source": "hellowebworld.py",
      "destination": "/srv/hellowebworld.py"
    }
  ]
}
```

!SUB
Build, import & run the image
```
packer build hellowebworld.json
cat hellowebworld.tar | docker import - repo:hellowebworld
docker run -ti -p 8080:8080 repo:hellowebworld python /srv/hellowebworld.py
```

!SUB
Check the result
```
curl {CONTAINERIP}:8080
> Hello World!
```