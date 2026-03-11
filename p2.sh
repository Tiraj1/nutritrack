set -e

echo "Creating NutriTrack project..."
npx create-next-app@latest nutritrack --typescript --tailwind --eslint --app --src-dir --import-alias "@/*"

cd nutritrack

echo "Installing dependencies..."
npm install next-themes lucide-react clsx tailwind-merge recharts prisma @prisma/client next-auth@beta openai html5-qrcode next-pwa bcrypt

echo "Initializing Prisma..."
npx prisma init

echo "Creating project structure..."
mkdir -p src/{components/{layout,dashboard,food,charts,ui},lib,actions,types,hooks}

echo "Writing Prisma schema..."

cat > prisma/schema.prisma << 'EOF'
generator client {
 provider = "prisma-client-js"
}

datasource db {
 provider = "postgresql"
 url = env("DATABASE_URL")
}

model User {
 id String @id @default(cuid())
 name String?
 email String @unique
 emailVerified DateTime?
 image String?
 password String?

 accounts Account[]
 sessions Session[]

 foodLogs FoodLog[]
 nutritionGoal NutritionGoal?

 createdAt DateTime @default(now())
 updatedAt DateTime @updatedAt
}

model Account {
 id String @id @default(cuid())
 userId String
 type String
 provider String
 providerAccountId String
 refresh_token String?
 access_token String?
 expires_at Int?
 token_type String?
 scope String?
 id_token String?
 session_state String?

 user User @relation(fields: [userId], references: [id], onDelete: Cascade)

 @@unique([provider, providerAccountId])
}

model Session {
 id String @id @default(cuid())
 sessionToken String @unique
 userId String
 expires DateTime

 user User @relation(fields: [userId], references: [id], onDelete: Cascade)
}

model VerificationToken {
 identifier String
 token String @unique
 expires DateTime

 @@unique([identifier, token])
}

model NutritionGoal {
 id String @id @default(cuid())
 userId String @unique

 calories Int
 protein Int
 carbs Int
 fat Int

 user User @relation(fields: [userId], references: [id], onDelete: Cascade)

 createdAt DateTime @default(now())
 updatedAt DateTime @updatedAt
}

model FoodLog {
 id String @id @default(cuid())
 userId String

 date DateTime
 mealType MealType

 foodName String
 fatSecretId String?

 grams Float?

 calories Float
 protein Float
 carbs Float
 fat Float
 fiber Float?
 sugar Float?
 sodium Float?

 createdAt DateTime @default(now())
 updatedAt DateTime @updatedAt

 user User @relation(fields: [userId], references: [id], onDelete: Cascade)
}

model SharedReport {
 id String @id @default(cuid())
 token String @unique
 userId String
 startDate DateTime
 endDate DateTime
 createdAt DateTime @default(now())

 user User @relation(fields: [userId], references: [id], onDelete: Cascade)
}

enum MealType {
 BREAKFAST
 LUNCH
 DINNER
 SNACK
}
EOF

echo "Creating Prisma client helper..."

cat > src/lib/prisma.ts << 'EOF'
import { PrismaClient } from "@prisma/client"

const globalForPrisma = global as unknown as {
 prisma: PrismaClient
}

export const prisma =
 globalForPrisma.prisma ||
 new PrismaClient()

if (process.env.NODE_ENV !== "production")
 globalForPrisma.prisma = prisma
EOF

echo "Creating Theme Provider..."

cat > src/components/theme-provider.tsx << 'EOF'
"use client"

import { ThemeProvider as NextThemesProvider } from "next-themes"

export function ThemeProvider({ children }: { children: React.ReactNode }) {
 return (
 <NextThemesProvider attribute="class" defaultTheme="system" enableSystem>
 {children}
 </NextThemesProvider>
 )
}
EOF

echo "Creating Root Layout..."

cat > src/app/layout.tsx << 'EOF'
import "./globals.css"
import { ThemeProvider } from "@/components/theme-provider"

export default function RootLayout({
 children,
}: {
 children: React.ReactNode
}) {
 return (
 <html lang="en" suppressHydrationWarning>
 <body className="min-h-screen bg-background text-foreground">
 <ThemeProvider>{children}</ThemeProvider>
 </body>
 </html>
 )
}
EOF

echo "Creating .env template..."

cat > .env << 'EOF'
DATABASE_URL="postgresql://user:password@localhost:5432/nutritrack"

NEXTAUTH_SECRET=

GOOGLE_CLIENT_ID=
GOOGLE_CLIENT_SECRET=

GITHUB_CLIENT_ID=
GITHUB_CLIENT_SECRET=

FATSECRET_CLIENT_ID=
FATSECRET_CLIENT_SECRET=

OPENAI_API_KEY=
EOF

echo "Bootstrap complete!"
echo ""
echo "Next steps:"
echo "1) cd nutritrack"
echo "2) setup DATABASE_URL in .env"
echo "3) npx prisma migrate dev --name init"
echo "4) npm run dev"
echo ""
echo "Open http://localhost:3000"