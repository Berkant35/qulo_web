import {AbsoluteFill, Sequence} from 'remotion';
import {theme} from '../theme';
import {SORULAR} from '../configs/questions';
import type {SoruSpec} from '../configs/questions';
import {CollageShapes} from '../components/CollageShapes';
import {CollageSticker} from '../components/CollageSticker';
import {PaperShreds} from '../components/PaperShreds';
import {QuestionCard} from '../components/QuestionCard';
import {StaggerText} from '../components/StaggerText';

export type Round = {src: string; question: SoruSpec; correct: boolean};

const DEFAULT_ROUNDS: readonly Round[] = [
  {src: 'ai/m1.png', question: SORULAR[0], correct: false},
  {src: 'ai/m2.png', question: SORULAR[1], correct: false},
  {src: 'ai/m3.png', question: SORULAR[2], correct: true},
];

// Adayın verdiği cevap: yanlış roundlarda kadının 'yanlis' seçeneği, doğru roundda 'dogru'.
const roundAnswer = (round: Round) => (round.correct ? round.question.dogru : round.question.yanlis);

type Props = {
  rounds?: readonly Round[];
  juryStickerSrc?: string;
  juryFlip?: boolean;
  // İlk round'un başladığı kare (varsayılan 30 = mevcut QuloReelsAd/Varyant A davranışı). Varyant B gibi
  // sıkıştırılmış sahne sürelerinde daha erken başlatmak için (bkz. kaos.config.ts) kullanılır.
  firstRoundStart?: number;
};

export const S3Elimination: React.FC<Props> = ({
  rounds = DEFAULT_ROUNDS,
  juryStickerSrc = 'ai/w1_hook.png',
  juryFlip = false,
  firstRoundStart = 30,
}) => {
  const roundStart = (i: number) => firstRoundStart + i * 70;

  return (
    <AbsoluteFill style={{background: theme.colors.bg, overflow: 'hidden'}}>
      <CollageShapes variant="elimination" />
      {/* Kadın küçük "jüri" olarak solda sabit */}
      <CollageSticker src={juryStickerSrc} width={300} x={190} y={1500} enterFrame={0} baseRotate={-3} sway={false} flip={juryFlip} />
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
      {rounds.map((round, i) => {
        const start = roundStart(i);
        const isLast = i === rounds.length - 1;
        return (
          <Sequence key={`${round.src}-${i}`} from={start} durationInFrames={isLast ? undefined : 70} name={`Round ${i + 1}`}>
            <CollageSticker
              src={round.src}
              width={560}
              x={640}
              y={1380}
              enterFrame={0}
              baseRotate={i % 2 === 0 ? 3 : -3}
              tearFrame={round.correct ? undefined : 44}
            />
            {!round.correct ? (
              <>
                {/* Ana patlama: yırtılma anıyla (tearFrame 44) eşzamanlı, geniş ve yoğun. */}
                <PaperShreds startFrame={44} count={26} originX={640} originY={1050} spread={420} />
                {/* İkincil küçük patlama: hafif gecikmeli + sağa kaymış — asimetri için. */}
                <PaperShreds startFrame={50} count={10} originX={760} originY={1050} spread={260} />
              </>
            ) : null}
            <QuestionCard
              text={round.question.soru}
              x={540}
              y={500}
              width={680}
              rotate={i % 2 === 0 ? -2 : 2}
              enterFrame={4}
              state={round.correct ? 'correct' : 'wrong'}
              stateFrame={36}
              answer={roundAnswer(round)}
              answerTone={round.correct ? 'correct' : 'wrong'}
              answerFrame={26}
            />
          </Sequence>
        );
      })}
    </AbsoluteFill>
  );
};
