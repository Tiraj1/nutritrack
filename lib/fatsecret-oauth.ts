export async function fatsecretAuth(){

 const res = await fetch(
  "https://oauth.fatsecret.com/connect/token",
  {
   method:"POST",
   headers:{
    "Content-Type":"application/x-www-form-urlencoded"
   },
   body:new URLSearchParams({
    grant_type:"client_credentials",
    scope:"basic"
   })
  }
 )

 return res.json()
}
