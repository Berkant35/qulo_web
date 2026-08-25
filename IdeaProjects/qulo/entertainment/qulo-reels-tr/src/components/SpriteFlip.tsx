import {Img, staticFile, useCurrentFrame} from 'remotion';

// Varyant K2 "Kadıköy Kedileri" — durak-hareket (stop-motion) animatik oynatıcı: poz görsellerini
// ardı ardına oynatır (ör. kedi: taban → bağır → pati). Deterministik (sadece kare matematiği,
// Math.random YOK).
//
// Konum sözleşmesi (CollageSticker'dan FARKLI): x,y = width×height büyüklüğünde bir kutunun SOL-ÜST
// köşesi (top-left). Merkez/alt-çapa hesabı YOK. Varsayılan kullanım 1:1 (kare) asset'lerdir (ör.
// kediler, hayalet) — height verilmezse width'e eşitlenir, basit top-left konumlama yeterli. height
// opsiyonel override'ı 2:3 gibi kare-olmayan poz dizileri için eklendi (ör. AnneScene'in anne/anne_terlik
// jürisi) — width verilip height override edilmediğinde eski davranış birebir korunur (backward-compatible).
type Props = {
  frames: string[];
  x: number;
  y: number;
  width: number;
  height?: number;
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
  height,
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

  const boxHeight = height ?? width;

  return (
    <div style={{position: 'absolute', left: x, top: y, width, height: boxHeight}}>
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
