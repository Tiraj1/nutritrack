"use client"

export default function PortionSelector({
 value,
 onChange
}:{
 value:number
 onChange:(v:number)=>void
}){

 return(
  <div className="flex gap-2 items-center">

   <span>Portion:</span>

   <input
    type="number"
    className="border p-1 w-20"
    value={value}
    onChange={e=>onChange(Number(e.target.value))}
   />

   <span>grams</span>

  </div>
 )
}
