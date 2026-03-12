"use client"

import { useState } from "react"

export default function FoodSearch(){

 const [query,setQuery]=useState("")
 const [results,setResults]=useState<any[]>([])

 async function search(q:string){

  setQuery(q)

  if(!q) return

  const res=await fetch("/api/food/search?q="+q)

  const data=await res.json()

  setResults(data)

 }

 async function log(food:any){

  await fetch("/api/food/log",{
   method:"POST",
   headers:{ "Content-Type":"application/json" },
   body:JSON.stringify({
    userId:"demo-user",
    foodName:food.name,
    calories:food.calories,
    protein:food.protein,
    carbs:food.carbs,
    fat:food.fat,
    mealType:"meal"
   })
  })

  alert("Food logged!")

 }

 return(

  <div className="space-y-4">

   <input
    className="border p-3 rounded w-full"
    placeholder="Search food..."
    onChange={e=>search(e.target.value)}
   />

   {results.map(food=>(
    <div
     key={food.id}
     className="border p-3 rounded flex justify-between"
    >

     <span>{food.name}</span>

     <button
      onClick={()=>log(food)}
      className="text-green-600"
     >
      add
     </button>

    </div>
   ))}

  </div>

 )

}
