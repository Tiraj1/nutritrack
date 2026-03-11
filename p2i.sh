bash -c '
set -e

echo "Installing authentication dependencies..."
npm install next-auth@beta @auth/prisma-adapter bcrypt

echo "Creating folders..."
mkdir -p src/lib
mkdir -p src/app/api/auth/nextauth
mkdir -p src/app/api/register
mkdir -p src/app/auth/login
mkdir -p src/app/auth/register

echo "Creating auth config..."

cat > src/lib/auth.ts << "EOF"
import NextAuth from "next-auth"
import Credentials from "next-auth/providers/credentials"
import Google from "next-auth/providers/google"
import GitHub from "next-auth/providers/github"
import { PrismaAdapter } from "@auth/prisma-adapter"
import bcrypt from "bcrypt"
import { prisma } from "./prisma"

export const authOptions = {
 adapter: PrismaAdapter(prisma),
 session: { strategy: "database" },

 providers: [

  Google({
   clientId: process.env.GOOGLE_CLIENT_ID!,
   clientSecret: process.env.GOOGLE_CLIENT_SECRET!,
  }),

  GitHub({
   clientId: process.env.GITHUB_CLIENT_ID!,
   clientSecret: process.env.GITHUB_CLIENT_SECRET!,
  }),

  Credentials({
   name: "credentials",

   credentials: {
    email: { label: "Email", type: "email" },
    password: { label: "Password", type: "password" },
   },

   async authorize(credentials) {

    const user = await prisma.user.findUnique({
     where: { email: credentials?.email }
    })

    if (!user || !user.password) return null

    const valid = await bcrypt.compare(
     credentials!.password,
     user.password
    )

    if (!valid) return null

    return user
   },
  }),

 ],
}

export const { handlers, auth, signIn, signOut } =
 NextAuth(authOptions)
EOF


echo "Creating NextAuth route..."

cat > src/app/api/auth/nextauth/route.ts << "EOF"
import { handlers } from "@/lib/auth"

export const { GET, POST } = handlers
EOF


echo "Creating middleware..."

cat > src/middleware.ts << "EOF"
export { auth as middleware } from "@/lib/auth"

export const config = {
 matcher: ["/dashboard/:path*"],
}
EOF


echo "Creating register API..."

cat > src/app/api/register/route.ts << "EOF"
import { prisma } from "@/lib/prisma"
import bcrypt from "bcrypt"

export async function POST(req: Request) {

 const body = await req.json()

 const password = await bcrypt.hash(body.password, 10)

 const user = await prisma.user.create({
  data: {
   email: body.email,
   password
  }
 })

 return Response.json(user)
}
EOF


echo "Creating login page..."

cat > src/app/auth/login/page.tsx << "EOF"
"use client"

import { signIn } from "next-auth/react"
import { useState } from "react"

export default function LoginPage() {

 const [email,setEmail] = useState("")
 const [password,setPassword] = useState("")

 async function submit(e:any){
  e.preventDefault()

  await signIn("credentials",{
   email,
   password,
   callbackUrl:"/dashboard"
  })
 }

 return (
  <div className="flex min-h-screen items-center justify-center">
   <form onSubmit={submit} className="space-y-4 border p-6 rounded">

    <h1 className="text-xl font-bold">
     NutriTrack Login
    </h1>

    <input
     className="border p-2 w-full"
     placeholder="Email"
     onChange={e=>setEmail(e.target.value)}
    />

    <input
     type="password"
     className="border p-2 w-full"
     placeholder="Password"
     onChange={e=>setPassword(e.target.value)}
    />

    <button className="bg-black text-white p-2 w-full">
     Login
    </button>

    <button
     type="button"
     className="border p-2 w-full"
     onClick={()=>signIn("google")}
    >
     Google Login
    </button>

    <button
     type="button"
     className="border p-2 w-full"
     onClick={()=>signIn("github")}
    >
     GitHub Login
    </button>

   </form>
  </div>
 )
}
EOF


echo "Creating register page..."

cat > src/app/auth/register/page.tsx << "EOF"
"use client"

import { useState } from "react"

export default function RegisterPage(){

 const [email,setEmail] = useState("")
 const [password,setPassword] = useState("")

 async function register(){

  await fetch("/api/register",{
   method:"POST",
   body:JSON.stringify({email,password})
  })

  alert("Account created")
 }

 return(
  <div className="flex min-h-screen items-center justify-center">

   <div className="space-y-4 border p-6 rounded">

    <h1 className="text-xl font-bold">
     Create Account
    </h1>

    <input
     className="border p-2 w-full"
     placeholder="Email"
     onChange={e=>setEmail(e.target.value)}
    />

    <input
     type="password"
     className="border p-2 w-full"
     placeholder="Password"
     onChange={e=>setPassword(e.target.value)}
    />

    <button
     onClick={register}
     className="bg-black text-white p-2 w-full"
    >
     Register
    </button>

   </div>

  </div>
 )
}
EOF


echo ""
echo "? Authentication installed successfully"
echo ""
echo "Next steps:"
echo "1) set your .env variables"
echo "2) run database migration"
echo ""
echo "Run:"
echo "npx prisma migrate dev --name auth"
echo "npm run dev"
'