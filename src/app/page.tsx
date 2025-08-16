export default function Home() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-between p-24">
      <div className="z-10 max-w-5xl w-full items-center justify-between font-mono text-sm">
        <h1 className="text-4xl font-bold text-center">
          Next.js Full-Stack Template
        </h1>
        <p className="text-center mt-4 text-xl text-muted-foreground">
          🚀 Your modern full-stack application is ready!
        </p>
        <div className="mt-8 grid grid-cols-1 md:grid-cols-2 gap-4 text-center">
          <div className="p-6 border rounded-lg shadow-sm">
            <h3 className="font-semibold text-lg">⚡ Next.js 15</h3>
            <p className="text-muted-foreground">App Router + TypeScript</p>
          </div>
          <div className="p-6 border rounded-lg shadow-sm">
            <h3 className="font-semibold text-lg">🎨 Tailwind CSS</h3>
            <p className="text-muted-foreground">+ shadcn/ui components</p>
          </div>
          <div className="p-6 border rounded-lg shadow-sm">
            <h3 className="font-semibold text-lg">🗄️ Supabase</h3>
            <p className="text-muted-foreground">Database + Auth + Storage</p>
          </div>
          <div className="p-6 border rounded-lg shadow-sm">
            <h3 className="font-semibold text-lg">💳 Stripe</h3>
            <p className="text-muted-foreground">Payment processing</p>
          </div>
        </div>
        <div className="mt-8 text-center">
          <p className="text-sm text-muted-foreground mb-4">
            Complete with React Query, Zustand, Zod, Sentry, PostHog, and Sanity CMS
          </p>
          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <button className="px-6 py-2 bg-primary text-primary-foreground rounded-md hover:bg-primary/90 transition-colors">
              Get Started
            </button>
            <button className="px-6 py-2 border border-input rounded-md hover:bg-accent hover:text-accent-foreground transition-colors">
              View Docs
            </button>
          </div>
        </div>
      </div>
    </main>
  )
}
