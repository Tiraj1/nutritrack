"use client"

import { useEffect, useState } from "react"

export default function DailyLog({ userId }: { userId: string }) {

  const [logs, setLogs] = useState<any[]>([])
  const [calories, setCalories] = useState(0)

  useEffect(() => {

    async function load() {

      const res = await fetch("/api/food/day?userId=" + userId)
      const data = await res.json()

      setLogs(data)

      const total = data.reduce(
        (sum: number, l: any) => sum + (l.calories || 0),
        0
      )

      setCalories(total)
    }

    load()

  }, [userId])

  return (
    <div className="mt-8 space-y-3">

      <h2 className="text-xl font-bold">
        Today Calories: {calories}
      </h2>

      {logs.map((log: any) => (
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
