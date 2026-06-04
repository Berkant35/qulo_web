import {AbsoluteFill, interpolate, spring, staticFile, useCurrentFrame, useVideoConfig} from 'remotion';
import {theme} from '../theme';

type Props = {
  text: string;
  accentText?: string;
  logoReveal?: boolean;
};

export const HookScene: React.FC<Props> = ({text, accentText, logoReveal = false}) => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();

  if (logoReveal) {
    const scale = spring({frame, fps, from: 0.4, to: 1.0, config: {damping: 12}});
    return (
      <AbsoluteFill style={{justifyContent: 'center', alignItems: 'center', background: theme.colors.bg}}>
        <img
          src={staticFile('brand/qulo_logo.svg')}
          style={{width: 600, transform: `scale(${scale})`}}
        />
      </AbsoluteFill>
    );
  }

  const scale = spring({frame, fps, config: {damping: 12, stiffness: 120}});
  const opacity = interpolate(frame, [0, 8], [0, 1], {extrapolateRight: 'clamp'});

  return (
    <AbsoluteFill
      style={{
        background: `radial-gradient(circle at 50% 40%, ${theme.colors.bgAlt} 0%, ${theme.colors.bg} 70%)`,
        justifyContent: 'center',
        alignItems: 'center',
        padding: `${theme.safeZone.top}px ${theme.safeZone.horizontal}px ${theme.safeZone.bottom}px`,
      }}
    >
      <div
        style={{
          transform: `scale(${scale})`,
          opacity,
          textAlign: 'center',
          fontFamily: theme.fonts.display,
          fontWeight: theme.caption.weight,
          fontSize: theme.caption.sizeHook,
          color: theme.colors.text,
          lineHeight: 1.05,
          letterSpacing: -2,
          textShadow: '0 8px 32px rgba(0,0,0,0.55)',
        }}
      >
        {text}
        {accentText ? (
          <>
            <br />
            <span style={{color: theme.colors.green}}>{accentText}</span>
          </>
        ) : null}
      </div>
    </AbsoluteFill>
  );
};
