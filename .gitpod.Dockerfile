FROM ubuntu:latest

RUN mkdir -p /var/run/sshd
RUN apt-get update && apt-get install -y openjdk-8-jdk openssh-server

RUN useradd -rm -d /home/ssh_user -s /bin/bash ssh_user && echo ssh_user:password123 | chpasswd

RUN mkdir -p /home/ssh_user/.ssh && chmod 700 /home/ssh_user/.ssh

COPY .pub /home/ssh_user/.ssh/authorized_keys

RUN chmod 600 /home/ssh_user/.ssh/authorized_keys

CMD ["/usr/sbin/sshd","-D"]

