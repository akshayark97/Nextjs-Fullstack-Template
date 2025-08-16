// no need for tailwind v4 and you can directly add it in where you import tailwindcss in global.css
import type { Config } from 'tailwindcss'

const config: Config = {
  darkMode: 'class',
  content: [
    './src/app/**/*.{js,ts,jsx,tsx,mdx}',
    './src/pages/**/*.{js,ts,jsx,tsx,mdx}',
    './src/components/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    container: { center: true, padding: '2rem', screens: { '2xl': '1400px' } },
    extend: { /* ... */ },
  },
  plugins: [
    require('@tailwindcss/postcss'),
    require('tailwindcss-animate'),
    require('@tailwindcss/typography'),
  ],
}

export default config
