FROM ppc64le/ubuntu:16.04

MAINTAINER Abhishek Dasgupta <abdasgupta@in.ibm.com>

RUN apt-get update && apt-get install -y \
        build-essential \
        curl \
        git \
        libfreetype6-dev \
        libpng12-dev \
        libzmq3-dev \
        nodejs \
        npm \
        openjdk-8-jdk \
        openjdk-8-jre-headless \
        pkg-config \
        python-dev \
        python-numpy \
        python-pip \
        software-properties-common \
        swig \
        zip \
        zlib1g-dev \
        libcurl3-dev \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -fSsL -O https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    rm get-pip.py

RUN pip install grpcio
RUN pip install mock

COPY tensorflow-app/ /tensorflow-app/

WORKDIR /tensorflow-app/flowers

RUN touch package.json
RUN npm install express --save
RUN npm install shortid --save
RUN npm install multer --save
RUN npm install command-line-args --save

WORKDIR /

CMD ["/bin/bash"]
