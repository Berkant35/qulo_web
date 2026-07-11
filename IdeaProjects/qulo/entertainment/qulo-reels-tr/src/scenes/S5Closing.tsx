import {AbsoluteFill, Img, spring, staticFile, useCurrentFrame, useVideoConfig} from 'remotion';
import {theme} from '../theme';
import {StaggerText} from '../components/StaggerText';
import {StoreBadges} from '../components/StoreBadges';

type Props = {
  topLine?: string;
};

export const S5Closing: React.FC<Props> = ({topLine}) => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();
  const logoScale = spring({frame, fps, from: 0.5, to: 1, config: {damping: 12, stiffness: 150}, durationInFrames: 18});

  return (
    <AbsoluteFill
      style={{
        background: theme.colors.bg,
        alignItems: 'center',
        justifyContent: 'center',
        gap: 56,
        paddingBottom: theme.safeZone.bottom,
      }}
    >
      {topLine ? (
        <StaggerText
          lines={[topLine]}
          startFrame={0}
          fontSize={theme.type.small + 6}
          color={theme.colors.textMuted}
        />
      ) : null}
      <Img
        src={staticFile('brand/qulo_logo.svg')}
        style={{width: 280, transform: `scale(${logoScale})`, filter: 'drop-shadow(0 0 60px rgba(105,240,174,0.35))'}}
      />
      <StaggerText
        lines={['Doğru soru,', '*doğru insan.*']}
        startFrame={10}
        fontSize={theme.type.title}
        accentColor={theme.colors.green}
      />
      <StoreBadges startFrame={30} />
    </AbsoluteFill>
  );
};
