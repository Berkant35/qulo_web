import {AbsoluteFill, interpolate, useCurrentFrame} from 'remotion';
import {theme} from '../theme';
import {CollageShapes} from '../components/CollageShapes';
import {CollageSticker} from '../components/CollageSticker';
import {StaggerText} from '../components/StaggerText';
import {rnd} from '../components/PaperShreds';

// Varyant H "Kalabalık Yalnızlığı" — açılış: dolu bir parti, herkes telefonda, kimse birbirine bakmıyor.
// Disko topu tavandan sarkıyormuş gibi yavaşça sallanır (asılı ip hissi için ayrı bir dönen wrapper —
// CollageSticker'ın kendi sway'i sadece ±1.4deg mikro titreşim verir, bu ek ±4deg genlikli yavaş salınım).
const DOT_COUNT = 14;

// Sahne üstünde donuk yanıp sönen parti ışıkları — deterministik (Math.random YASAK, rnd() kullanılır).
const LightDot: React.FC<{i: number; frame: number}> = ({i, frame}) => {
  const x = 60 + rnd(i, 21) * 960;
  const y = 190 + rnd(i, 23) * 560;
  const size = 5 + rnd(i, 25) * 6;
  const color = i % 2 === 0 ? theme.colors.green : theme.colors.purple;
  const phase = rnd(i, 27) * Math.PI * 2;
  const pulse = 0.25 + 0.35 * (0.5 + 0.5 * Math.sin(frame / 18 + phase));
  return (
    <div
      style={{
        position: 'absolute',
        left: x,
        top: y,
        width: size,
        height: size,
        borderRadius: '50%',
        background: color,
        opacity: pulse,
        boxShadow: `0 0 ${size * 2}px ${color}`,
      }}
    />
  );
};

export const PartyCrowd: React.FC = () => {
  const frame = useCurrentFrame();

  // Disko topu: 1:1 asset -> top = y - width, bottom = y (bkz. CollageSticker konum sözleşmesi).
  // Spec taslağı y~430 idi ama safeZone.top+40'ta oturan başlıkla (yaklaşık 180-336 bandı) çakışıyordu
  // (bounding box: top=190/bottom=430); topu y=580'e indirdim (top=360, başlığın altından ~24px boşlukla),
  // yine de safeZone.top(140)'ın çok altında kaldığı için üstten kırpılma yok (bkz. görev tarifi deviation notu).
  const diskoWidth = 220;
  const diskoX = 540;
  const diskoY = 580;
  const diskoTop = diskoY - diskoWidth;
  const swingDeg = Math.sin(frame / 40) * 4;

  return (
    <AbsoluteFill style={{background: theme.colors.bg, overflow: 'hidden'}}>
      <CollageShapes variant="hook" />

      {Array.from({length: DOT_COUNT}, (_, i) => (
        <LightDot key={i} i={i} frame={frame} />
      ))}

      {/* Tavandan sarkan disko topu — wrapper tüm tuvali kaplar, dönüş ekseni topun asılı olduğu noktada. */}
      <div
        style={{
          position: 'absolute',
          inset: 0,
          transform: `rotate(${swingDeg}deg)`,
          transformOrigin: `${diskoX}px ${diskoTop}px`,
        }}
      >
        <CollageSticker src="ai/prop_disko.png" width={diskoWidth} x={diskoX} y={diskoY} enterFrame={0} baseRotate={0} sway />
      </div>

      {/* 3:4 kalabalık kesitleri alt yarıda üst üste biner, ikisi de telefonlarına bakıyor. */}
      <CollageSticker src="ai/h_crowd1.png" width={560} x={300} y={1290} enterFrame={6} enter="drift" />
      <CollageSticker src="ai/h_crowd2.png" width={560} x={800} y={1330} enterFrame={14} enter="drift" baseRotate={2} flip />

      <div
        style={{
          position: 'absolute',
          top: theme.safeZone.top + 40,
          left: 0,
          width: '100%',
          display: 'flex',
          justifyContent: 'center',
          padding: `0 ${theme.safeZone.horizontal}px`,
          opacity: interpolate(frame, [16, 24], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'}),
        }}
      >
        <StaggerText
          lines={['Kalabalık bir oda.', '*Sıfır* tanışma.']}
          startFrame={20}
          fontSize={theme.type.title}
          accentColor={theme.colors.danger}
        />
      </div>
    </AbsoluteFill>
  );
};
