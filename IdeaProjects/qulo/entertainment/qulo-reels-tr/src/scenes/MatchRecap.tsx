import {AbsoluteFill, useVideoConfig} from 'remotion';
import {theme} from '../theme';
import {CollageShapes} from '../components/CollageShapes';
import {CollageSticker} from '../components/CollageSticker';
import {MatchSpark} from '../components/MatchSpark';
import {StaggerText} from '../components/StaggerText';

type Props = {
  leftSrc?: string;
  rightSrc?: string;
};

// Varyant C hook — video 1'in eşleşme anını kısaca hatırlatır, ardından "peki ya sonrası?" sorusunu açar.
export const MatchRecap: React.FC<Props> = ({leftSrc = 'ai/w1_hook.png', rightSrc = 'ai/m3.png'}) => {
  const {height} = useVideoConfig();
  // 9:16'da (height=1920) y=1400 → önceki sabitle birebir aynı; 4:5'te (1350) çiftler alt banda otomatik oturur.
  return (
    <AbsoluteFill style={{background: theme.colors.bg, overflow: 'hidden'}}>
      <CollageShapes variant="match" />
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
        <StaggerText lines={['Peki ya *sonrası*?']} startFrame={40} fontSize={theme.type.title} accentColor={theme.colors.green} />
      </div>
      <div style={{position: 'absolute', top: 520, left: 0, width: '100%', display: 'flex', justifyContent: 'center'}}>
        <MatchSpark startFrame={18} label="Eşleşme!" />
      </div>
      {/* width=420 -> görünür alt ≈ y + 0.34*420 ≈ 1543, safe-zone uyumlu. */}
      <CollageSticker src={leftSrc} width={420} x={300} y={height - 520} enterFrame={4} baseRotate={-2} />
      <CollageSticker src={rightSrc} width={420} x={780} y={height - 520} enterFrame={8} baseRotate={2} flip />
    </AbsoluteFill>
  );
};
