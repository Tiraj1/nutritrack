"use client"

import { signIn } from "next-auth/react"
import { useState } from "react"

export default function LoginPage() {

 const [email,setEmail] = useState("")
 const [password,setPassword] = useState("")

 async function submit(e:any){
  e.preventDefault()

  await signIn("credentials",{
   email,
   password,
   callbackUrl:"/dashboard"
  })
 }

 return (
  <div className="flex min-h-screen items-center justify-center">
   <form onSubmit={submit} className="space-y-4 border p-6 rounded">

    <h1 className="text-xl font-bold">
     NutriTrack Login
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

    <button className="bg-black text-white p-2 w-full">
     Login
    </button>

    <button
     type="button"
     className="border p-2 w-full"
     onClick={()=>signIn("google")}
    >
     Google Login
    </button>

    <button
     type="button"
     className="border p-2 w-full"
     onClick={()=>signIn("github")}
    >
     GitHub Login
    </button>

   </form>
  </div>
 )
}
