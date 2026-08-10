# csjewell/atuin-tiny

This repository is just tooling to build small Atuin images - it does not
contain much in the way of what could be considered "code".

In particular, it chooses to check out Atuin within the Github Action instead of
including it as a 'git submodule' or 'git subtree' link, and then copies it into
the debian 13-based 'cc-nonroot' version of the distroless

## Contributing

The `release` branch is only for release engineering - do NOT create PR's
off of it. Create them off of `dev` instead.
