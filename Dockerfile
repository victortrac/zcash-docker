FROM ubuntu:latest
MAINTAINER Victor Trac <victor.trac@gmail.com>

ENV VERSION v1.0.0

RUN apt-get update && apt-get install -y \
      build-essential \
      pkg-config \
      libc6-dev \
      m4 \
      g++-multilib \
      autoconf \
      libtool \
      ncurses-dev \
      unzip \
      git \
      python \
      zlib1g-dev \
      wget \
      bsdmainutils \
      automake

RUN git clone https://github.com/zcash/zcash.git \
      && cd zcash/ \
      && git checkout ${VERSION}
      
RUN bash /zcash/zcutil/fetch-params.sh
RUN bash /zcash/zcutil/build.sh -j$(nproc)

# Install built libraries to /usr/local/bin
RUN cp /zcash/src/zcash-* /usr/local/bin \
    && cp /zcash/src/zcashd /usr/local/bin

# Cleanup
RUN apt-get clean && rm -rf /zcash && rm -rf /root/.ccache

CMD /usr/local/bin/zcashd
