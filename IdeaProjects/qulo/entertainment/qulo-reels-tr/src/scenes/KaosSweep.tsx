import {AbsoluteFill, interpolate, useCurrentFrame} from 'remotion';
import {theme} from '../theme';
import {CollageShapes} from '../components/CollageShapes';
import {PaperShreds, rnd} from '../components/PaperShreds';
import {QuestionCard} from '../components/QuestionCard';
import {StaggerText} from '../components/StaggerText';
import {MiniProfileCard} from '../components/MiniProfileCard';
import {SORULAR} from '../configs/questions';

// Varyant B "Kaos'tan Kurala" — süpürme: dağınık mini kartlar hızlanarak yanlara uçar, tek büyük soru kartı
// (çip YOK — kural henüz belirlenmedi) merkeze yaylanarak oturur. "Kaydırma bitti." mesajı.
const CARD_COUNT = 16;
const SWEEP_START = 4;
const SWEEP_DUR = 40;

export const KaosSweep: React.FC = () => {
  const frame = useCurrentFrame();

  return (
    <AbsoluteFill style={{background: theme.colors.bg, overflow: 'hidden'}}>
      <CollageShapes variant="rules" />
      {Array.from({length: CARD_COUNT}, (_, i) => {
        const size = 120 + rnd(i, 2) * 70;
        const startX = 300 + rnd(i, 1) * 480; // merkez etrafında dağınık başlangıç
        const startY = 500 + rnd(i, 3) * 900;
        const goLeft = rnd(i, 9) < 0.5;
        const t = interpolate(frame, [SWEEP_START, SWEEP_START + SWEEP_DUR], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
        const ease = t * t * (3 - 2 * t); // smoothstep — hızlanan süpürme hissi
        const targetX = goLeft ? -260 : 1340;
        const x = startX + (targetX - startX) * ease;
        const wobble = Math.sin((frame + i * 9) / 6) * 10 * (1 - ease);
        const y = startY + wobble - ease * 60;
        const rotate = (rnd(i, 7) - 0.5) * 40 + ease * (goLeft ? -220 : 220);
        const opacity = interpolate(t, [0, 0.75, 1], [1, 0.9, 0]);
        return <MiniProfileCard key={i} x={x} y={y} width={size} rotate={rotate} opacity={opacity} />;
      })}
      <PaperShreds startFrame={SWEEP_START} count={20} originX={540} originY={960} spread={520} />
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
        <StaggerText lines={['*Kaydırma* bitti.']} startFrame={4} fontSize={theme.type.title} accentColor={theme.colors.green} />
      </div>
      <QuestionCard text={SORULAR[0].soru} x={540} y={820} width={720} enterFrame={18} />
    </AbsoluteFill>
  );
};
