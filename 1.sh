bash -c '
set -e

echo "Installing UI dependencies..."
npm install framer-motion next-themes lucide-react react-loading-skeleton class-variance-authority

echo "Creating UI folders..."
mkdir -p components/ui
mkdir -p components/layout
mkdir -p styles

echo "Creating design tokens..."

cat > styles/design-tokens.ts << "EOF"
export const colors = {
 primary: "hsl(142, 50%, 45%)",
 primarySoft: "hsl(142, 40%, 92%)",

 success: "#22c55e",
 warning: "#f59e0b",
 danger: "#ef4444",

 neutral: {
 50:"#fafafa",
 100:"#f5f5f5",
 200:"#e5e5e5",
 300:"#d4d4d4",
 400:"#a3a3a3",
 500:"#737373",
 700:"#404040",
 900:"#171717"
 }
}
EOF


echo "Creating Card component..."

cat > components/ui/card.tsx << "EOF"
export default function Card({children}:{children:React.ReactNode}) {
 return (
  <div className="rounded-xl border bg-white dark:bg-neutral-900 p-6 shadow-sm hover:shadow-md transition">
   {children}
  </div>
 )
}
EOF


echo "Creating Button component..."

cat > components/ui/button.tsx << "EOF"
export default function Button({
 children,
 className=""
}:{
 children:React.ReactNode
 className?:string
}){

 return (
  <button
   className={
    "px-5 py-2 rounded-lg bg-black text-white hover:opacity-90 transition "+className
   }
  >
   {children}
  </button>
 )
}
EOF


echo "Creating Sidebar..."

cat > components/layout/sidebar.tsx << "EOF"
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
EOF


echo "Updating dashboard layout..."

cat > app/dashboard/layout.tsx << "EOF"
import Sidebar from "@/components/layout/sidebar"

export default function DashboardLayout({
 children,
}:{children:React.ReactNode}){

 return (
  <div className="flex">

   <Sidebar/>

   <main className="flex-1 p-10 bg-neutral-50 dark:bg-neutral-950 min-h-screen">
    {children}
   </main>

  </div>
 )
}
EOF


echo "Updating dashboard page..."

cat > app/dashboard/page.tsx << "EOF"
import Card from "@/components/ui/card"

export default function DashboardPage(){

 return (
  <div className="space-y-8">

   <h1 className="text-3xl font-bold">
    Dashboard
   </h1>

   <div className="grid md:grid-cols-3 gap-6">

    <Card>
     <h3 className="font-semibold mb-2">Calories</h3>
     <p className="text-2xl">1450 / 2000</p>
    </Card>

    <Card>
     <h3 className="font-semibold mb-2">Protein</h3>
     <p className="text-2xl">82g</p>
    </Card>

    <Card>
     <h3 className="font-semibold mb-2">Carbs</h3>
     <p className="text-2xl">165g</p>
    </Card>

   </div>

  </div>
 )
}
EOF


echo "Adding dark mode support..."

cat > components/theme-provider.tsx << "EOF"
"use client"

import { ThemeProvider } from "next-themes"

export default function Provider({
 children
}:{children:React.ReactNode}){

 return (
  <ThemeProvider attribute="class">
   {children}
  </ThemeProvider>
 )
}
EOF


echo "Updating root layout..."

cat > app/layout.tsx << "EOF"
import "./globals.css"
import Provider from "@/components/theme-provider"

export default function RootLayout({
 children
}:{children:React.ReactNode}){

 return (
  <html lang="en">
   <body>
    <Provider>
     {children}
    </Provider>
   </body>
  </html>
 )
}
EOF


echo ""
echo "NutriTrack UI Upgrade Installed!"
echo ""
echo "Restart server:"
echo "rm -rf .next && npm run dev"
'
