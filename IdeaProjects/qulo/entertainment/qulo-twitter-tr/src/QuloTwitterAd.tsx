import {AbsoluteFill, Audio, Sequence, staticFile} from 'remotion';
import {theme} from './theme';
import {twitterConfig} from './configs/twitter-tr.config';
import type {SceneSpec} from './types';
import {Placeholder} from './scenes/Placeholder';

const renderScene = (scene: SceneSpec, idx: number) => {
  const props = (scene.props ?? {}) as Record<string, never>;
  const cast = <T,>() => props as unknown as T;
  switch (scene.component) {
    case 'Placeholder':
      return <Placeholder {...cast<React.ComponentProps<typeof Placeholder>>()} />;
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
