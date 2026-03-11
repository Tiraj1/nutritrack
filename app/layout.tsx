import "./globals.css"
import Provider from "@/components/theme-provider"

export default function RootLayout({
 children
}:{children:React.ReactNode}){

 return (
  <html lang="en">
   <body>
    <Provider>
     {children}
    </Provider>
   </body>
  </html>
 )
}
