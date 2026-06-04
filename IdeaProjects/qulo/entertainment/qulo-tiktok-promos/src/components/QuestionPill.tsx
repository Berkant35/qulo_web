import {AbsoluteFill, interpolate, spring, useCurrentFrame, useVideoConfig} from 'remotion';
import {theme} from '../theme';

type Props = {
  question?: string;
  answer?: string;
  showCorrect?: boolean;
  label?: string;
  accent?: boolean;
  urgent?: boolean;
};

export const QuestionPill: React.FC<Props> = ({question, answer, showCorrect = false, label, accent = false, urgent = false}) => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();

  const pillScale = spring({frame, fps, config: {damping: 11, stiffness: 130}});
  const answerOpacity = interpolate(frame, [20, 32], [0, 1], {extrapolateRight: 'clamp'});
  const correctScale = spring({frame: frame - 45, fps, config: {damping: 9, stiffness: 140}});

  // label-only mode (no question)
  if (label && !question) {
    const urgentPulse = urgent ? 1 + 0.05 * Math.sin(frame / 3) : 1;
    const labelBg = accent ? '#F5C518' : urgent ? theme.colors.danger : theme.colors.bgAlt;
    const labelColor = accent ? '#000' : theme.colors.text;
    return (
      <AbsoluteFill
        style={{
          background: theme.colors.bg,
          justifyContent: 'center',
          alignItems: 'center',
        }}
      >
        <div
          style={{
            background: labelBg,
            borderRadius: 48,
            padding: '24px 48px',
            color: labelColor,
            fontFamily: theme.fonts.display,
            fontWeight: 700,
            fontSize: 48,
            textAlign: 'center',
            transform: `scale(${pillScale * urgentPulse})`,
            boxShadow: accent
              ? '0 16px 40px rgba(245,197,24,0.4)'
              : urgent
              ? `0 16px 40px ${theme.colors.danger}66`
              : `0 16px 40px rgba(123,92,250,0.2)`,
          }}
        >
          {label}
        </div>
      </AbsoluteFill>
    );
  }

  return (
    <AbsoluteFill
      style={{
        background: theme.colors.bg,
        padding: `${theme.safeZone.top}px ${theme.safeZone.horizontal}px ${theme.safeZone.bottom}px`,
        justifyContent: 'center',
        alignItems: 'center',
      }}
    >
      <div
        style={{
          background: theme.colors.bgAlt,
          borderRadius: 48,
          padding: '48px 64px',
          color: theme.colors.text,
          fontFamily: theme.fonts.display,
          fontWeight: 700,
          fontSize: 56,
          textAlign: 'center',
          maxWidth: 880,
          transform: `scale(${pillScale})`,
          boxShadow: `0 24px 48px rgba(123,92,250,0.25)`,
          border: `2px solid ${theme.colors.purple}`,
        }}
      >
        {question}
      </div>

      {answer ? (
        <div
          style={{
            marginTop: 48,
            background: `linear-gradient(135deg, ${theme.colors.green}22 0%, ${theme.colors.green}11 100%)`,
            border: `2px solid ${theme.colors.green}`,
            borderRadius: 32,
            padding: '32px 48px',
            color: theme.colors.text,
            fontFamily: theme.fonts.body,
            fontWeight: 600,
            fontSize: 44,
            opacity: answerOpacity,
          }}
        >
          {answer}
        </div>
      ) : null}

      {showCorrect ? (
        <div
          style={{
            position: 'absolute',
            bottom: theme.safeZone.bottom + 80,
            transform: `scale(${correctScale})`,
            color: theme.colors.green,
            fontFamily: theme.fonts.display,
            fontWeight: 900,
            fontSize: 96,
            letterSpacing: -2,
            textShadow: `0 0 40px ${theme.colors.green}66`,
          }}
        >
          ✓ MATCH
        </div>
      ) : null}
    </AbsoluteFill>
  );
};
