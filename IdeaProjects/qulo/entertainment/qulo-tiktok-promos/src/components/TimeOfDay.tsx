import {AbsoluteFill, interpolate, spring, useCurrentFrame, useVideoConfig} from 'remotion';
import {theme} from '../theme';

type Props = {
  label: string;
  subLabel?: string;
  icon?: string;
  tone?: 'morning' | 'evening' | 'night';
  time?: 'morning' | 'noon' | 'evening' | 'week-transition';
  subtle?: boolean;
};

const TONE_GRADIENT: Record<string, readonly [string, string]> = {
  morning: ['#FFE680', '#FF9B6B'],
  evening: ['#7B5CFA', '#2C1E62'],
  night: ['#1E2257', '#0A0E2A'],
} as const;

const TIME_GRADIENT: Record<string, readonly [string, string]> = {
  morning: ['#FFE680', '#FF9B6B'],
  noon: ['#87CEEB', '#4A90E2'],
  evening: ['#FF6B6B', '#7B5CFA'],
  'week-transition': ['#A855F7', '#22C55E'],
} as const;

export const TimeOfDay: React.FC<Props> = ({label, subLabel, icon, tone = 'evening', time, subtle = false}) => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();

  const scale = spring({frame, fps, config: {damping: 13, stiffness: 100}});
  const opacity = interpolate(frame, [0, 8], [0, 1], {extrapolateRight: 'clamp'});

  // `time` overrides `tone` gradient when provided
  const gradient: readonly [string, string] = time ? TIME_GRADIENT[time] : TONE_GRADIENT[tone];

  return (
    <AbsoluteFill
      style={{
        background: subtle
          ? theme.colors.bg
          : `radial-gradient(circle at 50% 40%, ${gradient[0]}33 0%, ${theme.colors.bg} 70%)`,
        justifyContent: 'center',
        alignItems: 'center',
      }}
    >
      {subtle ? (
        <div
          style={{
            position: 'absolute',
            inset: 0,
            background: `radial-gradient(circle at 50% 40%, ${gradient[0]}18 0%, transparent 70%)`,
            pointerEvents: 'none',
          }}
        />
      ) : null}
      <div
        style={{
          transform: `scale(${scale})`,
          opacity,
          textAlign: 'center',
          fontFamily: theme.fonts.display,
        }}
      >
        {icon ? (
          <div style={{fontSize: 140, marginBottom: 24}}>{icon}</div>
        ) : null}
        <div
          style={{
            fontSize: 96,
            fontWeight: 900,
            background: `linear-gradient(135deg, ${gradient[0]} 0%, ${gradient[1]} 100%)`,
            WebkitBackgroundClip: 'text',
            WebkitTextFillColor: 'transparent',
            letterSpacing: -2,
          }}
        >
          {label}
        </div>
        {subLabel ? (
          <div
            style={{
              marginTop: 16,
              fontSize: 32,
              color: theme.colors.textMuted,
              fontWeight: 500,
              letterSpacing: 1,
            }}
          >
            {subLabel}
          </div>
        ) : null}
      </div>
    </AbsoluteFill>
  );
};
