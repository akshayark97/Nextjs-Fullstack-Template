#!/bin/bash

# Next.js Full-Stack Template Setup Script
# This script automates the complete setup process

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_step() {
    echo -e "${BLUE}==>${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Check if required tools are installed
check_prerequisites() {
    print_step "Checking prerequisites..."
    
    if ! command -v node &> /dev/null; then
        print_error "Node.js is not installed. Please install Node.js 18+ first."
        exit 1
    fi
    
    if ! command -v npm &> /dev/null; then
        print_error "npm is not installed. Please install npm first."
        exit 1
    fi
    
    if ! command -v git &> /dev/null; then
        print_error "Git is not installed. Please install Git first."
        exit 1
    fi
    
    # Check Node.js version
    NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
    if [ "$NODE_VERSION" -lt 18 ]; then
        print_error "Node.js version must be 18 or higher. Current version: $(node -v)"
        exit 1
    fi
    
    print_success "All prerequisites are installed"
}

# Create project structure
create_project_structure() {
    print_step "Creating project structure..."
    
    # Create main directories
    mkdir -p src/{app,components,lib,stores,types}
    mkdir -p src/app/{api,\(marketing\),\(auth\),\(dashboard\),\(admin\)}
    mkdir -p src/app/api/{auth/{callback,logout,register},stripe/{checkout,webhook,portal},users/{profile,\[id\]},sanity/webhook,analytics}
    mkdir -p src/components/{ui,layout,auth,dashboard,marketing,features/{stripe,cms,analytics},providers}
    mkdir -p src/lib/{supabase,stripe,sanity,analytics,validations,utils,hooks,db/{queries,migrations}}
    mkdir -p public/{images/{avatars},icons}
    mkdir -p docs scripts .github/{workflows,ISSUE_TEMPLATE}
    mkdir -p supabase/{migrations,functions/{stripe-webhook,send-email}}
    mkdir -p sanity/{schemas,lib}
    
    print_success "Project structure created"
}

# Initialize package.json
init_package_json() {
    print_step "Initializing package.json..."
    
    cat > package.json << 'PKGJSON'
{
  "name": "nextjs-fullstack-template",
  "version": "1.0.0",
  "private": true,
  "description": "A comprehensive Next.js full-stack template with modern tech stack",
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint",
    "lint:fix": "next lint --fix",
    "format": "prettier --write .",
    "type-check": "tsc --noEmit",
    "db:generate": "supabase gen types typescript --local > src/lib/supabase/database.types.ts",
    "db:push": "supabase db push",
    "db:reset": "supabase db reset",
    "stripe:listen": "stripe listen --forward-to localhost:3000/api/stripe/webhook",
    "prepare": "husky install"
  }
}
PKGJSON
    
    print_success "package.json initialized"
}

# Install dependencies
install_dependencies() {
    print_step "Installing dependencies... This may take a few minutes."
    
    # Core Next.js dependencies
    npm install next@latest react@latest react-dom@latest typescript @types/node @types/react @types/react-dom
    
    # Styling
    npm install -D tailwindcss postcss autoprefixer @tailwindcss/typography tailwindcss-animate
    npm install class-variance-authority clsx tailwind-merge lucide-react
    
    # UI Components (Radix UI)
    npm install @radix-ui/react-avatar @radix-ui/react-dropdown-menu @radix-ui/react-dialog @radix-ui/react-toast @radix-ui/react-tabs @radix-ui/react-switch @radix-ui/react-checkbox @radix-ui/react-select @radix-ui/react-label @radix-ui/react-slot @radix-ui/react-separator @radix-ui/react-progress @radix-ui/react-alert-dialog @radix-ui/react-tooltip
    
    # Backend & Database
    npm install @supabase/supabase-js @supabase/ssr
    
    # Payments
    npm install stripe @stripe/stripe-js
    
    # State Management & Data Fetching
    npm install @tanstack/react-query @tanstack/react-query-devtools zustand
    
    # Validation & Forms
    npm install zod react-hook-form @hookform/resolvers
    
    # Monitoring & Analytics
    npm install @sentry/nextjs posthog-js
    
    # CMS
    npm install @sanity/client @sanity/image-url
    
    # Utilities
    npm install @t3-oss/env-nextjs date-fns lodash next-themes sonner cmdk
    npm install -D @types/lodash
    
    # Development tools
    npm install -D eslint @typescript-eslint/eslint-plugin @typescript-eslint/parser eslint-config-next prettier eslint-config-prettier eslint-plugin-prettier prettier-plugin-tailwindcss husky lint-staged
    
    # Optional CLI tools
    npm install -D supabase @sanity/cli next-sitemap
    
    print_success "Dependencies installed"
}

