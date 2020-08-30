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
    libglew-dev \
    parcellite \
    automake \
    autoconf \
    libssl-dev \
    libreadline-dev \
    libncurses5-dev \
    libevent-dev

# Install rbenv
RUN apt autoremove -y ruby*  \
    && apt autoremove  \
    && apt update  \
    && git clone https://github.com/rbenv/rbenv.git ~/.rbenv \
    && echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc  \
    && echo 'eval "$(rbenv init -)"' >> ~/.bashrc
ENV PATH /root/.rbenv/shims:/root/.rbenv/bin:$PATH
# Install ruby-build & ruby
RUN git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build  \
    && ~/.rbenv/bin/rbenv install 2.6.0  \
    && ~/.rbenv/bin/rbenv global 2.6.0
# Initiarize ruby encording
ENV RUBYOPT -EUTF-8


# Tmux
RUN git clone https://github.com/tmux/tmux.git \
    && cd tmux \
    && git checkout 2.6 \
    && sh autogen.sh \
    && ./configure && make && make install \
    && gem install --user-install tmuxinator


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
    && make -j 3 \
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

# dotfile
RUN cd /root \
    && git clone https://github.com/yubaoliu/dotfiles.git \
    && cd dotfiles \
    && ./deploy.sh \
    && touch ~/local_config.sh


CMD ["/bin/bash"]

