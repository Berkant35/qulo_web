import {AbsoluteFill, Img, interpolate, staticFile, useCurrentFrame, useVideoConfig} from 'remotion';
import type {SoruSpec} from '../configs/questions';
import {theme} from '../theme';
import {BackdropPlate} from '../components/BackdropPlate';
import {CollageSticker} from '../components/CollageSticker';
import {QuestionCard} from '../components/QuestionCard';
import {SpriteFlip} from '../components/SpriteFlip';
import {EliminationStamp} from '../components/EliminationStamp';
import {MatchSpark} from '../components/MatchSpark';
import {PaperShreds} from '../components/PaperShreds';

// Varyant AN "Anne Onayı" — parametrik aday round'u: yapısal olarak K2 "Kadıköy Kedileri" ile aynı
// (jüri reaksiyonu + aday elenmesi/onaylanması) — tek fark jürinin kedi değil ANNE olması. Zamanlama
// (sahne-lokal kare, K2/G1 ile aynı dil): soru giriş 6, cevap çipi 40, anne tepkisi 58 (SpriteFlip
// anne→anne_terlik + terlik fırlatma aynı anda başlar — bkz. görev tarifi), aday yırtılma 76 +
// kırıntı 78 + ELENDİ damgası 82; onaysa HELAL OLSUN köşe damgası da 58'de (anne anında onaylar,
// bekleyecek bir "uçuş" beat'i yok — bkz. GhostScene'in KALDI=SWAP_FRAME diliyle aynı mantık).
const QUESTION_ENTER = 6;
const ANSWER_FRAME = 40;
const REACT_FRAME = 58;
const SLIPPER_FLIGHT_FRAMES = 24;
const TEAR_FRAME = 76;
const SHRED_FRAME = 78;
const STAMP_FRAME = 82;
const HELAL_STAMP_FRAME = REACT_FRAME;
const MATCH_FRAME = 80;
const W4_ENTER_FRAME = 72;

// QuestionCard sabit y'de başlar (top-anchored — bkz. KadikoyScene/GhostScene, height-göreli DEĞİL,
// her iki formatta da üstten aynı güvenli konum) + tahmini kart yüksekliği (~254px: padding 60 + ~2
// satır soru metni + cevap çipi, bkz. GhostScene'deki aynı tahmin). CARD_GAP: kart ile figürler
// arasında ZORUNLU minimum boşluk (4:5'te çakışmayı yapısal olarak imkansız kılan pay).
const CARD_Y = 250;
const CARD_BOTTOM = CARD_Y + 254;
const CARD_GAP = 36;

// 2:3 portre oranı — anne/anne_terlik + m1/m2/erko_kasli/w4 hepsi bu oranda (bkz. görev asset tablosu).
const ASPECT_RATIO = 1.5;

type Props = {
  suspectSrc: string;
  soru: SoruSpec;
  correct: boolean;
  durationFrames: number;
};

// Terlik fırlatma: CollageSticker'ın giriş animasyonları (slap/drift) A noktasından B noktasına
// SEYAHAT desteklemiyor (sadece kendi sabit konumuna "yapışma/süzülme" biçimi var) — bu yüzden
// sahne-lokal, elle interpolate edilen bir uçuş (translate + spin + yay) burada tanımlanıyor (bkz.
// GhostHook'daki sahne-lokal GhostDrift ile aynı dil: paylaşılan bileşen YERİNE tek-seferlik efekt).
type SlipperProps = {startFrame: number; fromX: number; fromY: number; toX: number; toY: number};

