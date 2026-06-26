#!/bin/sh
set -eu

DATA_DIR=".postgres-data"
DATABASE_URL_VALUE="postgresql://dunkie:dunkie_password@localhost:5433/dunkie"
POSTGRES_URL_VALUE="postgresql://dunkie:dunkie_password@localhost:5433/postgres"

if command -v docker >/dev/null 2>&1; then
  docker compose up -d postgres
  exit 0
fi

if ! command -v initdb >/dev/null 2>&1 || ! command -v pg_ctl >/dev/null 2>&1; then
  echo "PostgreSQL is not installed. Install Docker or PostgreSQL, then rerun npm run db:start." >&2
  exit 1
fi

if [ ! -d "$DATA_DIR" ]; then
  initdb -D "$DATA_DIR" --username=dunkie --auth-local=trust --auth-host=trust
fi

if ! pg_ctl -D "$DATA_DIR" status >/dev/null 2>&1; then
  pg_ctl -D "$DATA_DIR" -l "$DATA_DIR/server.log" -o "-p 5433" start
fi

if ! psql "$POSTGRES_URL_VALUE" -tAc "select 1 from pg_database where datname = 'dunkie'" | grep -q 1; then
  createdb -h localhost -p 5433 -U dunkie -T template0 dunkie
fi

psql "$DATABASE_URL_VALUE" -f db/init/001_init.sql >/dev/null
echo "PostgreSQL is running at $DATABASE_URL_VALUE"
