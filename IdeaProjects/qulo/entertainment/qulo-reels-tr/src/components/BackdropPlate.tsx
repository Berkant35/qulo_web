import {AbsoluteFill, Img, interpolate, staticFile, useCurrentFrame} from 'remotion';

// Varyant R2 "Sorgu Odası" — tam kare (full-bleed) ortam plate'i (bkz. tools/assets.manifest.mjs BG_SUFFIX).
// Chroma key YOK: bu asset'ler zaten 9:16 tam kare fotoğraf, direkt cover ile basılır.
type Props = {
  src: string;
  zoomFrom?: number;
  zoomTo?: number;
  darken?: number;
  // Ken Burns zoom'un zoomFrom→zoomTo'ya ulaşacağı kare sayısı. Sequence içinde useCurrentFrame()
  // sahne-lokaldir ama useVideoConfig().durationInFrames HER ZAMAN composition'ın TOPLAM süresini
  // döner (900f) — sahnenin kendi süresini bilemeyiz, bu yüzden caller kendi durationFrames'ini geçer.
  durationInFrames?: number;
};

export const BackdropPlate: React.FC<Props> = ({
  src,
  zoomFrom = 1,
  zoomTo = 1.08,
  darken = 0.35,
  durationInFrames = 180,
}) => {
  const frame = useCurrentFrame();
  const scale = interpolate(frame, [0, durationInFrames], [zoomFrom, zoomTo], {
    extrapolateLeft: 'clamp',
    extrapolateRight: 'clamp',
  });

  return (
    <AbsoluteFill style={{overflow: 'hidden'}}>
      <Img
        src={staticFile(src)}
        style={{
          width: '100%',
          height: '100%',
          objectFit: 'cover',
          transform: `scale(${scale})`,
          transformOrigin: 'center center',
        }}
      />
      <AbsoluteFill style={{background: `rgba(0,0,0,${darken})`}} />
      <AbsoluteFill
        style={{background: 'radial-gradient(ellipse at center, rgba(0,0,0,0) 42%, rgba(0,0,0,0.55) 100%)'}}
      />
    </AbsoluteFill>
  );
};

type LightSwingProps = {originX?: number; amplitude?: number; opacity?: number};

// Tavandan sarkan tek ampul / sorgu spotu: x ekseninde sinüsle hafif salınan üstten radial glow.
// BackdropPlate'ten ayrı export edilir (sahneler bunu bağımsız bir katman olarak, plate'in üstünde
// ama figür/kartların altında kullanır) — bkz. görev tarifi "swinging light cone overlay".
export const LightSwing: React.FC<LightSwingProps> = ({originX = 540, amplitude = 60, opacity = 0.25}) => {
  const frame = useCurrentFrame();
  const swingX = originX + Math.sin(frame / 50) * amplitude;
  return (
    <AbsoluteFill
      style={{
        pointerEvents: 'none',
        background: `radial-gradient(ellipse 520px 1000px at ${swingX}px -100px, rgba(255,244,210,${opacity}), rgba(255,244,210,0) 60%)`,
      }}
    />
  );
};
