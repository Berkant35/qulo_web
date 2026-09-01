import {AbsoluteFill, Sequence, interpolate, useCurrentFrame, useVideoConfig} from 'remotion';
import type {SoruSpec} from '../configs/questions';
import {theme} from '../theme';
import {BackdropPlate} from '../components/BackdropPlate';
import {CollageSticker} from '../components/CollageSticker';
import {QuestionCard} from '../components/QuestionCard';
import {EliminationStamp} from '../components/EliminationStamp';
import {MatchSpark} from '../components/MatchSpark';
import {PaperShreds} from '../components/PaperShreds';

// Varyant B1 "Kırıntı" — parametrik aday round'u: kaçamak/oyalayan cevap veren aday SWAP_FRAME'de
// KIRINTILARA UFALANIR — yoğun bir PaperShreds burst'ü etrafa saçılırken adayın kendi görselinin ikinci
// bir kopyası opacity 1→0 + hafif aşağı çöküşle (translateY +40) dağılıp kayboluyor (GhostScene'deki
// hayaletin YUKARI yükselişinin tam tersi yön — breadcrumbing temasıyla tutarlı: kişi "kırıntı"ya
// dönüşüp aşağı çöker/dağılır). Net adım atan kalır ve NET + Eşleşme! alır. YAPISAL OLARAK GhostScene
// (G1)/TanimScene (S1) ile aynı iskelet (band-fit aday genişliği, torso ankraj, köşe damgası deseni,
// zamanlama sabitleri) — tek fark "kayboluş" dilinin hayalet/sis YERİNE kırıntı-ufalanma teması olması.
// Yeni alt-seviye bileşen YOK: mevcut PaperShreds + CollageSticker'ın ikinci bir örneği yeniden kullanılıyor.
const QUESTION_ENTER = 6;
const ANSWER_FRAME = 40;
const SWAP_FRAME = 64; // yanlışsa: aday burada Sequence tarafından kesiliyor; çöken kopya da tam bu kareden devralıyor
// DEVIATION (still doğrulamasıyla bulundu — GhostScene'in GHOST_DRIFT_FRAMES ve UncertaintyFog'un
// FOG_DRIFT_FRAMES deviation'larıyla AYNI kök neden, artık G1+S1'de 2/2 doğrulanmış bir desen): görev
// tarifi "~40f" öneriyordu ama still doğrulama noktaları (f290/f500) sahne-lokal SWAP_FRAME+106'ya denk
// geliyor (G1/S1 ile birebir aynı zamanlama sabitleri kullanıldığı için) — 40 karelik kısa ömürle o anda
// çöküş TAMAMEN tamamlanmış oluyordu (sadece KIRINTI damgası kalıyordu, "suspect fading, henüz görünür"
// beklentisi karşılanmıyordu). G1/S1'in aynı noktada uyguladığı 130 çözümüyle aynı mantıkla uzatıldı:
// SWAP_FRAME+106 anında aday ~%18 opacity'de, ~33px çökmüş — "dağılıp kayboluyor, henüz görünür"
// okunuyor (düzeltilmiş f200/f290/f500/f290_45 still'lerinde doğrulandı). Çöküş MESAFESİ (+40px, "slight
// slump") görev tarifinde tilde'siz sabit bir değerdi — SÜRE uzatılsa da DEĞİŞTİRİLMEDİ, sadece daha
// yavaş/belirgin bir çöküş okunuyor.
const CRUMBLE_FADE_FRAMES = 130; // çöken kopyanın opacity 1→0 + translateY 0→40 süresi
const KIRINTI_STAMP_FRAME = 78;
const MATCH_FRAME = 76;
const W7_ENTER_FRAME = 72;

// QuestionCard sabit y=240'ta başlar (GhostScene/TanimScene ile aynı sabitler — top-anchored,
// height-göreli DEĞİL, her iki formatta da güvenli üstten konum). CARD_GAP: kart ile aday arasında
// ZORUNLU minimum boşluk (4:5'te çakışmayı yapısal olarak imkansız kılan pay — bkz. suspectWidth hesabı).
const CARD_BOTTOM = 500;
const CARD_GAP = 36;

type Props = {
  suspectSrc: string;
  soru: SoruSpec;
  correct: boolean;
  durationFrames: number;
};

