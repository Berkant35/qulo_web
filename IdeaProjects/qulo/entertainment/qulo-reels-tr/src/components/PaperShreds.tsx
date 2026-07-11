import {interpolate, useCurrentFrame} from 'remotion';
import {theme} from '../theme';

type Props = {
  startFrame: number;
  count?: number;
  originX: number;
  originY: number;
  spread?: number;
};

// Deterministik sözde-rastgele (Math.random YASAK — bkz. görev tarifi).
const rnd = (i: number, salt: number) => (((Math.sin(i * 127.1 + salt * 311.7) * 43758.5453) % 1) + 1) % 1;

// Düzensiz dörtgen (kağıt parçası) clip-path'i, parça başına hafif farklı köşeler.
const shredClip = (i: number) => {
  const j = (salt: number) => 6 + rnd(i, salt) * 88;
  return `polygon(${j(1)}% ${j(2)}%, ${j(3)}% ${j(4)}%, ${j(5)}% ${j(6)}%, ${j(7)}% ${j(8)}%)`;
};

export const PaperShreds: React.FC<Props> = ({startFrame, count = 14, originX, originY, spread = 220}) => {
  const frame = useCurrentFrame();
  const t = frame - startFrame;
  if (t < 0) return null;

  return (
    <>
      {Array.from({length: count}, (_, i) => {
        const size = 16 + rnd(i, 3) * 22; // 16-38px
        const angle = rnd(i, 5) * Math.PI * 2;
        const dist = spread * (0.35 + rnd(i, 7) * 0.65);
        const delay = rnd(i, 9) * 6;
        const local = Math.max(0, t - delay);
        const burst = interpolate(local, [0, 22], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
        const drift = (rnd(i, 11) - 0.5) * 60;
        const dx = Math.cos(angle) * dist * burst + drift * burst;
        const tumbleTurns = 1.5 + rnd(i, 13) * 2.5;
        const rotate = (rnd(i, 15) > 0.5 ? 1 : -1) * tumbleTurns * 360 * Math.min(1, local / 45);
        const fall = 0.55 * local * local * 0.06 + Math.sin(angle) * dist * 0.25 * burst;
        const opacity = interpolate(local, [0, 5, 45], [0, 1, 0], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
        return (
          <div
            key={i}
            style={{
              position: 'absolute',
              left: originX + dx - size / 2,
              top: originY + fall - size / 2,
              width: size,
              height: size,
              background: theme.colors.paper,
              opacity,
              transform: `rotate(${rotate}deg)`,
              clipPath: shredClip(i),
            }}
          />
        );
      })}
    </>
  );
};
