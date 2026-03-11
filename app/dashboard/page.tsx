import CalorieRing from "@/components/dashboard/calorie-ring"
import MacroSummary from "@/components/dashboard/macro-summary"
import WeeklyMacroChart from "@/components/dashboard/weekly-macro-chart"
import CalorieTrendChart from "@/components/dashboard/calorie-trend-chart"

export default function DashboardPage() {

  return (
    <div className="space-y-8">

      <h1 className="text-2xl font-bold">
        Dashboard
      </h1>

      <CalorieRing />

      <MacroSummary />

      <WeeklyMacroChart />

      <CalorieTrendChart />

    </div>
  )
}
