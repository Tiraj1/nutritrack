"use client"

import Link from "next/link"

export default function FAB(){

 return(

  <Link
   href="/dashboard/log"
   className="fixed bottom-20 right-6 bg-black text-white w-14 h-14 rounded-full flex items-center justify-center text-2xl shadow-lg md:hidden"
  >
   +
  </Link>

 )

}
