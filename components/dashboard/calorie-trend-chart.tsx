"use client"

import { LineChart, Line, XAxis, Tooltip, ResponsiveContainer } from "recharts"

const data = [
  { day: "Mon", calories: 1800 },
  { day: "Tue", calories: 2000 },
  { day: "Wed", calories: 1700 },
  { day: "Thu", calories: 2100 },
  { day: "Fri", calories: 1900 },
]

export default function CalorieTrendChart() {

  return (
    <div className="border rounded p-6">

      <h2 className="font-bold mb-4">
        Calorie Trend
      </h2>

      <ResponsiveContainer width="100%" height={250}>
        <LineChart data={data}>
          <XAxis dataKey="day" />
          <Tooltip />
          <Line dataKey="calories" />
        </LineChart>
      </ResponsiveContainer>

    </div>
  )
}
