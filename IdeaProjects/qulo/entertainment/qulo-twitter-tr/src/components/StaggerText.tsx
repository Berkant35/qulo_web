import {interpolate, useCurrentFrame} from 'remotion';
import {theme} from '../theme';

type Props = {
  lines: string[];
  startFrame?: number;
  perLineFrames?: number;
  fontSize?: number;
  color?: string;
  accentColor?: string;
  align?: 'center' | 'left';
};

const renderLine = (line: string, accentColor?: string) => {
  if (!accentColor) return line;
  // *kelime* → accent renkli
  const parts = line.split(/(\*[^*]+\*)/g);
  return parts.map((p, i) =>
    p.startsWith('*') && p.endsWith('*') ? (
      <span key={i} style={{color: accentColor}}>{p.slice(1, -1)}</span>
    ) : (
      <span key={i}>{p}</span>
    ),
  );
};

export const StaggerText: React.FC<Props> = ({
  lines,
  startFrame = 0,
  perLineFrames = 18,
  fontSize = theme.type.title,
  color = theme.colors.text,
  accentColor,
  align = 'center',
}) => {
  const frame = useCurrentFrame();
  return (
    <div
      style={{
        display: 'flex',
        flexDirection: 'column',
        alignItems: align === 'center' ? 'center' : 'flex-start',
        textAlign: align,
        gap: 18,
        fontFamily: theme.fonts.display,
        fontWeight: theme.type.weight,
        fontSize,
        color,
        lineHeight: 1.08,
        letterSpacing: -1.5,
      }}
    >
      {lines.map((line, i) => {
        const t = startFrame + i * perLineFrames;
        const opacity = interpolate(frame, [t, t + 10], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
        const y = interpolate(frame, [t, t + 12], [28, 0], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
        return (
          <div key={i} style={{opacity, transform: `translateY(${y}px)`, textShadow: '0 8px 32px rgba(0,0,0,0.55)'}}>
            {renderLine(line, accentColor)}
          </div>
        );
      })}
    </div>
  );
};
