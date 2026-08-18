# Transparency

There is, unfortunately, no absolute security guarantee. Given that, I
try to be as transparent as possible so that you can be comfortable with
your own computer's security when using this container image - especially
since I'm just "J. Random Open-Source-Developer", unassociated with the
Atuin project itself - I just build it because I use it, and want a
smaller container than what the project builds.

## How I try to be transparent

Containers built from this repository include two things:

First, they include provenance. Provenance describes how the container
was built. In this repository's case, we generate it at `depot build`
time. As a side note, I use depot.dev's container-building services
because trying to build a multi-architecture container on the
Github-provided runners takes HOURS. So does the Atuin project, and
I thank them for pointing me toward Depot.)

Second, they have an attestation, which is a signature by GitHub
that the container that you download is the container that was built
by the GitHub Action from a checkout of this repository at a
particular "git hash".

Note that neither of those says that what was built is not malicious -
there have been supply-chain attacks that have made GitHub Actions
include malicious code in what was built for a non-malicious project.
The Trivy container vulnerability scanner is probably the most famous
example I can think of as I write this in August 2026 (and if you think
about it, having that particular project get malicious code included
within its generated binaries and containers was scary!)

However, the provenance documents what steps were taken to perform
the build on depot.dev, and the attestation covers both the containers
built and the provenance attached to them, so you can inspect the
directions that were used to build the container and be assured that those
WERE the directions used.

And of course, you can see the build directions here, and check out those
directions using Git. The attestation also attests to the particular
check out point (the "git hash") that was used to build the container,
so you can even check out what was checked out at build time. At that
point, yes, you have to trust GitHub. Cannot help that. You (and I) also
have to trust that Depot is generating a correct provenance.

Note that I pin to particular git hashes for each step within the
GitHub Action that builds the containers, also.

## Inspecting the provenance

To download the provenance, use [oras](https://github.com/oras-project/oras):

    oras copy ghcr.io/csjewell/atuin-tiny:<tag> --to-oci-layout provenance

If you've checked out this repository, and followed the directions in
docs/development-environment.md, you'll have oras available to you when
you are within the checkout directory.

Using the tag pulls down the top-level manifest, the container
manifests and stages for both the linux/amd64 and linux/arm64 versions,
and the provenance for both (which is attached as an 'unknown/unknown'
manifest to the top-level tag.
[GitHub's web interface](https://github.com/csjewell/atuin-tiny/pkgs/container/atuin-tiny)
thinks it's a third container that can be downloaded, but it isn't.
Oh, well.)

Once you've performed that command, you'll see that you downloaded at
least two blobs with the application/vnd.in-toto+json MIME type - one
for the linux/amd64 version and one for the linux/arm64 version. You can
inspect those with less and jq, like so, given the hash of the blob you
downloaded:

    jq -C '.' provenance/blobs/sha256/<hash> | less -R
    # The -C says 'color this', the -R says 'accept color and url codes only'

You'll see what containers were used, (using `'.predicate.materials'` instead
of `'.'` in the command above only shows that portion of the JSON,) the steps
that were taken when building the container
(`'.predicate.buildConfig.llbDefinition'`, and don't spell it libDefinition -
it has two L's in it,) the version of the Containerfile (I call it that
since I use Podman rootless locally in place of Docker) that
was used, and other things.

To extract the Containerfile used from the provenance JSON (it is
base64-encoded, so it needs passed through `base64 -d` to be readable):

    jq -r '.predicate.metadata."https://mobyproject.org/buildkit@v1#metadata".source.infos[0].data' \
        provenance/blobs/sha256/<hash> | base64 -d | less

## Checking an attestation

You can [see attestations](https://github.com/csjewell/atuin-tiny/attestations)
on the web, but ultimately, you can check them on the command line.

To check the attestation, use the Github CLI:

    gh attestation verify --owner csjewell oci:ghcr.io/csjewell/atuin-tiny:<tag or hash>

This means that GitHub has attached a certificate, verifiable with
Sigstore, that specifies that "What was attested to was what was built" -
in short, that we were within a particular GitHub Actions run,
and that the container manifest with this particular tag or hash was
built by the run.

Technically, I have GitHub attest to the hash that refers to the "top-level
manifest", so one attestation covers all of one build run, which includes the two
versions of the container and the provenance generated by [Depot](https://depot.dev).
