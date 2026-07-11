import {AbsoluteFill, interpolate, useCurrentFrame} from 'remotion';
import {theme} from '../theme';
import {CollageShapes} from '../components/CollageShapes';
import {CollageSticker} from '../components/CollageSticker';
import {MatchSpark} from '../components/MatchSpark';

type Props = {
  leftSrc?: string;
  rightSrc?: string;
};

export const S4Match: React.FC<Props> = ({leftSrc = 'ai/w1_hook.png', rightSrc = 'ai/m3.png'}) => {
  const frame = useCurrentFrame();
  // İki figür kenarlardan merkeze kayar.
  const slide = interpolate(frame, [0, 24], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const womanX = interpolate(slide, [0, 1], [40, 330]);
  const manX = interpolate(slide, [0, 1], [1040, 750]);

  return (
    <AbsoluteFill style={{background: theme.colors.bg, overflow: 'hidden'}}>
      <CollageShapes variant="match" />
      {/* width=520 -> visible bottom ≈ y + 0.49*520; 1390 => ~1645, safe-zone uyumlu (bkz. Task 5-7 dersi). */}
      <CollageSticker src={leftSrc} width={520} x={womanX} y={1390} enterFrame={0} baseRotate={-2} />
      <CollageSticker src={rightSrc} width={520} x={manX} y={1390} enterFrame={0} baseRotate={2} flip />
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
