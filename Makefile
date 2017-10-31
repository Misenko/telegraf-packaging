.PHONY: clean build

all: build

build:
		docker run --name telegraf-packaging -it -v ${PWD}/build:/home/builder/build misenko/telegraf-packaging:latest

clean:
		- rm -r build/*
		- docker rm telegraf-packaging
