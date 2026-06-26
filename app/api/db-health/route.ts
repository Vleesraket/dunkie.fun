import { query } from "@/lib/db";

export const runtime = "nodejs";

export async function GET() {
  const result = await query<{ now: string; database: string }>(
    "select now()::text as now, current_database() as database"
  );

  return Response.json({
    ok: true,
    database: result.rows[0].database,
    now: result.rows[0].now,
  });
}
