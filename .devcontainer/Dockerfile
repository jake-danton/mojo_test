FROM ubuntu:noble

ARG DEFAULT_TZ=America/Los_Angeles
ENV DEFAULT_TZ=$DEFAULT_TZ

RUN apt-get update \
   && DEBIAN_FRONTEND=noninteractive TZ=$DEFAULT_TZ apt-get install -y \
   # Installation dependencies
   sudo \
   curl \
   # Magic/Pixi Dependencies
   # `magic init testtest --format mojoproject` fails otherwise
   tzdata \
   # C++ compiler and debugging dependencies
   build-essential \
   libedit2 \
   zlib1g-dev \
   libtinfo-dev \
   && rm -rf /var/lib/apt/lists/*

# Download the latest version of magic for Ubuntu
RUN curl -ssL https://magic.modular.com/deb10c87-7449-475a-a82c-91b48d458b77 | bash

# Change permissions to allow for Apptainer/Singularity containers
RUN chmod -R a+rwX /root
