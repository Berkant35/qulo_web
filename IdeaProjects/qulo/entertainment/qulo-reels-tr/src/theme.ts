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
    paper: '#F2EDE4',
    paperInk: '#171717',
  },
  fonts: {
    display: `${poppins}, "SF Pro Display", system-ui, sans-serif`,
    body: `${poppins}, "SF Pro Text", system-ui, sans-serif`,
  },
  type: {
    hook: 84,
    title: 64,
    body: 42,
    small: 28,
    weight: 800,
  },
  safeZone: {
    top: 140,
    bottom: 260,
    horizontal: 70,
  },
  radius: {sm: 10, md: 16, lg: 24, xl: 36, pill: 999},
  composition: {
    width: 1080,
    height: 1920,
    fps: 30,
  },
} as const;

export type Theme = typeof theme;
