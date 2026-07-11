import {AbsoluteFill, useCurrentFrame} from 'remotion';
import {theme} from '../theme';
import {CollageShapes} from '../components/CollageShapes';
import {CollageSticker} from '../components/CollageSticker';
import {StaggerText} from '../components/StaggerText';
import {MiniProfileCard, rnd} from '../components/MiniProfileCard';

// Varyant B "Kaos'tan Kurala" — açılış: onlarca mini profil kartı sürekli yağıyor (Remotion-çizimi, AI DEĞİL),
// bunalmış kadın (w1_tired) ortada. Anti-infografik yoğunluk hedefi — kart sayısı/boyutu still ile doğrulanır.
const CARD_COUNT = 36;
const LOOP = 2500; // dikey döngü uzunluğu (ekran yüksekliği 1920 + giriş/çıkış tamponu)

export const KaosRain: React.FC = () => {
  const frame = useCurrentFrame();

  return (
    <AbsoluteFill style={{background: theme.colors.bg, overflow: 'hidden'}}>
      <CollageShapes variant="hook" />
      {Array.from({length: CARD_COUNT}, (_, i) => {
        const size = 110 + rnd(i, 6) * 95; // 110-205px — parallax boyutu
        const speed = 3 + ((size - 110) / 95) * 8; // büyük kart = yakın/hızlı (parallax)
        const x = rnd(i, 5) * 1180 - 60; // hafif taşarak yatay dağılım
        const phase = rnd(i, 4) * LOOP;
        const y = ((phase + frame * speed) % LOOP) - 380;
        const baseRotate = (rnd(i, 7) - 0.5) * 50;
        const tumble = frame * (rnd(i, 8) - 0.5) * 0.7;
        const depthOpacity = 0.42 + ((size - 110) / 95) * 0.5;
        return (
          <MiniProfileCard key={i} x={x} y={y} width={size} rotate={baseRotate + tumble} opacity={depthOpacity} />
        );
      })}
      <CollageSticker src="ai/w1_tired.png" width={640} x={540} y={1330} enterFrame={6} baseRotate={-1} enter="slap" />
      <div
        style={{
          position: 'absolute',
          top: theme.safeZone.top + 30,
          left: 0,
          width: '100%',
          display: 'flex',
          justifyContent: 'center',
          padding: `0 ${theme.safeZone.horizontal}px`,
        }}
      >
        <StaggerText
          lines={['Yüzlerce profil.', '*Sıfır* bağ.']}
          startFrame={10}
          fontSize={theme.type.title}
          accentColor={theme.colors.danger}
        />
      </div>
    </AbsoluteFill>
  );
};