export const KirintiScene: React.FC<Props> = ({suspectSrc, soru, correct, durationFrames}) => {
  const frame = useCurrentFrame();
  const {height} = useVideoConfig();

  // Aday sticker'ı: GhostScene/TanimScene'deki BAND-FIT clamp formülüyle birebir aynı — kart altı+CARD_GAP
  // → alt safe-zone arasına sığacak MAKSİMUM genişlik hesaplanıp 520 ile min alınır: 9:16'da (height=1920)
  // tam 520 çıkar, 4:5'te (1350) otomatik küçülüp kart çakışmasını YAPISAL olarak imkansız kılar.
  const bottomSafe = height > 1700 ? theme.safeZone.bottom : 190; // 4:5'te safe-zone oranlı küçülür
  const availableBand = height - bottomSafe - (CARD_BOTTOM + CARD_GAP);
  const suspectWidth = Math.min(520, availableBand / 1.5);

  const suspectBottom = height - bottomSafe;
  const suspectY = suspectBottom - 0.49 * suspectWidth; // CollageSticker sözleşmesi: top=y-width, bottom≈y+0.49*width (2:3 asset)
  const suspectTop = suspectY - suspectWidth;
  const suspectVisibleHeight = suspectWidth * 1.5;

  // Kırıntı burst ankraj noktası: adayın gövde/göğüs hizası (GhostScene'deki torsoY formülüyle birebir aynı).
  const torsoY = suspectTop + suspectVisibleHeight * 0.4;

  // KIRINTI damgası: kart altı ile gövde hizası arasındaki boşluğa ORANLI konumlanır (GhostScene'deki
  // stampY formülüyle aynı) — her iki formatta da otomatik olarak kart ile aday/kırıntı arasındaki
  // güvenli bantta kalır.
  const stampY = CARD_BOTTOM + (torsoY - CARD_BOTTOM) * 0.35;

  // Çöken kopya: SWAP_FRAME'de opacity 1'de devralıp CRUMBLE_FADE_FRAMES boyunca 0'a söner + hafifçe
  // aşağı çöker (Ghost'un yukarı yükselişinin tam tersi). extrapolateLeft:'clamp' SWAP_FRAME öncesinde
  // opacity'yi 1'de, çöküşü 0'da sabitler — o aralıkta ORİJİNAL Sequence-kesimli kopya zaten aynı
  // konumda tam opak render ediyor, iki kopyanın üst üste binmesi görsel fark yaratmaz (GhostScene'in
  // tek-interpolate yaklaşımıyla aynı mantık, bkz. o dosyadaki yorum).
  const crumbleOpacity = interpolate(frame, [SWAP_FRAME, SWAP_FRAME + CRUMBLE_FADE_FRAMES], [1, 0], {
    extrapolateLeft: 'clamp',
    extrapolateRight: 'clamp',
  });
  const crumbleSlump = interpolate(frame, [SWAP_FRAME, SWAP_FRAME + CRUMBLE_FADE_FRAMES], [0, 40], {
    extrapolateLeft: 'clamp',
    extrapolateRight: 'clamp',
  });

  return (
    <AbsoluteFill style={{overflow: 'hidden'}}>
      <BackdropPlate src="ai/bg_bekleme.png" zoomFrom={1} zoomTo={1.08} darken={0.4} durationInFrames={durationFrames} />

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
          {/* Aday SWAP_FRAME'de Sequence tarafından kesiliyor (GhostScene'deki sert kesim tekniğiyle
              aynı) — hemen ardından aşağıdaki çöken kopya devralıyor. */}
          <Sequence durationInFrames={SWAP_FRAME}>
            <CollageSticker src={suspectSrc} width={suspectWidth} x={540} y={suspectY} enterFrame={0} sway={false} />
          </Sequence>

          <div
            style={{
              position: 'absolute',
              inset: 0,
              opacity: crumbleOpacity,
              transform: `translateY(${crumbleSlump}px)`,
            }}
          >
            <CollageSticker src={suspectSrc} width={suspectWidth} x={540} y={suspectY} enterFrame={0} sway={false} />
          </div>

          <PaperShreds startFrame={SWAP_FRAME} count={30} originX={540} originY={torsoY} spread={360} />
          <EliminationStamp frame={KIRINTI_STAMP_FRAME} label="KIRINTI" x={540} y={stampY} rotate={-9} fontSize={72} />
        </>
      ) : (
        <>
          <CollageSticker src={suspectSrc} width={suspectWidth} x={540} y={suspectY} enterFrame={0} sway={false} />

          {/* Küçük köşe damgası (InterrogationScene/GhostScene/TanimScene ile aynı dil) — merkezdeki
              MatchSpark'la çakışmasın diye kartın sağ-alt köşesine biner. */}
          <EliminationStamp
            frame={SWAP_FRAME}
            label="NET"
            color={theme.colors.greenDark}
            x={860}
            y={CARD_BOTTOM + 10}
            rotate={9}
            fontSize={52}
          />

          {/* Kartın altı ile adayın başı arasındaki boşluğa GhostScene/TanimScene'deki scale-squeeze
              tekniğiyle sıkıştırılmış spark. */}
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

          {/* w7 = B1'in marka kadını — soldan süzülerek eşleşme anına katılır. Genişlik suspectWidth'e
              ORANTILI (küçük ikincil figür) ki 4:5'te de kart/aday ile çakışmasın. */}
          <CollageSticker
            src="ai/w7.png"
            width={suspectWidth * 0.7}
            x={230}
            y={suspectBottom - 0.49 * suspectWidth * 0.7}
            enterFrame={W7_ENTER_FRAME}
            enter="drift"
            baseRotate={-2}
          />
        </>
      )}
    </AbsoluteFill>
  );
};
