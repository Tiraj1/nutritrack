const fs = require("fs")
const csv = require("csv-parser")
const { PrismaClient } = require("@prisma/client")

const prisma = new PrismaClient()

async function run(){

 const foods = []

 fs.createReadStream("./food.csv")
  .pipe(csv())
  .on("data",(row)=>{

   if(row.description){

    foods.push({
     name: row.description,
     calories: 0,
     protein: 0,
     carbs: 0,
     fat: 0
    })

   }

  })
  .on("end",async()=>{

   console.log("Importing foods...")

   for(const food of foods.slice(0,200000)){

    await prisma.food.create({
     data:food
    })

   }

   console.log("Import complete")

   process.exit()

  })

}

run()
