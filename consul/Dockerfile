FROM debian:jessie
RUN apt-get update && apt-get -y install curl unzip
WORKDIR /opt
ADD dns.json /opt/config/dns.json
RUN curl -k -L -O https://dl.bintray.com/mitchellh/consul/0.5.0_linux_amd64.zip && unzip 0.5.0_linux_amd64.zip && rm 0.5.0_linux_amd64.zip

ENTRYPOINT /opt/consul agent -server -bootstrap-expect 1 -data-dir /tmp/consul -config-dir /opt/config/ -client 0.0.0.0
