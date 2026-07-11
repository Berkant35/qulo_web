export type SceneComponent = 'Placeholder';

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
