# Serve this container on a container host

The reason I created this repository is to have a smaller, more minimal
container to use on hosts that deploy and execute containers.

In my case, I use [Fly.io](https://fly.io/machines) as my host, and
directions on how to use it are shown here, but pull-requests adding
directions to use this container on other hosts are welcomed.

## Fly.io (on a Fly Machine)

### How to do it

I happen to set it up on a Fly Machine, (and have Fly's CLI set up) and here are the
steps below to do so:

1. Create a new directory, change to it, and save the contents below as `fly.toml`.

```toml
# See https://fly.io/docs/reference/configuration/ for information about how to use this file.

app = 'atuin-YOUR-APP-NAME' # Your fly app name
primary_region = 'YOUR_REGION_OF_CHOICE' # ord, dfw, ams, lhr, nrt, syd, etcetera...

[build]
  image = 'ghcr.io/csjewell/atuin-tiny:latest-18.19.0-nocurl'

[env]
  ATUIN_DB_URI = 'sqlite:///database/atuin.db'
  # Has to be this for Fly.io to serve it at all.
  ATUIN_HOST = '0.0.0.0'
  # Set this to false once YOU have registered.
  ATUIN_OPEN_REGISTRATION = 'true'
  ATUIN_PORT = '8888'

[[mounts]]
  source = 'atuin_data'
  destination = '/database'

[http_service]
  internal_port = 8888
  force_https = true
  auto_stop_machines = 'suspend'
  auto_start_machines = true
  min_machines_running = 0

  [http_service.concurrency]
    type = 'requests'
    hard_limit = 250
    soft_limit = 200

  [http_service.tls_options]
    alpn = ['h2', 'http/1.1']
    versions = ['TLSv1.3']
    default_self_signed = false

[[http_service.checks]]
  grace_period = "12s"
  interval = "30s"
  method = "GET"
  timeout = "5s"
  path = "/healthz"

[[vm]]
  size = 'shared-cpu-1x'
  cpus = 1
  memory_mb = 256

[experimental]
  # We need to tell the server to actually START, because the Containerfiles do not do that.
  cmd = ["start"]

```

2. Run `fly deploy`.

3. If you want to have the server answer on your own domain name, run
`fly certs add <domain.name>` and follow the directions there.

### Cost

See [Fly.io pricing](https://fly.io/docs/about/pricing) for more details,
but this should help. I'm assuming the dfw region below.

Note that this ends up with a Fly Machine that should cost only $2.43 USD
IF it was running constantly (which it won't be), plus the storage cost.
Being suspended when you're not using it drops it to $0.15 per full
month of suspension (as your rootfs should be much less than 1GB.)

So, $2.43 * percent-active + $0.15 * percent-non-active.

I prefer attaching a volume to store the database, and this does that -
but a 1GB volume would only add another $0.15 per month, and that would be
a LOT of storage for atuin.db to use.

They also charge for provisioning an SSL certificate for a custom domain
IF you have more than 10 SSL certs for single custom domains on your
account - and even then, it's $1.20 a year, and half of that gets
donated to Let's Encrypt to help them out.

And bandwidth costs, of course. $0.02/GB for public internet egress, and just
how much is Atuin going to be doing?
