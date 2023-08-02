#!/bin/bash

set -euo pipefail

if ! locale -a | grep -q en_SG; then
  localedef -i en_SG -c -f UTF-8 -A /usr/share/locale/locale.alias en_SG.UTF-8
fi

export LANG=en_SG.UTF-8
exec /usr/local/bin/gosu postgres:postgres /usr/local/bin/docker-entrypoint.sh postgres