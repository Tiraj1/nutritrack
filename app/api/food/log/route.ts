import { prisma } from "@/lib/prisma"

export async function POST(req: Request) {

  const body = await req.json()

  const log = await prisma.foodLog.create({
    data: {
      userId: body.userId,
      foodName: body.foodName,
      calories: body.calories,
      protein: body.protein,
      carbs: body.carbs,
      fat: body.fat,
      mealType: body.mealType,
      date: new Date()
    }
  })

  return Response.json(log)
}
