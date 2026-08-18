# Development Environment

The development environment for this repository requires two things:

1. Git (of course)
2. A containerization builder/manager (docker, podman, nerdctl, etc.)

While I use Podman (and use its recommended general name of Containerfile
in this repository,) we DO use Docker syntax, so, for example, the warning
about HEALTHCHECK not being supported is fine.

A third thing is useful - a development-environment manager. I happen to
use [mise-en-place](https://mise.jdx.dev/) myself, and a file has been
committed to configure it. Mise will set up current versions of
the `depot`, `oras`, and `gh` commands to be in the path when you enter the
checkout directory if you set the configuration to be trusted.

`depot` is used to perform the building on [depot.dev](https://depot.dev) -
You'll want your own account there if you wish to use their services. I
will admit that they build container images FAST - especially
multi-architecture container images - compared to using the standard
docker/setup-qemu and docker/build-push-action on GitHub Actions.

`oras` and `gh` are used to run the commands in docs/transparency.md
if you wish to for yourself.

Beyond that, have at it!
