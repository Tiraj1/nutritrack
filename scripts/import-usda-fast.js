const fs = require("fs")
const csv = require("csv-parser")
const { PrismaClient } = require("@prisma/client")

const prisma = new PrismaClient()

const BATCH_SIZE = 1000

async function run() {
  const foods = []
  let total = 0

  console.log("Reading USDA food.csv...")

  fs.createReadStream("./food.csv")
    .pipe(csv())
    .on("data", async (row) => {
      if (!row.description) return

      foods.push({
        name: row.description,
        calories: 0,
        protein: 0,
        carbs: 0,
        fat: 0
      })

      if (foods.length >= BATCH_SIZE) {
        const batch = foods.splice(0, foods.length)

        await prisma.food.createMany({
          data: batch,
          skipDuplicates: true
        })

        total += batch.length
        console.log("Imported:", total)
      }
    })
    .on("end", async () => {

      if (foods.length > 0) {
        await prisma.food.createMany({
          data: foods,
          skipDuplicates: true
        })
        total += foods.length
      }

      console.log("Import finished:", total, "foods")
      process.exit()
    })
}

run()
