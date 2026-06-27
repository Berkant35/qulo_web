import {AbsoluteFill, interpolate, spring, staticFile, useCurrentFrame, useVideoConfig, Img} from 'remotion';
import {theme} from '../theme';
import {StoreBadges} from '../components/StoreBadges';

export const S6Closing: React.FC = () => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();
  const logoScale = spring({frame, fps, from: 0.6, to: 1, config: {damping: 13}, durationInFrames: 20});
  const motto = interpolate(frame, [20, 34], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});

  return (
    <AbsoluteFill
      style={{
        background: `radial-gradient(circle at 50% 45%, rgba(105,240,174,0.08), ${theme.colors.bg} 65%)`,
        justifyContent: 'center',
        alignItems: 'center',
        gap: 40,
      }}
    >
      <Img
        src={staticFile('brand/qulo_logo.svg')}
        style={{width: 360, transform: `scale(${logoScale})`, filter: 'drop-shadow(0 0 30px rgba(105,240,174,0.4))'}}
      />
      <div
        style={{
          opacity: motto,
          transform: `translateY(${(1 - motto) * 18}px)`,
          fontFamily: theme.fonts.display,
          fontWeight: theme.type.weight,
          fontSize: theme.type.title,
          color: theme.colors.text,
          letterSpacing: -1.5,
        }}
      >
        Doğru soru, doğru insan.
      </div>
      <StoreBadges startFrame={40} />
    </AbsoluteFill>
  );
};
