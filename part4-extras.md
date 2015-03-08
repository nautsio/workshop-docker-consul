# Extra exercises for the quick

- Health-checks (update service registry)
- A/B Testing
- Feature toggles using K/V toggles


!SLIDE

# Health Checks

!SUB
Health-checks for the webserver apps

Remove from load-balancer if failed


!SUB
Dumb health-check
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
Consul's included health-checks, e.g. HTTP


!SUB
Update the load-balancer based on the health of the apps

Using [Consul template](https://github.com/hashicorp/consul-template/) [with HAProxy](https://github.com/hashicorp/consul-template#examples)



!SLIDE
# 5
A/B testing


!SUB
Add new version of app to load-balancer
(helloworldp-python:1.1)



!SUB
Extra excercise: weighted load-balancing



!SLIDE
# 6/extra excercise
Feature toggles using Consul's K/V store
