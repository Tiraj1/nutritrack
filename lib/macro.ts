export function calculateMacros(logs:any[]){

 const totals = logs.reduce((acc,l)=>{

  acc.calories += l.calories || 0
  acc.protein += l.protein || 0
  acc.carbs += l.carbs || 0
  acc.fat += l.fat || 0

  return acc

 },{
  calories:0,
  protein:0,
  carbs:0,
  fat:0
 })

 return totals
}
