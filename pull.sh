#!/usr/bin/env bash

set -Eeuo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

URL="https://github.com/MehrAmin/website"
TARBALL_URL="${URL}/archive/refs/heads/main.tar.gz"

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  rm -rf "${HOME}/tmp/website.tar.gz"
  rm -rf "${HOME}/tmp/website"
}

curl -sL "${TARBALL_URL}" -o "${HOME}/tmp/website.tar.gz"

mkdir -p "${HOME}/tmp/website"
tar -xzf "${HOME}/tmp/website.tar.gz" --directory "${HOME}/tmp/website" --strip-components=1

rsync -aAXvh --delete --force "${HOME}/tmp/website/" "${HOME}/public_html/"
