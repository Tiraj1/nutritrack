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
