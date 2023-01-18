FROM ubuntu:jammy

RUN apt-get update
RUN apt-get install -y cmake build-essential file
