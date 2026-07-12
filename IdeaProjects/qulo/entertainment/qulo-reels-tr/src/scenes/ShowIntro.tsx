import {AbsoluteFill, interpolate, spring, useCurrentFrame, useVideoConfig} from 'remotion';
import {theme} from '../theme';
import {CollageSticker} from '../components/CollageSticker';
import {StaggerText} from '../components/StaggerText';
import {PaperShreds} from '../components/PaperShreds';

// Varyant E "TV Yarışması" — retro 70'ler yarışma programı stüdyo açılışı: perde + spot ışıkları +
// "DOĞRU CEVAP KİMDE?" başlık kartı + sunucu (e_host) sahneye şap diye girer.
// Tek seferlik retro vurgu rengi — global theme'e eklenmedi, sadece bu sahneye özgü "game-show" sarısı (bkz. görev tarifi).
const RETRO_YELLOW = '#F5D061';

type Corner = {top?: number; bottom?: number; left?: number; right?: number};

const Spotlight: React.FC<{side: 'left' | 'right'; opacity: number}> = ({side, opacity}) => (
  <div
    style={{
      position: 'absolute',
      top: -260,
      [side]: -260,
      width: 900,
      height: 1500,
      background: `linear-gradient(${side === 'left' ? 128 : 232}deg, rgba(255,244,200,0.22), rgba(255,244,200,0) 58%)`,
      opacity,
      pointerEvents: 'none',
    }}
  />
);

// Başlık panelinin köşelerinde patlayan küçük 4 uçlu yıldızlar (retro game-show süsü).
const Sparkle: React.FC<{corner: Corner; size: number; scale: number}> = ({corner, size, scale}) => (
  <div style={{position: 'absolute', ...corner, width: size, height: size, transform: `scale(${scale})`}}>
    <svg width={size} height={size} viewBox="0 0 24 24">
      <path d="M12 0 L14.5 9.5 L24 12 L14.5 14.5 L12 24 L9.5 14.5 L0 12 L9.5 9.5 Z" fill={RETRO_YELLOW} />
    </svg>
  </div>
);

export const ShowIntro: React.FC = () => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();

  const glowIn = interpolate(frame, [0, 20], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const panelScale = spring({frame: frame - 8, fps, from: 0.4, to: 1, config: {damping: 12, stiffness: 170}, durationInFrames: 16});
  const panelOpacity = interpolate(frame, [8, 18], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const sparkleScale = (delay: number) =>
    spring({frame: frame - 14 - delay, fps, from: 0, to: 1, config: {damping: 9, stiffness: 220}, durationInFrames: 12});

  const titleLine = (text: string, delay: number) => {
    const t = 16 + delay;
    const opacity = interpolate(frame, [t, t + 8], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
    const y = interpolate(frame, [t, t + 10], [22, 0], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
    return (
      <div
        key={text}
        style={{
          opacity,
          transform: `translateY(${y}px)`,
          fontFamily: theme.fonts.display,
          fontWeight: 900,
          fontSize: 88,
          lineHeight: 1.06,
          letterSpacing: -1.5,
          color: RETRO_YELLOW,
          WebkitTextStroke: `3px ${theme.colors.paperInk}`,
          textShadow: `6px 6px 0 ${theme.colors.paperInk}`,
        }}
      >
        {text}
      </div>
    );
  };

  return (
    <AbsoluteFill style={{background: theme.colors.bg, overflow: 'hidden'}}>
      {/* Perde: sahne kenarlarında dokulu şerit, her şeyin arkasında (başlık/sunucu bunun üstüne biner). */}
      <CollageSticker src="ai/e_curtain.png" width={460} x={90} y={980} enterFrame={0} baseRotate={0} sway={false} />
      <CollageSticker src="ai/e_curtain.png" width={460} x={990} y={980} enterFrame={0} baseRotate={0} sway={false} flip />

      <Spotlight side="left" opacity={0.9 * glowIn} />
      <Spotlight side="right" opacity={0.9 * glowIn} />

      {/* Konfeti patlaması ikinci başlık satırının oturmasıyla eşzamanlı (frame 34) — frame 14'te tetiklenirse
          40 karelik sönümü f60 doğrulama karesinden önce bitiyordu. Orijin panelin İÇİNDE değil ÜSTÜNDEKİ
          koyu alanda (y 440 < panel top ~460): parça rengi (paper) panelle aynı olduğundan panelin üstüne
          binen kısımlar panel tarafından örtülüyor/kamufle oluyordu (still doğrulamasında görüldü). */}
      <PaperShreds startFrame={34} count={18} originX={540} originY={420} spread={300} />

      {/* Başlık kartı: retro game-show lockup, "DOĞRU CEVAP KİMDE?". */}
      <div style={{position: 'absolute', top: 660, left: '50%', transform: 'translate(-50%, -50%)'}}>
        <div
          style={{
            position: 'relative',
            transform: `rotate(-3deg) scale(${panelScale})`,
            opacity: panelOpacity,
            background: theme.colors.paper,
            borderRadius: theme.radius.xl,
            padding: '46px 64px',
            boxShadow: '0 20px 40px rgba(0,0,0,0.5)',
            display: 'flex',
            flexDirection: 'column',
            alignItems: 'center',
          }}
        >
          <Sparkle corner={{top: -26, left: -26}} size={54} scale={sparkleScale(0)} />
          <Sparkle corner={{top: -26, right: -26}} size={54} scale={sparkleScale(4)} />
          <Sparkle corner={{bottom: -26, left: -26}} size={54} scale={sparkleScale(8)} />
          <Sparkle corner={{bottom: -26, right: -26}} size={54} scale={sparkleScale(12)} />
          {titleLine('DOĞRU CEVAP', 0)}
          {titleLine('KİMDE?', 10)}
        </div>
      </div>

      {/* Tanıtım satırı — ilk taslakta y~1000 "bottom banner" olarak sunucunun gövdesinin arkasına
          denk geliyordu ve metin okunaksız bölünüyordu (still doğrulamasında görüldü). Üst boşluğa
          (perde/panel'in üstünde, henüz boş olan top-safeZone altı) taşındı — bir TV jeneriği "kicker"ı gibi
          panelden önce belirir, hiçbir elemanla çakışmaz. */}
      <div
        style={{
          position: 'absolute',
          top: 220,
          left: 0,
          width: '100%',
          display: 'flex',
          justifyContent: 'center',
          padding: `0 ${theme.safeZone.horizontal}px`,
        }}
      >
        <StaggerText
          lines={["Türkiye'nin en dürüst yarışması."]}
          startFrame={4}
          fontSize={theme.type.small + 6}
          color={theme.colors.textMuted}
        />
      </div>

      <CollageSticker src="ai/e_host.png" width={600} x={540} y={1330} enterFrame={20} baseRotate={1} />
    </AbsoluteFill>
  );
};
