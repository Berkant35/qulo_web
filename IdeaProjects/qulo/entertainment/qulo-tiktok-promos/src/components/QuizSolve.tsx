import {interpolate, spring, useCurrentFrame, useVideoConfig} from 'remotion';
import {theme} from '../theme';
import {PhoneFrame} from './PhoneFrame';

type Props = {
  questionIndex?: number;
  questionTotal?: number;
  question?: string;
  options?: string[];
  correctIndex?: number;
  selectedIndex?: number;
  remainingSec?: number;
  totalSec?: number;
  showTimer?: boolean;
};

const DEFAULT_OPTIONS = ['Pineapple', 'Olives', 'Anchovies', 'Mushrooms'];

export const QuizSolve: React.FC<Props> = ({
  questionIndex = 1,
  questionTotal = 3,
  question = "What's your most controversial food take?",
  options = DEFAULT_OPTIONS,
  correctIndex = 0,
  selectedIndex,
  remainingSec = 28,
  totalSec = 45,
  showTimer = false,
}) => {
  const frame = useCurrentFrame();
  const {fps, durationInFrames} = useVideoConfig();

  // Animated timer: drains 100%→0% over scene duration, green→yellow→red
  const animatedTimerProgress = showTimer
    ? Math.max(0, 1 - frame / durationInFrames)
    : null;
  const animatedTimerColor = animatedTimerProgress != null
    ? animatedTimerProgress > 0.6
      ? theme.colors.secondary
      : animatedTimerProgress > 0.3
      ? theme.colors.warning
      : theme.colors.danger
    : null;

  // Reveal staggered options
  const optionReveal = (i: number) =>
    spring({frame: frame - 8 - i * 4, fps, config: {damping: 14, stiffness: 110}});

  // Timer progress
  const timerProgress = remainingSec / totalSec;
  const timerColor =
    remainingSec > 10
      ? theme.colors.secondary
      : remainingSec > 5
      ? theme.colors.warning
      : theme.colors.danger;

  return (
    <PhoneFrame appLabel="Qulo · Quiz">
      {/* Animated countdown bar (showTimer=true) */}
      {showTimer && animatedTimerProgress != null && animatedTimerColor != null ? (
        <div
          style={{
            position: 'absolute',
            top: 0,
            left: 0,
            right: 0,
            height: 6,
            background: theme.colors.surfaceInput,
            zIndex: 10,
          }}
        >
          <div
            style={{
              height: '100%',
              width: `${animatedTimerProgress * 100}%`,
              background: animatedTimerColor,
              transition: 'none',
            }}
          />
        </div>
      ) : null}
      <div
        style={{
          position: 'absolute',
          inset: 0,
          padding: 24,
          paddingTop: showTimer ? 30 : 24,
          background: theme.colors.bg,
          color: theme.colors.text,
          fontFamily: theme.fonts.body,
        }}
      >
        <div
          style={{
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'space-between',
            marginBottom: 20,
          }}
        >
          <span style={{fontSize: 28, fontWeight: 700, color: theme.colors.primary}}>
            {questionIndex} / {questionTotal}
          </span>
          <span style={{fontSize: 26, fontWeight: 700}}>×</span>
        </div>

        <div style={{marginBottom: 24}}>
          <div
            style={{
              height: 6,
              borderRadius: 3,
              background: theme.colors.surfaceInput,
              overflow: 'hidden',
            }}
          >
            <div
              style={{
                height: '100%',
                width: `${timerProgress * 100}%`,
                background: timerColor,
                transition: 'none',
              }}
            />
          </div>
          <div
            style={{
              marginTop: 8,
              fontSize: 20,
              fontWeight: 600,
              color: timerColor,
              textAlign: 'right',
            }}
          >
            ⏱ {remainingSec}s
          </div>
        </div>

        <div
          style={{
            background: theme.colors.surface,
            borderRadius: theme.radius.lg,
            padding: 28,
            fontSize: 30,
            fontWeight: 700,
            lineHeight: 1.35,
            textAlign: 'center',
            marginBottom: 28,
          }}
        >
          {question}
        </div>

        <div style={{display: 'flex', flexDirection: 'column', gap: 14}}>
          {options.map((opt, i) => {
            const reveal = optionReveal(i);
            const isSelected = selectedIndex === i;
            // Auto-reveal correct at 70% of duration when no selectedIndex provided
            const autoRevealCorrect = selectedIndex === undefined && frame >= durationInFrames * 0.7;
            const isCorrectShown = (selectedIndex !== undefined && i === correctIndex) || (autoRevealCorrect && i === correctIndex);
            const isWrongSelected = isSelected && selectedIndex !== correctIndex;
            const borderColor = isCorrectShown
              ? theme.colors.secondary
              : isWrongSelected
              ? theme.colors.danger
              : isSelected
              ? theme.colors.primary
              : theme.colors.border;
            const bg = isCorrectShown
              ? `${theme.colors.secondary}22`
              : isWrongSelected
              ? `${theme.colors.danger}22`
              : isSelected
              ? `${theme.colors.primary}22`
              : theme.colors.surface;
            return (
              <div
                key={opt}
                style={{
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'space-between',
                  background: bg,
                  border: `2px solid ${borderColor}`,
                  borderRadius: theme.radius.md,
                  padding: '18px 22px',
                  fontSize: 24,
                  fontWeight: 600,
                  opacity: reveal,
                  transform: `translateY(${(1 - reveal) * 30}px)`,
                }}
              >
                <span>
                  <span style={{color: theme.colors.textMuted, marginRight: 12}}>
                    {String.fromCharCode(65 + i)}.
                  </span>
                  {opt}
                </span>
                {isCorrectShown ? (
                  <span style={{color: theme.colors.secondary, fontSize: 28}}>✓</span>
                ) : isWrongSelected ? (
                  <span style={{color: theme.colors.danger, fontSize: 28}}>✕</span>
                ) : null}
              </div>
            );
          })}
        </div>

        <div
          style={{
            position: 'absolute',
            bottom: 24,
            left: 24,
            right: 24,
            display: 'flex',
            justifyContent: 'space-evenly',
          }}
        >
          {[
            {icon: '🎯', color: theme.colors.primary, count: 2},
            {icon: '✂️', color: theme.colors.secondary, count: 1},
            {icon: '💡', color: theme.colors.warning, count: 3},
            {icon: '⏱', color: theme.colors.info, count: 1},
            {icon: '⏭', color: '#E91E63', count: 1},
          ].map((p, i) => (
            <div
              key={i}
              style={{
                width: 56,
                height: 56,
                borderRadius: 28,
                background: `${p.color}22`,
                border: `1.5px solid ${p.color}88`,
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                fontSize: 26,
                position: 'relative',
              }}
            >
              {p.icon}
              <div
                style={{
                  position: 'absolute',
                  top: -4,
                  right: -4,
                  background: p.color,
                  color: '#000',
                  fontSize: 14,
                  fontWeight: 700,
                  padding: '2px 7px',
                  borderRadius: 10,
                  minWidth: 20,
                  textAlign: 'center',
                }}
              >
                {p.count}
              </div>
            </div>
          ))}
        </div>
      </div>
    </PhoneFrame>
  );
};
