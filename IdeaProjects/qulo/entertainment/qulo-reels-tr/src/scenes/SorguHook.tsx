import {AbsoluteFill, useVideoConfig} from 'remotion';
import {theme} from '../theme';
import {BackdropPlate, LightSwing} from '../components/BackdropPlate';
import {CollageSticker} from '../components/CollageSticker';
import {StaggerText} from '../components/StaggerText';

// Varyant R2 "Sorgu Odası" — açılış: sorgu odası plate'i + sorgucu duruşundaki w1_hook (sağda, flip) +
// keskin başlık. QuloReelsAd'in S1Hook'una DOKUNULMAZ; bu ayrı, plate-tabanlı bir sahne.
type Props = {
  stickerSrc?: string;
  lines?: string[];
  bgSrc?: string;
  durationFrames?: number;
};

export const SorguHook: React.FC<Props> = ({
  stickerSrc = 'ai/w1_hook.png',
  lines = ["Qulo'ya girmeden önce", 'ifadeniz *alınacak*.'],
  bgSrc = 'ai/bg_sorgu.png',
  durationFrames = 120,
}) => {
  const {height} = useVideoConfig();
  // 9:16'da (height=1920) y=1420 → önceki sabitle birebir aynı; 4:5'te (1350) sorgucu alt banda oturur.
  return (
    <AbsoluteFill style={{overflow: 'hidden'}}>
      <BackdropPlate src={bgSrc} zoomFrom={1} zoomTo={1.07} darken={0.35} durationInFrames={durationFrames} />
      <LightSwing />
      {/* width=480 -> visible bottom ≈ y + 0.49*480 (bkz. CollageSticker konum sözleşmesi). */}
      <CollageSticker src={stickerSrc} width={480} x={800} y={height - 500} enterFrame={4} baseRotate={-2} flip />
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
        <StaggerText lines={lines} startFrame={14} fontSize={theme.type.title} accentColor={theme.colors.danger} />
      </div>
    </AbsoluteFill>
  );
};
