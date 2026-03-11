import FoodSearch from "@/components/food/food-search"
import DailyLog from "@/components/food/daily-log"
import BarcodeScanner from "@/components/food/barcode-scanner"
import AIMeal from "@/components/food/ai-meal"

export default function LogPage(){

  const userId="demo-user"

  return(
    <div className="p-8 space-y-8">

      <h1 className="text-2xl font-bold">
        Log Food
      </h1>

      <FoodSearch/>

      <BarcodeScanner/>

      <AIMeal/>

      <DailyLog userId={userId}/>

    </div>
  )
}
