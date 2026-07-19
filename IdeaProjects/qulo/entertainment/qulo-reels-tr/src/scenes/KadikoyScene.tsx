import {AbsoluteFill, useVideoConfig} from 'remotion';
import type {SoruSpec} from '../configs/questions';
import {BackdropPlate} from '../components/BackdropPlate';
import {CollageSticker} from '../components/CollageSticker';
import {QuestionCard} from '../components/QuestionCard';
import {EliminationStamp} from '../components/EliminationStamp';
import {MatchSpark} from '../components/MatchSpark';
import {PaperShreds} from '../components/PaperShreds';
import {CatJury} from '../components/CatJury';

// Varyant K2 "Kadıköy Kedileri" — parametrik aday round'u: erko_zengin_araba (3:4) / erko_kasli /
// italyan (2:3) hepsi bu tek sahneyle oynatılır. Zamanlama (sahne-lokal kare): soru giriş 6, cevap
// çipi 40, kedi jürisi tepkisi 64 (staggered +6/+12, bkz. CatJury); ret ise yırtılma 78 + kırıntı 80
// + ELENDİ damgası 86; onaysa Eşleşme! 80 + w4 soldan kayarak girer 76.
const QUESTION_ENTER = 6;
const ANSWER_FRAME = 40;
const REACT_FRAME = 64;
const TEAR_FRAME = 78;
const SHRED_FRAME = 80;
const STAMP_FRAME = 86;
const MATCH_FRAME = 80;
const W4_ENTER_FRAME = 76;

// Aday sticker'ının görünür alt kenarını (CollageSticker sözleşmesi: top=y-width,
// bottom=top+width*ratio=y+width*(ratio-1)) aspect/width ne olursa olsun kedi jürisinin (top~1520,
// bkz. CatJury) HEMEN ÜSTÜNDE sabit bir çizgide (~1485) tutan formül — iki ayrı sabit yerine (bkz. plan: 2:3/520→
// y~1230, 3:4/700→y~1250) tek kaynaktan üretiliyor.
const ASPECT_HEIGHT_RATIO: Record<'2:3' | '3:4', number> = {'2:3': 1.5, '3:4': 4 / 3};

type Props = {
  bg: string;
  suspectSrc: string;
  suspectWidth?: number;
  suspectAspect?: '2:3' | '3:4';
  soru: SoruSpec;
  correct: boolean;
  durationFrames: number;
};

export const KadikoyScene: React.FC<Props> = ({
  bg,
  suspectSrc,
  suspectWidth = 520,
  suspectAspect = '2:3',
  soru,
  correct,
  durationFrames,
}) => {
  const {height} = useVideoConfig();
  // 9:16'da (height=1920) suspectBottomTarget=1485 → önceki sabitle birebir aynı; 4:5'te (1350) alt banda otomatik oturur.
  const suspectBottomTarget = height - 435;
  const ratio = ASPECT_HEIGHT_RATIO[suspectAspect];
  const suspectY = suspectBottomTarget - suspectWidth * (ratio - 1);

  return (
    <AbsoluteFill style={{overflow: 'hidden'}}>
      <BackdropPlate src={bg} zoomFrom={1} zoomTo={1.08} darken={0.35} durationInFrames={durationFrames} />
      <QuestionCard
        text={soru.soru}
        x={540}
        y={250}
        width={760}
        enterFrame={QUESTION_ENTER}
        answer={correct ? soru.dogru : soru.yanlis}
        answerTone={correct ? 'correct' : 'wrong'}
        answerFrame={ANSWER_FRAME}
      />
      <CollageSticker
        src={suspectSrc}
        width={suspectWidth}
        x={540}
        y={suspectY}
        enterFrame={0}
        sway={false}
        tearFrame={correct ? undefined : TEAR_FRAME}
      />
      <CatJury reaction={correct ? 'approve' : 'reject'} reactFrame={REACT_FRAME} />
      {!correct ? (
        <>
          <PaperShreds startFrame={SHRED_FRAME} count={24} originX={540} originY={1050} spread={400} />
          <PaperShreds startFrame={SHRED_FRAME + 6} count={10} originX={660} originY={1050} spread={250} />
          <EliminationStamp frame={STAMP_FRAME} />
        </>
      ) : (
        <>
          {/* MatchSpark tam boyutuyla suspectY formülüyle çakışır (aday başı ~705'te başlıyor, glow
              430px çapında) — InterrogationScene'in "İfade Tutanağı" sıkıştırma tekniğiyle aynı dilde
              (scale+top-anchor) soru kartı (bitiş ~446) ile adayın başı (~705) arasındaki boşluğa
              küçültülüyor (bkz. still f640/f720 doğrulaması — tune). */}
          <div
            style={{
              position: 'absolute',
              top: 550,
              left: 0,
              width: '100%',
              display: 'flex',
              justifyContent: 'center',
              transform: 'scale(0.55)',
              transformOrigin: 'top center',
            }}
          >
            <MatchSpark startFrame={MATCH_FRAME} label="Eşleşme!" />
          </div>
          {/* w4 = K2'nin marka kadını (bkz. CAST.md) — sadece onay round'unda, eşleşme anında girer. */}
          <CollageSticker src="ai/w4.png" width={460} x={300} y={height - 710} enterFrame={W4_ENTER_FRAME} enter="drift" baseRotate={-2} />
        </>
      )}
    </AbsoluteFill>
  );
};
