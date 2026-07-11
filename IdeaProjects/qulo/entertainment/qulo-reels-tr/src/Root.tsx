import {Composition} from 'remotion';
import {QuloReelsAd} from './QuloReelsAd';
import {reelsConfig} from './configs/reels-tr.config';
import {theme} from './theme';

export const RemotionRoot: React.FC = () => {
  return (
    <Composition
      id="QuloReelsAd"
      component={QuloReelsAd}
      durationInFrames={reelsConfig.durationInFrames}
      fps={theme.composition.fps}
      width={theme.composition.width}
      height={theme.composition.height}
    />
  );
};
