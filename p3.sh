bash -c '
set -e

echo "Creating folders..."
mkdir -p lib
mkdir -p components/food
mkdir -p app/api/food/search
mkdir -p app/api/food/log
mkdir -p app/dashboard/log

echo "Creating FatSecret client..."

cat > lib/fatsecret.ts << "EOF"
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
EOF


echo "Creating search API..."

cat > app/api/food/search/route.ts << "EOF"
import { searchFood } from "@/lib/fatsecret"

export async function GET(req:Request){

 const { searchParams } = new URL(req.url)
 const query = searchParams.get("q")

 if(!query) return Response.json([])

 const results = await searchFood(query)

 return Response.json(results)
}
EOF


echo "Creating food log API..."

cat > app/api/food/log/route.ts << "EOF"
import { prisma } from "@/lib/prisma"

export async function POST(req:Request){

 const body = await req.json()

 const log = await prisma.foodLog.create({
  data:{
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
EOF


echo "Creating food search component..."

cat > components/food/food-search.tsx << "EOF"
"use client"

import { useState } from "react"

export default function FoodSearch(){

 const [query,setQuery] = useState("")
 const [results,setResults] = useState<any[]>([])

 async function search(){

  const res = await fetch("/api/food/search?q="+query)

  const data = await res.json()

  setResults(data.foods?.food || [])
 }

 return(
  <div className="space-y-4">

   <div className="flex gap-2">
    <input
     className="border p-2 flex-1"
     placeholder="Search food..."
     onChange={e=>setQuery(e.target.value)}
    />

    <button
     onClick={search}
     className="bg-black text-white px-4"
    >
     Search
    </button>
   </div>

   <div className="space-y-2">
    {results.map((food:any)=>(
     <div
      key={food.food_id}
      className="border p-2 rounded"
     >
      {food.food_name}
     </div>
    ))}
   </div>

  </div>
 )
}
EOF


echo "Creating log page..."

cat > app/dashboard/log/page.tsx << "EOF"
import FoodSearch from "@/components/food/food-search"

export default function LogPage(){

 return(
  <div className="p-8">

   <h1 className="text-2xl font-bold mb-6">
    Log Food
   </h1>

   <FoodSearch/>

  </div>
 )
}
EOF


echo ""
echo "Phase 3 installed successfully!"
echo ""
echo "Restart your server:"
echo "rm -rf .next"
echo "npm run dev"
'