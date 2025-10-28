/** @type {import('tailwindcss').Config} */
const shared = require("../tailwind.config.js");

module.exports = {
  ...shared,
  content: [
    "./templates/**/*.twig",
    "../assets/**/*.svg",
  ],
   safelist: [
    "bg-red-600",
    "bg-green-600",
    "bg-amber-500",
    "text-white",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
};