# Create configuration files
create_config_files() {
    print_step "Creating configuration files..."
    
    # TypeScript config
    cat > tsconfig.json << 'TSCONFIG'
{
  "compilerOptions": {
    "lib": ["dom", "dom.iterable", "es6"],
    "allowJs": true,
    "skipLibCheck": true,
    "strict": true,
    "noEmit": true,
    "esModuleInterop": true,
    "module": "esnext",
    "moduleResolution": "bundler",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "jsx": "preserve",
    "incremental": true,
    "plugins": [{"name": "next"}],
    "baseUrl": ".",
    "paths": {
      "@/*": ["./src/*"],
      "@/components/*": ["./src/components/*"],
      "@/lib/*": ["./src/lib/*"],
      "@/stores/*": ["./src/stores/*"],
      "@/types/*": ["./src/types/*"],
      "@/app/*": ["./src/app/*"]
    }
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx", ".next/types/**/*.ts"],
  "exclude": ["node_modules", ".next", "out", "dist"]
}
TSCONFIG

    # Tailwind config
    cat > tailwind.config.ts << 'TAILWIND'
import type { Config } from 'tailwindcss'

const config: Config = {
  darkMode: ['class'],
  content: [
    './src/pages/**/*.{js,ts,jsx,tsx,mdx}',
    './src/components/**/*.{js,ts,jsx,tsx,mdx}',
    './src/app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    container: {
      center: true,
      padding: '2rem',
      screens: {
        '2xl': '1400px',
      },
    },
    extend: {
      colors: {
        border: 'hsl(var(--border))',
        input: 'hsl(var(--input))',
        ring: 'hsl(var(--ring))',
        background: 'hsl(var(--background))',
        foreground: 'hsl(var(--foreground))',
        primary: {
          DEFAULT: 'hsl(var(--primary))',
          foreground: 'hsl(var(--primary-foreground))',
        },
        secondary: {
          DEFAULT: 'hsl(var(--secondary))',
          foreground: 'hsl(var(--secondary-foreground))',
        },
        destructive: {
          DEFAULT: 'hsl(var(--destructive))',
          foreground: 'hsl(var(--destructive-foreground))',
        },
        muted: {
          DEFAULT: 'hsl(var(--muted))',
          foreground: 'hsl(var(--muted-foreground))',
        },
        accent: {
          DEFAULT: 'hsl(var(--accent))',
          foreground: 'hsl(var(--accent-foreground))',
        },
        popover: {
          DEFAULT: 'hsl(var(--popover))',
          foreground: 'hsl(var(--popover-foreground))',
        },
        card: {
          DEFAULT: 'hsl(var(--card))',
          foreground: 'hsl(var(--card-foreground))',
        },
      },
      borderRadius: {
        lg: 'var(--radius)',
        md: 'calc(var(--radius) - 2px)',
        sm: 'calc(var(--radius) - 4px)',
      },
      keyframes: {
        'accordion-down': {
          from: { height: '0' },
          to: { height: 'var(--radix-accordion-content-height)' },
        },
        'accordion-up': {
          from: { height: 'var(--radix-accordion-content-height)' },
          to: { height: '0' },
        },
      },
      animation: {
        'accordion-down': 'accordion-down 0.2s ease-out',
        'accordion-up': 'accordion-up 0.2s ease-out',
      },
    },
  },
  plugins: [
    require('tailwindcss-animate'),
    require('@tailwindcss/typography'),
  ],
} satisfies Config

export default config
TAILWIND

    # Next.js config
    cat > next.config.js << 'NEXTCONFIG'
/** @type {import('next').NextConfig} */
const nextConfig = {
  experimental: {
    typedRoutes: true,
  },
  images: {
    remotePatterns: [
      {
        protocol: 'https',
        hostname: 'cdn.sanity.io',
      },
      {
        protocol: 'https',
        hostname: '*.supabase.co',
      },
    ],
  },
}

module.exports = nextConfig
NEXTCONFIG

    # PostCSS config
    cat > postcss.config.js << 'POSTCSS'
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
POSTCSS

    # Environment template
    cat > .env.local.example << 'ENV'
# Next.js Configuration
NEXT_PUBLIC_APP_URL=http://localhost:3000

# Supabase Configuration
NEXT_PUBLIC_SUPABASE_URL=your_supabase_project_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
SUPABASE_SERVICE_ROLE_KEY=your_supabase_service_role_key

# Stripe Configuration
STRIPE_SECRET_KEY=sk_test_your_stripe_secret_key
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=pk_test_your_stripe_publishable_key
STRIPE_WEBHOOK_SECRET=whsec_your_webhook_secret

# Sentry Configuration (Optional)
SENTRY_DSN=your_sentry_dsn
SENTRY_ORG=your_sentry_organization
SENTRY_PROJECT=your_sentry_project

# PostHog Configuration (Optional)
NEXT_PUBLIC_POSTHOG_KEY=your_posthog_project_api_key
NEXT_PUBLIC_POSTHOG_HOST=https://us.i.posthog.com

# Sanity Configuration (Optional)
NEXT_PUBLIC_SANITY_PROJECT_ID=your_sanity_project_id
NEXT_PUBLIC_SANITY_DATASET=production
SANITY_API_TOKEN=your_sanity_api_token

# Feature Flags
ENABLE_ANALYTICS=true
ENABLE_ERROR_TRACKING=true
ENABLE_CMS=true
ENABLE_PAYMENTS=true
ENV

    # Copy environment template
    cp .env.local.example .env.local
    
    # ESLint config
    cat > .eslintrc.json << 'ESLINT'
{
  "extends": [
    "next/core-web-vitals",
    "@typescript-eslint/recommended",
    "prettier"
  ],
  "parser": "@typescript-eslint/parser",
  "plugins": ["@typescript-eslint"],
  "rules": {
    "@typescript-eslint/no-unused-vars": "error",
    "@typescript-eslint/no-explicit-any": "warn",
    "prefer-const": "error"
  }
}
ESLINT

    # Prettier config
    cat > prettier.config.js << 'PRETTIER'
module.exports = {
  plugins: ['prettier-plugin-tailwindcss'],
  semi: false,
  singleQuote: true,
  tabWidth: 2,
  trailingComma: 'es5',
}
PRETTIER

    # Components config for shadcn/ui
    cat > components.json << 'COMPONENTS'
{
  "$schema": "https://ui.shadcn.com/schema.json",
  "style": "default",
  "rsc": true,
  "tsx": true,
  "tailwind": {
    "config": "tailwind.config.ts",
    "css": "src/app/globals.css",
    "baseColor": "slate",
    "cssVariables": true,
    "prefix": ""
  },
  "aliases": {
    "components": "@/components",
    "utils": "@/lib/utils"
  }
}
COMPONENTS
    
    print_success "Configuration files created"
}

