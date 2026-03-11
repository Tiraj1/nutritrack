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
