#!/bin/sh
set -eux

docker build --tag=app-builder \
             --build-arg USER=$USER \
             --build-arg UID=$(id --user $USER) \
             --build-arg GID=$(id --group $USER) \
             docker/builder
# we run this image two times, once to prime a wheel cache
mkdir -p .dockercache
docker run --rm \
           --user=$USER \
           --volume="$PWD/requirements.txt":/requirements.txt:ro \
           --volume="$PWD/.dockercache":/home/$USER \
           app-builder \
           pip wheel --requirement=/requirements.txt
# and the second time to create the final wheel set
rm -rf "$PWD/docker/deps/.wheels"
mkdir  "$PWD/docker/deps/.wheels"
docker run --rm \
           --user=$USER \
           --volume="$PWD/requirements.txt":/requirements.txt:ro \
           --volume="$PWD/.dockercache":/home/$USER \
           --volume="$PWD/docker/deps/.wheels":/home/$USER/wheels \
           app-builder \
           pip wheel --wheel-dir=wheels \
                     --requirement=/requirements.txt
# and now there are going to be tons of wheels in "docker/deps/.wheels/"
docker build --tag=app-deps docker/deps

docker build --tag=app-base --file=docker/base/Dockerfile .
# this is why we simply ignore "docker/" in .dockerignore -- it
# would inflate the context a lot and we don't need the wheels in this step

docker build --tag=app-web docker/web


