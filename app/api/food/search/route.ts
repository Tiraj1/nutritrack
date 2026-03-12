import { prisma } from "@/lib/prisma"

export async function GET(req: Request) {

  const { searchParams } = new URL(req.url)
  const q = searchParams.get("q") || ""

  if (!q) return Response.json([])

  const foods = await prisma.$queryRaw`
    SELECT id, name, calories, protein, carbs, fat
    FROM "Food"
    WHERE search_vector @@ plainto_tsquery('english', ${q})
    LIMIT 10
  `

  return Response.json(foods)
}
