import {interpolate, spring, useCurrentFrame, useVideoConfig} from 'remotion';
import {theme} from '../theme';

type State = 'neutral' | 'correct' | 'wrong';
type Props = {
  text: string;
  x: number;
  y: number;
  width?: number;
  rotate?: number;
  enterFrame?: number;
  state?: State;
  stateFrame?: number;
};

const StateBadge: React.FC<{state: State; visible: number}> = ({state, visible}) => {
  if (state === 'neutral') return null;
  const color = state === 'correct' ? theme.colors.greenDark : theme.colors.danger;
  const glyph = state === 'correct' ? 'M5 13l4 4L19 7' : 'M6 6l12 12M18 6L6 18';
  return (
    <div
      style={{
        position: 'absolute',
        right: -28,
        top: -28,
        width: 76,
        height: 76,
        borderRadius: '50%',
        background: color,
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        transform: `scale(${visible})`,
        boxShadow: '0 10px 24px rgba(0,0,0,0.4)',
      }}
    >
      <svg width={40} height={40} viewBox="0 0 24 24" fill="none" stroke={theme.colors.text} strokeWidth={3.4} strokeLinecap="round">
        <path d={glyph} />
      </svg>
    </div>
  );
};

export const QuestionCard: React.FC<Props> = ({
  text,
  x,
  y,
  width = 660,
  rotate = 0,
  enterFrame = 0,
  state = 'neutral',
  stateFrame = 0,
}) => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();
  const local = frame - enterFrame;
  if (local < 0) return null;

  const enter = spring({frame: local, fps, from: 0, to: 1, config: {damping: 13, stiffness: 160}, durationInFrames: 14});
  const chars = Math.round(interpolate(local, [6, 26], [0, text.length], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'}));
  const badgeScale = spring({frame: frame - stateFrame, fps, from: 0, to: 1, config: {damping: 10, stiffness: 200}, durationInFrames: 12});

  return (
    <div
      style={{
        position: 'absolute',
        left: x - width / 2,
        top: y,
        width,
        padding: '30px 38px',
        background: theme.colors.paper,
        color: theme.colors.paperInk,
        borderRadius: 14,
        fontFamily: theme.fonts.body,
        fontWeight: 600,
        fontSize: theme.type.body,
        lineHeight: 1.25,
        transform: `rotate(${rotate}deg) scale(${enter})`,
        opacity: enter,
        boxShadow: '0 16px 30px rgba(0,0,0,0.45)',
      }}
    >
      {text.slice(0, chars)}
      <StateBadge state={frame >= stateFrame ? state : 'neutral'} visible={frame >= stateFrame ? badgeScale : 0} />
    </div>
  );
};
