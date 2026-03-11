import Link from "next/link"

export default function Home() {
  return (
    <main className="min-h-screen flex flex-col items-center justify-center p-8">

      <h1 className="text-4xl font-bold mb-6">
        NutriTrack
      </h1>

      <p className="mb-8 text-gray-600">
        AI-powered nutrition tracking
      </p>

      <div className="flex gap-4">

        <Link
          href="/auth/login"
          className="bg-black text-white px-6 py-3 rounded"
        >
          Login
        </Link>

        <Link
          href="/dashboard"
          className="border px-6 py-3 rounded"
        >
          Go to Dashboard
        </Link>

      </div>

    </main>
  )
}
