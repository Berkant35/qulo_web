import {Img, interpolate, spring, staticFile, useCurrentFrame, useVideoConfig} from 'remotion';

// Konum sözleşmesi: x = yatay merkez; y = dikey çapa (top = y - width). 2:3 asset'lerde görsel merkez y'nin ~0.25*width altındadır; sahneler koordinatları still doğrulamasıyla ayarlar.
type EnterStyle = 'slap' | 'drift';

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
  enter?: EnterStyle;
};

// src'e göre deterministik açı (0-359) — 'drift' girişinde rastgele hissi verir, Math.random YOK.
const driftAngleDeg = (src: string) => {
  let h = 0;
  for (let i = 0; i < src.length; i++) h = (h * 31 + src.charCodeAt(i)) % 360;
  return h;
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
  enter = 'slap',
}) => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();
  const local = frame - enterFrame;
  if (local < 0) return null;

  // Yapıştırma: büyükten küçülerek "şap" diye oturur.
  const slapScale = spring({frame: local, fps, from: 1.5, to: 1, config: {damping: 13, stiffness: 190}, durationInFrames: 14});
  const slapOpacity = interpolate(local, [0, 5], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const swayDeg = sway ? Math.sin(frame / 22) * 1.4 : 0;

  // Süzülerek giriş: açılı bir yönden kayar, hafif dönerek yerine oturur (~18 kare).
  const driftProgress = interpolate(local, [0, 18], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const driftEase = 1 - Math.pow(1 - driftProgress, 3);
  const driftAngle = (driftAngleDeg(src) * Math.PI) / 180;
  const driftDist = 170;
  const driftX = Math.cos(driftAngle) * driftDist * (1 - driftEase);
  const driftYOffset = Math.sin(driftAngle) * driftDist * (1 - driftEase);
  const driftRotExtra = (1 - driftEase) * (driftAngleDeg(src) % 2 === 0 ? 16 : -16);
  const driftOpacity = interpolate(local, [0, 10], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});

  const scale = enter === 'drift' ? 1 : slapScale;
  const enterOpacity = enter === 'drift' ? driftOpacity : slapOpacity;
  const enterOffsetX = enter === 'drift' ? driftX : 0;
  const enterOffsetY = enter === 'drift' ? driftYOffset : 0;
  const enterRotExtra = enter === 'drift' ? driftRotExtra : 0;

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
        top: y - width, // bkz. konum sözleşmesi
        width,
        transform: `translate(${enterOffsetX}px, ${enterOffsetY + fallY}px) rotate(${baseRotate + swayDeg + fallRot + enterRotExtra}deg) scale(${scale}) ${flip ? 'scaleX(-1)' : ''}`,
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
