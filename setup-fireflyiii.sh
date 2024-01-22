#!/bin/bash

set -euo pipefail

mkdir -p "${ARG_DEST}"
cd "${ARG_DEST}"

: "${ARG_GIT_REMOTE:=https://github.com/firefly-iii/firefly-iii.git}"
: "${ARG_REF}"

rm -rf bootstrap/cache/*
rm -rf vendor/

if [ -d .git ]; then
  git fetch --depth 1 "${ARG_GIT_REMOTE}" "${ARG_REF}"
  git reset --hard
  git clean -xfd -e /.env -e /storage/upload
  git checkout FETCH_HEAD
else
  git clone --depth 1 -b "${ARG_REF}" "${ARG_GIT_REMOTE}" .
fi

composer install --no-scripts --prefer-dist --no-dev --ignore-platform-reqs

if [ -n "${ARG_ENV_LINK:-}" ]; then
  rm -f .env
  ln -s "${ARG_ENV_LINK}" .env
fi

composer install --prefer-dist --no-dev --ignore-platform-reqs
php artisan firefly-iii:upgrade-database
php artisan firefly-iii:correct-database
php artisan firefly-iii:report-integrity
php artisan cache:clear
php artisan config:cache