# Create .gitignore
create_gitignore() {
    print_step "Creating .gitignore..."
    
    cat > .gitignore << 'GITIGNORE'
# Dependencies
node_modules/
/.pnp
.pnp.js

# Testing
/coverage

# Next.js
/.next/
/out/

# Production
/build
dist/

# Misc
.DS_Store
*.pem

# Debug
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Local env files
.env.local
.env.development.local
.env.test.local
.env.production.local

# Vercel
.vercel

# TypeScript
*.tsbuildinfo
next-env.d.ts

# Supabase
**/supabase/.branches
**/supabase/.temp
**/supabase/logs

# IDEs
.vscode/
.idea/

# OS
Thumbs.db

# Husky
.husky/_
GITIGNORE
    
    print_success ".gitignore created"
}

# Initialize Git
init_git() {
    print_step "Initializing Git repository..."
    
    if [ ! -d ".git" ]; then
        git init
        print_success "Git repository initialized"
    else
        print_warning "Git repository already exists"
    fi
}

# Create basic app files
create_basic_files() {
    print_step "Creating basic app files..."
    
    # Create basic layout
    cat > src/app/layout.tsx << 'LAYOUT'
import type { Metadata } from 'next'
import { Inter } from 'next/font/google'
import './globals.css'

const inter = Inter({ subsets: ['latin'] })

export const metadata: Metadata = {
  title: 'Next.js Full-Stack Template',
  description: 'A comprehensive Next.js template with modern tech stack',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body className={inter.className}>{children}</body>
    </html>
  )
}
LAYOUT

    # Create basic page
    cat > src/app/page.tsx << 'PAGE'
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
PAGE

    # Create basic globals.css
    cat > src/app/globals.css << 'CSS'
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer base {
  :root {
    --background: 0 0% 100%;
    --foreground: 222.2 84% 4.9%;
    --card: 0 0% 100%;
    --card-foreground: 222.2 84% 4.9%;
    --popover: 0 0% 100%;
    --popover-foreground: 222.2 84% 4.9%;
    --primary: 222.2 47.4% 11.2%;
    --primary-foreground: 210 40% 98%;
    --secondary: 210 40% 96%;
    --secondary-foreground: 222.2 47.4% 11.2%;
    --muted: 210 40% 96%;
    --muted-foreground: 215.4 16.3% 46.9%;
    --accent: 210 40% 96%;
    --accent-foreground: 222.2 47.4% 11.2%;
    --destructive: 0 84.2% 60.2%;
    --destructive-foreground: 210 40% 98%;
    --border: 214.3 31.8% 91.4%;
    --input: 214.3 31.8% 91.4%;
    --ring: 222.2 84% 4.9%;
    --radius: 0.5rem;
  }

  .dark {
    --background: 222.2 84% 4.9%;
    --foreground: 210 40% 98%;
    --card: 222.2 84% 4.9%;
    --card-foreground: 210 40% 98%;
    --popover: 222.2 84% 4.9%;
    --popover-foreground: 210 40% 98%;
    --primary: 210 40% 98%;
    --primary-foreground: 222.2 47.4% 11.2%;
    --secondary: 217.2 32.6% 17.5%;
    --secondary-foreground: 210 40% 98%;
    --muted: 217.2 32.6% 17.5%;
    --muted-foreground: 215 20.2% 65.1%;
    --accent: 217.2 32.6% 17.5%;
    --accent-foreground: 210 40% 98%;
    --destructive: 0 62.8% 30.6%;
    --destructive-foreground: 210 40% 98%;
    --border: 217.2 32.6% 17.5%;
    --input: 217.2 32.6% 17.5%;
    --ring: 212.7 26.8% 83.9%;
  }
}

