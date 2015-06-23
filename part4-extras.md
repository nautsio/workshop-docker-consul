# Already done?

Wow, you're quick :-)
<br><br>
Here is some more stuff you could try:

- Health-checks
- A/B Testing
- Feature toggles

<br>
Careful though, you're on you own now...

!SLIDE

# Health Checks

!SUB

Consul support [health checks](https://consul.io/intro/getting-started/checks.html)

Add health-checks to helloworld app

Remove from haproxy if failed


!SUB
Example of a dumb health-check
```
$ ping -c3 redis.service.consul
PING redis.service.consul (172.17.0.39): 48 data bytes
56 bytes from 172.17.0.39: icmp_seq=0 ttl=64 time=0.055 ms
56 bytes from 172.17.0.39: icmp_seq=1 ttl=64 time=0.083 ms
56 bytes from 172.17.0.39: icmp_seq=2 ttl=64 time=0.160 ms
```
(this only checks is the container is still running)


!SUB
Check of actual server is still running
```
$ nc -zv redis.service.consul 6379
Warning: inverse host lookup failed for 172.17.0.39: No address associated with name
redis.service.consul [172.17.0.39] 6379 (?) open
```


!SUB
Consul's included health-checks, e.g. [HTTP, Script or TTL](https://consul.io/docs/agent/checks.html)


!SUB
Update the load-balancer based on the health of the apps

Using [Consul template](https://github.com/hashicorp/consul-template/) [with HAProxy](https://github.com/hashicorp/consul-template#examples)



!SLIDE
# A/B testing

!SUB
Simulate A/B test by adding both non-db and redis versions of the helloworld app to the same loadbalancer

!SUB
Introduce weighted load-balancing


!SLIDE
# Feature toggles

!SUB
Conditionally expose functionality using feature toggles

Use Consul's K/V store to enable/disable features


!SLIDE
# Thanks!

[cargonauts.io](http://cargonauts.io)

!SUB

### Want to know / learn more?

- [Official Docker training](https://training.xebia.com/continuous-delivery-devops/introduction-to-docker/)
- [Open Kitchen - Data Center Automation: Building multi-cloud infrastructure with Terraform](https://xebia.com/events/open-kitchen-datacentre-automation-building-multi-cloud-infrastructure-with-terraform)
- [Summer Special - Build your own Continuous Delivery pipeline using Docker](https://training.xebia.com/summer-specials/build-your-own-continuous-delivery-pipeline-using-docker/)
- [Summer Special - Deep Dive into Consul](https://training.xebia.com/summer-specials/deep-dive-into-consul/)
