import {interpolate, useCurrentFrame, useVideoConfig} from 'remotion';
import {theme} from '../theme';
import {PhoneFrame} from './PhoneFrame';

type Props = {
  question?: string;
  category?: string;
  steps?: string[];
  typewriter?: boolean;
  aiSuggested?: boolean;
};

export const QuestionCreate: React.FC<Props> = ({
  question = "What's your most controversial food take?",
  category = 'Lifestyle',
  steps,
  typewriter = false,
  aiSuggested = false,
}) => {
  const frame = useCurrentFrame();
  const {durationInFrames} = useVideoConfig();

  // Typing animation: 1 char per 2 frames after 12-frame delay
  const charsRevealed = Math.max(0, Math.floor((frame - 12) / 2));
  const visibleText = question.slice(0, charsRevealed);
  const cursorVisible = frame % 30 < 15;

  const saveOpacity = interpolate(frame, [question.length * 2 + 18, question.length * 2 + 36], [0, 1], {
    extrapolateLeft: 'clamp',
    extrapolateRight: 'clamp',
  });

  // --- steps mode: render up to 3 questions typed sequentially ---
  if (steps && steps.length > 0) {
    const visibleSteps = steps.slice(0, 3);
    const stepDuration = durationInFrames / visibleSteps.length;

    return (
      <PhoneFrame appLabel="Qulo · New Question">
        <div
          style={{
            position: 'absolute',
            inset: 0,
            padding: 24,
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
            <span style={{fontSize: 28, fontWeight: 700}}>← New Question</span>
            {aiSuggested ? (
              <div
                style={{
                  background: `linear-gradient(135deg, ${theme.colors.purple} 0%, ${theme.colors.primary} 100%)`,
                  borderRadius: 20,
                  padding: '6px 16px',
                  fontSize: 20,
                  fontWeight: 700,
                  color: '#fff',
                }}
              >
                ✨ AI
              </div>
            ) : null}
          </div>

          <div style={{display: 'flex', flexDirection: 'column', gap: 20}}>
            {visibleSteps.map((q, stepIdx) => {
              const stepStart = stepIdx * stepDuration;
              const localFrame = frame - stepStart;
              if (localFrame < 0) return null;
              const speedMult = aiSuggested ? 1.5 : 1;
              const chars = typewriter
                ? Math.min(q.length, Math.floor((localFrame * speedMult) / 2))
                : q.length;
              const displayText = q.slice(0, chars);
              const cursor = typewriter && localFrame % 30 < 15 && chars < q.length;
              const stepOpacity = interpolate(localFrame, [0, 8], [0, 1], {extrapolateRight: 'clamp'});
              return (
                <div
                  key={stepIdx}
                  style={{
                    background: theme.colors.surface,
                    border: `1.5px solid ${theme.colors.primary}`,
                    borderRadius: theme.radius.lg,
                    padding: 20,
                    fontSize: 26,
                    fontWeight: 600,
                    lineHeight: 1.35,
                    color: theme.colors.text,
                    opacity: stepOpacity,
                    boxShadow: `0 0 24px ${theme.colors.primary}22`,
                    minHeight: 80,
                  }}
                >
                  {displayText}
                  {cursor ? (
                    <span
                      style={{
                        display: 'inline-block',
                        width: 3,
                        height: 28,
                        background: theme.colors.primary,
                        verticalAlign: 'middle',
                        marginLeft: 3,
                      }}
                    />
                  ) : null}
                </div>
              );
            })}
          </div>
        </div>
      </PhoneFrame>
    );
  }

  return (
    <PhoneFrame appLabel="Qulo · New Question">
      <div
        style={{
          position: 'absolute',
          inset: 0,
          padding: 24,
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
            marginBottom: 28,
          }}
        >
          <span style={{fontSize: 28, fontWeight: 700}}>← New Question</span>
          <span style={{fontSize: 22, color: theme.colors.textMuted}}>1 / 10</span>
        </div>

        <div
          style={{
            display: 'flex',
            gap: 8,
            flexWrap: 'wrap',
            marginBottom: 24,
          }}
        >
          {['Lifestyle', 'Values', 'Humor', 'Travel'].map((c) => {
            const active = c === category;
            return (
              <div
                key={c}
                style={{
                  padding: '10px 20px',
                  borderRadius: theme.radius.pill,
                  background: active ? `${theme.colors.primary}22` : theme.colors.surface,
                  border: active ? `1.5px solid ${theme.colors.primary}` : '1.5px solid transparent',
                  color: active ? theme.colors.primary : theme.colors.textMuted,
                  fontSize: 20,
                  fontWeight: 600,
                }}
              >
                {c}
              </div>
            );
          })}
        </div>

        <div style={{fontSize: 22, color: theme.colors.textMuted, marginBottom: 12, fontWeight: 600}}>
          Your question
        </div>

        <div
          style={{
            background: theme.colors.surface,
            border: `1.5px solid ${theme.colors.primary}`,
            borderRadius: theme.radius.lg,
            padding: 24,
            minHeight: 200,
            fontSize: 32,
            fontWeight: 600,
            lineHeight: 1.35,
            color: theme.colors.text,
            boxShadow: `0 0 32px ${theme.colors.primary}33`,
          }}
        >
          {visibleText}
          {cursorVisible ? (
            <span
              style={{
                display: 'inline-block',
                width: 4,
                height: 36,
                background: theme.colors.primary,
                verticalAlign: 'middle',
                marginLeft: 4,
              }}
            />
          ) : null}
        </div>

        <div style={{marginTop: 32, fontSize: 22, color: theme.colors.textMuted, fontWeight: 600}}>
          Correct answer
        </div>
        <div
          style={{
            marginTop: 12,
            background: theme.colors.surface,
            borderRadius: theme.radius.lg,
            padding: 20,
            fontSize: 24,
            color: theme.colors.textMuted,
          }}
        >
          Pineapple belongs on pizza.
        </div>

        <div
          style={{
            marginTop: 36,
            display: 'flex',
            justifyContent: 'center',
            opacity: saveOpacity,
          }}
        >
          <div
            style={{
              background: `linear-gradient(135deg, ${theme.gradients.primary[0]} 0%, ${theme.gradients.primary[1]} 100%)`,
              padding: '20px 48px',
              borderRadius: theme.radius.pill,
              color: '#fff',
              fontSize: 30,
              fontWeight: 800,
              boxShadow: `0 12px 32px ${theme.colors.primary}55`,
              fontFamily: theme.fonts.display,
            }}
          >
            Save Question ✨
          </div>
        </div>
      </div>
    </PhoneFrame>
  );
};
