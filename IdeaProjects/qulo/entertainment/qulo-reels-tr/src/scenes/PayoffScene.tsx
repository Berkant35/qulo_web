import {AbsoluteFill, useVideoConfig} from 'remotion';
import {theme} from '../theme';
import {CollageShapes} from '../components/CollageShapes';
import {CollageSticker} from '../components/CollageSticker';
import {QuestionCard} from '../components/QuestionCard';
import {StaggerText} from '../components/StaggerText';
import type {SoruSpec} from '../configs/questions';

type ShapesVariant = 'hook' | 'rules' | 'elimination' | 'match';

type Props = {
  coupleSrc: string;
  question: SoruSpec;
  caption: string;
  shapesVariant?: ShapesVariant;
};

// Varyant C "Buluşma Payoff'u" — küçük soru kartı (video 1'deki mekanik) → büyük çift fotoğrafı (gerçeğe dönüşen cevap).
export const PayoffScene: React.FC<Props> = ({coupleSrc, question, caption, shapesVariant = 'match'}) => {
  const {height} = useVideoConfig();
  // 9:16'da (height=1920) çift y=1310 / caption top=1530 → önceki sabitlerle birebir aynı; 4:5'te (1350) alt banda oturur.
  return (
    <AbsoluteFill style={{background: theme.colors.bg, overflow: 'hidden'}}>
      <CollageShapes variant={shapesVariant} />
      <QuestionCard
        text={question.soru}
        x={540}
        y={250}
        width={620}
        rotate={-2}
        enterFrame={4}
        answer={question.dogru}
        answerTone="correct"
        answerFrame={20}
      />
      {/* width=880 -> top=y-width=430; çift asset 3:4 oranlı, görünür alt ≈ y + 0.34*880 ≈ 1610 (safe-zone ≤1660 uyumlu). */}
      <CollageSticker src={coupleSrc} width={880} x={540} y={height - 610} enterFrame={8} enter="drift" />
      {/* Caption çiftin alt/gövde bölgesi üstüne biner; StaggerText'in kendi text-shadow'u + accent yeşil okunabilirliği sağlar. */}
      <div
        style={{
          position: 'absolute',
          top: height - 390,
          left: 0,
          width: '100%',
          display: 'flex',
          justifyContent: 'center',
          padding: `0 ${theme.safeZone.horizontal}px`,
        }}
      >
        <StaggerText lines={[`*${caption}*`]} startFrame={40} fontSize={theme.type.body + 6} accentColor={theme.colors.green} />
      </div>
    </AbsoluteFill>
  );
};
