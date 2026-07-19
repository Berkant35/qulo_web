import {AbsoluteFill, useVideoConfig} from 'remotion';
import {theme} from '../theme';
import {SORULAR} from '../configs/questions';
import type {SoruSpec} from '../configs/questions';
import {CollageShapes} from '../components/CollageShapes';
import {CollageSticker} from '../components/CollageSticker';
import {QuestionCard} from '../components/QuestionCard';
import {StaggerText} from '../components/StaggerText';

export type PropSticker = {
  src: string;
  width: number;
  x: number;
  y: number;
  rotate?: number;
  enterFrame?: number;
};

type Props = {
  stickerSrc?: string;
  stickerX?: number;
  stickerWidth?: number;
  sorular?: readonly SoruSpec[];
  lines?: string[];
  props?: PropSticker[];
};

export const S2Rules: React.FC<Props> = ({
  stickerSrc = 'ai/w1_point.png',
  stickerX = 300,
  stickerWidth = 560,
  sorular = SORULAR,
  lines = ['2-10 soru sor.', 'Doğru cevabı *sen* belirle.'],
  props = [],
}) => {
  const {height} = useVideoConfig();
  // 9:16'da (height=1920) y=1380 → önceki sabitle birebir aynı; 4:5'te (1350) sticker alt banda otomatik oturur.
  return (
    <AbsoluteFill style={{background: theme.colors.bg, overflow: 'hidden'}}>
      <CollageShapes variant="rules" />
      <CollageSticker src={stickerSrc} width={stickerWidth} x={stickerX} y={height - 540} enterFrame={0} baseRotate={2} />
      {props.map((p, i) => (
        <CollageSticker
          key={`${p.src}-${i}`}
          src={p.src}
          width={p.width}
          x={p.x}
          y={p.y}
          baseRotate={p.rotate ?? 0}
          enterFrame={p.enterFrame ?? 0}
        />
      ))}
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
          lines={lines}
          startFrame={4}
          fontSize={theme.type.title}
          accentColor={theme.colors.purple}
        />
      </div>
      {sorular.map((q, i) => (
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
