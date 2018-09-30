FROM arm32v7/golang:1.10

RUN apt update && apt install -y \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common

RUN  echo "deb [arch=armhf] https://download.docker.com/linux/debian \
     $(lsb_release -cs) stable" | \
     tee /etc/apt/sources.list.d/docker.list

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt update && apt install -y  docker-ce


CMD tail -f /var/log/alternatives.log