FROM ubuntu:latest

ENV ANACONDA_FILE Anaconda3-2019.07-Linux-x86_64.sh
ENV ANACONDA_PATH /opt/anaconda3

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH $ANACONDA_PATH/bin:$PATH

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates git man

WORKDIR /data/notebooks

EXPOSE 8888


