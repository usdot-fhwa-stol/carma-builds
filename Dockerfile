FROM ubuntu:jammy

ARG STOL_APT_REPOSITORY=http://s3.amazonaws.com/stol-apt-repository
ENV STOL_APT_REPOSITORY=$STOL_APT_REPOSITORY

# add the CARMA repository to the sources list
RUN echo "deb [trusted=yes] ${STOL_APT_REPOSITORY} develop main" > /etc/apt/sources.list.d/carma.list

RUN apt-get update
# add build tools including Google test and mock
RUN apt-get install -y cmake build-essential file libgtest-dev libgmock-dev

COPY cmake /opt/carma/cmake
COPY scripts /opt/carma/scripts
ENV CARMA_OPT_DIR=/opt/carma
