import {AbsoluteFill, interpolate, spring, useCurrentFrame, useVideoConfig} from 'remotion';
import {theme} from '../theme';
import {BackdropPlate, LightSwing} from '../components/BackdropPlate';
import {StaggerText} from '../components/StaggerText';

// Varyant R2 "Sorgu Odası" — kurallar: aynı plate devam eder + ortada kısa "İFADE TUTANAĞI" kağıt
// kartı (Remotion çizimi, sahte dosya no YAZILMAZ — bkz. plan notu) + keskin başlık.
type Props = {
  lines?: string[];
  bgSrc?: string;
  durationFrames?: number;
};

export const SorguKurallar: React.FC<Props> = ({
  lines = ['3 soru. 4 şık.', 'Yalan *yok*.'],
  bgSrc = 'ai/bg_sorgu.png',
  durationFrames = 90,
}) => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();
  const cardScale = spring({frame: frame - 6, fps, from: 0.6, to: 1, config: {damping: 13, stiffness: 170}, durationInFrames: 16});
  const cardOpacity = interpolate(frame, [6, 18], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});

  return (
    <AbsoluteFill style={{overflow: 'hidden'}}>
      <BackdropPlate src={bgSrc} zoomFrom={1.04} zoomTo={1} darken={0.4} durationInFrames={durationFrames} />
      <LightSwing />
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
        <StaggerText lines={lines} startFrame={26} fontSize={theme.type.title} accentColor={theme.colors.danger} />
      </div>
      <div
        style={{
          position: 'absolute',
          top: 840,
          left: '50%',
          transform: `translateX(-50%) scale(${cardScale})`,
          opacity: cardOpacity,
          background: theme.colors.paper,
          color: theme.colors.paperInk,
          borderRadius: 14,
          padding: '34px 56px',
          boxShadow: '0 16px 30px rgba(0,0,0,0.45)',
          textAlign: 'center',
          fontFamily: theme.fonts.display,
        }}
      >
        <div style={{fontWeight: 800, fontSize: theme.type.body, letterSpacing: 1}}>İFADE TUTANAĞI</div>
        <div style={{margin: '14px auto 0', width: 90, height: 4, background: theme.colors.danger, borderRadius: 2}} />
      </div>
    </AbsoluteFill>
  );
};
