FROM ubuntu:latest

RUN mkdir -p /var/run/sshd
RUN apt-get update && apt-get install -y openjdk-8-jdk ca-certificates openssh-server iputils-ping curl apt-transport-https lsb-release gnupg git && apt-get clean && rm -rf /var/cache/apt/* && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*
RUN curl -fsSL https://get.docker.com | bash
RUN rm -Rf /usr/local/confluent
RUN curl -sL --http1.1 https://cnfl.io/cli | sh -s -- -b /opt/opschain/confluent latest
RUN chmod -R 755 /opt/opschain/confluent
RUN ln -s /opt/opschain/confluent/confluent /usr/local/bin/confluent

RUN useradd -rm -d /home/ssh_user -s /bin/bash ssh_user && echo ssh_user:password123 | chpasswd

RUN mkdir -p /home/ssh_user/.ssh && chmod 700 /home/ssh_user/.ssh

COPY .pub /home/ssh_user/.ssh/authorized_keys

RUN chmod 600 /home/ssh_user/.ssh/authorized_keys

CMD ["/usr/sbin/sshd","-D"]

