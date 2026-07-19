import {AbsoluteFill, Sequence, interpolate, useCurrentFrame, useVideoConfig} from 'remotion';
import type {SoruSpec} from '../configs/questions';
import {theme} from '../theme';
import {BackdropPlate} from '../components/BackdropPlate';
import {CollageSticker} from '../components/CollageSticker';
import {QuestionCard} from '../components/QuestionCard';
import {SpriteFlip} from '../components/SpriteFlip';
import {EliminationStamp} from '../components/EliminationStamp';
import {MatchSpark} from '../components/MatchSpark';
import {PaperShreds} from '../components/PaperShreds';

// Varyant G1 "Hayalet Avı" — parametrik aday round'u: kaçamak cevap veren aday SWAP_FRAME'de aniden
// kaybolur (poof) ve yerinde hayalete dönüşüp (SpriteFlip: hayalet_1 taban → hayalet_2 el sallayan)
// süzülerek yukarı kaybolur; net cevap veren kalır ve KALDI + Eşleşme! alır. Zamanlama (sahne-lokal
// kare, K2/R2 ile aynı dil): soru giriş 6, cevap çipi 40, dönüşüm/karar 64, GHOSTLANDI damgası 78.
const QUESTION_ENTER = 6;
const ANSWER_FRAME = 40;
const SWAP_FRAME = 64; // yanlışsa: aday <Sequence> ile aniden kayboluyor + hayalet belirip yükseliyor; doğruysa: KALDI damgası anı
const GHOST_STAMP_FRAME = 78;
// Görev tarifi "~50 kare" öneriyordu; still doğrulaması (f290/f500, SWAP_FRAME+106 kare) 50 kare ile
// hayaletin tamamen kaybolmuş olacağını gösterdi — "risen+fading, henüz görünür" beklentisini
// karşılamak için 130'a uzatıldı (bkz. GHOST_RISE_MARGIN deviation notu: asıl kart-çakışması engeli
// yükseliş MESAFESİNİN sınırlanması ile çözüldü, bu süre sadece solma hızını ayarlıyor).
const GHOST_DRIFT_FRAMES = 130;
const GHOST_FRAME_DURATION = 12; // hayalet_1 (taban) → hayalet_2 (el sallayan), yükselişin ortasında poz değişir
const MATCH_FRAME = 76;
const W5_ENTER_FRAME = 72;

// QuestionCard sabit y=240'ta başlar (top-anchored, height-göreli DEĞİL — her iki formatta da aynı
// üstten konum güvenli) + tahmini kart yüksekliği (~254px: padding 60 + ~2 satır soru metni + cevap
// çipi). CARD_GAP: kart ile aday arasında ZORUNLU minimum boşluk (4:5'te çakışmayı yapısal olarak
// imkansız kılan pay — bkz. suspectWidth hesabı).
const CARD_BOTTOM = 500;
const CARD_GAP = 36;

type Props = {
  suspectSrc: string;
  soru: SoruSpec;
  correct: boolean;
  durationFrames: number;
};

