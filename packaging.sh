#! /bin/bash

export PATH=$HOME_DIR/go/bin:$PATH
export GOPATH=$HOME_DIR/gopath 
TELEGRAF_PATH=$GOPATH/src/github.com/influxdata/telegraf

git clone $REPOSITORY $TELEGRAF_PATH

cd $TELEGRAF_PATH
git checkout $BRANCH

$TELEGRAF_PATH/scripts/build.py --package --platform=linux --arch=amd64

cp $TELEGRAF_PATH/build/* $HOME_DIR/build/ 
