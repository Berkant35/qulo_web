import {AbsoluteFill, useVideoConfig} from 'remotion';
import {theme} from '../theme';
import {BackdropPlate} from '../components/BackdropPlate';
import {CollageSticker} from '../components/CollageSticker';
import {StaggerText} from '../components/StaggerText';

// Varyant AN "Anne Onayı" — açılış: sıcak Türk salonu + anne sağda (jüri, henüz sakin) + iki beat'lik
// başlık (frame 4: ana hook; frame 62: alt satır uyarı). Yapı KadikoyHook'un birebir aynısı (bkz. o
// dosyadaki w4 yerleşimi) — sadece ortam (bg_salon) ve karakter (anne) değişti.
type Props = {
  durationFrames?: number;
};

export const AnneHook: React.FC<Props> = ({durationFrames = 120}) => {
  const {height} = useVideoConfig();
  return (
    <AbsoluteFill style={{overflow: 'hidden'}}>
      <BackdropPlate src="ai/bg_salon.png" zoomFrom={1} zoomTo={1.07} darken={0.4} durationInFrames={durationFrames} />
      {/* width=480 -> visible bottom ≈ y + 0.5*480 = 1450 (bkz. CollageSticker konum sözleşmesi), KadikoyHook'un w4 yerleşimiyle birebir aynı. 9:16'da y=1210. */}
      <CollageSticker src="ai/anne.png" width={480} x={740} y={height - 710} enterFrame={4} baseRotate={-2} />
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
          lines={['Sınavı geçtin.', 'Sıra *annede*.']}
          startFrame={4}
          fontSize={theme.type.title}
          accentColor={theme.colors.purple}
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
          lines={['Onayı kolay değil.']}
          startFrame={62}
          fontSize={theme.type.small + 8}
          color={theme.colors.textMuted}
        />
      </div>
    </AbsoluteFill>
  );
};