export const GhostScene: React.FC<Props> = ({suspectSrc, soru, correct, durationFrames}) => {
  const frame = useCurrentFrame();
  const {height} = useVideoConfig();

  // Aday sticker'ı: genişlik height'e göre KISITLANMIŞ (proportional, bkz. görev tarifi "center
  // figures ≈ proportional") — sabit 520px 4:5'te (height küçük) üstteki soru kartıyla çakışırdı. Bu
  // yüzden mevcut dikey bant (kart altı+CARD_GAP → alt safe-zone) içine sığacak MAKSİMUM genişlik
  // hesaplanıp 520 ile min alınıyor: 9:16'da (height=1920) tam 520 çıkar (önceki sabitle birebir
  // aynı); 4:5'te (1350) otomatik küçülüp kart çakışmasını YAPISAL olarak imkansız kılar.
  const bottomSafe = height > 1700 ? theme.safeZone.bottom : 190; // 4:5'te safe-zone oranlı küçülür (bkz. görev notu ~180)
  const availableBand = height - bottomSafe - (CARD_BOTTOM + CARD_GAP);
  const suspectWidth = Math.min(520, availableBand / 1.5);

  const suspectBottom = height - bottomSafe;
  const suspectY = suspectBottom - 0.49 * suspectWidth; // CollageSticker sözleşmesi: top=y-width, bottom≈y+0.49*width (2:3 asset)
  const suspectTop = suspectY - suspectWidth;
  const suspectVisibleHeight = suspectWidth * 1.5;

  // Hayalete dönüşüm ankraj noktası: adayın gövde/göğüs hizası (baş-omuzdan biraz aşağı — görünür
  // yüksekliğin %40'ı kadar aşağıda).
  const torsoY = suspectTop + suspectVisibleHeight * 0.4;
  const ghostWidth = suspectWidth * (440 / 520);
  const ghostBoxX = 540 - ghostWidth / 2;
  const ghostBoxTop = torsoY - ghostWidth / 2;

  // GHOSTLANDI damgası: kart altı ile gövde hizası arasındaki boşluğa ORANLI konumlanır — her iki
  // formatta da otomatik olarak kart ile aday/hayalet arasındaki güvenli bantta kalır.
  const stampY = CARD_BOTTOM + (torsoY - CARD_BOTTOM) * 0.35;

  // Hayalet giriş/yükseliş: SWAP_FRAME'den 1 kare önce 0 → SWAP_FRAME'de aniden 1 (poof) → GHOST_DRIFT_FRAMES
  // boyunca yükselip söner. Tek interpolate ile "SWAP_FRAME öncesi görünmez" garantisi (ayrı bir
  // frame>=SWAP_FRAME koşuluna gerek kalmadan, extrapolateLeft:'clamp' başlangıç noktasındaki 0'a sabitler).
  const ghostOpacity = interpolate(
    frame,
    [SWAP_FRAME - 1, SWAP_FRAME, SWAP_FRAME + GHOST_DRIFT_FRAMES],
    [0, 1, 0],
    {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'},
  );
  // DEVIATION (still doğrulamasıyla bulundu): height*0.55 sabit yükseliş mesafesi 4:5'te (torsoY kart
  // kartına çok daha yakın olduğu için) hayaletin BAŞININ soru kartının içine girmesine yol açıyordu —
  // f290/f500 still'lerinde doğrulandı. Çözüm: yükseliş mesafesi height'e değil, kart altı ile gövde
  // ankraj noktası arasındaki GERÇEK boşluğa göre YUKARI SINIRLANIYOR (GHOST_RISE_MARGIN payıyla) —
  // hayaletin TEPESİ hiçbir zaman kart altına (CARD_BOTTOM) ulaşmaz, format ne olursa olsun.
  const GHOST_RISE_MARGIN = 30;
  const maxGhostRise = Math.max(60, torsoY - CARD_BOTTOM - ghostWidth / 2 - GHOST_RISE_MARGIN);
  const ghostTranslateY = interpolate(frame, [SWAP_FRAME, SWAP_FRAME + GHOST_DRIFT_FRAMES], [0, -maxGhostRise], {
    extrapolateLeft: 'clamp',
    extrapolateRight: 'clamp',
  });

  return (
    <AbsoluteFill style={{overflow: 'hidden'}}>
      <BackdropPlate src="ai/bg_gece.png" zoomFrom={1} zoomTo={1.08} darken={0.4} durationInFrames={durationFrames} />

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
          {/* Aday SWAP_FRAME'de aniden kayboluyor (tearFrame'in aşağı düşme animasyonu YERİNE — aynı
              anda hayalet yukarı yükseldiği için iki zıt yönlü hareket çakışmasın diye sert kesim). */}
          <Sequence durationInFrames={SWAP_FRAME}>
            <CollageSticker src={suspectSrc} width={suspectWidth} x={540} y={suspectY} enterFrame={0} sway={false} />
          </Sequence>

          <div
            style={{
              position: 'absolute',
              inset: 0,
              transform: `translateY(${ghostTranslateY}px)`,
              opacity: ghostOpacity,
            }}
          >
            <SpriteFlip
              frames={['ai/hayalet_1.png', 'ai/hayalet_2.png']}
              x={ghostBoxX}
              y={ghostBoxTop}
              width={ghostWidth}
              frameDuration={GHOST_FRAME_DURATION}
              startFrame={SWAP_FRAME}
            />
          </div>

          <PaperShreds startFrame={SWAP_FRAME} count={14} originX={540} originY={torsoY} spread={190} />
          <EliminationStamp frame={GHOST_STAMP_FRAME} label="GHOSTLANDI" x={540} y={stampY} rotate={-9} fontSize={72} />
        </>
      ) : (
        <>
          <CollageSticker src={suspectSrc} width={suspectWidth} x={540} y={suspectY} enterFrame={0} sway={false} />

          {/* Küçük köşe damgası (InterrogationScene'in "TEMİZ" tekniğiyle aynı dil) — merkezdeki
              MatchSpark'la çakışmasın diye kartın sağ-alt köşesine biner. */}
          <EliminationStamp
            frame={SWAP_FRAME}
            label="KALDI"
            color={theme.colors.greenDark}
            x={860}
            y={CARD_BOTTOM + 10}
            rotate={9}
            fontSize={52}
          />

          {/* Kartın altı ile adayın başı arasındaki boşluğa InterrogationScene/KadikoyScene'deki
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

          {/* w5 = G1'in marka kadını — soldan süzülerek eşleşme anına katılır. Genişlik suspectWidth'e
              ORANTILI (küçük ikincil figür) ki 4:5'te de kart/aday ile çakışmasın. */}
          <CollageSticker
            src="ai/w5.png"
            width={suspectWidth * 0.7}
            x={230}
            y={suspectBottom - 0.49 * suspectWidth * 0.7}
            enterFrame={W5_ENTER_FRAME}
            enter="drift"
            baseRotate={-2}
          />
        </>
      )}
    </AbsoluteFill>
  );
};
