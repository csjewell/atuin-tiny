# csjewell/atuin-tiny

This repository is just tooling to build small Atuin images - it does not
contain much in the way of what could be considered "code".

In particular, it chooses to check out Atuin within the Github Action
instead of including it as a 'git submodule' or 'git subtree' link,
build it, and then copy it into the 'cc-debian13:nonroot'
version of the distroless image
[that Google creates](https://github.com/GoogleContainerTools/distroless).

## Supported tags

The "Atuin version" that the image contains will usually be specified in the tag.

| Tag                                    | Purpose                                      |
| -------------------------------------- | -------------------------------------------- |
| latest-18.17.1                         | 18.17 series (to replace w/o updating)       |
| latest-18.18.1                         | 18.18 series (to replace w/o updating)       |
| _latest_, latest-18.19.0               | Current version                              |
| _latest-nocurl_, latest-18.19.0-nocurl | Current version, -nocurl variant             |
| latest-18.20*                          | "Next version" builds for testing            |
| g###-*                                 | To hold to a particular image and not update |
| dev-*                                  | Builds off the "dev" branch of this repo     |

The git hash in the "g" series of tags is referring to the git hash of
**this** repository that was used to build the image.

## Using the image

Note that the container has a HEALTHCHECK that assumes that Atuin is
listening on port 8888 (Atuin's default port) - this may not be the
easiest thing to change without a wrapping Dockerfile, due to
the fact that there is no shell within the container, so we cannot
read the port from the environment within the command.

See [docs/serve-on-other-ports.md](docs/serve-on-other-ports.md) for
how to do that.

You can use the -nocurl variant of the image if you do not need the
health check.

## Contributing

See [docs/contributing.md](docs/contributing.md) for how to contribute,
including setting things up to build from this repository, and where
to make pull requests from.
