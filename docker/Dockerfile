# FROM nvidia/cudagl:9.0-devel-ubuntu16.04
# versiion
ARG cuda_version=9.0
# ARG cudnn_version=7
ARG ubuntu_version=16.04

# base image
FROM nvidia/cudagl:${cuda_version}-devel-ubuntu${ubuntu_version}
MAINTAINER yubaoliu89@gmail.com

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

COPY ./keyboard /etc/default/keyboard

RUN apt-get update && apt-get install -y --fix-missing  \
    sudo \
    lsb-release \
    bash-completion \
    apt-utils \
    language-pack-ja \
    language-pack-en \
    cmake-qt-gui \
    xterm \
    lxterminal \
    libglew-dev \
    gdb  \ 
    vim \
    qtbase5-dev \
    wget \
    unzip \
    git \
    vim \
    curl \
    python-dev \
    python-tk \
    python-pip \
    qtbase5-dev \
    qt5-default \
    libeigen3-dev \
    libboost-all-dev \
    libglew-dev

# update pip
RUN curl -kL https://bootstrap.pypa.io/get-pip.py | python 

WORKDIR /root

#install OpenCV 2.4.13.5
COPY ./install_opencv2.sh /root
RUN chmod 755 install_opencv2.sh && \
    ./install_opencv2.sh

#Pangolin
RUN git clone https://github.com/stevenlovegrove/Pangolin.git \
    && cd Pangolin \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make -j \
    && make install
# Install mask rcnn dependencies
COPY requirements.txt /root/requirements.txt

# Install mask rcnn
RUN git clone https://github.com/yubaoliu/Mask_RCNN.git \
    && cd Mask_RCNN \
    && mv requirements.txt requirements.txt.bk \
    && mv /root/requirements.txt . \
    && pip install --force-reinstall -r requirements.txt \
    && python setup.py install

# coco API
RUN pip install git+https://github.com/philferriere/cocoapi.git#subdirectory=PythonAPI


CMD ["/bin/bash"]

