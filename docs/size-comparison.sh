#!/bin/sh

podman pull ghcr.io/atuinsh/atuin:18.19.0
podman pull ghcr.io/csjewell/atuin-tiny:latest-v18.19.0

mkdir -p comparison

podman save --format=docker-archive ghcr.io/csjewell/atuin-tiny:latest-v18.19.0 -o comparison/atuin-tiny.tar
podman save --format=docker-archive ghcr.io/atuinsh/atuin:18.19.0 -o comparison/atuin.tar

# This is because I happen to have ls aliased to eza.
command ls -AsS1 --human-readable comparison/


