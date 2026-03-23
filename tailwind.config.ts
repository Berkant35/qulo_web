import type { Config } from "tailwindcss";

const config: Config = {
  content: ["./src/**/*.{js,ts,jsx,tsx,mdx}"],
  theme: {
    extend: {
      colors: {
        qulo: {
          purple: { light: "#BB86FC", DEFAULT: "#BB86FC", dark: "#9C27B0" },
          green: { light: "#69F0AE", DEFAULT: "#69F0AE", dark: "#4CAF50" },
          bg: { DEFAULT: "#050508", card: "#0D0D0D", surface: "#1A1A1A" },
          text: { primary: "#FFFFFF", secondary: "#888888", muted: "#555555" },
          error: "#CF6679",
          success: "#69F0AE",
          warning: "#FFB74D",
        },
      },
      fontFamily: {
        sans: ["var(--font-inter)", "system-ui", "sans-serif"],
      },
      animation: {
        "float-slow": "float 6s ease-in-out infinite",
        "float-medium": "float 4s ease-in-out infinite",
        "float-fast": "float 3s ease-in-out infinite",
        "glow-pulse": "glowPulse 4s ease-in-out infinite",
        "mesh-move": "meshMove 12s ease infinite",
        "scanline": "scanline 8s linear infinite",
        "morph-blob": "morphBlob 15s ease-in-out infinite",
        "rotate-border": "rotateBorder 4s linear infinite",
        "pulse-ring": "pulseRing 4s ease-out infinite",
        "border-glow": "borderGlow 4s ease-in-out infinite",
      },
    },
  },
  plugins: [],
};

export default config;
