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
    extend: {colors: {
        open: "#16a34a", // green tone
        in_progress: "#f59e0b", // amber tone
        closed: "#9ca3af", // gray tone
      },
      maxWidth: {
        container: "1440px",
      },
      fontFamily: {
        sans: ["Inter", "system-ui", "sans-serif"],
      },
    },
  },
  plugins: [],
};
