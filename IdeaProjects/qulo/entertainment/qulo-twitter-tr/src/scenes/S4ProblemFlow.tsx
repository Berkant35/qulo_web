import {AbsoluteFill, interpolate, useCurrentFrame} from 'remotion';
import {theme} from '../theme';
import {ProblemRow} from '../components/ProblemRow';

// Sahne yerel frame (S4 = 240 frame, 8s).
const PROBLEMS = [
  {text: 'Sevgili sandığın kişi evli çıktı.', appearFrame: 8, solveFrame: 55},
  {text: 'İlk buluşmada centilmen, sonra maço.', appearFrame: 38, solveFrame: 85},
  {text: 'Egosuz sanmıştın… değilmiş.', appearFrame: 68, solveFrame: 115},
];

export const S4ProblemFlow: React.FC = () => {
  const frame = useCurrentFrame();
  const closing = interpolate(frame, [150, 165], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});

  return (
    <AbsoluteFill
      style={{
        background: theme.colors.bg,
        justifyContent: 'center',
        alignItems: 'center',
        padding: `${theme.safeZone.top}px ${theme.safeZone.horizontal}px`,
      }}
    >
      <div style={{display: 'flex', flexDirection: 'column', gap: 22, width: '74%'}}>
        {PROBLEMS.map((p, i) => (
          <ProblemRow key={i} {...p} />
        ))}
        <div
          style={{
            marginTop: 28,
            textAlign: 'center',
            opacity: closing,
            transform: `translateY(${(1 - closing) * 20}px)`,
            fontFamily: theme.fonts.display,
            fontWeight: theme.type.weight,
            fontSize: theme.type.title,
            color: theme.colors.green,
          }}
        >
          Hepsi tek bir doğru soruyla elenir.
        </div>
      </div>
    </AbsoluteFill>
  );
};
