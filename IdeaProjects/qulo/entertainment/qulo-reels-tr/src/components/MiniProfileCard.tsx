import {theme} from '../theme';

// Deterministik sözde-rastgele (Math.random YASAK) — PaperShreds ile aynı sine-hash yöntemi, KaosRain/KaosSweep arasında paylaşılır.
export const rnd = (i: number, salt: number) => (((Math.sin(i * 127.1 + salt * 311.7) * 43758.5453) % 1) + 1) % 1;

// Konum sözleşmesi: x/y = MERKEZ (CollageSticker'ın top-anchor sözleşmesinden farklı — bu kart kendi ortasından konumlanır).
type Props = {
  x: number;
  y: number;
  width: number;
  rotate: number;
  opacity?: number;
};

// Remotion-çizimi mini profil kartı (AI görsel DEĞİL): kağıt zemin + gri avatar dairesi + 2 çizgi placeholder.
// KaosRain (yağmur) ve KaosSweep (süpürme) sahnelerinde yoğun kolaj hissi için kullanılır.
export const MiniProfileCard: React.FC<Props> = ({x, y, width, rotate, opacity = 1}) => {
  const height = width * 1.27; // ~150x190 oranı

  return (
    <div
      style={{
        position: 'absolute',
        left: x - width / 2,
        top: y - height / 2,
        width,
        height,
        background: theme.colors.paper,
        borderRadius: 14,
        opacity,
        transform: `rotate(${rotate}deg)`,
        boxShadow: '0 10px 20px rgba(0,0,0,0.35)',
        padding: width * 0.12,
        boxSizing: 'border-box',
      }}
    >
      <div
        style={{
          width: width * 0.34,
          height: width * 0.34,
          borderRadius: '50%',
          background: '#9C9690',
          margin: '0 auto',
        }}
      />
      <div
        style={{
          marginTop: width * 0.14,
          height: width * 0.09,
          borderRadius: 4,
          background: '#B7B0A6',
          width: '78%',
          marginLeft: 'auto',
          marginRight: 'auto',
        }}
      />
      <div
        style={{
          marginTop: width * 0.08,
          height: width * 0.09,
          borderRadius: 4,
          background: '#C7C1B8',
          width: '55%',
          marginLeft: 'auto',
          marginRight: 'auto',
        }}
      />
    </div>
  );
};
