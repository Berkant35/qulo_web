import {AbsoluteFill, Sequence, interpolate, useCurrentFrame, useVideoConfig} from 'remotion';
import type {SoruSpec} from '../configs/questions';
import {theme} from '../theme';
import {BackdropPlate} from '../components/BackdropPlate';
import {CollageSticker} from '../components/CollageSticker';
import {QuestionCard} from '../components/QuestionCard';
import {EliminationStamp} from '../components/EliminationStamp';
import {MatchSpark} from '../components/MatchSpark';
import {UncertaintyFog} from '../components/UncertaintyFog';

// Varyant S1 "Biz Neyiz?" — parametrik aday round'u: net cevaptan kaçan aday SWAP_FRAME'e doğru sönüp
// (opacity+yükseliş+blur) kayboluyor ve yerini BELİRSİZLİK SİSİ'ne (UncertaintyFog: gri sis bulutu +
// yukarı süzülen '?' glyph'leri) bırakıyor; net cevap veren kalır ve NET + Eşleşme! alır. YAPISAL
// OLARAK GhostScene (G1) ile aynı iskelet (band-fit aday genişliği, torso ankraj, köşe damgası deseni,
// zamanlama sabitleri) — tek fark "kayboluş" dilinin hayalet YERİNE sis/soru-işareti teması olması ve
// adayın G1'deki gibi ani "poof" kesim yerine son birkaç karede yumuşakça sönmesi (bkz. plan: aday
// sticker'ı opacity 1→0 + hafif yukarı+bulanıklaşma).
const QUESTION_ENTER = 6;
const ANSWER_FRAME = 40;
const SWAP_FRAME = 64; // yanlışsa: aday burada Sequence tarafından tamamen kesiliyor (fade son CANDIDATE_FADE_LEAD karede biter); sis de burada devralıyor
const CANDIDATE_FADE_LEAD = 18; // adayın "fades/rises slightly" geçişi SWAP_FRAME'den bu kadar önce başlar
const FOG_STAMP_FRAME = 78;
const MATCH_FRAME = 76;
const W6_ENTER_FRAME = 72;

// QuestionCard sabit y=240'ta başlar (GhostScene ile aynı sabitler — top-anchored, height-göreli
// DEĞİL, her iki formatta da güvenli üstten konum). CARD_GAP: kart ile aday arasında ZORUNLU minimum
// boşluk (4:5'te çakışmayı yapısal olarak imkansız kılan pay — bkz. suspectWidth hesabı).
const CARD_BOTTOM = 500;
const CARD_GAP = 36;

type Props = {
  suspectSrc: string;
  soru: SoruSpec;
  correct: boolean;
  durationFrames: number;
};

