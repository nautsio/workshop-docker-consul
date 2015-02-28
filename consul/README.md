# Consul

## How to use
```
# Build the image
docker build -t consul .
# Run the consul container
docker run -d -p <DOCKER0_IP>:53:53/udp consul
# for example
docker run -d -p 172.17.42.1:53:53/udp consul
```
