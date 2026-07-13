import {AbsoluteFill, interpolate, useCurrentFrame} from 'remotion';
import {theme} from '../theme';
import type {SorguSoru} from '../configs/questions';
import {BackdropPlate, LightSwing} from '../components/BackdropPlate';
import {CollageSticker} from '../components/CollageSticker';
import {OptionsCard} from '../components/OptionsCard';
import {EliminationStamp} from '../components/EliminationStamp';
import {MatchSpark} from '../components/MatchSpark';

// Varyant R2 "Sorgu Odası" — parametrik sorgu round'u. Zamanlama (sahne-lokal kare): kart giriş 6,
// soru typewriter 8-28, şıklar pop 34/40/46/52 (bkz. OptionsCard iç ofsetleri), seçim vurgusu ~70,
// karar ~86. Elendiyse sceneEnd-35'te mugshot kesitine sert kesim (hard cut); temizse karar anından
// kısa süre sonra yeşil 'TEMİZ' damgası + mini MatchSpark birlikte patlar (sceneEnd'e kadar sürer —
// scene süresine bağlı "son X kare" yerine karara bağlı ofset: still doğrulaması karar+spark'ı aynı
// karede görmeyi bekliyor).
const PICK_FRAME = 70;
const VERDICT_FRAME = 86;
const CUT_LEAD = 35;
const SPARK_DELAY_AFTER_VERDICT = 6;

type Props = {
  suspectSrc: string;
  sorgu: SorguSoru;
  eliminated: boolean;
  durationFrames: number;
  bgSorgu?: string;
  bgMugshot?: string;
};

export const InterrogationScene: React.FC<Props> = ({
  suspectSrc,
  sorgu,
  eliminated,
  durationFrames,
  bgSorgu = 'ai/bg_sorgu.png',
  bgMugshot = 'ai/bg_mugshot.png',
}) => {
  const frame = useCurrentFrame();
  const cutFrame = durationFrames - CUT_LEAD;
  const isCut = eliminated && frame >= cutFrame;

  if (isCut) {
    const local = frame - cutFrame;
    // Flaş: 2 kare tam beyaz, hızla söner. Bant: flaşın hemen ardından belirir.
    const flashOpacity = interpolate(local, [0, 2, 5], [1, 1, 0], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
    const bandOpacity = interpolate(local, [8, 14], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});

    return (
      <AbsoluteFill style={{overflow: 'hidden'}}>
        <BackdropPlate src={bgMugshot} zoomFrom={1} zoomTo={1} darken={0.3} durationInFrames={CUT_LEAD} />
        {/* width=560 -> visible bottom ≈ y + 0.49*560 (bkz. CollageSticker konum sözleşmesi). */}
        <CollageSticker src={suspectSrc} width={560} x={540} y={1380} enterFrame={cutFrame} sway={false} />
        <EliminationStamp frame={cutFrame + 6} label="ELENDİ" />
        <div
          style={{
            position: 'absolute',
            left: 0,
            bottom: theme.safeZone.bottom, // Reels alt UI güvenli bölgesi (260px)
            width: '100%',
            display: 'flex',
            justifyContent: 'center',
            opacity: bandOpacity,
          }}
        >
          <div
            style={{
              background: theme.colors.danger,
              color: theme.colors.paper,
              fontFamily: theme.fonts.display,
              fontWeight: 800,
              fontSize: theme.type.small + 6,
              letterSpacing: 2,
              padding: '14px 36px',
              borderRadius: theme.radius.pill,
            }}
          >
            İFADE: GEÇERSİZ
          </div>
        </div>
        <AbsoluteFill style={{background: '#FFFFFF', opacity: flashOpacity}} />
      </AbsoluteFill>
    );
  }

  const sparkStart = VERDICT_FRAME + SPARK_DELAY_AFTER_VERDICT;

  return (
    <AbsoluteFill style={{overflow: 'hidden'}}>
      <BackdropPlate src={bgSorgu} zoomFrom={1} zoomTo={1.08} darken={0.35} durationInFrames={durationFrames} />
      <LightSwing />
      {/* width=500 -> visible bottom ≈ y + 0.49*500 (bkz. CollageSticker konum sözleşmesi); masanın
          önünde/başında dururmuş gibi okunması için alt-orta konum. */}
      <CollageSticker src={suspectSrc} width={500} x={540} y={1400} enterFrame={0} sway={false} />
      <OptionsCard
        soru={sorgu.soru}
        siklar={sorgu.siklar}
        secimIndex={sorgu.secimIndex}
        dogruIndex={sorgu.dogruIndex}
        x={540}
        y={230}
        enterFrame={6}
        pickFrame={PICK_FRAME}
        verdictFrame={VERDICT_FRAME}
      />
      {!eliminated ? (
        <>
          {/* Küçük köşe damgası: kartın sağ-alt köşesine "İfade Tutanağı" üstüne basılmış gibi biner
              (mini — MatchSpark'ın merkez sahnesiyle çakışmasın diye). */}
          <EliminationStamp
            frame={VERDICT_FRAME}
            label="TEMİZ"
            color={theme.colors.greenDark}
            x={850}
            y={700}
            fontSize={48}
          />
          {/* Kartın altı (~735) ile şüphelinin başı (~900) arasındaki boşluğa küçültülmüş spark —
              MatchSpark'ın kendi iç yerleşimi (glow, metin kutusunun düşey ortasında absolute
              konumlanır) DEĞİŞTİRİLMEDEN sadece dıştan scale+top ile bu boşluğa sıkıştırılıyor. */}
          <div
            style={{
              position: 'absolute',
              top: 820,
              left: 0,
              width: '100%',
              display: 'flex',
              justifyContent: 'center',
              transform: 'scale(0.55)',
              transformOrigin: 'top center',
            }}
          >
            <MatchSpark startFrame={sparkStart} label="Eşleşme!" />
          </div>
        </>
      ) : null}
    </AbsoluteFill>
  );
};
