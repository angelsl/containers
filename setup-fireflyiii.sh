#!/bin/bash

set -euo pipefail

mkdir -p "${ARG_DEST:=/sl/fireflyiii-app}"
cd "${ARG_DEST}"

: "${ARG_GIT_REMOTE:=https://github.com/angelsl/firefly-iii.git}"
: "${ARG_REF:=release}"

rm -rf bootstrap/cache/*

if [ -d .git ]; then
  git fetch --depth 1 "${ARG_GIT_REMOTE}" "${ARG_REF}"
  git reset --hard
  git clean -xfd -e /.env -e /storage
  git checkout FETCH_HEAD
else
  git clone --depth 1 -b "${ARG_REF}" "${ARG_GIT_REMOTE}" .
fi

if [ -n "${ARG_ENV_LINK:-}" ]; then
  rm -f .env
  ln -s "${ARG_ENV_LINK}" .env
fi

php artisan migrate --seed
php artisan firefly-iii:decrypt-all
php artisan cache:clear
php artisan firefly-iii:upgrade-database
php artisan firefly-iii:correct-database
php artisan firefly-iii:report-integrity
php artisan cache:clear
php artisan config:cache
