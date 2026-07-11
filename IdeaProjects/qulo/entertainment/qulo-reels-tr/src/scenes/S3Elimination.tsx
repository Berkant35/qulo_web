import {AbsoluteFill, Sequence} from 'remotion';
import {theme} from '../theme';
import {SORULAR} from '../configs/questions';
import {CollageShapes} from '../components/CollageShapes';
import {CollageSticker} from '../components/CollageSticker';
import {QuestionCard} from '../components/QuestionCard';
import {StaggerText} from '../components/StaggerText';

const ROUNDS = [
  {src: 'ai/m1.png', question: SORULAR[0], correct: false},
  {src: 'ai/m2.png', question: SORULAR[1], correct: false},
  {src: 'ai/m3.png', question: SORULAR[2], correct: true},
] as const;

const roundStart = (i: number) => 30 + i * 70;

export const S3Elimination: React.FC = () => {
  return (
    <AbsoluteFill style={{background: theme.colors.bg, overflow: 'hidden'}}>
      <CollageShapes variant="elimination" />
      {/* Kadın küçük "jüri" olarak solda sabit */}
      <CollageSticker src="ai/w1_hook.png" width={300} x={190} y={1500} enterFrame={0} baseRotate={-3} sway={false} />
      <div
        style={{
          position: 'absolute',
          top: theme.safeZone.top + 20,
          left: 0,
          width: '100%',
          display: 'flex',
          justifyContent: 'center',
          padding: `0 ${theme.safeZone.horizontal}px`,
        }}
      >
        <StaggerText
          lines={['Yanlış cevap?', '*Elenirsin.*']}
          startFrame={4}
          fontSize={theme.type.title}
          accentColor={theme.colors.danger}
        />
      </div>
      {ROUNDS.map((round, i) => {
        const start = roundStart(i);
        return (
          <Sequence key={round.src} from={start} durationInFrames={i === 2 ? 240 - start : 70} name={`Round ${i + 1}`}>
            <CollageSticker
              src={round.src}
              width={560}
              x={640}
              y={1380}
              enterFrame={0}
              baseRotate={i % 2 === 0 ? 3 : -3}
              tearFrame={round.correct ? undefined : 44}
            />
            <QuestionCard
              text={round.question}
              x={540}
              y={560}
              width={680}
              rotate={i % 2 === 0 ? -2 : 2}
              enterFrame={4}
              state={round.correct ? 'correct' : 'wrong'}
              stateFrame={34}
            />
          </Sequence>
        );
      })}
    </AbsoluteFill>
  );
};
