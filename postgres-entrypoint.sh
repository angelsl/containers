#!/bin/bash

set -euo pipefail

if ! locale -a | grep -q en_SG; then
  localedef -i en_SG -c -f UTF-8 -A /usr/share/locale/locale.alias en_SG.UTF-8
fi

export LANG=en_SG.UTF-8

if [ ! -f /usr/local/bin/pg_back ]; then
  curl -qsSL 'https://github.com/orgrim/pg_back/releases/download/v2.1.1/pg_back_2.1.1_linux_amd64.tar.gz' | \
    tar -C /usr/local/bin -zx pg_back
  sha256sum -c - <<EOF
3b039fea1714fdae077e7e73a25093d5acbd2a92596e362ff7c715b0471654c9 /usr/local/bin/pg_back
EOF
fi

exec /usr/local/bin/gosu postgres:postgres /usr/local/bin/docker-entrypoint.sh postgres
