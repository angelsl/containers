#!/bin/bash

set -euo pipefail

mkdir -p "${ARG_DEST}"
cd "${ARG_DEST}"

: "${ARG_GIT_REMOTE:=https://github.com/firefly-iii/firefly-iii.git}"
: "${ARG_REF}"

rm -rf bootstrap/cache/*
rm -rf vendor/

if [ -d .git ]; then
  git fetch "${ARG_GIT_REMOTE}" "${ARG_REF}"
  git reset --hard
  git clean -xfd
  git checkout "${ARG_REF}"
else
  git clone --depth 1 -b "${ARG_REF}" "${ARG_GIT_REMOTE}" .
fi

composer install --no-scripts --no-dev
composer install --no-dev

if [ -n "${ARG_ENV_LINK:-}" ]; then
  rm .env
  ln -s "${ARG_ENV_LINK}" .env
fi
