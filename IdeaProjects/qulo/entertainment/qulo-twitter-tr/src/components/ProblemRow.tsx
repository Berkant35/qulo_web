import {interpolate, spring, useCurrentFrame, useVideoConfig} from 'remotion';
import {theme} from '../theme';

type Props = {text: string; appearFrame: number; solveFrame: number};

export const ProblemRow: React.FC<Props> = ({text, appearFrame, solveFrame}) => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();

  const appear = interpolate(frame, [appearFrame, appearFrame + 10], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const solved = frame >= solveFrame;
  const check = spring({frame: frame - solveFrame, fps, config: {damping: 12}, durationInFrames: 12});
  const dim = interpolate(frame, [solveFrame, solveFrame + 12], [1, 0.45], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});

  return (
    <div
      style={{
        opacity: appear * dim,
        transform: `translateX(${(1 - appear) * -40}px)`,
        display: 'flex',
        alignItems: 'center',
        gap: 24,
        padding: '22px 30px',
        borderRadius: theme.radius.lg,
        background: solved ? 'rgba(105,240,174,0.08)' : 'rgba(207,102,121,0.12)',
        border: `2px solid ${solved ? theme.colors.green : theme.colors.danger}`,
        fontFamily: theme.fonts.display,
        fontWeight: 700,
        fontSize: theme.type.body,
        color: theme.colors.text,
        textDecoration: solved ? 'line-through' : 'none',
        textDecorationColor: theme.colors.textMuted,
      }}
    >
      <span style={{flex: 1}}>{text}</span>
      {solved ? (
        <span style={{color: theme.colors.green, fontSize: theme.type.title, transform: `scale(${check})`}}>✓</span>
      ) : (
        <span style={{color: theme.colors.danger, fontSize: theme.type.title}}>✕</span>
      )}
    </div>
  );
};
