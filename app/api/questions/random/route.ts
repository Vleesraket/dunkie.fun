import { query } from "@/lib/db";

export const runtime = "nodejs";

export async function GET() {
  const result = await query(
    `
    select id, question, answer_one, answer_two, correct_answer
    from questions
    order by random()
    limit 1
    `
  );

  return Response.json(result.rows[0]);
}
