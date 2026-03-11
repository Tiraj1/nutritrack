bash -c '
set -e

echo "Installing dependencies..."
npm install html5-qrcode openai

echo "Creating folders..."
mkdir -p app/api/ai-meal
mkdir -p components/food

echo "Creating OpenAI helper..."

cat > lib/openai.ts << "EOF"
import OpenAI from "openai"

export const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY
})
EOF


echo "Creating AI meal recognition API..."

cat > app/api/ai-meal/route.ts << "EOF"
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
EOF


echo "Creating barcode scanner component..."

cat > components/food/barcode-scanner.tsx << "EOF"
"use client"

import { Html5QrcodeScanner } from "html5-qrcode"
import { useEffect } from "react"

export default function BarcodeScanner(){

  useEffect(()=>{

    const scanner = new Html5QrcodeScanner(
      "scanner",
      { fps: 10, qrbox: 250 },
      false
    )

    scanner.render(
      (decodedText)=>{
        alert("Barcode: "+decodedText)
      },
      ()=>{}
    )

  },[])

  return(
    <div className="mt-6">
      <h2 className="font-bold mb-2">Scan Barcode</h2>
      <div id="scanner"/>
    </div>
  )
}
EOF


echo "Creating AI meal upload component..."

cat > components/food/ai-meal.tsx << "EOF"
"use client"

import { useState } from "react"

export default function AIMeal(){

  const [result,setResult] = useState("")

  async function analyze(){

    const res = await fetch("/api/ai-meal",{
      method:"POST",
      body:JSON.stringify({
        description:"A plate of chicken, rice and broccoli"
      })
    })

    const data = await res.json()

    setResult(data.content)
  }

  return(
    <div className="mt-8 space-y-3">

      <button
        onClick={analyze}
        className="bg-black text-white px-4 py-2"
      >
        Analyze Meal
      </button>

      <pre>{result}</pre>

    </div>
  )
}
EOF


echo "Updating log page..."

cat > app/dashboard/log/page.tsx << "EOF"
import FoodSearch from "@/components/food/food-search"
import DailyLog from "@/components/food/daily-log"
import BarcodeScanner from "@/components/food/barcode-scanner"
import AIMeal from "@/components/food/ai-meal"

export default function LogPage(){

  const userId="demo-user"

  return(
    <div className="p-8 space-y-8">

      <h1 className="text-2xl font-bold">
        Log Food
      </h1>

      <FoodSearch/>

      <BarcodeScanner/>

      <AIMeal/>

      <DailyLog userId={userId}/>

    </div>
  )
}
EOF

echo ""
echo "Phase 4 installed!"
echo "Add OPENAI_API_KEY to .env and restart server."
'