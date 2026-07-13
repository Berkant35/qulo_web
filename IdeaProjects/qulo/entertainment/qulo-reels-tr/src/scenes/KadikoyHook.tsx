import {AbsoluteFill} from 'remotion';
import {theme} from '../theme';
import {BackdropPlate} from '../components/BackdropPlate';
import {CollageSticker} from '../components/CollageSticker';
import {CatJury} from '../components/CatJury';
import {StaggerText} from '../components/StaggerText';

// Varyant K2 "Kadıköy Kedileri" — açılış: Kadıköy sokağı + w4 (kadın, sağda) + kedi jürisi (izlemede,
// alt bant) + iki beat'lik başlık (frame 4: ana hook; frame 62: alt satır kural özeti).
type Props = {
  durationFrames?: number;
};

export const KadikoyHook: React.FC<Props> = ({durationFrames = 120}) => {
  return (
    <AbsoluteFill style={{overflow: 'hidden'}}>
      <BackdropPlate src="ai/bg_kadikoy.png" zoomFrom={1} zoomTo={1.07} darken={0.4} durationInFrames={durationFrames} />
      {/* width=480 -> visible bottom ≈ y + 0.5*480 = 1450 (bkz. CollageSticker konum sözleşmesi), kedilerin üstünde. */}
      <CollageSticker src="ai/w4.png" width={480} x={740} y={1210} enterFrame={4} baseRotate={-2} />
      <CatJury reaction="watch" />
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
          lines={["Kadıköy'de bir kız.", 'Ve üç *tüylü* jüri.']}
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
          lines={['Sorular ondan. *Onay* kedilerden.']}
          startFrame={62}
          fontSize={theme.type.small + 8}
          color={theme.colors.textMuted}
          accentColor={theme.colors.green}
        />
      </div>
    </AbsoluteFill>
  );
};
