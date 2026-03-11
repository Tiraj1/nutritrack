import CalorieRing from "@/components/dashboard/calorie-ring"
import MacroSummary from "@/components/dashboard/macro-summary"
import WeeklyMacroChart from "@/components/dashboard/weekly-macro-chart"
import CalorieTrendChart from "@/components/dashboard/calorie-trend-chart"
import NutritionHeatmap from "@/components/dashboard/nutrition-heatmap"

export default function Dashboard(){

  return(
    <div className="p-8 space-y-8">

      <CalorieRing/>

      <MacroSummary/>

      <WeeklyMacroChart/>

      <CalorieTrendChart/>

      <NutritionHeatmap/>

    </div>
  )
}
