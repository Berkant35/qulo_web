import {Img, staticFile, useCurrentFrame} from 'remotion';

// Varyant K2 "Kadıköy Kedileri" — durak-hareket (stop-motion) animatik oynatıcı: poz görsellerini
// ardı ardına oynatır (ör. kedi: taban → bağır → pati). Deterministik (sadece kare matematiği,
// Math.random YOK).
//
// Konum sözleşmesi (CollageSticker'dan FARKLI): x,y = width büyüklüğünde bir karenin SOL-ÜST köşesi
// (top-left). Merkez/alt-çapa hesabı YOK çünkü SpriteFlip sadece 1:1 (kare) asset'lerle kullanılır
// (ör. kediler) — height her zaman width'e eşittir, bu yüzden basit top-left konumlama yeterli.
type Props = {
  frames: string[];
  x: number;
  y: number;
  width: number;
  frameDuration?: number;
  startFrame?: number;
  loop?: boolean;
  flip?: boolean;
};

export const SpriteFlip: React.FC<Props> = ({
  frames,
  x,
  y,
  width,
  frameDuration = 8,
  startFrame = 0,
  loop = false,
  flip = false,
}) => {
  const frame = useCurrentFrame();
  const local = frame - startFrame;

  // startFrame'den önce frames[0] (taban poz); sonrasında her frameDuration karede bir sıradaki poz.
  // loop=false ise son poz üstünde kalır (hold), loop=true ise baştan sarar.
  let index = 0;
  if (local >= 0) {
    const step = Math.floor(local / frameDuration);
    index = loop ? step % frames.length : Math.min(step, frames.length - 1);
  }

  return (
    <div style={{position: 'absolute', left: x, top: y, width, height: width}}>
      <Img
        src={staticFile(frames[index])}
        style={{
          width: '100%',
          height: '100%',
          transform: flip ? 'scaleX(-1)' : undefined,
          filter: 'drop-shadow(0 20px 34px rgba(0,0,0,0.5))',
        }}
      />
    </div>
  );
};
