import {interpolate, useCurrentFrame} from 'remotion';
import {theme} from '../theme';

type Props = {startFrame?: number};

const AppleGlyph: React.FC = () => (
  <svg width={42} height={42} viewBox="0 0 24 24" fill={theme.colors.text}>
    <path d="M16.36 12.78c.02 2.36 2.07 3.15 2.1 3.16-.02.06-.33 1.13-1.08 2.23-.65.96-1.32 1.92-2.38 1.94-1.04.02-1.38-.62-2.57-.62-1.19 0-1.56.6-2.55.64-1.02.04-1.8-1.04-2.46-2-1.35-1.96-2.38-5.54-1-7.96.69-1.2 1.92-1.96 3.26-1.98 1-.02 1.95.68 2.57.68.61 0 1.77-.84 2.98-.72.51.02 1.93.21 2.85 1.55-.07.05-1.7 1-1.68 2.98M14.4 5.4c.55-.66.92-1.58.82-2.5-.79.03-1.75.53-2.31 1.19-.51.58-.95 1.52-.83 2.41.88.07 1.78-.45 2.32-1.1"/>
  </svg>
);

const PlayGlyph: React.FC = () => (
  <svg width={38} height={38} viewBox="0 0 24 24">
    <path d="M3.6 2.4 13.2 12 3.6 21.6c-.36-.18-.6-.55-.6-1V3.4c0-.45.24-.82.6-1Z" fill="#34D399"/>
    <path d="M3.6 2.4 13.2 12l3-3L5.5 1.5C4.9 1.16 4.1 1.3 3.6 2.4Z" fill="#34A853" opacity="0.9"/>
    <path d="M3.6 21.6 13.2 12l3 3L5.5 22.5c-.6.34-1.4.2-1.9-.9Z" fill="#FBBC04"/>
    <path d="M13.2 12 16.2 9l3.9 2.1c.9.5.9 1.3 0 1.8L16.2 15l-3-3Z" fill="#EA4335"/>
  </svg>
);

const Badge: React.FC<{top: string; bottom: string; glyph: React.ReactNode}> = ({top, bottom, glyph}) => (
  <div
    style={{
      display: 'flex',
      alignItems: 'center',
      gap: 16,
      padding: '16px 28px',
      borderRadius: theme.radius.md,
      background: '#000',
      border: '1px solid #333',
      minWidth: 280,
    }}
  >
    <div style={{display: 'flex', alignItems: 'center', justifyContent: 'center', width: 44}}>{glyph}</div>
    <div style={{display: 'flex', flexDirection: 'column', fontFamily: theme.fonts.body, color: theme.colors.text}}>
      <span style={{fontSize: 18, opacity: 0.8}}>{top}</span>
      <span style={{fontSize: 30, fontWeight: 700}}>{bottom}</span>
    </div>
  </div>
);

export const StoreBadges: React.FC<Props> = ({startFrame = 0}) => {
  const frame = useCurrentFrame();
  const appear = interpolate(frame, [startFrame, startFrame + 14], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  return (
    <div style={{display: 'flex', gap: 28, opacity: appear, transform: `translateY(${(1 - appear) * 24}px)`}}>
      <Badge top="App Store'dan" bottom="İndir" glyph={<AppleGlyph />} />
      <Badge top="Google Play'den" bottom="İndir" glyph={<PlayGlyph />} />
    </div>
  );
};
