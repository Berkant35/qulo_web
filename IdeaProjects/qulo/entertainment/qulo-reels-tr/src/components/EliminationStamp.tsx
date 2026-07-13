import {interpolate, spring, useCurrentFrame, useVideoConfig} from 'remotion';
import {theme} from '../theme';

// Varyant R2 "Sorgu Odası" — Remotion-çizimi damga: büyükten sertçe oturan spring çarpma + hafif
// geri tepme (overshoot barındıran damping). Varsayılanlar 'ELENDİ' (kırmızı, mugshot kesiti) için;
// x/y/color/fontSize/rotate override edilerek 'TEMİZ' (yeşil, İfade Tutanağı kartı üstü) için de kullanılır.
type Props = {
  frame: number;
  label?: string;
  color?: string;
  x?: number;
  y?: number;
  rotate?: number;
  fontSize?: number;
};

export const EliminationStamp: React.FC<Props> = ({
  frame: startFrame,
  label = 'ELENDİ',
  color = theme.colors.danger,
  x = 540,
  y = 960,
  rotate = -12,
  fontSize = 92,
}) => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();
  const local = frame - startFrame;
  if (local < 0) return null;

  const scale = spring({frame: local, fps, from: 2.4, to: 1, config: {damping: 9, stiffness: 260}, durationInFrames: 16});
  const opacity = interpolate(local, [0, 4], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});

  return (
    <div
      style={{
        position: 'absolute',
        left: x,
        top: y,
        transform: `translate(-50%, -50%) rotate(${rotate}deg) scale(${scale})`,
        opacity,
        border: `8px solid ${color}`,
        borderRadius: 16,
        padding: '16px 44px',
        background: 'rgba(0,0,0,0.18)',
        color,
        fontFamily: theme.fonts.display,
        fontWeight: 900,
        fontSize,
        letterSpacing: 3,
        textShadow: '0 6px 20px rgba(0,0,0,0.6)',
        whiteSpace: 'nowrap',
      }}
    >
      {label}
    </div>
  );
};
