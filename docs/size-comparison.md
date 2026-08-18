# Size comparison

Just for a quick size-comparison on the images:

    107M atuin.tar
     56M atuin-tiny.tar
     46M atuin-tiny-nocurl.tar

How we got this comparison (so you can see we're comparing like to like):

    podman pull ghcr.io/atuinsh/atuin:18.19.0
    podman pull ghcr.io/csjewell/atuin-tiny:latest-18.19.0
    podman pull ghcr.io/csjewell/atuin-tiny:latest-18.19.0-nocurl
    mkdir -p comparison
    podman save --format=docker-archive ghcr.io/csjewell/atuin-tiny:latest-18.19.0-nocurl -o comparison/atuin-tiny-nocurl.tar
    podman save --format=docker-archive ghcr.io/csjewell/atuin-tiny:latest-18.19.0 -o comparison/atuin-tiny.tar
    podman save --format=docker-archive ghcr.io/atuinsh/atuin:18.19.0 -o comparison/atuin.tar
    command ls -AsS1 --human-readable comparison/

This is saved as a shell-script in docs/size-comparison.sh
