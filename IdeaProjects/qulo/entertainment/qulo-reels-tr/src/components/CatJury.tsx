import {spring, useCurrentFrame, useVideoConfig} from 'remotion';
import {theme} from '../theme';
import {SpriteFlip} from './SpriteFlip';

// Varyant K2 "Kadıköy Kedileri" — alt bantta yan yana oturan 3 kedi jürisi (bkz. CAST.md kedi
// taksonomisi). watch: idle sallanma. reject/approve: SpriteFlip ile animatik tepki (taban→bağır→
// pati→bağır ret; taban→bağır→pati onay, son karede kalır) + hafif zıplama + baloncuk (✕/❤).
type Reaction = 'watch' | 'reject' | 'approve';

type CatConfig = {base: string; x: number};

// Sıra: kedi_tekir (sol) → kedi_sarman (orta) → kedi_sb (sağ).
const CATS: readonly CatConfig[] = [
  {base: 'kedi_tekir', x: 155},
  {base: 'kedi_sarman', x: 425},
  {base: 'kedi_sb', x: 695},
];

const CAT_WIDTH = 230;
const STAGGER = 6; // her kedi bir öncekinden 6 kare gecikmeli tepki verir.
const FRAME_DURATION = 8;

type Props = {
  reaction: Reaction;
  reactFrame?: number;
  y?: number;
};

const Bubble: React.FC<{x: number; y: number; startFrame: number; glyph: string; color: string}> = ({
  x,
  y,
  startFrame,
  glyph,
  color,
}) => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();
  const local = frame - startFrame;
  if (local < 0) return null;

  const scale = spring({frame: local, fps, from: 0, to: 1, config: {damping: 10, stiffness: 200}, durationInFrames: 12});
  const opacity = Math.min(1, local / 4);

  return (
    <div
      style={{
        position: 'absolute',
        left: x - 34,
        top: y,
        width: 68,
        height: 68,
        borderRadius: '50%',
        background: color,
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        transform: `scale(${scale})`,
        opacity,
        boxShadow: '0 8px 20px rgba(0,0,0,0.4)',
      }}
    >
      <span style={{fontSize: 32, color: theme.colors.text, lineHeight: 1}}>{glyph}</span>
    </div>
  );
};

// y=1520 (spec önerisi ~1560'tan biraz yukarı çekildi — bkz. still f200 doğrulaması): kediler
// (width 230, top-left konum) 260px alt safe-zone'a (y>=1660) hâlâ biraz taşıyor ama bu yapısal —
// aday sticker'ları jüriye yer açmak için y-bottom≈1485'te durur (bkz. KadikoyScene), bu yüzden
// kediler en erken ~1490'da başlayabilir; 1520 suspect-cat çakışmasını önleyip taşmayı asgariye indirir.
export const CatJury: React.FC<Props> = ({reaction, reactFrame = 0, y = 1520}) => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();

  const bubbleColor = reaction === 'reject' ? theme.colors.danger : theme.colors.greenDark;
  const bubbleGlyph = reaction === 'reject' ? '✕' : '❤';

  return (
    <>
      {CATS.map((cat, i) => {
        const catReactFrame = reactFrame + i * STAGGER;
        const centerX = cat.x + CAT_WIDTH / 2;

        const frames =
          reaction === 'watch'
            ? [`ai/${cat.base}.png`]
            : reaction === 'reject'
              ? [
                  `ai/${cat.base}.png`,
                  `ai/${cat.base}_bagir.png`,
                  `ai/${cat.base}_pati.png`,
                  `ai/${cat.base}_bagir.png`,
                ]
              : [`ai/${cat.base}.png`, `ai/${cat.base}_bagir.png`, `ai/${cat.base}_pati.png`];

        // watch: hafif faz kaymalı sine sallanma (idle). reject/approve: reactFrame'de spring zıplama
        // (yukarı fırlayıp hafif sekerek yerine oturur — bkz. EliminationStamp'ın "büyükten küçülme"
        // idiyomuyla aynı dil, translateY'e uygulanmış hali).
        const sway = reaction === 'watch' ? Math.sin((frame + i * 10) / 24) * 3 : 0;
        const hop =
          reaction !== 'watch' && frame >= catReactFrame
            ? spring({frame: frame - catReactFrame, fps, from: -24, to: 0, config: {damping: 7, stiffness: 220}, durationInFrames: 16})
            : 0;

        return (
          <div key={cat.base}>
            <div
              style={{
                position: 'absolute',
                left: cat.x,
                top: y,
                width: CAT_WIDTH,
                height: CAT_WIDTH,
                transform: `translateY(${hop}px) rotate(${sway}deg)`,
                transformOrigin: 'center bottom',
              }}
            >
              <SpriteFlip frames={frames} x={0} y={0} width={CAT_WIDTH} frameDuration={FRAME_DURATION} startFrame={catReactFrame} />
            </div>
            {reaction !== 'watch' ? (
              <Bubble x={centerX} y={y - 86} startFrame={catReactFrame} glyph={bubbleGlyph} color={bubbleColor} />
            ) : null}
          </div>
        );
      })}
    </>
  );
};
