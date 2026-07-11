import {interpolate, useCurrentFrame} from 'remotion';

// Konum sözleşmesi: x = yatay merkez; y = üst çapa (bkz. QuestionCard) — kart benzeri çocuk bileşenler bu sarmalayıcıya konur.
type Props = {
  width: number;
  x: number;
  y: number;
  tearFrame: number;
  children: React.ReactNode;
};

// Ortak diş diş (zigzag) dikiş hattı: sol/sağ parça bu hattı paylaşır (bkz. görev tarifi: 52,46,55,48,53...).
const SEAM_LEFT =
  'polygon(0% 0%, 52% 0%, 46% 12%, 55% 24%, 48% 36%, 53% 48%, 46% 60%, 54% 72%, 47% 84%, 52% 100%, 0% 100%)';
const SEAM_RIGHT =
  'polygon(52% 0%, 100% 0%, 100% 100%, 52% 100%, 47% 84%, 54% 72%, 46% 60%, 53% 48%, 48% 36%, 55% 24%, 46% 12%)';

export const TearSplit: React.FC<Props> = ({width, x, y, tearFrame, children}) => {
  const frame = useCurrentFrame();
  const torn = frame >= tearFrame;

  if (!torn) {
    return (
      <div style={{position: 'absolute', left: x - width / 2, top: y, width}}>
        {children}
      </div>
    );
  }

  const t = frame - tearFrame;
  const fade = interpolate(t, [20, 40], [1, 0], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const fall = 1.5 * t * t;
  const drift = interpolate(t, [0, 30], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});

  // Sol parça: -8..-18deg, sola+aşağı; sağ parça: +8..+18deg, sağa+aşağı.
  const leftRot = -8 - 10 * drift;
  const rightRot = 8 + 10 * drift;
  const leftX = -50 * drift;
  const rightX = 50 * drift;

  return (
    <div style={{position: 'absolute', left: x - width / 2, top: y, width}}>
      <div
        style={{
          position: 'absolute',
          inset: 0,
          clipPath: SEAM_LEFT,
          transformOrigin: '52% 45%',
          transform: `translate(${leftX}px, ${fall}px) rotate(${leftRot}deg)`,
          opacity: fade,
        }}
      >
        {children}
      </div>
      <div
        style={{
          position: 'absolute',
          inset: 0,
          clipPath: SEAM_RIGHT,
          transformOrigin: '48% 45%',
          transform: `translate(${rightX}px, ${fall}px) rotate(${rightRot}deg)`,
          opacity: fade,
        }}
      >
        {children}
      </div>
    </div>
  );
};
