#Dockerfile to telegraf packaging
#start system
FROM centos:latest


#install dependencies
RUN yum -y install wget ruby-devel rpm-build libvirt-devel git gcc make
RUN gem install fpm


#create user
ENV NAME="builder"
ENV HOME_DIR=/home/$NAME

RUN useradd --shell /bin/bash --create-home -u 1000 $NAME
RUN mkdir -p $HOME_DIR/build
RUN chown -R $NAME:$NAME $HOME_DIR/build

USER $NAME
WORKDIR $HOME_DIR


#install go
RUN wget https://storage.googleapis.com/golang/go1.9.linux-amd64.tar.gz 
RUN tar -xzvf go1.9.linux-amd64.tar.gz 


#create directory
RUN mkdir -p $HOME_DIR/gopath/src/github.com/influxdata/telegraf/

#env variables
ENV REPOSITORY https://github.com/Misenko/telegraf.git
ENV BRANCH meta

#copy bash
COPY packaging.sh /home/builder/packaging.sh

VOLUME ["$HOME_DIR/build"]

ENTRYPOINT ["/home/builder/packaging.sh"]

