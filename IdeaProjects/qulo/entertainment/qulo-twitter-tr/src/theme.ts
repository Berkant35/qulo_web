import {loadFont} from '@remotion/google-fonts/Poppins';

const {fontFamily: poppins} = loadFont('normal', {
  weights: ['400', '500', '600', '700', '800', '900'],
});

export const theme = {
  colors: {
    bg: '#0D0D0D',
    bgAlt: '#1A1A1A',
    surface: '#1A1A1A',
    surfaceElevated: '#242424',
    green: '#69F0AE',
    greenDark: '#4CAF50',
    purple: '#BB86FC',
    danger: '#CF6679',
    text: '#FFFFFF',
    textMuted: '#B0B0B0',
    textHint: '#666666',
    border: '#2A2A2A',
  },
  fonts: {
    display: `${poppins}, "SF Pro Display", system-ui, sans-serif`,
    body: `${poppins}, "SF Pro Text", system-ui, sans-serif`,
  },
  type: {
    hook: 120,
    title: 92,
    body: 56,
    small: 36,
    weight: 800,
  },
  safeZone: {
    top: 80,
    bottom: 100,
    horizontal: 120,
  },
  radius: {sm: 10, md: 16, lg: 24, xl: 36, pill: 999},
  composition: {
    width: 1920,
    height: 1080,
    fps: 30,
  },
} as const;

export type Theme = typeof theme;
