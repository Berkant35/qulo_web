import {AbsoluteFill, interpolate, spring, useCurrentFrame, useVideoConfig, Img, staticFile} from 'remotion';
import {theme} from '../theme';

type Props = {
  headline: string;
  subline?: string;
  showBadges?: boolean;
};

export const CTAScene: React.FC<Props> = ({headline, subline, showBadges = false}) => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();

  const logoScale = spring({frame, fps, config: {damping: 10, stiffness: 120}});
  const headlineOpacity = interpolate(frame, [10, 22], [0, 1], {extrapolateRight: 'clamp'});
  const sublineOpacity = interpolate(frame, [22, 34], [0, 1], {extrapolateRight: 'clamp'});

  return (
    <AbsoluteFill
      style={{
        background: `linear-gradient(180deg, ${theme.colors.bg} 0%, #1a0e2a 100%)`,
        padding: `${theme.safeZone.top}px ${theme.safeZone.horizontal}px ${theme.safeZone.bottom}px`,
        justifyContent: 'center',
        alignItems: 'center',
      }}
    >
      <Img
        src={staticFile('brand/qulo_logo.svg')}
        style={{width: 360, height: 'auto', transform: `scale(${logoScale})`}}
      />

      <div
        style={{
          marginTop: 56,
          color: theme.colors.text,
          fontFamily: theme.fonts.display,
          fontWeight: 900,
          fontSize: theme.caption.sizeCTA,
          textAlign: 'center',
          opacity: headlineOpacity,
          lineHeight: 1.05,
          letterSpacing: -1.5,
        }}
      >
        {headline}
      </div>

      {subline ? (
        <div
          style={{
            marginTop: 24,
            color: theme.colors.textMuted,
            fontFamily: theme.fonts.body,
            fontWeight: 600,
            fontSize: 40,
            textAlign: 'center',
            opacity: sublineOpacity,
          }}
        >
          {subline}
        </div>
      ) : null}

      {showBadges ? (
        <div
          style={{
            marginTop: 40,
            display: 'flex',
            gap: 24,
            opacity: sublineOpacity,
          }}
        >
          {/* Placeholder badges — brand/app-store-badge.svg and brand/google-play-badge.svg not present */}
          {(['App Store', 'Google Play'] as const).map((label) => (
            <div
              key={label}
              style={{
                background: '#1c1c1e',
                border: '1.5px solid rgba(255,255,255,0.25)',
                borderRadius: 14,
                padding: '14px 28px',
                display: 'flex',
                alignItems: 'center',
                gap: 10,
                color: '#fff',
                fontFamily: theme.fonts.body,
                fontWeight: 600,
                fontSize: 24,
                minWidth: 180,
                justifyContent: 'center',
              }}
            >
              {label === 'App Store' ? '🍎' : '▶'} {label}
            </div>
          ))}
        </div>
      ) : null}
    </AbsoluteFill>
  );
};
