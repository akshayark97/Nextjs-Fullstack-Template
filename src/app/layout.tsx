import Navbar from "@/components/Navbar"
import "./globals.css"
import ThemeProviderWrapper from "@/components/ThemeProviderWrapper"

export const metadata = {
  title: "NextStack",
  description: "Modern Next.js Template",
}

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en" className="bg-white text-slate-900 dark:bg-slate-900 dark:text-slate-50" suppressHydrationWarning>
      <body>
        <ThemeProviderWrapper>
          <Navbar />
          {children}
        </ThemeProviderWrapper>
      </body>
    </html>
  )
}
