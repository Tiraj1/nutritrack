"use client"

import Link from "next/link"

export default function Sidebar() {
  return (
    <aside className="w-64 h-screen border-r p-6 flex flex-col gap-4">

      <h2 className="text-xl font-bold mb-6">
        NutriTrack
      </h2>

      <Link href="/dashboard" className="hover:font-semibold">
        Dashboard
      </Link>

      <Link href="/dashboard/log" className="hover:font-semibold">
        Log Food
      </Link>

      <Link href="/dashboard/history" className="hover:font-semibold">
        History
      </Link>

      <Link href="/dashboard/reports" className="hover:font-semibold">
        Reports
      </Link>

      <Link href="/settings" className="hover:font-semibold">
        Settings
      </Link>

    </aside>
  )
}
