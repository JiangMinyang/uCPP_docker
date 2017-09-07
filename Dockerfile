FROM ubuntu:latest
MAINTAINER Minyang Jiang <minyang@minyang-jiang.com>

WORKDIR /workspace

RUN apt-get update && apt-get install -y wget build-essential software-properties-common 
RUN add-apt-repository ppa:ubuntu-toolchain-r/test -y
RUN apt-get update
RUN apt-get install gcc-6 g++-6 -y

RUN wget http://plg.uwaterloo.ca/~usystem/pub/uSystem/u++-7.0.0.sh
RUN chmod +x u++-7.0.0.sh
RUN sh u++-7.0.0.sh