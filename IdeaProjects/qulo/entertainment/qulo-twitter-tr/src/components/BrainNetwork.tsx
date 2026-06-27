import {interpolate, useCurrentFrame} from 'remotion';
import {theme} from '../theme';

type Props = {startFrame?: number; sizePx?: number};

// Basit nöron ağı: normalize (0..1) koordinatlar.
const NODES = [
  {x: 0.2, y: 0.35},
  {x: 0.4, y: 0.2},
  {x: 0.55, y: 0.45},
  {x: 0.35, y: 0.6},
  {x: 0.65, y: 0.7},
  {x: 0.78, y: 0.4},
  {x: 0.5, y: 0.78},
];
const EDGES: Array<[number, number]> = [
  [0, 1], [1, 2], [2, 3], [3, 0], [2, 5], [4, 2], [4, 6], [3, 6], [5, 4],
];

export const BrainNetwork: React.FC<Props> = ({startFrame = 0, sizePx = 620}) => {
  const frame = useCurrentFrame();
  const local = frame - startFrame;
  const S = sizePx;

  return (
    <svg width={S} height={S} viewBox="0 0 1 1" style={{overflow: 'visible'}}>
      {EDGES.map(([a, b], i) => {
        const t = i * 5; // her kenar sırayla
        const progress = interpolate(local, [t, t + 16], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
        const na = NODES[a];
        const nb = NODES[b];
        return (
          <line
            key={i}
            x1={na.x}
            y1={na.y}
            x2={interpolate(progress, [0, 1], [na.x, nb.x])}
            y2={interpolate(progress, [0, 1], [na.y, nb.y])}
            stroke={theme.colors.green}
            strokeWidth={0.006}
            strokeLinecap="round"
            opacity={0.55 * progress + 0.15}
          />
        );
      })}
      {NODES.map((n, i) => {
        const t = i * 5;
        const pop = interpolate(local, [t, t + 12], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
        const pulse = 1 + 0.15 * Math.sin((local + i * 7) / 6);
        return (
          <circle
            key={i}
            cx={n.x}
            cy={n.y}
            r={0.018 * pop * pulse}
            fill={i % 2 === 0 ? theme.colors.green : theme.colors.purple}
            opacity={pop}
            style={{filter: 'drop-shadow(0 0 6px rgba(105,240,174,0.7))'}}
          />
        );
      })}
    </svg>
  );
};
