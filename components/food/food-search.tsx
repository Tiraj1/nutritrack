"use client"

import { useState } from "react"

export default function FoodSearch(){

 const [query,setQuery] = useState("")
 const [results,setResults] = useState<any[]>([])

 async function search(){

  const res = await fetch("/api/food/search?q="+query)

  const data = await res.json()

  setResults(data.foods?.food || [])
 }

 return(
  <div className="space-y-4">

   <div className="flex gap-2">
    <input
     className="border p-2 flex-1"
     placeholder="Search food..."
     onChange={e=>setQuery(e.target.value)}
    />

    <button
     onClick={search}
     className="bg-black text-white px-4"
    >
     Search
    </button>
   </div>

   <div className="space-y-2">
    {results.map((food:any)=>(
     <div
      key={food.food_id}
      className="border p-2 rounded"
     >
      {food.food_name}
     </div>
    ))}
   </div>

  </div>
 )
}
