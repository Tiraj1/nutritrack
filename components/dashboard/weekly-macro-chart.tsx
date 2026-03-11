"use client"

import { BarChart, Bar, XAxis, Tooltip, ResponsiveContainer } from "recharts"

const data = [
  { day: "Mon", protein: 120 },
  { day: "Tue", protein: 140 },
  { day: "Wed", protein: 160 },
  { day: "Thu", protein: 150 },
  { day: "Fri", protein: 170 },
  { day: "Sat", protein: 130 },
  { day: "Sun", protein: 110 },
]

export default function WeeklyMacroChart() {

  return (
    <div className="border rounded p-6">

      <h2 className="font-bold mb-4">
        Weekly Protein Intake
      </h2>

      <ResponsiveContainer width="100%" height={250}>
        <BarChart data={data}>
          <XAxis dataKey="day" />
          <Tooltip />
          <Bar dataKey="protein" />
        </BarChart>
      </ResponsiveContainer>

    </div>
  )
}
