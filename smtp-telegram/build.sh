#!/bin/bash

set -euo pipefail

git clone https://github.com/KostyaEsmukov/smtp_to_telegram.git sources
cd sources

export ST_VERSION=`git describe --tags --always`
export CGO_ENABLED=0 GOOS=linux
go build -ldflags "-s -w -X main.Version=${ST_VERSION:-UNKNOWN_RELEASE}" -a -o smtp_to_telegram
mv smtp_to_telegram /app