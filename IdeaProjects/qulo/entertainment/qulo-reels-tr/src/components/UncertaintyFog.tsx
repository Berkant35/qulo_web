import {interpolate, useCurrentFrame} from 'remotion';
import {theme} from '../theme';
import {rnd} from './PaperShreds';

// Varyant S1 "Biz Neyiz?" — belirsizlik sisi: net cevaptan kaçıp kaybolan adayın üstüne biner (bkz.
// plan: 2026-07-12-qulo-reels-tr-variant-s1.md). GhostScene'deki (G1) "yukarı süzülüp kaybolma" dilinin
// sis/soru-işareti temalı karşılığı — hayalet sprite'ı YERİNE gri sis bulutu (radial-gradient) + yukarı
// süzülen '?' glyph'leri. Kendi başına yeterli (self-contained) katman: caller sadece ankraj noktası
// (x,y,width — adayın torso hizası, GhostScene'deki torsoY sözleşmesiyle aynı) ve başlangıç karesini
// verir; iç animasyon tamamen deterministik (rnd — Math.random/Date.now YASAK).
type Props = {
  startFrame: number;
  x: number; // yatay merkez (adayın gövde ankraj noktası)
  y: number; // dikey merkez (adayın torso'su)
  width: number; // sis/glyph dağılım alanının referans genişliği (caller suspectWidth'ten türetir)
};

const GLYPH_COUNT = 7;
// DEVIATION (still doğrulamasıyla bulundu — GhostScene'deki GHOST_DRIFT_FRAMES deviation'ıyla AYNI kök
// neden): plan metni "~45 frame" öneriyordu ama TanimScene'de SWAP_FRAME sabit 64 iken still doğrulama
// noktaları (f290/f500) sahne-lokal SWAP_FRAME+106'ya denk geliyor (G1 ile birebir aynı zamanlama
// sabitleri kullanıldığı için) — 45/34 karelik kısa ömürle o anda efekt TAMAMEN sönmüş oluyordu (sadece
// TANIMSIZ damgası kalıyordu, "fog + ? glyphs" beklentisi karşılanmıyordu). G1'in GHOST_DRIFT_FRAMES=130
// çözümüyle aynı mantıkla 130/120'ye uzatıldı: SWAP_FRAME+106 anında sis ~%15, glyph'ler ~%10-23
// opacity'de — "süzülüp kayboluyor, henüz görünür" okunuyor (düzeltilmiş f290/f500/f290_45 still'lerinde
// doğrulandı).
const FOG_DRIFT_FRAMES = 130;
const GLYPH_FADE_OUT = 120;

export const UncertaintyFog: React.FC<Props> = ({startFrame, x, y, width}) => {
  const frame = useCurrentFrame();
  const local = frame - startFrame;
  if (local < 0) return null;

  // (a) Gri sis bulutu: opacity 0→0.7→0 üstünde hafif genişleyip dağılır. Ölçek aralığı bilinçli olarak
  // DAR tutuldu (0.85→1.1) — geniş bir büyüme, kart-aday arasındaki dar boşlukta (bkz. TanimScene'deki
  // band-fit clamp'in 4:5'te bıraktığı pay) opacity hâlâ belirginken karta değebilirdi; bu aralıkta en
  // yüksek opacity (local≈14) anındaki gerçek çap her iki formatta da kart boşluğunun çok altında kalır.
  const fogOpacity = interpolate(local, [0, 14, FOG_DRIFT_FRAMES], [0, 0.7, 0], {
    extrapolateLeft: 'clamp',
    extrapolateRight: 'clamp',
  });
  const fogScale = interpolate(local, [0, FOG_DRIFT_FRAMES], [0.85, 1.1], {
    extrapolateLeft: 'clamp',
    extrapolateRight: 'clamp',
  });

  return (
    <div style={{position: 'absolute', left: x, top: y, width: 0, height: 0}}>
      <div
        style={{
          position: 'absolute',
          left: -width / 2,
          top: -width / 2,
          width,
          height: width,
          borderRadius: '50%',
          transform: `scale(${fogScale})`,
          opacity: fogOpacity,
          filter: 'blur(7px)',
          background:
            'radial-gradient(circle, rgba(180,180,180,0.85) 0%, rgba(160,160,160,0.45) 48%, rgba(160,160,160,0) 74%)',
        }}
      />

      {/* (b) 6-8 '?' glyph'i: her biri deterministik açı/mesafe/gecikmeyle yukarı süzülüp dağılır (sine
          sway). Yükseliş küçük çarpanlı (frame başına ~1.2-1.9px, GLYPH_FADE_OUT=120 karede toplam
          ~144-216px) — GhostScene'deki sabit-mesafe hayalet yükselişinin aksine (bkz. o dosyadaki
          GHOST_RISE_MARGIN deviation notu), bu mesafe TanimScene'deki band-fit clamp'in bıraktığı
          torso↔kart boşluğundan (9:16'da ~697px, 4:5'te ~290px, bkz. o dosyadaki suspectWidth hesabı)
          HER ZAMAN küçük kalır — kart çakışması riske girmez (still doğrulamasıyla teyit edildi). */}
      {Array.from({length: GLYPH_COUNT}, (_, i) => {
        const angle = rnd(i, 41) * Math.PI * 2;
        const dist = width * (0.14 + rnd(i, 43) * 0.4);
        const originX = Math.cos(angle) * dist;
        const originY = Math.sin(angle) * dist * 0.5;
        const delay = rnd(i, 45) * 12;
        const glyphLocal = Math.max(0, local - delay);
        const rise = -glyphLocal * (1.2 + rnd(i, 47) * 0.7);
        const sway = Math.sin(glyphLocal / 8 + rnd(i, 49) * 9) * 13;
        const glyphOpacity = interpolate(glyphLocal, [0, 7, GLYPH_FADE_OUT], [0, 1, 0], {
          extrapolateLeft: 'clamp',
          extrapolateRight: 'clamp',
        });
        const glyphScale = interpolate(glyphLocal, [0, 7], [0.35, 1], {
          extrapolateLeft: 'clamp',
          extrapolateRight: 'clamp',
        });
        const size = 24 + rnd(i, 51) * 20;
        const danger = i % 2 === 0;
        return (
          <div
            key={i}
            style={{
              position: 'absolute',
              left: originX + sway - size / 2,
              top: originY + rise - size / 2,
              width: size,
              fontFamily: theme.fonts.display,
              fontWeight: 800,
              fontSize: size,
              lineHeight: 1,
              textAlign: 'center',
              color: danger ? theme.colors.danger : theme.colors.textMuted,
              opacity: glyphOpacity,
              transform: `scale(${glyphScale})`,
              textShadow: '0 4px 12px rgba(0,0,0,0.55)',
            }}
          >
            ?
          </div>
        );
      })}
    </div>
  );
};
