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
