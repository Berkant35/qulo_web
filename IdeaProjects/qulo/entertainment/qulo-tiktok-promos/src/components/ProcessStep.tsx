import {AbsoluteFill, interpolate, spring, useCurrentFrame, useVideoConfig} from 'remotion';
import {theme} from '../theme';

type Props = {
  step: number;
  text: string;
  subText?: string;
  compact?: boolean;
  labelAbove?: boolean;
};

export const ProcessStep: React.FC<Props> = ({step, text, subText, compact = false, labelAbove = false}) => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();

  const numberScale = spring({frame, fps, config: {damping: 10, stiffness: 130}});
  const textOpacity = interpolate(frame, [10, 22], [0, 1], {extrapolateRight: 'clamp'});

  // --- compact: smaller spacing, all steps visible at once ---
  const iconSize = compact ? 100 : 240;
  const iconFontSize = compact ? 56 : 140;
  const iconRadius = iconSize / 2;
  const textFontSize = compact ? 40 : 72;
  const subFontSize = compact ? 24 : 36;
  const marginTop = compact ? 20 : 56;
  const subMarginTop = compact ? 12 : 24;

  const labelElement = (
    <>
      <div
        style={{
          marginTop: labelAbove ? 0 : marginTop,
          marginBottom: labelAbove ? marginTop : 0,
          color: theme.colors.text,
          fontFamily: theme.fonts.display,
          fontWeight: 800,
          fontSize: textFontSize,
          textAlign: 'center',
          opacity: textOpacity,
          lineHeight: 1.1,
          maxWidth: 880,
        }}
      >
        {text}
      </div>

      {subText ? (
        <div
          style={{
            marginTop: subMarginTop,
            color: theme.colors.textMuted,
            fontFamily: theme.fonts.body,
            fontWeight: 500,
            fontSize: subFontSize,
            textAlign: 'center',
            opacity: textOpacity,
            maxWidth: 800,
          }}
        >
          {subText}
        </div>
      ) : null}
    </>
  );

  const iconElement = (
    <div
      style={{
        width: iconSize,
        height: iconSize,
        borderRadius: iconRadius,
        background: `linear-gradient(135deg, ${theme.colors.green} 0%, ${theme.colors.purple} 100%)`,
        display: 'flex',
        justifyContent: 'center',
        alignItems: 'center',
        color: theme.colors.bg,
        fontFamily: theme.fonts.display,
        fontWeight: 900,
        fontSize: iconFontSize,
        transform: `scale(${numberScale})`,
        boxShadow: '0 24px 60px rgba(31,203,126,0.35)',
        flexShrink: 0,
      }}
    >
      {step}
    </div>
  );

  return (
    <AbsoluteFill
      style={{
        background: theme.colors.bg,
        padding: `${theme.safeZone.top}px ${theme.safeZone.horizontal}px ${theme.safeZone.bottom}px`,
        justifyContent: 'center',
        alignItems: 'center',
      }}
    >
      {labelAbove ? labelElement : null}
      {iconElement}
      {labelAbove ? null : labelElement}
    </AbsoluteFill>
  );
};
