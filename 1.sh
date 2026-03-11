bash -c '
set -e

echo "Installing icon library..."
npm install lucide-react

echo "Creating landing page..."

cat > app/page.tsx << "EOF"
import Link from "next/link"
import { BarChart3, Brain, Scan } from "lucide-react"

export default function Home() {

  return (
    <main className="min-h-screen">

      <section className="text-center py-24 px-6">

        <h1 className="text-5xl font-bold mb-6">
          NutriTrack
        </h1>

        <p className="text-gray-600 text-lg mb-10">
          AI-powered nutrition tracking for modern health.
        </p>

        <div className="flex justify-center gap-4">

          <Link
            href="/auth/login"
            className="bg-black text-white px-6 py-3 rounded"
          >
            Get Started
          </Link>

          <Link
            href="/dashboard"
            className="border px-6 py-3 rounded"
          >
            Dashboard
          </Link>

        </div>

      </section>


      <section className="grid md:grid-cols-3 gap-8 px-10 pb-24 max-w-6xl mx-auto">

        <div className="border p-6 rounded">

          <Brain className="mb-4" />

          <h3 className="font-bold text-lg mb-2">
            AI Meal Recognition
          </h3>

          <p className="text-gray-600">
            Upload a photo and automatically detect foods and calories.
          </p>

        </div>


        <div className="border p-6 rounded">

          <Scan className="mb-4" />

          <h3 className="font-bold text-lg mb-2">
            Barcode Scanner
          </h3>

          <p className="text-gray-600">
            Instantly log packaged foods with your camera.
          </p>

        </div>


        <div className="border p-6 rounded">

          <BarChart3 className="mb-4" />

          <h3 className="font-bold text-lg mb-2">
            Smart Analytics
          </h3>

          <p className="text-gray-600">
            Track calories, macros and weekly nutrition trends.
          </p>

        </div>

      </section>


      <footer className="text-center py-10 border-t text-gray-500">
        © 2026 NutriTrack
      </footer>

    </main>
  )
}
EOF


echo ""
echo "Landing page installed!"
echo ""
echo "Restart your server:"
echo "rm -rf .next && npm run dev"
'
