FROM ubuntu:xenial

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
                    ca-certificates curl \
                    strace gdb lsof locate net-tools htop \
                    python2.7-dbg python2.7 libpython2.7 \
 && rm -rf /var/lib/apt/lists/*

ENV PYTHON_PIP_VERSION 8.1.1
RUN set -eEx \
 && curl -fSL 'https://bootstrap.pypa.io/get-pip.py' | python2.7 - \
         --no-cache-dir --upgrade pip==$PYTHON_PIP_VERSION

COPY .wheels /wheels
RUN pip install --force-reinstall --ignore-installed --upgrade \
                --no-index --use-wheel --no-deps /wheels/* \
 && rm -rf /wheels

