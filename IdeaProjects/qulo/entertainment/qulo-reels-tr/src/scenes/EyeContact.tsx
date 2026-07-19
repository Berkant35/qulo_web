import {AbsoluteFill, interpolate, useCurrentFrame, useVideoConfig} from 'remotion';
import {theme} from '../theme';
import {CollageShapes} from '../components/CollageShapes';
import {CollageSticker} from '../components/CollageSticker';
import {StaggerText} from '../components/StaggerText';

// Varyant H "Kalabalık Yalnızlığı" — kalabalık soluklaşır, iki kişi birbirini fark eder.
// 11 noktalı bir çizgi bakışlarını birbirine bağlar, tek tek belirir (frame 24-46 arası).
const DOT_COUNT = 11;
const DOT_START = 24;
const DOT_END = 46;
const ARC_X0 = 360;
const ARC_X1 = 760;
// Bakış yayı iki figürün (look_w/look_m) yüz hizasında durmalı; figürler height-göreli olduğu için
// yay da height-göreli — 9:16'da (height=1920) base=900/peak=830 önceki sabitlerle birebir aynı, 4:5'te
// (1350) figürlerle birlikte yukarı toplanır.
const ConnectionDots: React.FC<{frame: number; height: number}> = ({frame, height}) => {
  const arcBaseY = height - 1020;
  const arcPeakY = height - 1090;
  return (
  <>
    {Array.from({length: DOT_COUNT}, (_, i) => {
      const t = i / (DOT_COUNT - 1);
      const x = ARC_X0 + (ARC_X1 - ARC_X0) * t;
      const y = arcBaseY - Math.sin(t * Math.PI) * (arcBaseY - arcPeakY);
      const appearAt = DOT_START + t * (DOT_END - DOT_START);
      const scale = interpolate(frame, [appearAt, appearAt + 8], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
      const opacity = interpolate(frame, [appearAt, appearAt + 6], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
      return (
        <div
          key={i}
          style={{
            position: 'absolute',
            left: x - 5,
            top: y - 5,
            width: 10,
            height: 10,
            borderRadius: '50%',
            background: theme.colors.paper,
            opacity,
            transform: `scale(${scale})`,
            boxShadow: '0 4px 10px rgba(0,0,0,0.4)',
          }}
        />
      );
    })}
  </>
  );
};

export const EyeContact: React.FC = () => {
  const frame = useCurrentFrame();
  const {height} = useVideoConfig();
  // 9:16'da (height=1920) kalabalık/figürler y=1290/1330 → önceki sabitlerle birebir aynı; 4:5'te (1350) alt banda oturur.

  return (
    <AbsoluteFill style={{background: theme.colors.bg, overflow: 'hidden'}}>
      <CollageShapes variant="match" />

      {/* Kalabalık soluklaşmış halde arka planda kalır — giriş animasyonu yok, sabit soluk katman. */}
      <div style={{position: 'absolute', inset: 0, opacity: 0.22}}>
        <CollageSticker src="ai/h_crowd1.png" width={560} x={300} y={height - 630} enterFrame={0} sway={false} />
        <CollageSticker src="ai/h_crowd2.png" width={560} x={800} y={height - 590} enterFrame={0} sway={false} baseRotate={2} flip />
      </div>

      <ConnectionDots frame={frame} height={height} />

      {/* h_look_w/h_look_m: 2:3 asset -> bottom ≈ y + 0.49*width. 9:16'da width=500,y=1330 -> bottom≈1575 (≤1660 safe). */}
      <CollageSticker src="ai/h_look_w.png" width={500} x={270} y={height - 590} enterFrame={4} baseRotate={-1} />
      <CollageSticker src="ai/h_look_m.png" width={500} x={810} y={height - 590} enterFrame={10} baseRotate={1} flip />

      <div
        style={{
          position: 'absolute',
          top: theme.safeZone.top + 40,
          left: 0,
          width: '100%',
          display: 'flex',
          justifyContent: 'center',
          padding: `0 ${theme.safeZone.horizontal}px`,
          opacity: interpolate(frame, [0, 10], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'}),
        }}
      >
        <StaggerText
          lines={['Bir bakış *yetmez*.']}
          startFrame={4}
          fontSize={theme.type.title}
          accentColor={theme.colors.purple}
        />
      </div>
    </AbsoluteFill>
  );
};
