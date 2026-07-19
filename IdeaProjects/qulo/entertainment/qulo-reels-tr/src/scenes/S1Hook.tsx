import {AbsoluteFill, useVideoConfig} from 'remotion';
import {theme} from '../theme';
import {CollageShapes} from '../components/CollageShapes';
import {CollageSticker} from '../components/CollageSticker';
import {StaggerText} from '../components/StaggerText';

type Props = {
  stickerSrc?: string;
  lines?: string[];
  accentColor?: string;
};

export const S1Hook: React.FC<Props> = ({
  stickerSrc = 'ai/w1_hook.png',
  lines = ['Sana ulaşmak', 'bu kadar *kolay* olmamalı.'],
  accentColor = theme.colors.green,
}) => {
  const {height} = useVideoConfig();
  // 9:16'da (height=1920) y=1280 → önceki sabitle birebir aynı; 4:5'te (1350) sticker alt banda otomatik oturur.
  return (
    <AbsoluteFill style={{background: theme.colors.bg, overflow: 'hidden'}}>
      <CollageShapes variant="hook" />
      <CollageSticker src={stickerSrc} width={720} x={540} y={height - 640} enterFrame={4} baseRotate={-2} />
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
          lines={lines}
          startFrame={12}
          fontSize={theme.type.title}
          accentColor={accentColor}
        />
      </div>
    </AbsoluteFill>
  );
};
