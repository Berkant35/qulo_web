import {AbsoluteFill, interpolate, useCurrentFrame, Img, staticFile, useVideoConfig} from 'remotion';
import {theme} from '../theme';

type Props = {
  tone: 'green' | 'purple';
  label?: string;
  scale?: 'micro' | 'large' | 'huge' | 'continuous' | 'finale';
  color?: 'green' | 'purple' | 'mixed' | 'flow';
  dual?: boolean;
  count?: number;
};

const SEEDS = [
  {x: 0.2, y: 0.3, delay: 0, size: 120},
  {x: 0.75, y: 0.25, delay: 4, size: 100},
  {x: 0.5, y: 0.5, delay: 2, size: 160},
  {x: 0.3, y: 0.7, delay: 6, size: 110},
  {x: 0.7, y: 0.72, delay: 8, size: 130},
  {x: 0.15, y: 0.55, delay: 10, size: 90},
  {x: 0.85, y: 0.5, delay: 12, size: 100},
];

const GREEN_SRC = staticFile('brand/green_diamond.svg');
const PURPLE_SRC = staticFile('brand/purple_diamond.svg');

function getSrc(color: Props['color'], index: number): string {
  if (color === 'purple') return PURPLE_SRC;
  if (color === 'mixed') return index % 2 === 0 ? GREEN_SRC : PURPLE_SRC;
  return GREEN_SRC; // 'green' | 'flow' | undefined → green default
}

