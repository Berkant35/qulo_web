import {AbsoluteFill, Img, interpolate, spring, staticFile, useCurrentFrame, useVideoConfig} from 'remotion';
import {theme} from '../theme';

type StatItem = {
  value: string;
  label: string;
  tone?: 'green' | 'purple' | 'danger' | 'muted';
};

type Props = {
  title?: string;
  items: StatItem[];
  compact?: boolean;
  infographic?: boolean;
  large?: boolean;
};

const toneColor = (tone: StatItem['tone']): string => {
  switch (tone) {
    case 'green':
      return theme.colors.green;
    case 'purple':
      return theme.colors.purple;
    case 'danger':
      return theme.colors.danger;
    case 'muted':
      return theme.colors.textMuted;
    default:
      return theme.colors.text;
  }
};

export const StatsGrid: React.FC<Props> = ({title, items, compact = false, infographic = false, large = false}) => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();

  // --- compact: 3-stat horizontal row, 32px font, 80px height ---
  if (compact) {
    return (
      <AbsoluteFill style={{background: theme.colors.bg, justifyContent: 'center', alignItems: 'center'}}>
        <div style={{display: 'flex', flexDirection: 'row', gap: 24, height: 80, alignItems: 'center', padding: `0 ${theme.safeZone.horizontal}px`}}>
          {items.slice(0, 3).map((item, i) => {
            const delay = 4 + i * 6;
            const reveal = spring({frame: frame - delay, fps, config: {damping: 14, stiffness: 110}});
            return (
              <div
                key={i}
                style={{
                  flex: 1,
                  background: theme.colors.bgAlt,
                  borderRadius: 20,
                  padding: '10px 16px',
                  textAlign: 'center',
                  opacity: reveal,
                  transform: `translateY(${(1 - reveal) * 20}px)`,
                  height: 80,
                  display: 'flex',
                  flexDirection: 'column',
                  justifyContent: 'center',
                }}
              >
                <div style={{color: toneColor(item.tone), fontFamily: theme.fonts.display, fontWeight: 900, fontSize: 32, lineHeight: 1}}>{item.value}</div>
                <div style={{color: theme.colors.textMuted, fontFamily: theme.fonts.body, fontWeight: 600, fontSize: 16, marginTop: 4}}>{item.label}</div>
              </div>
            );
          })}
        </div>
      </AbsoluteFill>
    );
  }

  // --- infographic: icon + label + value cells with diamond accents ---
  if (infographic) {
    return (
      <AbsoluteFill style={{background: theme.colors.bg, justifyContent: 'center', alignItems: 'center', padding: `${theme.safeZone.top}px ${theme.safeZone.horizontal}px ${theme.safeZone.bottom}px`}}>
        {title ? (
          <div style={{color: theme.colors.text, fontFamily: theme.fonts.display, fontWeight: 800, fontSize: 56, textAlign: 'center', marginBottom: 32, opacity: interpolate(frame, [0, 10], [0, 1], {extrapolateRight: 'clamp'})}}>
            {title}
          </div>
        ) : null}
        <div style={{display: 'flex', flexDirection: 'column', gap: 24, width: '100%'}}>
          {items.map((item, i) => {
            const delay = 6 + i * 8;
            const reveal = spring({frame: frame - delay, fps, config: {damping: 14, stiffness: 110}});
            return (
              <div
                key={i}
                style={{
                  background: theme.colors.bgAlt,
                  borderRadius: 28,
                  padding: '24px 32px',
                  display: 'flex',
                  alignItems: 'center',
                  gap: 24,
                  opacity: reveal,
                  transform: `translateX(${(1 - reveal) * -40}px)`,
                }}
              >
                <Img src={staticFile('brand/green_diamond.svg')} style={{width: 48, height: 48}} />
                <div style={{flex: 1}}>
                  <div style={{color: theme.colors.textMuted, fontFamily: theme.fonts.body, fontWeight: 600, fontSize: 24}}>{item.label}</div>
                  <div style={{color: toneColor(item.tone), fontFamily: theme.fonts.display, fontWeight: 900, fontSize: 48, lineHeight: 1}}>{item.value}</div>
                </div>
              </div>
            );
          })}
        </div>
      </AbsoluteFill>
    );
  }

  // --- large: 96px font, vertical 3-row, fills 80% of safe zone ---
  if (large) {
    return (
      <AbsoluteFill style={{background: theme.colors.bg, justifyContent: 'center', alignItems: 'center', padding: `${theme.safeZone.top}px ${theme.safeZone.horizontal}px ${theme.safeZone.bottom}px`}}>
        <div style={{display: 'flex', flexDirection: 'column', gap: 40, width: '80%'}}>
          {items.map((item, i) => {
            const delay = 8 + i * 10;
            const reveal = spring({frame: frame - delay, fps, config: {damping: 12, stiffness: 100}});
            return (
              <div
                key={i}
                style={{
                  textAlign: 'center',
                  opacity: reveal,
                  transform: `translateY(${(1 - reveal) * 80}px)`,
                }}
              >
                <div style={{color: toneColor(item.tone), fontFamily: theme.fonts.display, fontWeight: 900, fontSize: 96, lineHeight: 1}}>{item.value}</div>
                <div style={{color: theme.colors.textMuted, fontFamily: theme.fonts.body, fontWeight: 600, fontSize: 36, marginTop: 12}}>{item.label}</div>
              </div>
            );
          })}
        </div>
      </AbsoluteFill>
    );
  }

  return (
    <AbsoluteFill
      style={{
        background: theme.colors.bg,
        padding: `${theme.safeZone.top}px ${theme.safeZone.horizontal}px ${theme.safeZone.bottom}px`,
        justifyContent: 'center',
      }}
    >
      {title ? (
        <div
          style={{
            color: theme.colors.text,
            fontFamily: theme.fonts.display,
            fontWeight: 800,
            fontSize: 64,
            textAlign: 'center',
            marginBottom: 48,
            opacity: interpolate(frame, [0, 10], [0, 1], {extrapolateRight: 'clamp'}),
          }}
        >
          {title}
        </div>
      ) : null}

      <div
        style={{
          display: 'grid',
          gridTemplateColumns: items.length <= 2 ? '1fr' : '1fr 1fr',
          gap: 32,
        }}
      >
        {items.map((item, i) => {
          const delay = 6 + i * 8;
          const reveal = spring({frame: frame - delay, fps, config: {damping: 14, stiffness: 110}});
          return (
            <div
              key={i}
              style={{
                background: theme.colors.bgAlt,
                borderRadius: 32,
                padding: 40,
                textAlign: 'center',
                transform: `translateY(${(1 - reveal) * 60}px)`,
                opacity: reveal,
              }}
            >
              <div
                style={{
                  color: toneColor(item.tone),
                  fontFamily: theme.fonts.display,
                  fontWeight: 900,
                  fontSize: 128,
                  lineHeight: 1,
                }}
              >
                {item.value}
              </div>
              <div
                style={{
                  color: theme.colors.textMuted,
                  fontFamily: theme.fonts.body,
                  fontWeight: 600,
                  fontSize: 32,
                  marginTop: 16,
                }}
              >
                {item.label}
              </div>
            </div>
          );
        })}
      </div>
    </AbsoluteFill>
  );
};
