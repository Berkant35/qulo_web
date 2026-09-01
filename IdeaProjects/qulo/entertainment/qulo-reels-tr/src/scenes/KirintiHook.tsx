import {AbsoluteFill, useVideoConfig} from 'remotion';
import {theme} from '../theme';
import {BackdropPlate} from '../components/BackdropPlate';
import {CollageSticker} from '../components/CollageSticker';
import {StaggerText} from '../components/StaggerText';

// Varyant B1 "Kırıntı" — açılış: bekleme kafesinde kadın (w7) telefona bakıp oyalanıyor + iki beat'lik
// başlık (frame 4: hook; frame 62: kural özeti). Araştırma dayanağı: breadcrumbing ~%35 (The Daily
// Star/MDPI) — duygusal olarak aç bırakıp ilgiyi canlı tutma, adım atmadan kırıntı bırakma.

// w7 (kadın) sağ-merkez: genişlik height'e ORANTILI (bkz. GhostHook/TanimHook'taki aynı yaklaşım) —
// 9:16'da W7_WIDTH_RATIO*1920=460 (diğer hook sahnelerindeki sticker ölçeğiyle aynı), 4:5'te (1350)
// küçülerek başlık metniyle çakışmayı önler.
const W7_WIDTH_RATIO = 460 / 1920;

type Props = {
  durationFrames?: number;
};

export const KirintiHook: React.FC<Props> = ({durationFrames = 120}) => {
  const {height} = useVideoConfig();
  const w7Width = height * W7_WIDTH_RATIO;
  // CollageSticker sözleşmesi: top=y-width, görünür alt kenar ≈ y+0.49*width (2:3 asset). Hedef: alt
  // kenar height-270'te sabit kalsın ⇒ y + 0.49*w7Width = height-270 ⇒ y = height-270-0.49*w7Width.
  const w7Y = height - 270 - 0.49 * w7Width;

  return (
    <AbsoluteFill style={{overflow: 'hidden'}}>
      <BackdropPlate src="ai/bg_bekleme.png" zoomFrom={1} zoomTo={1.07} darken={0.4} durationInFrames={durationFrames} />

      <CollageSticker src="ai/w7.png" width={w7Width} x={760} y={w7Y} enterFrame={4} baseRotate={-2} />

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
        <StaggerText
          lines={['Seni oyalıyor,', 'adım *atmıyor*.']}
          startFrame={4}
          fontSize={theme.type.title}
          accentColor={theme.colors.danger}
        />
      </div>

      <div
        style={{
          position: 'absolute',
          top: 460,
          left: 0,
          width: '100%',
          display: 'flex',
          justifyContent: 'center',
          padding: `0 ${theme.safeZone.horizontal}px`,
        }}
      >
        <StaggerText
          lines={['Kırıntıyla doyulmaz.']}
          startFrame={62}
          fontSize={theme.type.small + 8}
          color={theme.colors.textMuted}
        />
      </div>
    </AbsoluteFill>
  );
};
