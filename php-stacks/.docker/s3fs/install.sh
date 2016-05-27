#!/bin/bash

# Install dependencies
apt-get update
apt-get install -y \
        automake \
        autotools-dev \
        g++ \
        libcurl4-gnutls-dev \
        libfuse-dev \
        libssl-dev \
        libxml2-dev \
        make \
        pkg-config \
        unzip

# Install S3FS
git clone https://github.com/s3fs-fuse/s3fs-fuse.git /usr/s3fs-repository
cd /usr/s3fs-repository
./autogen.sh
./configure --prefix=/usr --with-openssl
make
make install