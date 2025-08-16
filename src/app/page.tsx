import { Button } from "@/components/ui/button"
import Link from "next/link"

export default function HomePage() {
  return (
    <main className="space-y-16">
      {/* Hero */}
      <section className="bg-slate-100 dark:bg-slate-700">
        <div className="container mx-auto px-4 py-16 flex flex-col lg:flex-row items-center">
          <div className="flex-1 space-y-6">
            <h1 className="text-4xl font-bold">Modern Next.js Template</h1>
            <p className="text-lg text-slate-700 dark:text-slate-300">
              Production-ready template with TypeScript, Supabase, Stripe, and more
            </p>
            <div className="space-x-4">
              <Link href="/register" passHref><Button size="lg">Get Started</Button></Link>
              <Link href="/features" passHref><Button variant="outline" size="lg">View Features</Button></Link>
            </div>
          </div>
          <div className="flex-1 grid grid-cols-1 sm:grid-cols-3 gap-6 mt-8 lg:mt-0">
            <div className="text-center">
              <div className="text-3xl font-bold">12+</div>
              <div className="text-slate-600 dark:text-slate-300">Technologies</div>
            </div>
            <div className="text-center">
              <div className="text-3xl font-bold">100%</div>
              <div className="text-slate-600 dark:text-slate-300">TypeScript</div>
            </div>
            <div className="text-center">
              <div className="text-3xl">⚡</div>
              <div className="text-slate-600 dark:text-slate-300">Performance</div>
            </div>
          </div>
        </div>
      </section>

      {/* Tech Stack */}
      <section className="container mx-auto px-4 py-16">
        <h2 className="text-3xl font-bold text-center mb-8">Tech Stack</h2>
        <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-8">
          {[
            { title: "Next.js 15", desc: "App Router with server components" },
            { title: "TypeScript", desc: "Strict mode with type safety" },
            { title: "Tailwind CSS", desc: "Utility-first CSS framework" },
            { title: "Supabase", desc: "Auth, database, and real-time" },
            { title: "Stripe", desc: "Payment processing" },
            { title: "React Query", desc: "Server state management" },
          ].map((tech) => (
            <div key={tech.title} className="p-6 bg-white dark:bg-slate-800 rounded-lg shadow">
              <h3 className="text-xl font-semibold mb-2">{tech.title}</h3>
              <p className="text-slate-600 dark:text-slate-300">{tech.desc}</p>
            </div>
          ))}
        </div>
      </section>
    </main>
  )
}
