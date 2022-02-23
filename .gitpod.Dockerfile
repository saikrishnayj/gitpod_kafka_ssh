FROM ubuntu:lates

RUN mkdir -p /var/run/sshd
RUN apt-get update && apt-get install -y openjdk-8-jdk openssh-server


