# Serve this container on other ports

The main problem with having this container serve on other ports than 8888
is the HEALTHCHECK in the Dockerfile. If you need the Dockerfile-provided
healthcheck to still operate, you'll need to build a Dockerfile that does
this, and use the container it builds:

```dockerfile
FROM ghcr.io/csjewell/atuin-tiny:latest-v18.19.0

ENV ATUIN_PORT 8080

# Note: the port in the URL must match what is above.
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD ["/usr/local/bin/curl", "-fsS", "-o", "/dev/null", "http://localhost:8080/healthz"]
```

When you're using hosting that provides their own healthchecks that are
external to the container, then you can use the -nocurl variants of the
image. They do not provide curl or the healthcheck, and therefore, you
can serve them on whatever port you wish.
