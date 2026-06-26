#!/bin/sh
set -eu

DATA_DIR=".postgres-data"

if command -v docker >/dev/null 2>&1; then
  docker compose down -v
  docker compose up -d postgres
  exit 0
fi

if [ -d "$DATA_DIR" ] && command -v pg_ctl >/dev/null 2>&1; then
  pg_ctl -D "$DATA_DIR" stop >/dev/null 2>&1 || true
fi

rm -rf "$DATA_DIR"
sh scripts/db-start.sh
