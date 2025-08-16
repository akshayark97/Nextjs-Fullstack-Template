"use client"

import { useState, useEffect } from "react"
import { Button } from "@/components/ui/button"        // shadcn/ui
import { DropdownMenu, DropdownMenuTrigger, DropdownMenuContent, DropdownMenuItem } from "@/components/ui/dropdown-menu"
import { useTheme } from "next-themes"

export default function Navbar() {
  const [route, setRoute] = useState("home")
  const [session, setSession] = useState(false)       // replace with Supabase auth hook
  const { theme, setTheme } = useTheme()

  useEffect(() => {
    // TODO: listen to route changes and auth session
  }, [])

  const pages = ["home", "features", "pricing", "blog"]
  return (
    <nav className="bg-white dark:bg-slate-800 shadow">
      <div className="container mx-auto px-4 py-3 flex items-center justify-between">
        <h2 className="text-2xl font-bold">NextStack</h2>
        <div className="flex items-center space-x-4">
          {pages.map((p) => (
            <button
              key={p}
              onClick={() => setRoute(p)}
              className={`capitalize hover:text-primary ${route === p ? "text-primary font-semibold" : "text-slate-600 dark:text-slate-300"}`}
            >
              {p}
            </button>
          ))}

          {!session ? (
            <>
              <Button variant="outline" size="sm" onClick={() => setRoute("login")}>
                Login
              </Button>
              <Button variant="default" size="sm" onClick={() => setRoute("register")}>
                Get Started
              </Button>
            </>
          ) : (
            <DropdownMenu>
              <DropdownMenuTrigger asChild>
                <button className="w-8 h-8 rounded-full bg-blue-500 text-white flex items-center justify-center">
                  U
                </button>
              </DropdownMenuTrigger>
              <DropdownMenuContent>
                <DropdownMenuItem onClick={() => setRoute("dashboard")}>Dashboard</DropdownMenuItem>
                <DropdownMenuItem onClick={() => setRoute("settings")}>Settings</DropdownMenuItem>
                <DropdownMenuItem onClick={() => setRoute("admin")}>Admin</DropdownMenuItem>
                <DropdownMenuItem onClick={() => {/* TODO: logout */}}>Logout</DropdownMenuItem>
              </DropdownMenuContent>
            </DropdownMenu>
          )}
 
          <button
            onClick={() => setTheme(theme === "light" ? "dark" : "light")}
            className="p-2 rounded hover:bg-slate-200 dark:hover:bg-slate-700"
            aria-label="Toggle theme"
          >
            {theme === "light" ? "🌙" : "☀️"}
          </button>
        </div>
      </div>
    </nav>
  )
}
