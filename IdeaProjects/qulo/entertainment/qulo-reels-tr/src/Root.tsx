import {Composition} from 'remotion';
import {QuloReelsAd} from './QuloReelsAd';
import {reelsConfig} from './configs/reels-tr.config';
import {theme} from './theme';

// Yeni varyant eklemek için: bu diziye {id, component, config} ekle (Root'un geri kalanı sabit).
// Not: QuloReelsAd kendi config'ini içeride taşır (thin wrapper), bu yüzden durationInFrames
// doğrudan reelsConfig'ten okunur; ileride varyantlar QuloReelsPlayer'ı config prop'uyla saracak.
const compositions = [{id: 'QuloReelsAd', component: QuloReelsAd, durationInFrames: reelsConfig.durationInFrames}];

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
