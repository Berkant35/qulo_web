import {AbsoluteFill, interpolate, useCurrentFrame, useVideoConfig} from 'remotion';
import {theme} from '../theme';
import {CollageShapes} from '../components/CollageShapes';
import {CollageSticker} from '../components/CollageSticker';
import {MatchSpark} from '../components/MatchSpark';
import {PaperShreds} from '../components/PaperShreds';

type Props = {
  leftSrc?: string;
  rightSrc?: string;
  // Varyant E: eşleşme anında çift konfeti patlaması (varsayılan false — diğer varyantlar DEĞİŞMEZ).
  confetti?: boolean;
};

export const S4Match: React.FC<Props> = ({leftSrc = 'ai/w1_hook.png', rightSrc = 'ai/m3.png', confetti = false}) => {
  const frame = useCurrentFrame();
  const {height} = useVideoConfig();
  // İki figür kenarlardan merkeze kayar.
  const slide = interpolate(frame, [0, 24], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const womanX = interpolate(slide, [0, 1], [40, 330]);
  const manX = interpolate(slide, [0, 1], [1040, 750]);

  return (
    <AbsoluteFill style={{background: theme.colors.bg, overflow: 'hidden'}}>
      <CollageShapes variant="match" />
      {/* width=520 -> visible bottom ≈ y + 0.49*520; 9:16'da y=1390 => ~1645, safe-zone uyumlu (bkz. Task 5-7 dersi).
          4:5'te (height=1350) height-530 çiftleri alt banda otomatik toplar. */}
      <CollageSticker src={leftSrc} width={520} x={womanX} y={height - 530} enterFrame={0} baseRotate={-2} />
      <CollageSticker src={rightSrc} width={520} x={manX} y={height - 530} enterFrame={0} baseRotate={2} flip />
      {confetti ? (
        <>
          {/* MatchSpark (top:560) çevresinde iki asimetrik konfeti patlaması — spark girişiyle eşzamanlı. */}
          <PaperShreds startFrame={30} count={20} originX={380} originY={700} spread={380} />
          <PaperShreds startFrame={36} count={16} originX={700} originY={760} spread={320} />
        </>
      ) : null}
      <div
        style={{
          position: 'absolute',
          top: 560,
          left: 0,
          width: '100%',
          display: 'flex',
          justifyContent: 'center',
        }}
      >
        <MatchSpark startFrame={26} label="Eşleşme!" />
      </div>
    </AbsoluteFill>
  );
};
