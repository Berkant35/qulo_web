import {AbsoluteFill, Img, staticFile, useCurrentFrame, useVideoConfig} from 'remotion';
import {theme} from '../theme';
import {BackdropPlate} from '../components/BackdropPlate';
import {CollageSticker} from '../components/CollageSticker';
import {StaggerText} from '../components/StaggerText';

// Varyant G1 "Hayalet Avı" — açılış: gece sokağında iki hayalet arka planda sessizce süzülür + w5
// (kadın, sağda) + iki beat'lik başlık (frame 4: istatistik hook; frame 62: kural özeti). Araştırma
// dayanağı: ghosting %76 (Forbes Health/Gitnux) → "5 kişiden 4'ü" (savunulabilir yuvarlama).

type GhostDriftProps = {
  src: string;
  leftPct: number;
  topPct: number;
  width: number;
  phase: number;
  swayAmp: number;
  riseSpeed: number;
};

// Arka plan hayaletleri CollageSticker DEĞİL — "yapıştırma" (slap/drift-in) değil, sürekli atmosferik
// süzülme isteniyor (bkz. görev tarifi). Düz <Img> + deterministik sinüs (yatay) + doğrusal yukarı
// sürüklenme (dikey) — Math.random YASAK, her hayalet kendi sabit phase/hız değerleriyle ayrışır.
const GhostDrift: React.FC<GhostDriftProps> = ({src, leftPct, topPct, width, phase, swayAmp, riseSpeed}) => {
  const frame = useCurrentFrame();
  const sway = Math.sin(frame / 65 + phase) * swayAmp;
  const rise = -frame * riseSpeed;
  return (
    <div
      style={{
        position: 'absolute',
        left: `${leftPct}%`,
        top: `${topPct}%`,
        width,
        transform: `translate(${sway}px, ${rise}px)`,
        opacity: 0.5,
      }}
    >
      <Img src={staticFile(src)} style={{width: '100%'}} />
    </div>
  );
};

// w5 (kadın) sağda: genişlik height'e ORANTILI (bkz. GhostScene'deki aynı yaklaşım) — 9:16'da
// W5_WIDTH_RATIO*1920=460 (diğer hook sahnelerindeki sticker ölçeğiyle aynı), 4:5'te (1350) küçülerek
// başlık metniyle çakışmayı önler.
const W5_WIDTH_RATIO = 460 / 1920;

type Props = {
  durationFrames?: number;
};

export const GhostHook: React.FC<Props> = ({durationFrames = 120}) => {
  const {height} = useVideoConfig();
  const w5Width = height * W5_WIDTH_RATIO;
  // CollageSticker sözleşmesi: top=y-width, görünür alt kenar ≈ y+0.49*width (2:3 asset). Hedef: alt
  // kenar height-270'te sabit kalsın ⇒ y + 0.49*w5Width = height-270 ⇒ y = height-270-0.49*w5Width.
  const w5Y = height - 270 - 0.49 * w5Width;

  return (
    <AbsoluteFill style={{overflow: 'hidden'}}>
      <BackdropPlate src="ai/bg_gece.png" zoomFrom={1} zoomTo={1.07} darken={0.42} durationInFrames={durationFrames} />

      <GhostDrift src="ai/hayalet_1.png" leftPct={8} topPct={30} width={190} phase={0.6} swayAmp={22} riseSpeed={0.55} />
      <GhostDrift src="ai/hayalet_2.png" leftPct={66} topPct={54} width={158} phase={3.4} swayAmp={18} riseSpeed={0.4} />

      <CollageSticker src="ai/w5.png" width={w5Width} x={760} y={w5Y} enterFrame={4} baseRotate={-2} />

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
          lines={["5 kişiden 4'ü", '*ghostlandı*.']}
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
          lines={["Qulo'da hayaletler barınamaz."]}
          startFrame={62}
          fontSize={theme.type.small + 8}
          color={theme.colors.textMuted}
        />
      </div>
    </AbsoluteFill>
  );
};
