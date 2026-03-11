bash -c '
set -e

echo "Installing chart library..."
npm install recharts

echo "Creating dashboard components..."
mkdir -p components/dashboard
mkdir -p app/dashboard

echo "Creating Calorie Ring..."

cat > components/dashboard/calorie-ring.tsx << "EOF"
"use client"

export default function CalorieRing(){

  const consumed = 1850
  const goal = 2200
  const percent = Math.round((consumed/goal)*100)

  return(
    <div className="border rounded p-6 text-center">

      <h2 className="text-lg font-bold mb-4">
        Calories Today
      </h2>

      <div className="text-3xl font-bold">
        {consumed} / {goal}
      </div>

      <div className="mt-2 text-gray-500">
        {percent}% of goal
      </div>

    </div>
  )
}
EOF


echo "Creating Macro Summary..."

cat > components/dashboard/macro-summary.tsx << "EOF"
"use client"

export default function MacroSummary(){

  return(
    <div className="grid grid-cols-3 gap-4">

      <div className="border p-4 rounded text-center">
        <h3 className="font-bold">Protein</h3>
        <p>140g / 160g</p>
      </div>

      <div className="border p-4 rounded text-center">
        <h3 className="font-bold">Carbs</h3>
        <p>210g / 250g</p>
      </div>

      <div className="border p-4 rounded text-center">
        <h3 className="font-bold">Fat</h3>
        <p>60g / 70g</p>
      </div>

    </div>
  )
}
EOF


echo "Creating Weekly Macro Chart..."

cat > components/dashboard/weekly-macro-chart.tsx << "EOF"
"use client"

import { BarChart, Bar, XAxis, Tooltip, ResponsiveContainer } from "recharts"

const data = [
  { day:"Mon", protein:120 },
  { day:"Tue", protein:140 },
  { day:"Wed", protein:160 },
  { day:"Thu", protein:150 },
  { day:"Fri", protein:170 },
  { day:"Sat", protein:130 },
  { day:"Sun", protein:110 },
]

export default function WeeklyMacroChart(){

  return(
    <div className="border rounded p-6">

      <h2 className="font-bold mb-4">
        Weekly Protein Intake
      </h2>

      <ResponsiveContainer width="100%" height={250}>
        <BarChart data={data}>
          <XAxis dataKey="day"/>
          <Tooltip/>
          <Bar dataKey="protein"/>
        </BarChart>
      </ResponsiveContainer>

    </div>
  )
}
EOF


echo "Creating Calorie Trend Chart..."

cat > components/dashboard/calorie-trend-chart.tsx << "EOF"
"use client"

import { LineChart, Line, XAxis, Tooltip, ResponsiveContainer } from "recharts"

const data = [
  { day:"Mon", calories:1800 },
  { day:"Tue", calories:2000 },
  { day:"Wed", calories:1700 },
  { day:"Thu", calories:2100 },
  { day:"Fri", calories:1900 },
]

export default function CalorieTrendChart(){

  return(
    <div className="border rounded p-6">

      <h2 className="font-bold mb-4">
        Calorie Trend
      </h2>

      <ResponsiveContainer width="100%" height={250}>
        <LineChart data={data}>
          <XAxis dataKey="day"/>
          <Tooltip/>
          <Line dataKey="calories"/>
        </LineChart>
      </ResponsiveContainer>

    </div>
  )
}
EOF


echo "Creating Nutrition Heatmap..."

cat > components/dashboard/nutrition-heatmap.tsx << "EOF"
"use client"

export default function NutritionHeatmap(){

  const days = Array.from({length:30})

  return(
    <div className="border rounded p-6">

      <h2 className="font-bold mb-4">
        Nutrition Heatmap
      </h2>

      <div className="grid grid-cols-10 gap-2">

        {days.map((_,i)=>(
          <div
            key={i}
            className="w-6 h-6 bg-green-400 rounded"
          />
        ))}

      </div>

    </div>
  )
}
EOF


echo "Creating Dashboard Page..."

cat > app/dashboard/page.tsx << "EOF"
import CalorieRing from "@/components/dashboard/calorie-ring"
import MacroSummary from "@/components/dashboard/macro-summary"
import WeeklyMacroChart from "@/components/dashboard/weekly-macro-chart"
import CalorieTrendChart from "@/components/dashboard/calorie-trend-chart"
import NutritionHeatmap from "@/components/dashboard/nutrition-heatmap"

export default function Dashboard(){

  return(
    <div className="p-8 space-y-8">

      <CalorieRing/>

      <MacroSummary/>

      <WeeklyMacroChart/>

      <CalorieTrendChart/>

      <NutritionHeatmap/>

    </div>
  )
}
EOF


echo ""
echo "Phase 5 Dashboard installed!"
echo "Restart server:"
echo "rm -rf .next && npm run dev"
'