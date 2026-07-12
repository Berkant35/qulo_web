import {AbsoluteFill, Audio, Sequence, staticFile} from 'remotion';
import {theme} from './theme';
import type {ReelsConfig, SceneSpec} from './types';
import {S1Hook} from './scenes/S1Hook';
import {S2Rules} from './scenes/S2Rules';
import {S3Elimination} from './scenes/S3Elimination';
import {S4Match} from './scenes/S4Match';
import {S5Closing} from './scenes/S5Closing';
import {KaosRain} from './scenes/KaosRain';
import {KaosSweep} from './scenes/KaosSweep';
import {MatchRecap} from './scenes/MatchRecap';
import {PayoffScene} from './scenes/PayoffScene';

const renderScene = (scene: SceneSpec, idx: number) => {
  // scene.props tipi Record<string, unknown> — sahne bileşenlerine spread edilirken
  // burada sınırlı olarak 'any'e cast edilir; her sahne kendi opsiyonel prop tipini tanımlar.
  const props = (scene.props ?? {}) as any;
  switch (scene.component) {
    case 'S1Hook':
      return <S1Hook {...props} />;
    case 'S2Rules':
      return <S2Rules {...props} />;
    case 'S3Elimination':
      return <S3Elimination {...props} />;
    case 'S4Match':
      return <S4Match {...props} />;
    case 'S5Closing':
      return <S5Closing {...props} />;
    case 'KaosRain':
      return <KaosRain {...props} />;
    case 'KaosSweep':
      return <KaosSweep {...props} />;
    case 'MatchRecap':
      return <MatchRecap {...props} />;
    case 'PayoffScene':
      return <PayoffScene {...props} />;
    default:
      throw new Error(`Unknown scene component at index ${idx}: ${scene.component}`);
  }
};

type Props = {
  config: ReelsConfig;
};

export const QuloReelsPlayer: React.FC<Props> = ({config}) => {
  return (
    <AbsoluteFill style={{background: theme.colors.bg}}>
      {config.scenes.map((scene, i) => (
        <Sequence
          key={`${scene.component}-${i}-${scene.startFrame}`}
          from={scene.startFrame}
          durationInFrames={scene.durationFrames}
          name={`${i + 1}. ${scene.component}`}
        >
          {renderScene(scene, i)}
        </Sequence>
      ))}

      {config.audioTracks?.map((track, i) => (
        <Sequence key={`audio-${i}`} from={track.startFrame ?? 0} name={`Audio ${i + 1}`}>
          <Audio src={staticFile(track.path)} volume={track.volume ?? 1} startFrom={track.startFrom ?? 0} />
        </Sequence>
      ))}
    </AbsoluteFill>
  );
};
