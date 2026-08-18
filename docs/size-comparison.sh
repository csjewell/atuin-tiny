#!/bin/sh

podman pull ghcr.io/atuinsh/atuin:18.19.0
podman pull ghcr.io/csjewell/atuin-tiny:latest-18.19.0
podman pull ghcr.io/csjewell/atuin-tiny:latest-18.19.0-nocurl

mkdir -p comparison

podman save --format=docker-archive ghcr.io/csjewell/atuin-tiny:latest-18.19.0-nocurl -o comparison/atuin-tiny-nocurl.tar
podman save --format=docker-archive ghcr.io/csjewell/atuin-tiny:latest-18.19.0 -o comparison/atuin-tiny.tar
podman save --format=docker-archive ghcr.io/atuinsh/atuin:18.19.0 -o comparison/atuin.tar

# The `command` bit is because I happen to have ls aliased to eza.
# https://github.com/eza-community/eza is where you can get that, if you wish.
command ls -AsS1 --human-readable comparison/


