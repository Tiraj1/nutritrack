bash -c '
set -e

echo "Installing PWA dependency..."
npm install next-pwa

echo "Creating share report route..."
mkdir -p app/shared/[token]

cat > app/shared/[token]/page.tsx << "EOF"
import { prisma } from "@/lib/prisma"

export default async function SharedReport({
 params
}:{ params:{ token:string }}){

 const logs = await prisma.foodLog.findMany({
  orderBy:{ createdAt:"desc" },
  take:20
 })

 return(
  <div className="p-8">

   <h1 className="text-2xl font-bold mb-6">
    Shared Nutrition Report
   </h1>

   {logs.map(log=>(
    <div key={log.id} className="border p-2 rounded mb-2">
      {log.foodName} — {log.calories} kcal
    </div>
   ))}

  </div>
 )
}
EOF


echo "Creating share token API..."

mkdir -p app/api/share

cat > app/api/share/route.ts << "EOF"
import crypto from "crypto"

export async function POST(){

 const token = crypto.randomBytes(16).toString("hex")

 return Response.json({
  token,
  url:"/shared/"+token
 })
}
EOF


echo "Creating macro calculator..."

cat > lib/macro.ts << "EOF"
export function calculateMacros(logs:any[]){

 const totals = logs.reduce((acc,l)=>{

  acc.calories += l.calories || 0
  acc.protein += l.protein || 0
  acc.carbs += l.carbs || 0
  acc.fat += l.fat || 0

  return acc

 },{
  calories:0,
  protein:0,
  carbs:0,
  fat:0
 })

 return totals
}
EOF


echo "Creating FatSecret OAuth scaffold..."

cat > lib/fatsecret-oauth.ts << "EOF"
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
EOF


echo "Creating next.config.js PWA config..."

cat > next.config.js << "EOF"
const withPWA = require("next-pwa")({
 dest:"public",
 disable: process.env.NODE_ENV === "development"
})

module.exports = withPWA({
 reactStrictMode:true
})
EOF


echo "Creating PWA manifest..."

mkdir -p public

cat > public/manifest.json << "EOF"
{
 "name":"NutriTrack",
 "short_name":"NutriTrack",
 "start_url":"/",
 "display":"standalone",
 "background_color":"#ffffff",
 "theme_color":"#000000",
 "icons":[
  {
   "src":"/icon-192.png",
   "sizes":"192x192",
   "type":"image/png"
  }
 ]
}
EOF


echo "Phase 6 installed successfully!"
echo ""
echo "Restart server:"
echo "rm -rf .next && npm run dev"
'