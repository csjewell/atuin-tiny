#!/busybox/sh

mkdir -p /usr/local/bin
cd /usr/local/bin
case "$ARCH" in
  amd64)
    wget -O /static-curl.tar.xz https://github.com/stunnel/static-curl/releases/download/8.23.0-1/curl-linux-x86_64-musl-8.23.0-1.tar.xz
    ;;
  arm64)
    wget -O /static-curl.tar.xz https://github.com/stunnel/static-curl/releases/download/8.23.0-1/curl-linux-armv7-musl-8.23.0-1.tar.xz
    ;;
  *)
    echo "Unknown architechture: $ARCH"
    exit 1
    ;;
  esac
tar xa --no-same-permissions -f /static-curl.tar.xz
rm /static-curl.tar.xz
sha256sum -c SHA256SUMS >/dev/null || exit 1
