import {Composition} from 'remotion';
import {QuloReelsAd} from './QuloReelsAd';
import {QuloReelsTersKose} from './QuloReelsTersKose';
import {QuloReelsKaos} from './QuloReelsKaos';
import {QuloReelsBulusma} from './QuloReelsBulusma';
import {QuloReelsSov} from './QuloReelsSov';
import {QuloReelsParti} from './QuloReelsParti';
import {QuloReelsP} from './QuloReelsP';
import {QuloReelsSorgu} from './QuloReelsSorgu';
import {QuloReelsKadikoy} from './QuloReelsKadikoy';
import {reelsConfig} from './configs/reels-tr.config';
import {terskoseConfig} from './configs/terskose.config';
import {kaosConfig} from './configs/kaos.config';
import {bulusmaConfig} from './configs/bulusma.config';
import {sovConfig} from './configs/sov.config';
import {partiConfig} from './configs/parti.config';
import {pConfig} from './configs/p.config';
import {r2Config} from './configs/r2.config';
import {k2Config} from './configs/k2.config';
import {theme} from './theme';

// Yeni varyant eklemek için: bu diziye {id, component, config} ekle (Root'un geri kalanı sabit).
// Not: her varyant kendi config'ini içeride taşır (thin wrapper), bu yüzden durationInFrames
// doğrudan ilgili config'ten okunur.
// Not: width/height opsiyonel — verilmezse theme.composition (1080×1920, 9:16) kullanılır.
// *45 varyantları = aynı composition'ın Instagram/Facebook Feed reklamı için 4:5 (1080×1350) versiyonu.
// Reels/Stories 9:16 orijinaller aynen korunur; 4:5'te alt-ankrajlı öğeler height-göreli olduğu için
// içerik alt banda otomatik toplanır (bkz. ilgili sahnelerdeki useVideoConfig().height dönüşümleri).
const compositions: {
  id: string;
  component: React.FC;
  durationInFrames: number;
  width?: number;
  height?: number;
}[] = [
  {id: 'QuloReelsAd', component: QuloReelsAd, durationInFrames: reelsConfig.durationInFrames},
  {id: 'QuloReelsAd45', component: QuloReelsAd, durationInFrames: reelsConfig.durationInFrames, width: 1080, height: 1350},
  {id: 'QuloReelsTersKose', component: QuloReelsTersKose, durationInFrames: terskoseConfig.durationInFrames},
  {id: 'QuloReelsTersKose45', component: QuloReelsTersKose, durationInFrames: terskoseConfig.durationInFrames, width: 1080, height: 1350},
  {id: 'QuloReelsKaos', component: QuloReelsKaos, durationInFrames: kaosConfig.durationInFrames},
  {id: 'QuloReelsKaos45', component: QuloReelsKaos, durationInFrames: kaosConfig.durationInFrames, width: 1080, height: 1350},
  {id: 'QuloReelsBulusma', component: QuloReelsBulusma, durationInFrames: bulusmaConfig.durationInFrames},
  {id: 'QuloReelsBulusma45', component: QuloReelsBulusma, durationInFrames: bulusmaConfig.durationInFrames, width: 1080, height: 1350},
  {id: 'QuloReelsSov', component: QuloReelsSov, durationInFrames: sovConfig.durationInFrames},
  {id: 'QuloReelsSov45', component: QuloReelsSov, durationInFrames: sovConfig.durationInFrames, width: 1080, height: 1350},
  {id: 'QuloReelsParti', component: QuloReelsParti, durationInFrames: partiConfig.durationInFrames},
  {id: 'QuloReelsParti45', component: QuloReelsParti, durationInFrames: partiConfig.durationInFrames, width: 1080, height: 1350},
  {id: 'QuloReelsP', component: QuloReelsP, durationInFrames: pConfig.durationInFrames},
  {id: 'QuloReelsP45', component: QuloReelsP, durationInFrames: pConfig.durationInFrames, width: 1080, height: 1350},
  {id: 'QuloReelsSorgu', component: QuloReelsSorgu, durationInFrames: r2Config.durationInFrames},
  {id: 'QuloReelsSorgu45', component: QuloReelsSorgu, durationInFrames: r2Config.durationInFrames, width: 1080, height: 1350},
  {id: 'QuloReelsKadikoy', component: QuloReelsKadikoy, durationInFrames: k2Config.durationInFrames},
  {id: 'QuloReelsKadikoy45', component: QuloReelsKadikoy, durationInFrames: k2Config.durationInFrames, width: 1080, height: 1350},
];

export const RemotionRoot: React.FC = () => {
  return (
    <>
      {compositions.map(({id, component, durationInFrames, width, height}) => (
        <Composition
          key={id}
          id={id}
          component={component}
          durationInFrames={durationInFrames}
          fps={theme.composition.fps}
          width={width ?? theme.composition.width}
          height={height ?? theme.composition.height}
        />
      ))}
    </>
  );
};
