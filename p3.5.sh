bash -c '
set -e

echo "Creating API routes..."
mkdir -p app/api/food/log
mkdir -p app/api/food/day

echo "Creating save food log API..."

cat > app/api/food/log/route.ts << "EOF"
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
EOF


echo "Creating daily log API..."

cat > app/api/food/day/route.ts << "EOF"
import { prisma } from "@/lib/prisma"

export async function GET(req: Request){

  const { searchParams } = new URL(req.url)
  const userId = searchParams.get("userId")

  if(!userId) return Response.json([])

  const logs = await prisma.foodLog.findMany({
    where:{ userId },
    orderBy:{ createdAt:"desc" }
  })

  return Response.json(logs)
}
EOF


echo "Creating portion selector..."

mkdir -p components/food

cat > components/food/portion-selector.tsx << "EOF"
"use client"

export default function PortionSelector({
 value,
 onChange
}:{
 value:number
 onChange:(v:number)=>void
}){

 return(
  <div className="flex gap-2 items-center">

   <span>Portion:</span>

   <input
    type="number"
    className="border p-1 w-20"
    value={value}
    onChange={e=>onChange(Number(e.target.value))}
   />

   <span>grams</span>

  </div>
 )
}
EOF


echo "Creating daily log component..."

cat > components/food/daily-log.tsx << "EOF"
"use client"

import { useEffect,useState } from "react"

export default function DailyLog({userId}:{userId:string}){

 const [logs,setLogs] = useState<any[]>([])
 const [calories,setCalories] = useState(0)

 useEffect(()=>{

  async function load(){

   const res = await fetch("/api/food/day?userId="+userId)
   const data = await res.json()

   setLogs(data)

   const total = data.reduce(
    (sum:any,l:any)=>sum + l.calories,
    0
   )

   setCalories(total)
  }

  load()

 },[])

 return(
  <div className="mt-8 space-y-3">

   <h2 className="text-xl font-bold">
    Today Calories: {calories}
   </h2>

   {logs.map((log:any)=>(
    <div
     key={log.id}
     className="border p-2 rounded"
    >
     {log.foodName} — {log.calories} kcal
    </div>
   ))}

  </div>
 )
}
EOF


echo "Updating dashboard log page..."

cat > app/dashboard/log/page.tsx << "EOF"
import FoodSearch from "@/components/food/food-search"
import DailyLog from "@/components/food/daily-log"

export default function LogPage(){

 const userId="demo-user"

 return(
  <div className="p-8">

   <h1 className="text-2xl font-bold mb-6">
    Log Food
   </h1>

   <FoodSearch/>

   <DailyLog userId={userId}/>

  </div>
 )
}
EOF

echo ""
echo "Phase 3.5 installed successfully!"
echo "Restart server:"
echo "rm -rf .next && npm run dev"
'