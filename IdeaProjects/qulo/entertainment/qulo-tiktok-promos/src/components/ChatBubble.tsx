import {interpolate, Sequence, spring, useCurrentFrame, useVideoConfig} from 'remotion';
import {theme} from '../theme';
import {PhoneFrame} from './PhoneFrame';

type Message = {
  text: string;
  fromMe: boolean;
  startFrame: number;
  typingFrames?: number;
};

type ThreadMessage = {
  text: string;
  fromMe: boolean;
  startFrame: number;
};

type Props = {
  matchName?: string;
  messages?: Message[];
  compactFont?: boolean;
  mood?: 'normal' | 'ghost';
  thread?: ThreadMessage[];
};

const DEFAULT_MESSAGES: Message[] = [
  {text: 'Pineapple on pizza? Bold take. 😄', fromMe: false, startFrame: 6},
  {text: 'You solved all 3 — respect.', fromMe: true, startFrame: 40},
  {text: 'Coffee tomorrow?', fromMe: false, startFrame: 80},
];

const TypingDots: React.FC<{align: 'me' | 'them'}> = ({align}) => {
  const frame = useCurrentFrame();
  const dot = (i: number) => {
    const y = Math.sin((frame - i * 4) / 6) * 4;
    return (
      <span
        key={i}
        style={{
          display: 'inline-block',
          width: 10,
          height: 10,
          borderRadius: 5,
          background: theme.colors.textMuted,
          margin: '0 3px',
          transform: `translateY(${y}px)`,
        }}
      />
    );
  };
  return (
    <div
      style={{
        alignSelf: align === 'me' ? 'flex-end' : 'flex-start',
        background: align === 'me' ? theme.colors.primaryDark : theme.colors.surface,
        padding: '14px 22px',
        borderRadius: 24,
        borderBottomLeftRadius: align === 'me' ? 24 : 6,
        borderBottomRightRadius: align === 'me' ? 6 : 24,
      }}
    >
      {[0, 1, 2].map(dot)}
    </div>
  );
};

