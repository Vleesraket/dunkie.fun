#!/bin/sh
set -eu

DATA_DIR=".postgres-data"

if command -v docker >/dev/null 2>&1; then
  docker compose logs -f postgres
  exit 0
fi

if [ -f "$DATA_DIR/server.log" ]; then
  tail -f "$DATA_DIR/server.log"
else
  echo "No local PostgreSQL log found. Run npm run db:start first." >&2
  exit 1
fi
