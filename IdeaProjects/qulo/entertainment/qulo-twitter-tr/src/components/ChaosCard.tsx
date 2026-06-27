import {interpolate, spring, useCurrentFrame, useVideoConfig} from 'remotion';
import {theme} from '../theme';

type Props = {
  xStart: number;
  yStart: number;
  rotateStart: number;
  driftX: number;
  driftY: number;
  driftRotate: number;
  appearFrame: number;
  label: string;
  widthPx?: number;
};

export const ChaosCard: React.FC<Props> = ({
  xStart,
  yStart,
  rotateStart,
  driftX,
  driftY,
  driftRotate,
  appearFrame,
  label,
  widthPx = 300,
}) => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();
  const local = frame - appearFrame;

  const enter = spring({frame: local, fps, config: {damping: 14, stiffness: 90}, durationInFrames: 20});
  const drift = interpolate(local, [0, 90], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});

  const x = xStart + driftX * drift;
  const y = yStart + driftY * drift;
  const rot = rotateStart + driftRotate * drift;
  const opacity = interpolate(local, [0, 8, 70, 90], [0, 1, 1, 0.25], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const xMark = interpolate(local, [10, 22], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});

  if (local < 0) return null;

  return (
    <div
      style={{
        position: 'absolute',
        left: x,
        top: y,
        width: widthPx,
        height: widthPx * 1.4,
        transform: `rotate(${rot}deg) scale(${enter})`,
        opacity,
        borderRadius: theme.radius.lg,
        background: `linear-gradient(160deg, ${theme.colors.surfaceElevated}, ${theme.colors.surface})`,
        border: `1px solid ${theme.colors.border}`,
        boxShadow: '0 30px 60px rgba(0,0,0,0.55)',
        overflow: 'hidden',
      }}
    >
      <div
        style={{
          position: 'absolute',
          bottom: 0,
          width: '100%',
          padding: '16px 18px',
          background: 'linear-gradient(transparent, rgba(0,0,0,0.6))',
          fontFamily: theme.fonts.display,
          fontWeight: 700,
          fontSize: theme.type.small,
          color: theme.colors.text,
        }}
      >
        {label}
      </div>
      <div
        style={{
          position: 'absolute',
          inset: 0,
          display: 'flex',
          justifyContent: 'center',
          alignItems: 'center',
          opacity: xMark * 0.85,
        }}
      >
        <div
          style={{
            fontSize: widthPx * 0.6,
            color: theme.colors.danger,
            fontWeight: 900,
            lineHeight: 1,
            transform: `scale(${0.6 + 0.4 * xMark})`,
          }}
        >
          ✕
        </div>
      </div>
    </div>
  );
};