* {
  border-color: hsl(var(--border));
}

body {
  color: hsl(var(--foreground));
  background: hsl(var(--background));
}
CSS

    # Create utility functions
    mkdir -p src/lib
    cat > src/lib/utils.ts << 'UTILS'
import { type ClassValue, clsx } from "clsx"
import { twMerge } from "tailwind-merge"

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}
UTILS

    print_success "Basic app files created"
}

# Setup Husky
setup_husky() {
    print_step "Setting up Husky..."
    
    npx husky install
    npx husky add .husky/pre-commit "npx lint-staged"
    
    # Add lint-staged config to package.json
    npm pkg set lint-staged='{"*.{js,jsx,ts,tsx}":["eslint --fix","prettier --write"],"*.{json,md,css}":["prettier --write"]}'
    
    print_success "Husky configured"
}

# Create README
create_readme() {
    print_step "Creating README..."
    
    cat > README.md << 'README'
# 🚀 Next.js Full-Stack Template

A comprehensive, production-ready Next.js template with modern tech stack including TypeScript, Tailwind CSS, Supabase, Stripe, and more.

## ⭐ Features

- **Framework**: Next.js 15 with App Router
- **Language**: TypeScript with strict configuration
- **Styling**: Tailwind CSS v4 + shadcn/ui components
- **Backend**: Supabase (PostgreSQL, Auth, Storage, Real-time)
- **Payments**: Stripe (Checkout, Subscriptions, Webhooks)
- **State Management**: Zustand + React Query (TanStack Query)
- **Validation**: Zod schemas
- **Auth**: Complete authentication system with social login
- **Database**: PostgreSQL with type-safe queries
- **Monitoring**: Sentry error tracking
- **Analytics**: PostHog analytics & feature flags
- **CMS**: Sanity headless CMS integration
- **CI/CD**: GitHub Actions workflow
- **Deployment**: Optimized for Vercel

## 🛠 Quick Start

### Prerequisites
- Node.js 18+
- npm/yarn/pnpm
- Git

### 1. Install Dependencies
```bash
npm install
```

### 2. Configure Environment Variables
```bash
cp .env.local.example .env.local
# Edit .env.local with your actual values
```

### 3. Run Development Server
```bash
npm run dev
```

Visit `http://localhost:3000` to see your application.

## 📋 Available Scripts

| Command | Description |
|---------|-------------|
| `npm run dev` | Start development server |
| `npm run build` | Build for production |
| `npm run start` | Start production server |
| `npm run lint` | Run ESLint |
| `npm run format` | Format code with Prettier |
| `npm run type-check` | Run TypeScript type checking |
| `npm run db:generate` | Generate database types |
| `npm run db:push` | Push database changes |
| `npm run stripe:listen` | Listen to Stripe webhooks |

## 🚀 Deployment

### Vercel (Recommended)
1. Push your code to GitHub
2. Import your repository in Vercel
3. Configure environment variables
4. Deploy

## 📚 Documentation

- Edit `src/app/page.tsx` to customize your homepage
- Add components in `src/components/`
- Configure services in `src/lib/`
- Manage state in `src/stores/`

Built with ❤️ using modern web technologies.
README
    
    print_success "README created"
}