const FlyingSlipper: React.FC<SlipperProps> = ({startFrame, fromX, fromY, toX, toY}) => {
  const frame = useCurrentFrame();
  const local = frame - startFrame;
  if (local < 0 || local > SLIPPER_FLIGHT_FRAMES + 6) return null;

  const progress = interpolate(local, [0, SLIPPER_FLIGHT_FRAMES], [0, 1], {
    extrapolateLeft: 'clamp',
    extrapolateRight: 'clamp',
  });
  const arc = Math.sin(progress * Math.PI) * 90; // fırlatma yayı: ortada yükselip adayın üstüne iner
  const x = fromX + (toX - fromX) * progress;
  const y = fromY + (toY - fromY) * progress - arc;
  const rotate = progress * 760; // tumbling terlik
  const opacity = interpolate(
    local,
    [0, 3, SLIPPER_FLIGHT_FRAMES - 4, SLIPPER_FLIGHT_FRAMES + 4],
    [0, 1, 1, 0],
    {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'},
  );

  return (
    <div style={{position: 'absolute', left: x - 55, top: y - 55, width: 110, transform: `rotate(${rotate}deg)`, opacity}}>
      <Img src={staticFile('ai/prop_terlik.png')} style={{width: '100%', filter: 'drop-shadow(0 12px 20px rgba(0,0,0,0.5))'}} />
    </div>
  );
};

export const AnneScene: React.FC<Props> = ({suspectSrc, soru, correct, durationFrames}) => {
  const {height} = useVideoConfig();

  // Height-göreli "zemin çizgisi" — KadikoyScene'in suspectBottomTarget formülüyle BİREBİR aynı (bkz.
  // o dosya: "height - 435"), anne + aday burada aynı çizgide dururlar (aynı odada yan yana iki figür).
  // 9:16'da (1920) 1485, 4:5'te (1350) 915 — Kadıköy still doğrulamasıyla kanıtlanmış değerler.
  const figureBottom = height - 435;

  // Kart ile zemin çizgisi arasındaki dikey bant: GhostScene'in "availableBand" tekniğiyle BİREBİR
  // aynı yaklaşım (width'i bu banda oranlı sınırla) — 4:5'te İKİ figür de otomatik küçülüp kartla
  // çakışmayı YAPISAL olarak imkansız kılar; 9:16'da bant geniş olduğu için varsayılan boyutlar aynen kalır.
  const availableBand = figureBottom - (CARD_BOTTOM + CARD_GAP);
  const suspectWidth = Math.min(460, availableBand / ASPECT_RATIO);
  const anneWidth = Math.min(300, availableBand / ASPECT_RATIO);

  const suspectHeight = suspectWidth * ASPECT_RATIO;
  const suspectTop = figureBottom - suspectHeight;
  const suspectCenterX = 760;
  // CollageSticker sözleşmesi: y = alt-çapa (top = y - width) — bkz. KadikoyScene'deki suspectY formülü.
  const suspectY = figureBottom - suspectWidth * (ASPECT_RATIO - 1);

  const anneHeight = anneWidth * ASPECT_RATIO;
  const anneCenterX = 260;
  const anneLeft = anneCenterX - anneWidth / 2;
  const anneTop = figureBottom - anneHeight; // SpriteFlip sözleşmesi: top-left doğrudan konum

  // ELENDİ damgası adayın gövdesi üstüne biner (KadikoyScene'in "stamp adayın üstünde" dilini birebir
  // uygular — o dosyada x=540/y=960 sabiti adayın gövde açıklığının ~%33'üne denk gelir; aynı oran
  // burada da kullanılıyor ki format ne olursa olsun aday gövdesinin aynı bağıl noktasına otursun).
  const stampY = suspectTop + suspectHeight * 0.33;

  // Terlik uçuşu: annenin kaldırdığı eli (üst-sağ) → adayın yüz/göğüs hizası (üst-sol).
  const slipperFromX = anneLeft + anneWidth * 0.78;
  const slipperFromY = anneTop + anneHeight * 0.28;
  const slipperToX = suspectCenterX - suspectWidth * 0.3;
  const slipperToY = suspectTop + suspectHeight * 0.32;

  // HELAL OLSUN köşe damgası: GhostScene'in "KALDI" köşe rozetiyle aynı dil (kartın hemen altına yakın,
  // küçük fontSize, hafif döndürülmüş) — kalabalık figür bandına değil kartın altındaki boşluğa biner.
  const helalX = 860;
  const helalY = CARD_BOTTOM + 10;

  // w4 (kız) sadece onay round'unda: annenin yanında/az önünde "sahneye çıkan kız" efekti — aynı zemin
  // çizgisinde, anneye oranlı küçük, JSX'te anne'den SONRA render edilir ki önde/yanında dursun.
  // CollageSticker'ın enter='drift' animasyonu kaynak dosya adına göre deterministik bir açıdan süzülür
  // (bkz. CollageSticker driftAngleDeg) — "soldan" ifadesi bu genel süzülme hissini tarif eder.
  const w4Width = anneWidth * 0.75;
  const w4CenterX = anneCenterX + anneWidth * 0.42;
  const w4Y = figureBottom - w4Width * (ASPECT_RATIO - 1);

  return (
    <AbsoluteFill style={{overflow: 'hidden'}}>
      <BackdropPlate src="ai/bg_salon.png" zoomFrom={1} zoomTo={1.08} darken={0.35} durationInFrames={durationFrames} />

      <QuestionCard
        text={soru.soru}
        x={540}
        y={CARD_Y}
        width={760}
        enterFrame={QUESTION_ENTER}
        answer={correct ? soru.dogru : soru.yanlis}
        answerTone={correct ? 'correct' : 'wrong'}
        answerFrame={ANSWER_FRAME}
      />

      <CollageSticker
        src={suspectSrc}
        width={suspectWidth}
        x={suspectCenterX}
        y={suspectY}
        enterFrame={0}
        sway={false}
        tearFrame={correct ? undefined : TEAR_FRAME}
      />

      <SpriteFlip
        frames={correct ? ['ai/anne.png'] : ['ai/anne.png', 'ai/anne_terlik.png']}
        x={anneLeft}
        y={anneTop}
        width={anneWidth}
        height={anneHeight}
        frameDuration={10}
        startFrame={REACT_FRAME}
      />

      {!correct ? (
        <>
          <FlyingSlipper startFrame={REACT_FRAME} fromX={slipperFromX} fromY={slipperFromY} toX={slipperToX} toY={slipperToY} />
          <PaperShreds
            startFrame={SHRED_FRAME}
            count={24}
            originX={suspectCenterX}
            originY={suspectTop + suspectHeight * 0.55}
            spread={360}
          />
          <PaperShreds
            startFrame={SHRED_FRAME + 6}
            count={10}
            originX={suspectCenterX + 100}
            originY={suspectTop + suspectHeight * 0.55}
            spread={230}
          />
          <EliminationStamp frame={STAMP_FRAME} x={suspectCenterX} y={stampY} />
        </>
      ) : (
        <>
          <EliminationStamp
            frame={HELAL_STAMP_FRAME}
            label="HELAL OLSUN"
            color={theme.colors.greenDark}
            x={helalX}
            y={helalY}
            rotate={8}
            fontSize={44}
          />

          {/* Kartın altı ile figürlerin başı arasındaki boşluğa KadikoyScene/GhostScene'deki
              scale-squeeze tekniğiyle sıkıştırılmış spark — başların üstünde net (bkz. görev: "clear of heads"). */}
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

          <CollageSticker
            src="ai/w4.png"
            width={w4Width}
            x={w4CenterX}
            y={w4Y}
            enterFrame={W4_ENTER_FRAME}
            enter="drift"
            baseRotate={-2}
          />
        </>
      )}
    </AbsoluteFill>
  );
};
