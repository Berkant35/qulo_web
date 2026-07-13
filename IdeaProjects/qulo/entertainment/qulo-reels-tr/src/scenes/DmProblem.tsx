import {AbsoluteFill} from 'remotion';
import {theme} from '../theme';
import {CollageShapes} from '../components/CollageShapes';
import {CollageSticker} from '../components/CollageSticker';
import {MessageRain} from '../components/MessageRain';
import {StaggerText} from '../components/StaggerText';

// Varyant P "İlgi Bombardımanı" — problem: DM yağmuru sürüyor, kadın (w1_tired) bunalmış görünüyor.
export const DmProblem: React.FC = () => {
  return (
    <AbsoluteFill style={{background: theme.colors.bg, overflow: 'hidden'}}>
      <CollageShapes variant="hook" />
      <MessageRain startFrame={0} count={22} phase="flood" />
      <CollageSticker src="ai/w1_tired.png" width={600} x={540} y={1330} enterFrame={0} baseRotate={-1} enter="slap" />
      <div
        style={{
          position: 'absolute',
          top: theme.safeZone.top + 40,
          left: 0,
          width: '100%',
          display: 'flex',
          justifyContent: 'center',
          padding: `0 ${theme.safeZone.horizontal}px`,
        }}
      >
        <StaggerText
          lines={['Görünür olmak,', 'bir *yük* mü olmalı?']}
          startFrame={12}
          fontSize={theme.type.title}
          accentColor={theme.colors.purple}
        />
      </div>
    </AbsoluteFill>
  );
};
