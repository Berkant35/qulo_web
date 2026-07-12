import {AbsoluteFill, interpolate, useCurrentFrame} from 'remotion';
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
const ARC_BASE_Y = 900;
const ARC_PEAK_Y = 830;

const ConnectionDots: React.FC<{frame: number}> = ({frame}) => (
  <>
    {Array.from({length: DOT_COUNT}, (_, i) => {
      const t = i / (DOT_COUNT - 1);
      const x = ARC_X0 + (ARC_X1 - ARC_X0) * t;
      const y = ARC_BASE_Y - Math.sin(t * Math.PI) * (ARC_BASE_Y - ARC_PEAK_Y);
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

export const EyeContact: React.FC = () => {
  const frame = useCurrentFrame();

  return (
    <AbsoluteFill style={{background: theme.colors.bg, overflow: 'hidden'}}>
      <CollageShapes variant="match" />

      {/* Kalabalık soluklaşmış halde arka planda kalır — giriş animasyonu yok, sabit soluk katman. */}
      <div style={{position: 'absolute', inset: 0, opacity: 0.22}}>
        <CollageSticker src="ai/h_crowd1.png" width={560} x={300} y={1290} enterFrame={0} sway={false} />
        <CollageSticker src="ai/h_crowd2.png" width={560} x={800} y={1330} enterFrame={0} sway={false} baseRotate={2} flip />
      </div>

      <ConnectionDots frame={frame} />

      {/* h_look_w/h_look_m: 2:3 asset -> bottom ≈ y + 0.49*width. width=500,y=1330 -> bottom≈1575 (≤1660 safe). */}
      <CollageSticker src="ai/h_look_w.png" width={500} x={270} y={1330} enterFrame={4} baseRotate={-1} />
      <CollageSticker src="ai/h_look_m.png" width={500} x={810} y={1330} enterFrame={10} baseRotate={1} flip />

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
