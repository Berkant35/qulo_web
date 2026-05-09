export const colors = {
  // Brand
  green: "#1FCB7E",
  greenSoft: "#2EE090",
  purple: "#7B5CFA",
  purpleSoft: "#9B82FF",

  // Cool grade (Shot 1-2)
  coolShadow: "#0F1A2E",
  coolMid: "#3A4A66",
  coolHighlight: "#6F86A8",

  // Warm grade (Shot 3-4)
  warmShadow: "#1F1308",
  warmMid: "#5A3F1E",
  warmHighlight: "#E8B070",

  // End card
  bg: "#0D0D0D",
  white: "#FFFFFF",
  whiteSoft: "rgba(255, 255, 255, 0.6)",
} as const;

export const VIDEO = {
  width: 1080,
  height: 1920,
  fps: 30,
  durationSeconds: 15,
} as const;

export const VIDEO_DURATION_FRAMES = VIDEO.fps * VIDEO.durationSeconds;
