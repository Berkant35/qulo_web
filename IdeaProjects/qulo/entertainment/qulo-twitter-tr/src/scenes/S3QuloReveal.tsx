import {AbsoluteFill, interpolate, spring, staticFile, useCurrentFrame, useVideoConfig, Img} from 'remotion';
import {theme} from '../theme';
import {BrainNetwork} from '../components/BrainNetwork';
import {PhoneFrame} from '../components/PhoneFrame';
import {QuizSolveMini} from '../components/QuizSolveMini';
import {StaggerText} from '../components/StaggerText';

export const S3QuloReveal: React.FC = () => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();
  const logoScale = spring({frame, fps, from: 0.5, to: 1, config: {damping: 13}, durationInFrames: 24});
  const glow = interpolate(frame, [0, 20], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const phoneIn = spring({frame: frame - 30, fps, from: 0, to: 1, config: {damping: 16}, durationInFrames: 24});

  return (
    <AbsoluteFill
      style={{
        background: `radial-gradient(circle at 30% 40%, rgba(105,240,174,0.10), ${theme.colors.bg} 60%)`,
        flexDirection: 'row',
        alignItems: 'center',
        padding: `0 ${theme.safeZone.horizontal}px`,
      }}
    >
      {/* Sol kolon */}
      <div style={{flex: 1, display: 'flex', flexDirection: 'column', gap: 28, position: 'relative'}}>
        <div style={{position: 'absolute', top: -120, left: -40, opacity: 0.6}}>
          <BrainNetwork startFrame={6} sizePx={560} />
        </div>
        <div style={{display: 'flex', alignItems: 'center', gap: 24, transform: `scale(${logoScale})`, transformOrigin: 'left center'}}>
          <Img
            src={staticFile('brand/qulo_logo.svg')}
            style={{width: 240, filter: `drop-shadow(0 0 ${20 * glow}px rgba(105,240,174,${0.6 * glow}))`}}
          />
        </div>
        <StaggerText
          lines={['Qulo geldi.', 'Kaydırma. *Çöz.*']}
          startFrame={18}
          perLineFrames={14}
          fontSize={theme.type.title}
          accentColor={theme.colors.green}
          align="left"
        />
        <div style={{marginTop: 8}}>
          <StaggerText
            lines={['Sorunu sor. Çözen eşleşir.']}
            startFrame={50}
            fontSize={theme.type.body}
            color={theme.colors.textMuted}
            align="left"
          />
        </div>
      </div>

      {/* Sağ kolon — telefon */}
      <div style={{flex: 1, display: 'flex', justifyContent: 'center', opacity: phoneIn, transform: `translateY(${(1 - phoneIn) * 40}px)`}}>
        <PhoneFrame heightPx={820}>
          <QuizSolveMini
            question="Bir ilişkide senin için en önemli şey ne?"
            options={['Dürüstlük', 'Macera', 'Sadakat', 'Mizah']}
            correctIndex={0}
            startFrame={36}
            perItemFrames={16}
          />
        </PhoneFrame>
      </div>
    </AbsoluteFill>
  );
};
