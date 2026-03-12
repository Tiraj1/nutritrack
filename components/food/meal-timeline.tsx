"use client"

import { useEffect,useState } from "react"

export default function MealTimeline(){

 const [foods,setFoods]=useState<any[]>([])

 async function load(){

  const res=await fetch("/api/food/day")
  const data=await res.json()

  setFoods(data)

 }

 useEffect(()=>{load()},[])

 async function remove(id:string){

  await fetch("/api/food/delete",{
   method:"POST",
   headers:{ "Content-Type":"application/json" },
   body:JSON.stringify({id})
  })

  load()

 }

 if(!foods.length){
  return <p className="text-gray-500">No meals logged today.</p>
 }

 return(

  <div className="space-y-3">

   {foods.map(food=>(

    <div
     key={food.id}
     className="border rounded p-4 flex justify-between items-center"
    >

     <div>

      <p className="font-medium">
       {food.foodName}
      </p>

      <p className="text-sm text-gray-500">
       {food.mealType}
      </p>

     </div>

     <div className="flex items-center gap-3">

      <p className="font-semibold">
       {food.calories} kcal
      </p>

      <button
       onClick={()=>remove(food.id)}
       className="text-red-500 text-sm"
      >
       delete
      </button>

     </div>

    </div>

   ))}

  </div>

 )

}
