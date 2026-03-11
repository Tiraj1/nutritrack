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
