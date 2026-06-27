import {interpolate, spring, useCurrentFrame, useVideoConfig} from 'remotion';
import {theme} from '../theme';

type Props = {startFrame?: number; label?: string};

const SPARKS = Array.from({length: 12}, (_, i) => (i * 360) / 12);

export const MatchPop: React.FC<Props> = ({startFrame = 0, label = 'Eşleşme!'}) => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();
  const local = frame - startFrame;
  if (local < 0) return null;

  const scale = spring({frame: local, fps, from: 0.3, to: 1, config: {damping: 11, stiffness: 140}, durationInFrames: 20});
  const glow = interpolate(local, [0, 16], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const sparkDist = interpolate(local, [4, 30], [0, 220], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const sparkOpacity = interpolate(local, [4, 18, 36], [0, 1, 0], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});

  return (
    <div style={{position: 'relative', display: 'flex', justifyContent: 'center', alignItems: 'center'}}>
      <div
        style={{
          position: 'absolute',
          width: 520,
          height: 520,
          borderRadius: '50%',
          background: `radial-gradient(circle, rgba(105,240,174,${0.35 * glow}), transparent 65%)`,
        }}
      />
      {SPARKS.map((deg, i) => (
        <div
          key={i}
          style={{
            position: 'absolute',
            width: 8,
            height: 26,
            borderRadius: 4,
            background: i % 2 === 0 ? theme.colors.green : theme.colors.purple,
            opacity: sparkOpacity,
            transform: `rotate(${deg}deg) translateY(-${sparkDist}px)`,
          }}
        />
      ))}
      <div
        style={{
          transform: `scale(${scale})`,
          fontFamily: theme.fonts.display,
          fontWeight: 900,
          fontSize: theme.type.hook,
          color: theme.colors.green,
          textShadow: '0 8px 40px rgba(105,240,174,0.5)',
          letterSpacing: -2,
        }}
      >
        {label}
      </div>
    </div>
  );
};
