import Sidebar from "@/components/layout/sidebar"
import BottomNav from "@/components/mobile/bottom-nav"
import FAB from "@/components/mobile/fab"

export default function DashboardLayout({
 children
}:{children:React.ReactNode}){

 return(

  <div className="flex">

   <div className="hidden md:block">
    <Sidebar/>
   </div>

   <main className="flex-1 p-6 md:p-10 pb-24 bg-neutral-50 dark:bg-neutral-950 min-h-screen">

    {children}

   </main>

   <BottomNav/>
   <FAB/>

  </div>

 )

}
