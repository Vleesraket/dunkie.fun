# Dunkie

Blank Next.js app with PostgreSQL wired in.

## Getting Started

Run the development server:

```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

## Database

This project includes a local PostgreSQL database. `npm run db:start` uses Docker Compose when Docker is available; otherwise it uses local PostgreSQL binaries and stores data in `.postgres-data`.

```bash
npm run db:start
npm run dev
```

The app reads `DATABASE_URL` from `.env.local`. The default local database URL is:

```bash
postgresql://dunkie:dunkie_password@localhost:5433/dunkie
```

Useful database commands:

```bash
npm run db:psql
npm run db:logs
npm run db:stop
npm run db:reset
```

The initial schema lives in `db/init/001_init.sql`. To verify app connectivity, start Postgres and visit [http://localhost:3000/api/db-health](http://localhost:3000/api/db-health).
