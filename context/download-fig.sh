#!/usr/bin/env bash

cd /usr/local/bin
case "$ARCH" in
  amd64)
    wget -O fig.tar.xz https://github.com/diaryx-org/fig/releases/download/v6.0.0/fig-linux-x86_64.tar.gz
    ;;
  arm64)
    wget -O fig.tar.xz https://github.com/diaryx-org/fig/releases/download/v6.0.0/fig-linux-aarch64.tar.gz
    ;;
  *)
    echo "Unknown architechture: $ARCH"
    exit 1
    ;;
  esac
tar xa --no-same-permissions -f fig.tar.xz
