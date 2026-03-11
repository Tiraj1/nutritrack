"use client"

import { useState } from "react"

export default function RegisterPage(){

 const [email,setEmail] = useState("")
 const [password,setPassword] = useState("")

 async function register(){

  await fetch("/api/register",{
   method:"POST",
   body:JSON.stringify({email,password})
  })

  alert("Account created")
 }

 return(
  <div className="flex min-h-screen items-center justify-center">

   <div className="space-y-4 border p-6 rounded">

    <h1 className="text-xl font-bold">
     Create Account
    </h1>

    <input
     className="border p-2 w-full"
     placeholder="Email"
     onChange={e=>setEmail(e.target.value)}
    />

    <input
     type="password"
     className="border p-2 w-full"
     placeholder="Password"
     onChange={e=>setPassword(e.target.value)}
    />

    <button
     onClick={register}
     className="bg-black text-white p-2 w-full"
    >
     Register
    </button>

   </div>

  </div>
 )
}
