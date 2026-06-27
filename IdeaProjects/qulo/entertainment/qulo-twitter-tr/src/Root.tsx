import {Composition} from 'remotion';
import {QuloTwitterAd} from './QuloTwitterAd';
import {twitterConfig} from './configs/twitter-tr.config';
import {theme} from './theme';

export const RemotionRoot: React.FC = () => {
  return (
    <Composition
      id="QuloTwitterAd"
      component={QuloTwitterAd}
      durationInFrames={twitterConfig.durationInFrames}
      fps={theme.composition.fps}
      width={theme.composition.width}
      height={theme.composition.height}
    />
  );
};
