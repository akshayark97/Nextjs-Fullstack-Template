
<img width="2880" height="1624" alt="image" src="https://github.com/user-attachments/assets/63060783-e068-4b75-87ec-4d5b9941c9ce" />

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

## 📦 Tech Stack

| Category | Technology | Purpose |
|----------|------------|---------|
| Framework | Next.js 15 | SSR/SSG, API routes, edge functions |
| Language | TypeScript | Compile-time safety and better IDE support |
| Styling | Tailwind CSS | Utility-first responsive design |
| UI Components | shadcn/ui | Accessible, headless primitives |
| Backend & Database | Supabase | PostgreSQL, auth, storage, real-time |
| Payments | Stripe | Checkout UI, subscriptions, webhooks |
| Data Fetching | React Query | Client-side caching, background refetch |
| State Management | Zustand | Global UI state (cart, modals, theme) |
| Validation | Zod | Runtime schema validation |
| Monitoring & Errors | Sentry | Error tracking for frontend and serverless |
| Analytics | PostHog | Conversion funnels, A/B tests, feature flags |
| CMS | Sanity | Product catalog, rich content editing |
| CI/CD | GitHub Actions | Automated lint/test and deployment |
| Deployment | Vercel | Zero-config hosting, serverless functions |

## 🛠 Quick Start

### Prerequisites
- Node.js 18+
- npm/yarn/pnpm
- Git

### 1. Clone & Setup
```bash
# Clone the repository
git clone https://github.com/yourusername/nextjs-fullstack-template.git
cd nextjs-fullstack-template

# Install dependencies
npm install

# Copy environment variables
cp .env.local.example .env.local
```

### 2. Configure Environment Variables
Edit `.env.local` with your actual values:

```bash
# Supabase
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key

# Stripe
STRIPE_SECRET_KEY=your_stripe_secret_key
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=your_stripe_publishable_key

# Add other services as needed
```

### 3. Initialize Services

#### Supabase Setup
```bash
# Start Supabase locally (optional)
npx supabase start

# Or link to your cloud project
npx supabase link --project-ref your-project-ref

# Push database migrations
npm run db:push

# Generate TypeScript types
npm run db:generate
```

#### Stripe Setup
```bash
# Listen to webhooks (in development)
npm run stripe:listen
```

### 4. Run Development Server
```bash
npm run dev
```

Visit `http://localhost:3000` to see your application.

## 📁 Project Structure

```
├── src/
│   ├── app/                    # Next.js App Router pages
│   │   ├── (marketing)/        # Public marketing pages
│   │   ├── (auth)/             # Authentication pages
│   │   ├── (dashboard)/        # Protected user dashboard
│   │   ├── (admin)/            # Admin panel
│   │   └── api/                # API routes
│   ├── components/             # React components
│   │   ├── ui/                 # shadcn/ui primitives
│   │   ├── layout/             # Layout components
│   │   ├── features/           # Feature-specific components
│   │   └── providers/          # Context providers
│   ├── lib/                    # Configuration and utilities
│   │   ├── supabase/           # Database client setup
│   │   ├── stripe/             # Payment processing
│   │   ├── validations/        # Zod schemas
│   │   └── utils/              # Helper functions
│   ├── stores/                 # Zustand state stores
│   └── types/                  # TypeScript definitions
├── public/                     # Static assets
├── supabase/                   # Database migrations & functions
├── docs/                       # Documentation
└── .github/                    # GitHub Actions workflows
```

## 🎯 Key Features

### Authentication System
- Email/password authentication
- Social login (Google, GitHub)
- Password reset functionality
- Protected routes with middleware
- Role-based access control

### Payment Integration
- Stripe Checkout for one-time payments
- Subscription management
- Customer portal
- Webhook handling for payment events
- Invoice generation

### Database & API
- Type-safe database queries
- Real-time subscriptions
- File storage and CDN
- RESTful API routes
- Edge functions

### UI & Styling
- Dark/Light mode toggle
- Responsive design
- Accessible components
- Custom design system
- Loading and error states

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
| `npm run db:reset` | Reset database |
| `npm run stripe:listen` | Listen to Stripe webhooks |

## 🚀 Deployment

### Vercel (Recommended)
1. Push your code to GitHub
2. Import your repository in Vercel
3. Configure environment variables
4. Deploy

### Environment Variables for Production
Set these in your deployment platform:
- `NEXT_PUBLIC_SUPABASE_URL`
- `NEXT_PUBLIC_SUPABASE_ANON_KEY`
- `SUPABASE_SERVICE_ROLE_KEY`
- `STRIPE_SECRET_KEY`
- `NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY`
- `STRIPE_WEBHOOK_SECRET`
- All other optional service keys

## 📚 Documentation

- [Setup Guide](./docs/setup.md)
- [API Documentation](./docs/api.md)
- [Deployment Guide](./docs/deployment.md)
- [Contributing](./docs/contributing.md)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Next.js](https://nextjs.org/) - The React framework
- [Supabase](https://supabase.com/) - Backend as a Service
- [Stripe](https://stripe.com/) - Payment processing
- [shadcn/ui](https://ui.shadcn.com/) - UI components
- [T3 Stack](https://create.t3.gg/) - Inspiration for developer experience

## 📞 Support

If you have any questions or need help, please:
- Open an issue on GitHub
- Check the documentation
- Join our Discord community

---

Built with ❤️ by Akshay Rk
