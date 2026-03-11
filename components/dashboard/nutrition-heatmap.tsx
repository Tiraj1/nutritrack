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