export const DiamondBurst: React.FC<Props> = ({
  tone,
  label,
  scale: scaleProp = 'large',
  color,
  dual = false,
  count,
}) => {
  const frame = useCurrentFrame();
  const {durationInFrames} = useVideoConfig();

  // Resolve effective src for legacy `tone` prop (backwards compat) or new `color` prop
  const effectiveColor = color ?? (tone === 'purple' ? 'purple' : 'green');

  // --- micro: 1 small diamond, 30-frame pop+fade ---
  if (scaleProp === 'micro') {
    const n = count ?? 1;
    const microSeeds = Array.from({length: n}, (_, i) => ({
      x: 0.3 + (i * 0.4) / Math.max(n - 1, 1),
      y: 0.5,
    }));
    return (
      <AbsoluteFill style={{background: theme.colors.bg}}>
        {microSeeds.map((s, i) => {
          const pop = interpolate(frame, [0, 8], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
          const fade = interpolate(frame, [20, 30], [1, 0], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
          return (
            <div
              key={i}
              style={{
                position: 'absolute',
                left: `${s.x * 100}%`,
                top: `${s.y * 100}%`,
                transform: `translate(-50%, -50%) scale(${pop})`,
                opacity: fade,
              }}
            >
              <Img src={getSrc(effectiveColor, i)} style={{width: 60, height: 60}} />
            </div>
          );
        })}
      </AbsoluteFill>
    );
  }

  // --- huge: 14 diamonds, faster spread, 60 frames ---
  if (scaleProp === 'huge') {
    const n = count ?? 14;
    const seeds = Array.from({length: n}, (_, i) => ({
      x: 0.1 + (i % 7) * 0.13,
      y: 0.15 + Math.floor(i / 7) * 0.45,
      delay: i * 3,
      size: 80 + (i % 3) * 20,
    }));
    return (
      <AbsoluteFill style={{background: theme.colors.bg}}>
        {seeds.map((s, i) => {
          const local = frame - s.delay;
          const sc = interpolate(local, [0, 8], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
          const floatY = interpolate(local, [0, 60], [0, -50], {extrapolateRight: 'clamp'});
          const op = interpolate(local, [0, 4, 50, 60], [0, 1, 1, 0.5], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
          return (
            <div
              key={i}
              style={{
                position: 'absolute',
                left: `${s.x * 100}%`,
                top: `${s.y * 100}%`,
                transform: `translate(-50%, calc(-50% + ${floatY}px)) scale(${sc})`,
                opacity: op,
              }}
            >
              <Img src={getSrc(effectiveColor, i)} style={{width: s.size, height: s.size}} />
            </div>
          );
        })}
      </AbsoluteFill>
    );
  }

  // --- continuous: one diamond every 5 frames ---
  if (scaleProp === 'continuous') {
    const maxDiamonds = Math.floor(durationInFrames / 5);
    const n = count ?? maxDiamonds;
    const seeds = Array.from({length: n}, (_, i) => ({
      x: 0.1 + Math.random() * 0.8,
      y: 0.1 + Math.random() * 0.8,
      delay: i * 5,
      size: 70 + (i % 4) * 15,
    }));
    return (
      <AbsoluteFill style={{background: theme.colors.bg}}>
        {seeds.map((s, i) => {
          const local = frame - s.delay;
          if (local < 0) return null;
          const sc = interpolate(local, [0, 10], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
          const floatY = interpolate(local, [0, 40], [0, -30], {extrapolateRight: 'clamp'});
          const op = interpolate(local, [0, 5, 35, 45], [0, 1, 1, 0], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
          return (
            <div
              key={i}
              style={{
                position: 'absolute',
                left: `${s.x * 100}%`,
                top: `${s.y * 100}%`,
                transform: `translate(-50%, calc(-50% + ${floatY}px)) scale(${sc})`,
                opacity: op,
              }}
            >
              <Img src={getSrc(effectiveColor, i)} style={{width: s.size, height: s.size}} />
            </div>
          );
        })}
      </AbsoluteFill>
    );
  }

  // --- finale: 20 diamonds in spiral pattern ---
  if (scaleProp === 'finale') {
    const n = count ?? 20;
    const seeds = Array.from({length: n}, (_, i) => {
      const angle = (i / n) * 2 * Math.PI;
      const radius = 0.25 + (i / n) * 0.15;
      return {
        x: 0.5 + Math.cos(angle) * radius,
        y: 0.5 + Math.sin(angle) * radius * 0.7,
        delay: i * 2,
        size: 60 + (i % 5) * 18,
      };
    });
    return (
      <AbsoluteFill style={{background: theme.colors.bg}}>
        {seeds.map((s, i) => {
          const local = frame - s.delay;
          const sc = interpolate(local, [0, 10], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
          const floatY = interpolate(local, [0, 60], [0, -40], {extrapolateRight: 'clamp'});
          const op = interpolate(local, [0, 5, 55, 65], [0, 1, 1, 0.4], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
          return (
            <div
              key={i}
              style={{
                position: 'absolute',
                left: `${s.x * 100}%`,
                top: `${s.y * 100}%`,
                transform: `translate(-50%, calc(-50% + ${floatY}px)) scale(${sc})`,
                opacity: op,
              }}
            >
              <Img src={getSrc(effectiveColor, i)} style={{width: s.size, height: s.size}} />
            </div>
          );
        })}
      </AbsoluteFill>
    );
  }

  // --- large (default) + dual support ---
  const src = effectiveColor === 'purple' ? PURPLE_SRC : GREEN_SRC;
  const seeds = count != null ? SEEDS.slice(0, count) : SEEDS;

  // For dual mode, build two stream sets
  const streams: Array<{seeds: typeof SEEDS; srcOverride: string; offsetX: number}> = dual
    ? [
        {seeds, srcOverride: GREEN_SRC, offsetX: -160},
        {seeds, srcOverride: PURPLE_SRC, offsetX: 160},
      ]
    : [{seeds, srcOverride: src, offsetX: 0}];

  return (
    <AbsoluteFill
      style={{
        background: theme.colors.bg,
        padding: `${theme.safeZone.top}px ${theme.safeZone.horizontal}px ${theme.safeZone.bottom}px`,
      }}
    >
      {streams.flatMap(({seeds: streamSeeds, srcOverride, offsetX}, streamIdx) =>
        streamSeeds.map((seed, i) => {
          const local = frame - seed.delay;
          const sc = interpolate(local, [0, 12], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
          const floatY = interpolate(local, [0, 60], [0, -30], {extrapolateRight: 'clamp'});
          const op = interpolate(local, [0, 6, 50, 60], [0, 1, 1, 0.6], {
            extrapolateLeft: 'clamp',
            extrapolateRight: 'clamp',
          });
          return (
            <div
              key={`${streamIdx}-${i}`}
              style={{
                position: 'absolute',
                left: `${seed.x * 100}%`,
                top: `${seed.y * 100}%`,
                transform: `translate(calc(-50% + ${offsetX}px), calc(-50% + ${floatY}px)) scale(${sc})`,
                opacity: op,
              }}
            >
              <Img src={srcOverride} style={{width: seed.size, height: seed.size}} />
            </div>
          );
        })
      )}

      {label ? (
        <div
          style={{
            position: 'absolute',
            bottom: theme.safeZone.bottom + 40,
            left: theme.safeZone.horizontal,
            right: theme.safeZone.horizontal,
            textAlign: 'center',
            color: theme.colors.text,
            fontFamily: theme.fonts.display,
            fontWeight: 800,
            fontSize: 64,
            lineHeight: 1.1,
            opacity: interpolate(frame, [20, 32], [0, 1], {extrapolateRight: 'clamp'}),
          }}
        >
          {label}
        </div>
      ) : null}
    </AbsoluteFill>
  );
};
