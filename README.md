# csjewell/atuin-tiny

This repository is just tooling to build small Atuin images - it does not
contain much in the way of what could be considered "code".

In particular, it chooses to check out Atuin within the Github Action
instead of including it as a 'git submodule' or 'git subtree' link,
build it, and then copy it into the 'cc-debian13:nonroot'
version of the distroless image that Google creates at
https://github.com/GoogleContainerTools/distroless.

## Using the image

Note that the container has a HEALTHCHECK that assumes that Atuin is
listening on port 8888 (Atuin's default port) - this may not be the
easiest thing to change without a wrapping Dockerfile, due to
the fact that there is no shell within the container, so we cannot
read the port from the environment within the command.

## Contributing

The `release` branch is only for releasing - do NOT create PR's
off of it. Create pull requests off of `dev` instead.
