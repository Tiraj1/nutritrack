"use client"

import Link from "next/link"
import { Home, PlusCircle, Search, User } from "lucide-react"

export default function BottomNav(){

 return(

  <nav className="fixed bottom-0 left-0 right-0 bg-white border-t flex justify-around p-3 md:hidden">

   <Link href="/dashboard" className="flex flex-col items-center text-xs">
    <Home size={20}/>
    Home
   </Link>

   <Link href="/dashboard/log" className="flex flex-col items-center text-xs">
    <PlusCircle size={20}/>
    Log
   </Link>

   <Link href="/dashboard/search" className="flex flex-col items-center text-xs">
    <Search size={20}/>
    Search
   </Link>

   <Link href="/profile" className="flex flex-col items-center text-xs">
    <User size={20}/>
    Me
   </Link>

  </nav>

 )

}
