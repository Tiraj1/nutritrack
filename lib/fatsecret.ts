export async function searchFood(query: string) {

 const res = await fetch(
  "https://platform.fatsecret.com/rest/server.api",
  {
   method:"POST",
   headers:{
    "Content-Type":"application/x-www-form-urlencoded"
   },
   body: new URLSearchParams({
    method:"foods.search",
    search_expression:query,
    format:"json"
   })
  }
 )

 const data = await res.json()

 return data
}
