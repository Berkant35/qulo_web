import {AbsoluteFill, Audio, Sequence, staticFile} from 'remotion';
import {theme} from './theme';
import {reelsConfig} from './configs/reels-tr.config';
import type {SceneSpec} from './types';
import {S1Hook} from './scenes/S1Hook';
import {S2Rules} from './scenes/S2Rules';
import {S3Elimination} from './scenes/S3Elimination';
import {S4Match} from './scenes/S4Match';
import {S5Closing} from './scenes/S5Closing';

const renderScene = (scene: SceneSpec, idx: number) => {
  switch (scene.component) {
    case 'S1Hook':
      return <S1Hook />;
    case 'S2Rules':
      return <S2Rules />;
    case 'S3Elimination':
      return <S3Elimination />;
    case 'S4Match':
      return <S4Match />;
    case 'S5Closing':
      return <S5Closing />;
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
