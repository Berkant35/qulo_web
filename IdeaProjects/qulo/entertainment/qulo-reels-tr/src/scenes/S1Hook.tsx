import {AbsoluteFill} from 'remotion';
import {theme} from '../theme';
import {CollageShapes} from '../components/CollageShapes';
import {CollageSticker} from '../components/CollageSticker';
import {StaggerText} from '../components/StaggerText';

export const S1Hook: React.FC = () => {
  return (
    <AbsoluteFill style={{background: theme.colors.bg, overflow: 'hidden'}}>
      <CollageShapes variant="hook" />
      <CollageSticker src="ai/w1_hook.png" width={720} x={540} y={1280} enterFrame={4} baseRotate={-2} />
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
          lines={['Sana ulaşmak', 'bu kadar *kolay* olmamalı.']}
          startFrame={12}
          fontSize={theme.type.title}
          accentColor={theme.colors.green}
        />
      </div>
    </AbsoluteFill>
  );
};
