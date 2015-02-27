FROM debian:jessie
RUN apt-get update && apt-get -y install wget python
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py
RUN pip install flask redis

ADD . /code
WORKDIR /code
EXPOSE 80
ENTRYPOINT python app.py
