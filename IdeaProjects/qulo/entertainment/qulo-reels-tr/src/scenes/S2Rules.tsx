import {AbsoluteFill} from 'remotion';
import {theme} from '../theme';
import {SORULAR} from '../configs/questions';
import {CollageShapes} from '../components/CollageShapes';
import {CollageSticker} from '../components/CollageSticker';
import {QuestionCard} from '../components/QuestionCard';
import {StaggerText} from '../components/StaggerText';

export const S2Rules: React.FC = () => {
  return (
    <AbsoluteFill style={{background: theme.colors.bg, overflow: 'hidden'}}>
      <CollageShapes variant="rules" />
      <CollageSticker src="ai/w1_point.png" width={560} x={300} y={1380} enterFrame={0} baseRotate={2} />
      <div
        style={{
          position: 'absolute',
          top: theme.safeZone.top + 30,
          left: 0,
          width: '100%',
          display: 'flex',
          justifyContent: 'center',
          padding: `0 ${theme.safeZone.horizontal}px`,
        }}
      >
        <StaggerText
          lines={['2-10 soru sor.', 'Doğru cevabı *sen* belirle.']}
          startFrame={4}
          fontSize={theme.type.title}
          accentColor={theme.colors.purple}
        />
      </div>
      {SORULAR.map((q, i) => (
        <QuestionCard
          key={q.soru}
          text={q.soru}
          x={620}
          y={580 + i * 230}
          width={640}
          rotate={i % 2 === 0 ? -2 : 2}
          enterFrame={40 + i * 40}
          answer={q.dogru}
          answerTone="set"
          answerFrame={40 + i * 40 + 28}
        />
      ))}
    </AbsoluteFill>
  );
};
