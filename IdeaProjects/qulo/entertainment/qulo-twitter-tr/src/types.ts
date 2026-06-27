export type SceneComponent =
  | 'S1ChaosCards'
  | 'S2Questions'
  | 'S3QuloReveal'
  | 'S4ProblemFlow'
  | 'S5MatchMoment'
  | 'S6Closing';

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

export type TwitterConfig = {
  durationInFrames: number;
  scenes: SceneSpec[];
  audioTracks?: AudioTrack[];
};
