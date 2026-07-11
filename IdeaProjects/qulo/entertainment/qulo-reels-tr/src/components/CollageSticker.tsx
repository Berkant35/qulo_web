import {Img, interpolate, spring, staticFile, useCurrentFrame, useVideoConfig} from 'remotion';

type Props = {
  src: string;
  width: number;
  x: number;
  y: number;
  enterFrame?: number;
  baseRotate?: number;
  sway?: boolean;
  tearFrame?: number;
  flip?: boolean;
};

export const CollageSticker: React.FC<Props> = ({
  src,
  width,
  x,
  y,
  enterFrame = 0,
  baseRotate = 0,
  sway = true,
  tearFrame,
  flip = false,
}) => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();
  const local = frame - enterFrame;
  if (local < 0) return null;

  // Yapıştırma: büyükten küçülerek "şap" diye oturur.
  const scale = spring({frame: local, fps, from: 1.5, to: 1, config: {damping: 13, stiffness: 190}, durationInFrames: 14});
  const enterOpacity = interpolate(local, [0, 5], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const swayDeg = sway ? Math.sin(frame / 22) * 1.4 : 0;

  // Yırtılıp düşme.
  let fallY = 0;
  let fallRot = 0;
  let fallOpacity = 1;
  if (tearFrame !== undefined && frame >= tearFrame) {
    const t = frame - tearFrame;
    fallY = 1.9 * t * t;
    fallRot = t * 3.2;
    fallOpacity = interpolate(t, [18, 34], [1, 0], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  }

  return (
    <div
      style={{
        position: 'absolute',
        left: x - width / 2,
        top: y - width, // figürler ~2:3 → yükseklik ≈ width * 1.5; merkezleme sahnede x,y ile ayarlanır
        width,
        transform: `translateY(${fallY}px) rotate(${baseRotate + swayDeg + fallRot}deg) scale(${scale}) ${flip ? 'scaleX(-1)' : ''}`,
        opacity: enterOpacity * fallOpacity,
      }}
    >
      <Img
        src={staticFile(src)}
        style={{width: '100%', filter: 'drop-shadow(0 20px 34px rgba(0,0,0,0.5))'}}
      />
    </div>
  );
};
