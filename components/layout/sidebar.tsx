"use client"

import Link from "next/link"
import { BarChart3, ClipboardList, History, Settings } from "lucide-react"

export default function Sidebar(){

 return (
  <aside className="w-64 h-screen border-r p-6 flex flex-col gap-6">

   <h2 className="text-xl font-bold">
    NutriTrack
   </h2>

   <Link href="/dashboard" className="flex gap-2 items-center">
    <BarChart3 size={18}/>
    Dashboard
   </Link>

   <Link href="/dashboard/log" className="flex gap-2 items-center">
    <ClipboardList size={18}/>
    Log Food
   </Link>

   <Link href="/dashboard/history" className="flex gap-2 items-center">
    <History size={18}/>
    History
   </Link>

   <Link href="/settings" className="flex gap-2 items-center">
    <Settings size={18}/>
    Settings
   </Link>

  </aside>
 )
}
