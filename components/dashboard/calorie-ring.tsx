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