# Main execution
main() {
    echo -e "${GREEN}"
    echo "╔══════════════════════════════════════════════════════╗"
    echo "║              Next.js Full-Stack Template            ║"
    echo "║                 Setup Script v1.0                   ║"
    echo "╚══════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    
    check_prerequisites
    create_project_structure
    init_package_json
    install_dependencies
    create_config_files
    create_gitignore
    create_basic_files
    init_git
    setup_husky
    create_readme
    
    echo -e "${GREEN}"
    echo "╔══════════════════════════════════════════════════════╗"
    echo "║                    SUCCESS! 🎉                      ║"
    echo "║        Your Next.js template is ready to use!       ║"
    echo "╚══════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    
    echo -e "${YELLOW}Next steps:${NC}"
    echo "1. Edit .env.local with your actual service credentials"
    echo "2. Run 'npm run dev' to start the development server"
    echo "3. Visit http://localhost:3000 to see your application"
    echo ""
    echo -e "${BLUE}Optional setup:${NC}"
    echo "• Initialize shadcn/ui components: npx shadcn@latest add button"
    echo "• Initialize Supabase: npx supabase init && npx supabase start"
    echo "• Initialize Sanity: npx sanity init"
    echo "• Deploy to Vercel: npx vercel"
    echo ""
    echo -e "${GREEN}Happy coding! 🚀${NC}"
}

# Run the main function
main "$@"