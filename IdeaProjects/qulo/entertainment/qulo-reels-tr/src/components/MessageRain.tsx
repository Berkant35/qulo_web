import {interpolate, useCurrentFrame} from 'remotion';
import {theme} from '../theme';
import {rnd} from './PaperShreds';

type Phase = 'flood' | 'clear';

type Props = {
  startFrame: number;
  count?: number;
  phase?: Phase;
};

// Sabit metin havuzu — indekse göre deterministik döngü (bkz. konsept: boş/düşük-çaba DM'ler).
const TEXT_POOL = [
  'selam',
  'müsait misin?',
  'çok güzelsin',
  'naber',
  'tanışalım mı?',
  '🔥',
  'orada mısın?',
  'beğendim ✨',
  'msj at',
  'cevap versene',
];

const LOOP = 2400; // dikey döngü uzunluğu (ekran yüksekliği 1920 + giriş/çıkış tamponu)

// Sohbet baloncuğu: kağıt zemin + kısa koyu metin + kuyruk. Remotion-çizimi (AI DEĞİL).
const Bubble: React.FC<{
  x: number;
  y: number;
  width: number;
  rotate: number;
  opacity: number;
  text: string;
  tailLeft: boolean;
}> = ({x, y, width, rotate, opacity, text, tailLeft}) => (
  <div
    style={{
      position: 'absolute',
      left: x - width / 2,
      top: y,
      width,
      opacity,
      transform: `rotate(${rotate}deg)`,
    }}
  >
    <div
      style={{
        position: 'relative',
        background: theme.colors.paper,
        color: theme.colors.paperInk,
        borderRadius: theme.radius.lg,
        padding: '14px 20px',
        fontFamily: theme.fonts.body,
        fontWeight: 600,
        fontSize: 28,
        lineHeight: 1.15,
        textAlign: 'center',
        boxShadow: '0 10px 20px rgba(0,0,0,0.35)',
      }}
    >
      {text}
      <div
        style={{
          position: 'absolute',
          bottom: -10,
          ...(tailLeft ? {left: 28} : {right: 28}),
          width: 0,
          height: 0,
          borderLeft: '10px solid transparent',
          borderRight: '10px solid transparent',
          borderTop: `12px solid ${theme.colors.paper}`,
        }}
      />
    </div>
  </div>
);

// DM bombardımanı görselleştirmesi: 'flood' = sürekli yağan (döngülü) baloncuklar, 'clear' = dağınık
// baloncukların ~30 kare içinde yanlara uçup solması (Qulo'nun soru-kapısıyla "temizlenme" anı — şu an
// hiçbir sahnede kullanılmıyor, ama bileşen ileride kullanılabilecek şekilde tam teşekküllü).
export const MessageRain: React.FC<Props> = ({startFrame, count = 24, phase = 'flood'}) => {
  const frame = useCurrentFrame();
  const t = frame - startFrame;
  if (t < 0) return null;

  return (
    <>
      {Array.from({length: count}, (_, i) => {
        const text = TEXT_POOL[i % TEXT_POOL.length];
        const width = 180 + rnd(i, 2) * 60; // 180-240px
        const baseRotate = (rnd(i, 3) - 0.5) * 16;
        const tailLeft = rnd(i, 9) < 0.5;

        if (phase === 'flood') {
          const speed = 3 + rnd(i, 4) * 6; // 3-9px/kare — parallax hissi
          // Şeritli (stratified) yatay dağılım: her baloncuk kendi şeridinde jitter yapar — tamamen
          // bağımsız rastgelelikte olduğu gibi çoğu baloncuğun aynı bölgede kümelenip üst üste binmesini
          // (okunmaz hale gelmesini) önler.
          const LANES = 9;
          const laneWidth = 900 / LANES;
          const lane = i % LANES;
          const x = 90 + laneWidth * (lane + 0.5) + (rnd(i, 5) - 0.5) * laneWidth * 0.7;
          const startPhase = rnd(i, 6) * LOOP;
          const y = ((startPhase + t * speed) % LOOP) - 260;
          const rotate = baseRotate + Math.sin((t + i * 11) / 26) * 5;
          const fadeIn = interpolate(t, [0, 10], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
          return <Bubble key={i} x={x} y={y} width={width} rotate={rotate} opacity={0.94 * fadeIn} text={text} tailLeft={tailLeft} />;
        }

        // 'clear': dağınık sabit başlangıç (şeritli) -> kenarlara uçarak ~30 kare içinde kaybolma.
        const CLEAR_LANES = 9;
        const clearLaneWidth = 900 / CLEAR_LANES;
        const clearLane = i % CLEAR_LANES;
        const startX = 160 + clearLaneWidth * (clearLane + 0.5) + (rnd(i, 5) - 0.5) * clearLaneWidth * 0.7;
        const startY = 220 + rnd(i, 7) * 1300;
        const goLeft = rnd(i, 9) < 0.5;
        const progress = interpolate(t, [0, 30], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
        const ease = progress * (2 - progress); // ease-out
        const targetX = goLeft ? -220 : 1300;
        const x = startX + (targetX - startX) * ease;
        const rotate = baseRotate + (goLeft ? -1 : 1) * ease * 140;
        const opacity = interpolate(progress, [0, 0.6, 1], [0.94, 0.7, 0]);
        return <Bubble key={i} x={x} y={startY} width={width} rotate={rotate} opacity={opacity} text={text} tailLeft={tailLeft} />;
      })}
    </>
  );
};
