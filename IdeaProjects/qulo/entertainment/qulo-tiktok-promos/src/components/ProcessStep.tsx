import {AbsoluteFill, interpolate, spring, useCurrentFrame, useVideoConfig} from 'remotion';
import {theme} from '../theme';

type Props = {
  step?: number;
  text?: string;
  subText?: string;
  compact?: boolean;
  labelAbove?: boolean;
  steps?: string[]; // multi-step variant: renders all steps in a row
};

const MultiStep: React.FC<{steps: string[]; compact: boolean; labelAbove: boolean}> = ({steps, compact, labelAbove}) => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();
  const iconSize = compact ? 90 : 140;
  const iconFontSize = compact ? 44 : 72;
  const labelFontSize = compact ? 22 : 32;

  return (
    <AbsoluteFill
      style={{
        background: theme.colors.bg,
        padding: `${theme.safeZone.top}px ${theme.safeZone.horizontal}px ${theme.safeZone.bottom}px`,
        justifyContent: 'center',
        alignItems: 'center',
      }}
    >
      <div style={{display: 'flex', flexDirection: 'row', gap: compact ? 24 : 40, alignItems: 'center', justifyContent: 'center', flexWrap: 'wrap'}}>
        {steps.map((label, i) => {
          const delay = 5 + i * 8;
          const scale = spring({frame: frame - delay, fps, config: {damping: 12, stiffness: 130}});
          const labelOpacity = interpolate(frame, [delay + 5, delay + 15], [0, 1], {extrapolateRight: 'clamp'});
          return (
            <div key={i} style={{display: 'flex', flexDirection: labelAbove ? 'column-reverse' : 'column', alignItems: 'center', gap: 12}}>
              <div
                style={{
                  width: iconSize,
                  height: iconSize,
                  borderRadius: iconSize / 2,
                  background: `linear-gradient(135deg, ${theme.colors.green} 0%, ${theme.colors.purple} 100%)`,
                  display: 'flex',
                  justifyContent: 'center',
                  alignItems: 'center',
                  color: theme.colors.bg,
                  fontFamily: theme.fonts.display,
                  fontWeight: 900,
                  fontSize: iconFontSize,
                  transform: `scale(${scale})`,
                  boxShadow: '0 12px 30px rgba(31,203,126,0.30)',
                }}
              >
                {i + 1}
              </div>
              <div
                style={{
                  color: theme.colors.text,
                  fontFamily: theme.fonts.display,
                  fontWeight: 700,
                  fontSize: labelFontSize,
                  textAlign: 'center',
                  opacity: labelOpacity,
                  maxWidth: 180,
                  lineHeight: 1.15,
                }}
              >
                {label}
              </div>
            </div>
          );
        })}
      </div>
    </AbsoluteFill>
  );
};

export const ProcessStep: React.FC<Props> = ({step, text, subText, compact = false, labelAbove = false, steps}) => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();

  if (steps && steps.length > 0) {
    return <MultiStep steps={steps} compact={compact} labelAbove={labelAbove} />;
  }
  if (step === undefined || text === undefined) {
    return null;
  }

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
