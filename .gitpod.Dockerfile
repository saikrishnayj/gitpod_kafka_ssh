FROM ubuntu:latest

RUN mkdir -p /var/run/sshd
RUN apt-get update && apt-get install -y openjdk-8-jdk openssh-server

USER gitpod

RUN mkdir -p /home/gitpod/.ssh && chmod 700 /home/gitpod/.ssh

COPY .pub /home/gitpod/.ssh/authorized_keys

RUN chmod 600 /home/gitpod/.ssh/authorized_keys

CMD ["/usr/sbin/sshd","-D"]

