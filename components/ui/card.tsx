export default function Card({children}:{children:React.ReactNode}) {
 return (
  <div className="rounded-xl border bg-white dark:bg-neutral-900 p-6 shadow-sm hover:shadow-md transition">
   {children}
  </div>
 )
}
