import {AbsoluteFill, useCurrentFrame, interpolate} from 'remotion';

export type GenericSwipeStackProps = {
  count?: number;          // default 4
  ghostMode?: boolean;     // default false — when true, top card stays and shows "..." then fades
  brand?: 'neutral';       // only 'neutral' accepted — enforces brand-attack-free policy
};

// Brand-neutral pastel palette — must NOT resemble any dating app
const NEUTRAL_PALETTE = ['#E8DEF8', '#D7E4F2', '#FAE0E9', '#E6E0D4'];
const CARD_W = 540;
const CARD_H = 760;

export const GenericSwipeStack: React.FC<GenericSwipeStackProps> = ({
  count = 4,
  ghostMode = false,
}) => {
  const frame = useCurrentFrame();

  if (ghostMode) {
    // Top card stays, shows ghost ellipsis, fades out
    const ellipsisOpacity = interpolate(frame, [20, 40, 80, 100], [0, 1, 1, 0], {
      extrapolateLeft: 'clamp',
      extrapolateRight: 'clamp',
    });
    const cardOpacity = interpolate(frame, [90, 120], [1, 0.2], {
      extrapolateLeft: 'clamp',
      extrapolateRight: 'clamp',
    });
    return (
      <AbsoluteFill style={{justifyContent: 'center', alignItems: 'center'}}>
        <div
          style={{
            width: CARD_W,
            height: CARD_H,
            borderRadius: 36,
            background: NEUTRAL_PALETTE[0],
            opacity: cardOpacity,
            position: 'relative',
            overflow: 'hidden',
          }}
        >
          <div
            style={{
              position: 'absolute',
              bottom: 60,
              left: 0,
              right: 0,
              textAlign: 'center',
              fontSize: 80,
              color: '#666',
              opacity: ellipsisOpacity,
            }}
          >
            . . .
          </div>
        </div>
      </AbsoluteFill>
    );
  }

  // Normal mode: stack of cards, top one drifts off every ~30 frames
  const cycleFrame = frame % 30;
  const topDriftX = interpolate(cycleFrame, [0, 30], [0, -600], {
    extrapolateRight: 'clamp',
  });
  const topRotate = interpolate(cycleFrame, [0, 30], [0, -15]);
  const topOpacity = interpolate(cycleFrame, [0, 20, 30], [1, 1, 0]);

  return (
    <AbsoluteFill style={{justifyContent: 'center', alignItems: 'center'}}>
      {Array.from({length: count}).map((_, i) => {
        const reverseIdx = count - 1 - i;
        const isTop = reverseIdx === 0;
        const offsetY = reverseIdx * 8;
        const scale = 1 - reverseIdx * 0.02;
        return (
          <div
            key={i}
            style={{
              position: 'absolute',
              width: CARD_W,
              height: CARD_H,
              borderRadius: 36,
              background: NEUTRAL_PALETTE[reverseIdx % NEUTRAL_PALETTE.length],
              transform: isTop
                ? `translate(${topDriftX}px, ${offsetY}px) rotate(${topRotate}deg) scale(${scale})`
                : `translate(0px, ${offsetY}px) scale(${scale})`,
              opacity: isTop ? topOpacity : 1,
              boxShadow: '0 8px 28px rgba(0,0,0,0.12)',
            }}
          >
            {/* Silhouette placeholder — neutral, faceless */}
            <div
              style={{
                position: 'absolute',
                bottom: 0,
                left: 0,
                right: 0,
                height: '60%',
                background: 'linear-gradient(180deg, transparent 0%, rgba(0,0,0,0.18) 100%)',
              }}
            />
            <div
              style={{
                position: 'absolute',
                top: '32%',
                left: '50%',
                transform: 'translate(-50%, -50%)',
                width: 140,
                height: 140,
                borderRadius: '50%',
                background: 'rgba(255,255,255,0.45)',
              }}
            />
          </div>
        );
      })}
    </AbsoluteFill>
  );
};
