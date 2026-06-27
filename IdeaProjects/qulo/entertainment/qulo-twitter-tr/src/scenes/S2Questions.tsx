import {AbsoluteFill, interpolate, useCurrentFrame} from 'remotion';
import {theme} from '../theme';
import {StaggerText} from '../components/StaggerText';

export const S2Questions: React.FC = () => {
  const frame = useCurrentFrame();
  // İlk soru: 0–75 frame görünür sonra solar; ikinci soru: 75'ten sonra.
  const q1Opacity = interpolate(frame, [0, 10, 65, 78], [0, 1, 1, 0], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const q2Visible = frame >= 75;

  return (
    <AbsoluteFill
      style={{
        background: theme.colors.bg,
        justifyContent: 'center',
        alignItems: 'center',
        padding: `${theme.safeZone.top}px ${theme.safeZone.horizontal}px`,
      }}
    >
      <div style={{position: 'absolute', opacity: q1Opacity, width: '70%', display: 'flex', justifyContent: 'center'}}>
        <StaggerText
          lines={['Bu kısır döngüden', 'sıkılmadınız mı?']}
          startFrame={0}
          perLineFrames={14}
          fontSize={theme.type.title}
        />
      </div>
      {q2Visible ? (
        <div style={{position: 'absolute', width: '78%', display: 'flex', justifyContent: 'center'}}>
          <StaggerText
            lines={['Kriterlerinize gerçekten uyan', 'birini *nasıl* bulursunuz?']}
            startFrame={75}
            perLineFrames={14}
            fontSize={theme.type.title}
            accentColor={theme.colors.green}
          />
        </div>
      ) : null}
    </AbsoluteFill>
  );
};
