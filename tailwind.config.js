/** @type {import('tailwindcss').Config} */


module.exports = {
 
  content: [
    "./templates/**/*.twig",
    
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
