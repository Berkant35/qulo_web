import {AbsoluteFill, Audio, Sequence, staticFile} from 'remotion';
import {theme} from './theme';
import {twitterConfig} from './configs/twitter-tr.config';
import type {SceneSpec} from './types';
import {S1ChaosCards} from './scenes/S1ChaosCards';
import {S2Questions} from './scenes/S2Questions';
import {S3QuloReveal} from './scenes/S3QuloReveal';
import {S4ProblemFlow} from './scenes/S4ProblemFlow';
import {S5MatchMoment} from './scenes/S5MatchMoment';
import {S6Closing} from './scenes/S6Closing';

const renderScene = (scene: SceneSpec, idx: number) => {
  switch (scene.component) {
    case 'S1ChaosCards':
      return <S1ChaosCards />;
    case 'S2Questions':
      return <S2Questions />;
    case 'S3QuloReveal':
      return <S3QuloReveal />;
    case 'S4ProblemFlow':
      return <S4ProblemFlow />;
    case 'S5MatchMoment':
      return <S5MatchMoment />;
    case 'S6Closing':
      return <S6Closing />;
    default:
      throw new Error(`Unknown scene component at index ${idx}: ${scene.component}`);
  }
};

export const QuloTwitterAd: React.FC = () => {
  return (
    <AbsoluteFill style={{background: theme.colors.bg}}>
      {twitterConfig.scenes.map((scene, i) => (
        <Sequence
          key={`${scene.component}-${i}-${scene.startFrame}`}
          from={scene.startFrame}
          durationInFrames={scene.durationFrames}
          name={`${i + 1}. ${scene.component}`}
        >
          {renderScene(scene, i)}
        </Sequence>
      ))}

      {twitterConfig.audioTracks?.map((track, i) => (
        <Sequence key={`audio-${i}`} from={track.startFrame ?? 0} name={`Audio ${i + 1}`}>
          <Audio src={staticFile(track.path)} volume={track.volume ?? 1} startFrom={track.startFrom ?? 0} />
        </Sequence>
      ))}
    </AbsoluteFill>
  );
};