// Internal helper for thread mode — renders a single bubble starting at frame 0 (inside Sequence)
const ThreadBubbleInner: React.FC<{msg: {text: string; fromMe: boolean}; fontSize: number; fps: number; ghost: boolean}> = ({msg, fontSize, fps, ghost}) => {
  const frame = useCurrentFrame();
  const reveal = spring({frame, fps, config: {damping: 14, stiffness: 130}});
  const opacity = interpolate(frame, [0, 10], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const displayText = ghost ? '...' : msg.text;
  return (
    <div
      style={{
        alignSelf: msg.fromMe ? 'flex-end' : 'flex-start',
        maxWidth: '78%',
        background: msg.fromMe
          ? `linear-gradient(135deg, ${theme.gradients.primary[0]} 0%, ${theme.gradients.primary[1]} 100%)`
          : theme.colors.surface,
        color: '#fff',
        borderRadius: 24,
        borderBottomRightRadius: msg.fromMe ? 6 : 24,
        borderBottomLeftRadius: msg.fromMe ? 24 : 6,
        padding: '14px 20px',
        fontSize,
        fontWeight: 500,
        lineHeight: 1.35,
        opacity,
        transform: `translateY(${(1 - reveal) * 14}px)`,
        filter: ghost ? 'grayscale(1) opacity(0.5)' : undefined,
      }}
    >
      {displayText}
    </div>
  );
};

export const ChatBubble: React.FC<Props> = ({matchName = 'Maya', messages = DEFAULT_MESSAGES, compactFont = false, mood = 'normal', thread}) => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();

  const TYPING = 18;
  const fontSize = compactFont ? 22 : 26;
  const isGhost = mood === 'ghost';

  // If thread prop provided, render multiple bubbles with Sequence offsets
  if (thread) {
    return (
      <PhoneFrame appLabel="Qulo · Chat">
        <div
          style={{
            position: 'absolute',
            inset: 0,
            padding: 24,
            background: theme.colors.bg,
            color: theme.colors.text,
            fontFamily: theme.fonts.body,
            display: 'flex',
            flexDirection: 'column',
            justifyContent: 'flex-end',
            gap: 12,
            paddingBottom: 40,
          }}
        >
          {thread.map((msg, i) => (
            <Sequence key={i} from={msg.startFrame} layout="none">
              <ThreadBubbleInner
                msg={msg}
                fontSize={fontSize}
                fps={fps}
                ghost={isGhost}
              />
            </Sequence>
          ))}
        </div>
      </PhoneFrame>
    );
  }

  return (
    <PhoneFrame appLabel="Qulo · Chat">
      <div
        style={{
          position: 'absolute',
          inset: 0,
          padding: 24,
          background: isGhost ? 'rgba(0,0,0,0.95)' : theme.colors.bg,
          color: theme.colors.text,
          fontFamily: theme.fonts.body,
          display: 'flex',
          flexDirection: 'column',
          filter: isGhost ? 'grayscale(1) opacity(0.5)' : undefined,
        }}
      >
        <div
          style={{
            display: 'flex',
            alignItems: 'center',
            gap: 16,
            paddingBottom: 16,
            borderBottom: `1px solid ${theme.colors.border}`,
          }}
        >
          <span style={{fontSize: 28, fontWeight: 700, color: theme.colors.primary}}>←</span>
          <div
            style={{
              width: 56,
              height: 56,
              borderRadius: 28,
              background: 'linear-gradient(135deg, #FFAFBD 0%, #C780A5 100%)',
              border: `2px solid ${theme.colors.primary}`,
            }}
          />
          <div>
            <div style={{fontSize: 26, fontWeight: 700}}>{matchName}</div>
            <div style={{fontSize: 16, color: theme.colors.secondary, fontWeight: 600}}>● Online</div>
          </div>
        </div>

        <div
          style={{
            flex: 1,
            display: 'flex',
            flexDirection: 'column',
            gap: 12,
            paddingTop: 20,
            justifyContent: 'flex-end',
            paddingBottom: 24,
          }}
        >
          {messages.map((msg, i) => {
            const typingStart = msg.startFrame - (msg.typingFrames ?? TYPING);
            const showTyping = frame >= typingStart && frame < msg.startFrame;
            const showMessage = frame >= msg.startFrame;
            const local = frame - msg.startFrame;
            const reveal = spring({frame: local, fps, config: {damping: 14, stiffness: 130}});
            const opacity = interpolate(local, [0, 10], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});

            if (showTyping) {
              return <TypingDots key={`typing-${i}`} align={msg.fromMe ? 'me' : 'them'} />;
            }
            if (!showMessage) return null;

            return (
              <div
                key={i}
                style={{
                  alignSelf: msg.fromMe ? 'flex-end' : 'flex-start',
                  maxWidth: '78%',
                  background: msg.fromMe
                    ? `linear-gradient(135deg, ${theme.gradients.primary[0]} 0%, ${theme.gradients.primary[1]} 100%)`
                    : theme.colors.surface,
                  color: '#fff',
                  borderRadius: 24,
                  borderBottomRightRadius: msg.fromMe ? 6 : 24,
                  borderBottomLeftRadius: msg.fromMe ? 24 : 6,
                  padding: '14px 20px',
                  fontSize,
                  fontWeight: 500,
                  lineHeight: 1.35,
                  opacity,
                  transform: `translateY(${(1 - reveal) * 14}px)`,
                  boxShadow: msg.fromMe ? `0 6px 20px ${theme.colors.primary}55` : 'none',
                  filter: isGhost ? 'grayscale(1) opacity(0.5)' : undefined,
                }}
              >
                {isGhost ? '...' : msg.text}
              </div>
            );
          })}
        </div>

        <div
          style={{
            background: theme.colors.surface,
            borderRadius: theme.radius.pill,
            padding: '12px 22px',
            color: theme.colors.textMuted,
            fontSize: 20,
            display: 'flex',
            justifyContent: 'space-between',
            alignItems: 'center',
          }}
        >
          <span>Type a message…</span>
          <span style={{color: theme.colors.primary, fontSize: 24}}>↑</span>
        </div>
      </div>
    </PhoneFrame>
  );
};
