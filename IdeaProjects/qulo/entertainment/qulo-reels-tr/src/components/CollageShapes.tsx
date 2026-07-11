import {interpolate, useCurrentFrame} from 'remotion';
import {theme} from '../theme';

type Variant = 'hook' | 'rules' | 'elimination' | 'match';
type Props = {variant: Variant; enterFrame?: number};

const Halftone: React.FC<{x: number; y: number; size: number; color: string; opacity: number}> = ({x, y, size, color, opacity}) => {
  const n = 6;
  const gap = size / n;
  return (
    <svg style={{position: 'absolute', left: x, top: y}} width={size} height={size} opacity={opacity}>
      {Array.from({length: n * n}, (_, i) => {
        const cx = (i % n) * gap + gap / 2;
        const row = Math.floor(i / n);
        return <circle key={i} cx={cx} cy={row * gap + gap / 2} r={Math.max(2, (gap / 2.7) * (1 - row * 0.1))} fill={color} />;
      })}
    </svg>
  );
};

const Ring: React.FC<{x: number; y: number; size: number; color: string; opacity: number; strokeWidth?: number}> = ({x, y, size, color, opacity, strokeWidth = 14}) => (
  <svg style={{position: 'absolute', left: x, top: y}} width={size} height={size} opacity={opacity}>
    <circle cx={size / 2} cy={size / 2} r={size / 2 - strokeWidth} fill="none" stroke={color} strokeWidth={strokeWidth} />
  </svg>
);

const Blob: React.FC<{x: number; y: number; size: number; color: string; opacity: number}> = ({x, y, size, color, opacity}) => (
  <div style={{position: 'absolute', left: x, top: y, width: size, height: size, borderRadius: '50%', background: color, opacity}} />
);

const TornStrip: React.FC<{x: number; y: number; width: number; height: number; rotate: number; opacity: number}> = ({x, y, width, height, rotate, opacity}) => (
  <div
    style={{
      position: 'absolute',
      left: x,
      top: y,
      width,
      height,
      background: theme.colors.paper,
      opacity,
      transform: `rotate(${rotate}deg)`,
      clipPath:
        'polygon(0% 8%, 6% 0%, 15% 10%, 26% 2%, 38% 12%, 52% 3%, 63% 11%, 77% 1%, 88% 9%, 100% 4%, 100% 92%, 93% 100%, 81% 90%, 68% 99%, 55% 89%, 41% 98%, 29% 90%, 16% 99%, 7% 91%, 0% 97%)',
    }}
  />
);

export const CollageShapes: React.FC<Props> = ({variant, enterFrame = 0}) => {
  const frame = useCurrentFrame();
  const pop = (delay: number) =>
    interpolate(frame, [enterFrame + delay, enterFrame + delay + 10], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});

  if (variant === 'hook') {
    return (
      <div style={{position: 'absolute', inset: 0}}>
        <Halftone x={60} y={180} size={260} color={theme.colors.green} opacity={0.75 * pop(0)} />
        <Halftone x={780} y={1450} size={240} color={theme.colors.purple} opacity={0.7 * pop(6)} />
        <Ring x={800} y={300} size={220} color={theme.colors.purple} opacity={0.9 * pop(3)} />
        <Blob x={-90} y={1180} size={280} color={theme.colors.purple} opacity={0.55 * pop(8)} />
        <TornStrip x={120} y={880} width={840} height={560} rotate={-4} opacity={0.16 * pop(2)} />
      </div>
    );
  }
  if (variant === 'rules') {
    return (
      <div style={{position: 'absolute', inset: 0}}>
        <Halftone x={790} y={200} size={220} color={theme.colors.purple} opacity={0.7 * pop(0)} />
        <Ring x={60} y={1400} size={180} color={theme.colors.green} opacity={0.85 * pop(4)} />
        <Blob x={880} y={1050} size={200} color={theme.colors.green} opacity={0.35 * pop(6)} />
      </div>
    );
  }
  if (variant === 'elimination') {
    return (
      <div style={{position: 'absolute', inset: 0}}>
        <Halftone x={70} y={1420} size={220} color={theme.colors.green} opacity={0.6 * pop(0)} />
        <Ring x={820} y={240} size={190} color={theme.colors.danger} opacity={0.65 * pop(3)} />
        <Blob x={-70} y={300} size={220} color={theme.colors.purple} opacity={0.4 * pop(5)} />
      </div>
    );
  }
  // match
  return (
    <div style={{position: 'absolute', inset: 0}}>
      <Halftone x={70} y={220} size={240} color={theme.colors.green} opacity={0.8 * pop(0)} />
      <Halftone x={790} y={1420} size={240} color={theme.colors.green} opacity={0.8 * pop(2)} />
      <Ring x={90} y={1350} size={200} color={theme.colors.purple} opacity={0.9 * pop(4)} />
      <Ring x={800} y={330} size={170} color={theme.colors.green} opacity={0.9 * pop(6)} />
    </div>
  );
};
