import {AbsoluteFill, Audio, Sequence, staticFile} from 'remotion';
import {theme} from './theme';
import {reelsConfig} from './configs/reels-tr.config';
import type {SceneSpec} from './types';
import {Placeholder} from './scenes/Placeholder';
import {S1Hook} from './scenes/S1Hook';

const renderScene = (scene: SceneSpec, idx: number) => {
  switch (scene.component) {
    case 'Placeholder':
      return <Placeholder />;
    case 'S1Hook':
      return <S1Hook />;
    default:
      throw new Error(`Unknown scene component at index ${idx}: ${scene.component}`);
  }
};

export const QuloReelsAd: React.FC = () => {
  return (
    <AbsoluteFill style={{background: theme.colors.bg}}>
      {reelsConfig.scenes.map((scene, i) => (
        <Sequence
          key={`${scene.component}-${i}-${scene.startFrame}`}
          from={scene.startFrame}
          durationInFrames={scene.durationFrames}
          name={`${i + 1}. ${scene.component}`}
        >
          {renderScene(scene, i)}
        </Sequence>
      ))}

      {reelsConfig.audioTracks?.map((track, i) => (
        <Sequence key={`audio-${i}`} from={track.startFrame ?? 0} name={`Audio ${i + 1}`}>
          <Audio src={staticFile(track.path)} volume={track.volume ?? 1} startFrom={track.startFrom ?? 0} />
        </Sequence>
      ))}
    </AbsoluteFill>
  );
};
