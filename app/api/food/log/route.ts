import { prisma } from "@/lib/prisma"

export async function POST(req: Request) {

  try {

    const body = await req.json()

    const log = await prisma.foodLog.create({
      data: {
        userId: body.userId || "demo-user",
        foodName: body.foodName || "Unknown",
        calories: Number(body.calories) || 0,
        protein: Number(body.protein) || 0,
        carbs: Number(body.carbs) || 0,
        fat: Number(body.fat) || 0,
        mealType: body.mealType || "meal",
        date: new Date()
      }
    })

    return Response.json(log)

  } catch (err) {

    console.error(err)

    return Response.json(
      { error: "Logging failed" },
      { status: 500 }
    )

  }

}
