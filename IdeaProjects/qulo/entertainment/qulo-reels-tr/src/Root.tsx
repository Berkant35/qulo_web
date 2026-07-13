import {Composition} from 'remotion';
import {QuloReelsAd} from './QuloReelsAd';
import {QuloReelsTersKose} from './QuloReelsTersKose';
import {QuloReelsKaos} from './QuloReelsKaos';
import {QuloReelsBulusma} from './QuloReelsBulusma';
import {QuloReelsSov} from './QuloReelsSov';
import {QuloReelsParti} from './QuloReelsParti';
import {QuloReelsP} from './QuloReelsP';
import {QuloReelsSorgu} from './QuloReelsSorgu';
import {reelsConfig} from './configs/reels-tr.config';
import {terskoseConfig} from './configs/terskose.config';
import {kaosConfig} from './configs/kaos.config';
import {bulusmaConfig} from './configs/bulusma.config';
import {sovConfig} from './configs/sov.config';
import {partiConfig} from './configs/parti.config';
import {pConfig} from './configs/p.config';
import {r2Config} from './configs/r2.config';
import {theme} from './theme';

// Yeni varyant eklemek için: bu diziye {id, component, config} ekle (Root'un geri kalanı sabit).
// Not: her varyant kendi config'ini içeride taşır (thin wrapper), bu yüzden durationInFrames
// doğrudan ilgili config'ten okunur.
const compositions = [
  {id: 'QuloReelsAd', component: QuloReelsAd, durationInFrames: reelsConfig.durationInFrames},
  {id: 'QuloReelsTersKose', component: QuloReelsTersKose, durationInFrames: terskoseConfig.durationInFrames},
  {id: 'QuloReelsKaos', component: QuloReelsKaos, durationInFrames: kaosConfig.durationInFrames},
  {id: 'QuloReelsBulusma', component: QuloReelsBulusma, durationInFrames: bulusmaConfig.durationInFrames},
  {id: 'QuloReelsSov', component: QuloReelsSov, durationInFrames: sovConfig.durationInFrames},
  {id: 'QuloReelsParti', component: QuloReelsParti, durationInFrames: partiConfig.durationInFrames},
  {id: 'QuloReelsP', component: QuloReelsP, durationInFrames: pConfig.durationInFrames},
  {id: 'QuloReelsSorgu', component: QuloReelsSorgu, durationInFrames: r2Config.durationInFrames},
];

export const RemotionRoot: React.FC = () => {
  return (
    <>
      {compositions.map(({id, component, durationInFrames}) => (
        <Composition
          key={id}
          id={id}
          component={component}
          durationInFrames={durationInFrames}
          fps={theme.composition.fps}
          width={theme.composition.width}
          height={theme.composition.height}
        />
      ))}
    </>
  );
};