export const TanimScene: React.FC<Props> = ({suspectSrc, soru, correct, durationFrames}) => {
  const frame = useCurrentFrame();
  const {height} = useVideoConfig();

  // Aday sticker'ı: GhostScene'deki BAND-FIT clamp formülüyle birebir aynı (bkz. o dosyadaki yorum) —
  // kart altı+CARD_GAP → alt safe-zone arasına sığacak MAKSİMUM genişlik hesaplanıp 520 ile min alınır:
  // 9:16'da (height=1920) tam 520 çıkar, 4:5'te (1350) otomatik küçülüp kart çakışmasını YAPISAL olarak
  // imkansız kılar.
  const bottomSafe = height > 1700 ? theme.safeZone.bottom : 190; // 4:5'te safe-zone oranlı küçülür
  const availableBand = height - bottomSafe - (CARD_BOTTOM + CARD_GAP);
  const suspectWidth = Math.min(520, availableBand / 1.5);

  const suspectBottom = height - bottomSafe;
  const suspectY = suspectBottom - 0.49 * suspectWidth; // CollageSticker sözleşmesi: top=y-width, bottom≈y+0.49*width (2:3 asset)
  const suspectTop = suspectY - suspectWidth;
  const suspectVisibleHeight = suspectWidth * 1.5;

  // Sis ankraj noktası: adayın gövde/göğüs hizası (GhostScene'deki torsoY formülüyle birebir aynı).
  const torsoY = suspectTop + suspectVisibleHeight * 0.4;
  const fogWidth = suspectWidth * 1.1;

  // TANIMSIZ damgası: kart altı ile gövde hizası arasındaki boşluğa ORANLI konumlanır (GhostScene'deki
  // stampY formülüyle aynı) — her iki formatta da otomatik olarak kart ile aday/sis arasındaki güvenli
  // bantta kalır.
  const stampY = CARD_BOTTOM + (torsoY - CARD_BOTTOM) * 0.35;

  // Aday kaybolurken: son CANDIDATE_FADE_LEAD karede opacity 1→0 + hafif yukarı kayma + bulanıklaşma.
  // SWAP_FRAME'de zaten <Sequence> kesiyor — bu geçiş kesimden ÖNCEKİ son anları yumuşatır; sis tam
  // SWAP_FRAME'de devralır (bkz. plan: "UncertaintyFog ... swap frame'den").
  const candidateFadeOpacity = interpolate(frame, [SWAP_FRAME - CANDIDATE_FADE_LEAD, SWAP_FRAME], [1, 0], {
    extrapolateLeft: 'clamp',
    extrapolateRight: 'clamp',
  });
  const candidateFadeRise = interpolate(frame, [SWAP_FRAME - CANDIDATE_FADE_LEAD, SWAP_FRAME], [0, -26], {
    extrapolateLeft: 'clamp',
    extrapolateRight: 'clamp',
  });
  const candidateFadeBlur = interpolate(frame, [SWAP_FRAME - CANDIDATE_FADE_LEAD, SWAP_FRAME], [0, 7], {
    extrapolateLeft: 'clamp',
    extrapolateRight: 'clamp',
  });

  return (
    <AbsoluteFill style={{overflow: 'hidden'}}>
      <BackdropPlate src="ai/bg_kafe.png" zoomFrom={1} zoomTo={1.08} darken={0.4} durationInFrames={durationFrames} />

      <QuestionCard
        text={soru.soru}
        x={540}
        y={240}
        width={760}
        enterFrame={QUESTION_ENTER}
        answer={correct ? soru.dogru : soru.yanlis}
        answerTone={correct ? 'correct' : 'wrong'}
        answerFrame={ANSWER_FRAME}
      />

      {!correct ? (
        <>
          {/* Aday: son CANDIDATE_FADE_LEAD karede sönüp yükselip bulanıklaşarak kayboluyor, Sequence
              SWAP_FRAME'de kesin sınırı koyuyor (talimattaki gibi birebir). */}
          <div
            style={{
              position: 'absolute',
              inset: 0,
              opacity: candidateFadeOpacity,
              transform: `translateY(${candidateFadeRise}px)`,
              filter: `blur(${candidateFadeBlur}px)`,
            }}
          >
            <Sequence durationInFrames={SWAP_FRAME}>
              <CollageSticker src={suspectSrc} width={suspectWidth} x={540} y={suspectY} enterFrame={0} sway={false} />
            </Sequence>
          </div>

          <UncertaintyFog startFrame={SWAP_FRAME} x={540} y={torsoY} width={fogWidth} />

          <EliminationStamp frame={FOG_STAMP_FRAME} label="TANIMSIZ" x={540} y={stampY} rotate={-9} fontSize={72} />
        </>
      ) : (
        <>
          <CollageSticker src={suspectSrc} width={suspectWidth} x={540} y={suspectY} enterFrame={0} sway={false} />

          {/* Küçük köşe damgası (InterrogationScene'in "TEMİZ" tekniğiyle aynı dil, GhostScene'in
              "KALDI" damgasıyla aynı konum) — merkezdeki MatchSpark'la çakışmasın diye kartın sağ-alt
              köşesine biner. */}
          <EliminationStamp
            frame={SWAP_FRAME}
            label="NET"
            color={theme.colors.greenDark}
            x={860}
            y={CARD_BOTTOM + 10}
            rotate={9}
            fontSize={52}
          />

          {/* Kartın altı ile adayın başı arasındaki boşluğa InterrogationScene/KadikoyScene/GhostScene'deki
              scale-squeeze tekniğiyle sıkıştırılmış spark. */}
          <div
            style={{
              position: 'absolute',
              top: CARD_BOTTOM + 20,
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

          {/* w6 = S1'in marka kadını — soldan süzülerek eşleşme anına katılır. Genişlik suspectWidth'e
              ORANTILI (küçük ikincil figür) ki 4:5'te de kart/aday ile çakışmasın. */}
          <CollageSticker
            src="ai/w6.png"
            width={suspectWidth * 0.7}
            x={230}
            y={suspectBottom - 0.49 * suspectWidth * 0.7}
            enterFrame={W6_ENTER_FRAME}
            enter="drift"
            baseRotate={-2}
          />
        </>
      )}
    </AbsoluteFill>
  );
};
