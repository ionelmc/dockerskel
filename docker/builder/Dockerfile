# we start from an image with build deps preinstalled
FROM buildpack-deps:xenial

# seems acceptable for building, note the notes above about C.UTF-8 - it's not really good for running apps
ENV LANG C.UTF-8

# we'd add all the "-dev" packages we need here
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
                    python2.7 python2.7-dbg python2.7-dev libpython2.7 \
                    strace gdb lsof locate \
 && rm -rf /var/lib/apt/lists/*

ENV PYTHON_PIP_VERSION 8.1.1
RUN set -eEx \
 && curl -fSL 'https://bootstrap.pypa.io/get-pip.py' | python2.7 - --no-cache-dir --upgrade pip==$PYTHON_PIP_VERSION

ARG USER
ARG UID
ARG GID

# we set some default options for pip here so we don't have to specify them all the time

# this will make pip additionally look for available wheels here
ENV PIP_FIND_LINKS=/home/$USER/wheelcache
# and this is the default output dir when we run `pip wheel`
ENV PIP_WHEEL_DIR=/home/$USER/wheelcache
ENV PIP_TIMEOUT=60
# one network request less, we don't care about latest version
ENV PIP_DISABLE_PIP_VERSION_CHECK=true

RUN echo "Creating user: $USER ($UID:$GID)" \
 && groupadd --system --gid=$GID $USER \
 && useradd --system --create-home --gid=$GID --uid=$UID $USER \
 && mkdir /home/$USER/wheelcache

WORKDIR /home/$USER
