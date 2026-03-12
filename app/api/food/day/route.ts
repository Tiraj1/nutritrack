import { prisma } from "@/lib/prisma"

export async function GET() {

 const logs = await prisma.foodLog.findMany({
  orderBy:{
   createdAt:"desc"
  }
 })

 return Response.json(logs)

}
