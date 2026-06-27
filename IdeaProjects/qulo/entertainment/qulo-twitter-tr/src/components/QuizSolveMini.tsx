import {interpolate, spring, useCurrentFrame, useVideoConfig} from 'remotion';
import {theme} from '../theme';

type Props = {
  question: string;
  options: string[];
  correctIndex: number;
  startFrame?: number;
  perItemFrames?: number;
};

export const QuizSolveMini: React.FC<Props> = ({
  question,
  options,
  correctIndex,
  startFrame = 0,
  perItemFrames = 16,
}) => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();
  const local = frame - startFrame;

  return (
    <div style={{padding: 28, height: '100%', display: 'flex', flexDirection: 'column', gap: 18}}>
      <div
        style={{
          fontFamily: theme.fonts.display,
          fontWeight: 700,
          fontSize: 30,
          color: theme.colors.text,
          lineHeight: 1.2,
          marginTop: 24,
        }}
      >
        {question}
      </div>
      <div style={{display: 'flex', flexDirection: 'column', gap: 14, marginTop: 8}}>
        {options.map((opt, i) => {
          const t = i * perItemFrames;
          const appear = interpolate(local, [t, t + 8], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
          const isCorrect = i === correctIndex;
          const checkT = t + 8;
          const check = spring({frame: local - checkT, fps, config: {damping: 12}, durationInFrames: 12});
          const solved = isCorrect && local >= checkT;
          return (
            <div
              key={i}
              style={{
                opacity: appear,
                transform: `translateX(${(1 - appear) * 20}px)`,
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'space-between',
                padding: '16px 18px',
                borderRadius: theme.radius.md,
                background: solved ? 'rgba(105,240,174,0.14)' : theme.colors.surface,
                border: `2px solid ${solved ? theme.colors.green : theme.colors.border}`,
                fontFamily: theme.fonts.body,
                fontSize: 24,
                color: theme.colors.text,
              }}
            >
              <span>{opt}</span>
              {solved ? (
                <span style={{color: theme.colors.green, fontSize: 28, transform: `scale(${check})`}}>✓</span>
              ) : null}
            </div>
          );
        })}
      </div>
    </div>
  );
};
