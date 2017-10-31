FROM centos:latest

ENV user="builder"
ENV HOME_DIR="/home/${user}" \
    REPOSITORY="https://github.com/Misenko/telegraf.git" \
    BRANCH="meta"

LABEL application="telegraf-packaging" \
      description="Packaging of customized telegraf packages" \
      maintainer="kimle@cesnet.cz" \
      version=1.0.0

#install dependencies
RUN yum -y install wget ruby-devel rpm-build libvirt-devel git gcc make && \
    gem install fpm

#create user
RUN useradd --shell /bin/bash --create-home -u 1000 ${user} && \
    mkdir -p ${HOME_DIR}/build && \
    chown -R ${user}:${user} ${HOME_DIR}/build

USER ${user}
WORKDIR ${HOME_DIR}

#install go
RUN wget https://storage.googleapis.com/golang/go1.9.linux-amd64.tar.gz && \
    tar -xzvf go1.9.linux-amd64.tar.gz && \
    mkdir -p ${HOME_DIR}/gopath/src/github.com/influxdata/telegraf/

#copy bash
COPY packaging.sh ${HOME_DIR}/packaging.sh

VOLUME ["${HOME_DIR}/build"]

ENTRYPOINT ["/home/builder/packaging.sh"]
