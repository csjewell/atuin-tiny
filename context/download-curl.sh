#!/busybox/sh

case "$ARCH" in
  amd64)
    wget -O /static-curl.tar.xz https://github.com/stunnel/static-curl/releases/download/8.21.0/curl-linux-x86_64-musl-8.21.0.tar.xz
    ;;
  arm64)
    wget -O /static-curl.tar.xz https://github.com/stunnel/static-curl/releases/download/8.21.0/curl-linux-armv7-musl-8.21.0.tar.xz
    ;;
  *)
    echo "Unknown architechture: $arch"
    exit 1
    ;;
  esac
  mkdir -p /usr/local/bin
  cd /usr/local/bin
  tar xa --no-same-permissions -f /static-curl.tar.xz
  sha256sum -c SHA256SUMS >/dev/null || exit 1