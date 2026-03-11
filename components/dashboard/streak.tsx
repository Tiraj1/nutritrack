export default function Streak(){

 const days=6

 return(

  <div className="border rounded-xl p-6 text-center">

   <h3 className="font-semibold mb-2">
    Logging Streak
   </h3>

   <p className="text-3xl font-bold">
    {days} days
   </p>

   <p className="text-gray-500 text-sm">
    Keep logging meals!
   </p>

  </div>

 )
}
