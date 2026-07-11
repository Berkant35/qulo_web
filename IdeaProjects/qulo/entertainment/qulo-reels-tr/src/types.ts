export type {SoruSpec} from './configs/questions';

export type SceneComponent = 'S1Hook' | 'S2Rules' | 'S3Elimination' | 'S4Match' | 'S5Closing';

export type SceneSpec = {
  component: SceneComponent;
  startFrame: number;
  durationFrames: number;
  props?: Record<string, unknown>;
};

export type AudioTrack = {
  path: string;
  volume?: number;
  startFrom?: number;
  startFrame?: number;
};

export type ReelsConfig = {
  durationInFrames: number;
  scenes: SceneSpec[];
  audioTracks?: AudioTrack[];
};
