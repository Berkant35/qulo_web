import {AbsoluteFill, useVideoConfig} from 'remotion';
import {theme} from '../theme';
import {BackdropPlate} from '../components/BackdropPlate';
import {CollageSticker} from '../components/CollageSticker';
import {StaggerText} from '../components/StaggerText';

// Varyant S1 "Biz Neyiz?" — açılış: loş kokteyl barında w6 (sabrı tükenmiş, kolları kavuşuk şık) sağda
// + iki beat'lik başlık (frame 4: situationship istatistik hook; frame 62: soru). Araştırma dayanağı:
// Gen Z'nin üçte biri situationship yaşamış (IJIAP; bkz. plan: 2026-07-12-qulo-reels-tr-variant-s1.md).
// YAPISAL OLARAK GhostHook (G1) ile birebir aynı iskelet — w5→w6, bg_gece→bg_kafe; arka plan atmosfer
// katmanı (G1'deki GhostDrift) burada YOK çünkü S1'in asset setinde bir karşılığı yok (bkz. plan asset
// tablosu: sadece bg_kafe/w6/m_kacamak/m_fit/m3).

// w6 sağda: genişlik height'e ORANTILI (GhostHook'un w5 yaklaşımıyla birebir aynı) — 9:16'da
// W6_WIDTH_RATIO*1920=460 (diğer hook sahnelerindeki sticker ölçeğiyle aynı), 4:5'te küçülerek başlık
// metniyle çakışmayı önler.
const W6_WIDTH_RATIO = 460 / 1920;

type Props = {
  durationFrames?: number;
};

export const TanimHook: React.FC<Props> = ({durationFrames = 120}) => {
  const {height} = useVideoConfig();
  const w6Width = height * W6_WIDTH_RATIO;
  // CollageSticker sözleşmesi: top=y-width, görünür alt kenar ≈ y+0.49*width (2:3 asset). Hedef: alt
  // kenar height-270'te sabit kalsın ⇒ y + 0.49*w6Width = height-270 ⇒ y = height-270-0.49*w6Width.
  const w6Y = height - 270 - 0.49 * w6Width;

  return (
    <AbsoluteFill style={{overflow: 'hidden'}}>
      <BackdropPlate src="ai/bg_kafe.png" zoomFrom={1} zoomTo={1.07} darken={0.4} durationInFrames={durationFrames} />

      <CollageSticker src="ai/w6.png" width={w6Width} x={760} y={w6Y} enterFrame={4} baseRotate={-2} />

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
          lines={['Üçte biri', 'adını *koyamıyor*.']}
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
          lines={['Sen koyacak mısın?']}
          startFrame={62}
          fontSize={theme.type.small + 8}
          color={theme.colors.textMuted}
        />
      </div>
    </AbsoluteFill>
  );
};
