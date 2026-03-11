import { searchFood } from "@/lib/fatsecret"

export async function GET(req:Request){

 const { searchParams } = new URL(req.url)
 const query = searchParams.get("q")

 if(!query) return Response.json([])

 const results = await searchFood(query)

 return Response.json(results)
}
