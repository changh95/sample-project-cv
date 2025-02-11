FROM ubuntu:jammy

# ARG CUDA_ARCHITECTURES=native

# Prevent stop building ubuntu at time zone selection.
ARG BRANCH=develop
ENV DEBIAN_FRONTEND=noninteractive

# Prepare an empty machine for building.
RUN apt update
RUN apt install -y \
    sudo \
    git \
    cmake \
    unzip \
    ninja-build \
    build-essential \
    gfortran \
    python3 \
    python3-pip \
    intel-mkl \
    libatlas-base-dev \
    liblapack-dev \
    libblas-dev
RUN pip3 install pip
RUN pip3 install gitpython pyyaml

## For AMD CPUs using intel-mkl
ENV MKL_DEBUG_CPU_TYPE=5

## Build and install remote copy
# RUN git clone https://github.com/changh95/cpp-cv-project-template.git
# RUN cd cpp-cv-project-template &&  \
#     git remote update &&  \
#     git remote prune origin &&  \
#     git checkout ${BRANCH} &&  \
#     ./build_dependencies.py --d

## Build and install local copy
COPY . /cpp-cv-project-template/
WORKDIR /cpp-cv-project-template/
ADD . /cpp-cv-project-template/
# RUN pwd && ls -al
RUN chmod +x build_dependencies.py
RUN ./build_dependencies.py --d