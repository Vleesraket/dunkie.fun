#!/bin/sh
set -eu

DATA_DIR=".postgres-data"

if command -v docker >/dev/null 2>&1; then
  docker compose down
  exit 0
fi

if [ -d "$DATA_DIR" ] && command -v pg_ctl >/dev/null 2>&1; then
  pg_ctl -D "$DATA_DIR" stop
else
  echo "No local PostgreSQL data directory found."
fi
