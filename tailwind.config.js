/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./src/**/*.{js,jsx,purs}'],
  theme: {
    extend: {},
  },
  plugins: [require('@tailwindcss/typography')],
}

