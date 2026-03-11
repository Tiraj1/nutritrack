import { openai } from "@/lib/openai"

export async function POST(req: Request) {

  const body = await req.json()

  const response = await openai.chat.completions.create({
    model: "gpt-4o-mini",
    messages: [
      {
        role: "system",
        content: "Identify foods and estimate calories, protein, carbs, fat."
      },
      {
        role: "user",
        content: body.description
      }
    ]
  })

  return Response.json(response.choices[0].message)
}
