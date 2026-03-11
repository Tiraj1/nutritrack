"use client"

import { useState } from "react"

export default function AIMeal(){

  const [result,setResult] = useState("")

  async function analyze(){

    const res = await fetch("/api/ai-meal",{
      method:"POST",
      body:JSON.stringify({
        description:"A plate of chicken, rice and broccoli"
      })
    })

    const data = await res.json()

    setResult(data.content)
  }

  return(
    <div className="mt-8 space-y-3">

      <button
        onClick={analyze}
        className="bg-black text-white px-4 py-2"
      >
        Analyze Meal
      </button>

      <pre>{result}</pre>

    </div>
  )
}
