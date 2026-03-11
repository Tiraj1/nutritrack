import crypto from "crypto"

export async function POST(){

 const token = crypto.randomBytes(16).toString("hex")

 return Response.json({
  token,
  url:"/shared/"+token
 })
}
