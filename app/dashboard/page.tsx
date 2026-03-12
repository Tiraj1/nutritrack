import CalorieRing from "@/components/dashboard/calorie-ring"
import MacroDonut from "@/components/dashboard/macro-donut"
import WeeklyCalories from "@/components/dashboard/weekly-calories"
import Streak from "@/components/dashboard/streak"
import MealTimeline from "@/components/food/meal-timeline"

export default function DashboardPage(){

 return(

  <div className="space-y-10">

   <h1 className="text-3xl font-bold">
    Dashboard
   </h1>

   <div className="grid md:grid-cols-2 gap-6">

    <CalorieRing/>
    <MacroDonut/>

   </div>

   <WeeklyCalories/>

   <Streak/>

   <div>

    <h2 className="text-xl font-semibold mb-4">
     Today
    </h2>

    <MealTimeline/>

   </div>

  </div>

 )

}
