import {interpolate, spring, useCurrentFrame, useVideoConfig} from 'remotion';
import {theme} from '../theme';
import type {SorguSoru} from '../configs/questions';

// Varyant R2 "Sorgu Odası" — 4 şıklı ifade kartı. QuestionCard'a DOKUNULMAZ; bu ayrı, kendi kağıt-kart
// dilini (radius 14, shadow, padding) paylaşan yeni bir bileşen. İç zamanlama enterFrame'e göre sabit:
// soru typewriter enterFrame+2 → enterFrame+22, şıklar enterFrame+28'den başlayıp 6f arayla pop eder
// (InterrogationScene enterFrame=6 verdiğinde bu tam olarak plan'ın 8-28 typewriter / 34-40-46-52 pop
// zamanlamasını üretir).
const LETTERS = ['A', 'B', 'C', 'D'] as const;

type Props = {
  soru: string;
  siklar: SorguSoru['siklar'];
  secimIndex: SorguSoru['secimIndex'];
  dogruIndex: SorguSoru['dogruIndex'];
  x: number;
  y: number;
  width?: number;
  enterFrame?: number;
  pickFrame: number;
  verdictFrame: number;
};

export const OptionsCard: React.FC<Props> = ({
  soru,
  siklar,
  secimIndex,
  dogruIndex,
  x,
  y,
  width = 840,
  enterFrame = 0,
  pickFrame,
  verdictFrame,
}) => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();
  const local = frame - enterFrame;
  if (local < 0) return null;

  const enter = spring({frame: local, fps, from: 0, to: 1, config: {damping: 13, stiffness: 160}, durationInFrames: 14});
  const chars = Math.round(interpolate(local, [2, 22], [0, soru.length], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'}));
  const correct = secimIndex === dogruIndex;
  const verdictReached = frame >= verdictFrame;
  const chipStart = enterFrame + 28;

  // Kart shake: yanlış seçimde verdict anında sönümlü ±6px sallanma (QuestionCard ile aynı dil).
  const shakeT = frame - verdictFrame;
  const shakeX = !correct && frame >= verdictFrame ? Math.sin(shakeT * 3.2) * 6 * Math.max(0, 1 - shakeT / 8) : 0;

  return (
    <div
      style={{
        position: 'absolute',
        left: x - width / 2,
        top: y,
        width,
        padding: '30px 38px',
        background: theme.colors.paper,
        color: theme.colors.paperInk,
        borderRadius: 14,
        fontFamily: theme.fonts.body,
        boxShadow: '0 16px 30px rgba(0,0,0,0.45)',
        transform: `translateX(${shakeX}px) scale(${enter})`,
        opacity: enter,
      }}
    >
      <div style={{fontWeight: 600, fontSize: theme.type.body, lineHeight: 1.25, minHeight: theme.type.body * 1.25 * 2}}>
        {soru.slice(0, chars)}
      </div>
      <div style={{display: 'flex', flexDirection: 'column', gap: 14, marginTop: 22}}>
        {siklar.map((sik, i) => {
          const popFrame = chipStart + i * 6;
          const popLocal = frame - popFrame;
          if (popLocal < 0) return null;

          const popScale = spring({frame: popLocal, fps, from: 0.4, to: 1, config: {damping: 12, stiffness: 200}, durationInFrames: 12});
          const popOpacity = interpolate(popLocal, [0, 8], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});

          const isPicked = i === secimIndex;
          const emphasized = isPicked && frame >= pickFrame;
          const pickScale = emphasized
            ? spring({frame: frame - pickFrame, fps, from: 1, to: 1.06, config: {damping: 14, stiffness: 180}, durationInFrames: 10})
            : 1;

          let bg = 'rgba(23,23,23,0.05)';
          let borderColor = 'rgba(23,23,23,0.18)';
          // theme `as const` olduğundan paperInk burada dar bir literal tipe (\"#171717\") çıkarım
          // yapılırdı; sonradan greenDark/danger atanabilsin diye açıkça string'e genişletiliyor.
          let textColor: string = theme.colors.paperInk;
          let borderWidth = emphasized ? 3 : 2;
          let opacity = popOpacity;

          if (isPicked && verdictReached) {
            borderWidth = 3;
            if (correct) {
              bg = 'rgba(76,175,80,0.2)';
              borderColor = theme.colors.greenDark;
              textColor = theme.colors.greenDark;
            } else {
              bg = 'rgba(207,102,121,0.25)';
              borderColor = theme.colors.danger;
              textColor = theme.colors.danger;
            }
          } else if (!isPicked && verdictReached) {
            opacity = popOpacity * 0.4;
          }

          return (
            <div
              key={sik}
              style={{
                display: 'flex',
                alignItems: 'center',
                gap: 14,
                padding: '14px 20px',
                borderRadius: theme.radius.md,
                border: `${borderWidth}px solid ${borderColor}`,
                background: bg,
                color: textColor,
                fontSize: theme.type.small + 6,
                fontWeight: 700,
                opacity,
                transform: `scale(${popScale * pickScale})`,
                transformOrigin: 'center left',
              }}
            >
              <span style={{opacity: 0.55}}>{LETTERS[i]})</span>
              <span>{sik}</span>
            </div>
          );
        })}
      </div>
    </div>
  );
};
