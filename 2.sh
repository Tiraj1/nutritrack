bash -c '
set -e

echo "Installing analytics dependencies..."
npm install recharts

echo "Creating dashboard analytics components..."
mkdir -p components/dashboard

cat > components/dashboard/calorie-ring.tsx << "EOF"
"use client"

import { RadialBarChart, RadialBar, ResponsiveContainer } from "recharts"

export default function CalorieRing(){

 const consumed = 1450
 const goal = 2000
 const percent = Math.round(consumed/goal*100)

 const data=[{name:"calories",value:percent}]

 return(

  <div className="border rounded-xl p-6 text-center">

   <h3 className="font-semibold mb-4">
    Daily Calories
   </h3>

   <ResponsiveContainer width="100%" height={200}>

    <RadialBarChart
     innerRadius="70%"
     outerRadius="100%"
     data={data}
     startAngle={90}
     endAngle={-270}
    >

     <RadialBar dataKey="value"/>

    </RadialBarChart>

   </ResponsiveContainer>

   <p className="text-xl font-bold">
    {consumed} / {goal}
   </p>

   <p className="text-sm text-gray-500">
    {percent}% of goal
   </p>

  </div>

 )
}
EOF


cat > components/dashboard/macro-donut.tsx << "EOF"
"use client"

import { PieChart, Pie, Tooltip, ResponsiveContainer } from "recharts"

const data=[
 {name:"Protein",value:82},
 {name:"Carbs",value:165},
 {name:"Fat",value:52}
]

export default function MacroDonut(){

 return(

  <div className="border rounded-xl p-6">

   <h3 className="font-semibold mb-4">
    Macronutrients
   </h3>

   <ResponsiveContainer width="100%" height={250}>

    <PieChart>

     <Pie
      data={data}
      dataKey="value"
      nameKey="name"
      innerRadius={60}
      outerRadius={90}
     />

     <Tooltip/>

    </PieChart>

   </ResponsiveContainer>

  </div>

 )
}
EOF


cat > components/dashboard/weekly-calories.tsx << "EOF"
"use client"

import { LineChart, Line, XAxis, Tooltip, ResponsiveContainer } from "recharts"

const data=[
 {day:"Mon",cal:1800},
 {day:"Tue",cal:2000},
 {day:"Wed",cal:1700},
 {day:"Thu",cal:2100},
 {day:"Fri",cal:1950},
 {day:"Sat",cal:1600},
 {day:"Sun",cal:1850}
]

export default function WeeklyCalories(){

 return(

  <div className="border rounded-xl p-6">

   <h3 className="font-semibold mb-4">
    Weekly Calories
   </h3>

   <ResponsiveContainer width="100%" height={250}>

    <LineChart data={data}>

     <XAxis dataKey="day"/>

     <Tooltip/>

     <Line dataKey="cal"/>

    </LineChart>

   </ResponsiveContainer>

  </div>

 )
}
EOF


cat > components/dashboard/streak.tsx << "EOF"
export default function Streak(){

 const days=6

 return(

  <div className="border rounded-xl p-6 text-center">

   <h3 className="font-semibold mb-2">
    Logging Streak
   </h3>

   <p className="text-3xl font-bold">
    {days} days
   </p>

   <p className="text-gray-500 text-sm">
    Keep logging meals!
   </p>

  </div>

 )
}
EOF


echo "Updating dashboard page..."

cat > app/dashboard/page.tsx << "EOF"
import CalorieRing from "@/components/dashboard/calorie-ring"
import MacroDonut from "@/components/dashboard/macro-donut"
import WeeklyCalories from "@/components/dashboard/weekly-calories"
import Streak from "@/components/dashboard/streak"

export default function DashboardPage(){

 return(

  <div className="space-y-8">

   <h1 className="text-3xl font-bold">
    Dashboard
   </h1>

   <div className="grid md:grid-cols-2 gap-6">

    <CalorieRing/>
    <MacroDonut/>

   </div>

   <WeeklyCalories/>

   <Streak/>

  </div>

 )
}
EOF


echo ""
echo "Nutrition analytics installed!"
echo ""
echo "Restart dev server:"
echo "rm -rf .next && npm run dev"
'
