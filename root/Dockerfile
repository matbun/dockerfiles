FROM ubuntu:noble
LABEL org.opencontainers.image.description="ROOTv6.32.06 on Ubuntu 24.04"
LABEL maintainer="Matteo Bunino - matteo.bunino@cern.ch"

SHELL ["/bin/bash", "-c"]

WORKDIR /dependencies

# Install dependencies: https://root.cern/install/dependencies/#ubuntu-and-other-debian-based-distributions
RUN apt-get update && \
    apt-get install -y binutils cmake wget dpkg-dev g++ gcc libssl-dev git libx11-dev \
    libxext-dev libxft-dev libxpm-dev python3 libtbb-dev libvdt-dev libgif-dev && \
    apt-get install -y gfortran libpcre3-dev \
    libglu1-mesa-dev libglew-dev libftgl-dev \
    libfftw3-dev libcfitsio-dev libgraphviz-dev \
    libavahi-compat-libdnssd-dev libldap2-dev \
    python3-dev python3-numpy libxml2-dev libkrb5-dev \
    libgsl-dev qtwebengine5-dev nlohmann-json3-dev libmysqlclient-dev && \
    rm -rf /var/lib/apt/lists/*

# Install ROOT
RUN wget https://root.cern/download/root_v6.32.06.Linux-ubuntu24.04-x86_64-gcc13.2.tar.gz &&\
    tar -xzvf root_v6.32.06.Linux-ubuntu24.04-x86_64-gcc13.2.tar.gz && \
    rm root_v6.32.06.Linux-ubuntu24.04-x86_64-gcc13.2.tar.gz

# Make sure that ROOT is visible
RUN echo 'source /dependencies/root/bin/thisroot.sh' >> ~/.bashrc && \
    echo 'source /dependencies/root/bin/thisroot.sh' >> ~/.bash_profile && \
    echo 'source /dependencies/root/bin/thisroot.sh' >> ~/.profile

WORKDIR /app
