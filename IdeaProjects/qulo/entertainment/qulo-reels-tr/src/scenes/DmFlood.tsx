import {AbsoluteFill} from 'remotion';
import {theme} from '../theme';
import {CollageShapes} from '../components/CollageShapes';
import {CollageSticker} from '../components/CollageSticker';
import {MessageRain} from '../components/MessageRain';
import {StaggerText} from '../components/StaggerText';

// Varyant P "İlgi Bombardımanı" — açılış: kadın telefonuna bakıyor, onlarca boş DM baloncuğu yağıyor.
// MessageRain sticker'dan ÖNCE render edilir ki kadının opak silüeti (yüzü dahil) baloncukları doğal
// olarak örtsün; şeffaf alanlardan hâlâ görünürler (bkz. CollageSticker konum sözleşmesi).
export const DmFlood: React.FC = () => {
  return (
    <AbsoluteFill style={{background: theme.colors.bg, overflow: 'hidden'}}>
      <CollageShapes variant="hook" />
      <MessageRain startFrame={0} count={26} phase="flood" />
      <CollageSticker src="ai/p_phone.png" width={600} x={540} y={1330} enterFrame={6} baseRotate={-1} enter="slap" />
      <div
        style={{
          position: 'absolute',
          top: theme.safeZone.top + 40,
          left: 0,
          width: '100%',
          display: 'flex',
          justifyContent: 'center',
          padding: `0 ${theme.safeZone.horizontal}px`,
        }}
      >
        <StaggerText
          lines={['Herkes yazıyor.', '*Kimse* tanımıyor.']}
          startFrame={12}
          fontSize={theme.type.title}
          accentColor={theme.colors.danger}
        />
      </div>
    </AbsoluteFill>
  );
};
