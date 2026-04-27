/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./app/views/**/*.{erb,html}",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/assets/tailwind/**/*.css"
  ],
  theme: {
    extend: {}
  },
  plugins: []
}