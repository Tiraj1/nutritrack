"use client"

export default function MacroSummary() {

  return (
    <div className="grid grid-cols-3 gap-4">

      <div className="border p-4 rounded text-center">
        <h3 className="font-bold">Protein</h3>
        <p>140g / 160g</p>
      </div>

      <div className="border p-4 rounded text-center">
        <h3 className="font-bold">Carbs</h3>
        <p>210g / 250g</p>
      </div>

      <div className="border p-4 rounded text-center">
        <h3 className="font-bold">Fat</h3>
        <p>60g / 70g</p>
      </div>

    </div>
  )
}
