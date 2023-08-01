#!/bin/bash

set -euo pipefail

curl -L "https://getcomposer.org/download/2.5.8/composer.phar" > /tmp/composer.phar
sha256sum -c <(cat <<EOF
f07934fad44f9048c0dc875a506cca31cc2794d6aebfc1867f3b1fbf48dce2c5 /tmp/composer.phar
EOF
)

mkdir -p "${ARG_DEST}"
cd "${ARG_DEST}"

: "${ARG_GIT_REMOTE:=https://github.com/firefly-iii/firefly-iii.git}"
: "${ARG_REF}"

rm -rf bootstrap/cache/*
rm -rf vendor/

if [ -d .git ]; then
  git fetch --depth 1 "${ARG_GIT_REMOTE}" "${ARG_REF}"
  git reset --hard
  git clean -xfd
  git checkout "${ARG_REF}"
else
  git clone --depth 1 -b "${ARG_REF}" "${ARG_GIT_REMOTE}" .
fi

php /tmp/composer.phar install --no-scripts --no-dev --ignore-platform-reqs
php /tmp/composer.phar install --no-dev --ignore-platform-reqs

if [ -n "${ARG_ENV_LINK:-}" ]; then
  rm .env
  ln -s "${ARG_ENV_LINK}" .env
fi
