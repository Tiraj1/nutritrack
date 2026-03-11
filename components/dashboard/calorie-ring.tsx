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
