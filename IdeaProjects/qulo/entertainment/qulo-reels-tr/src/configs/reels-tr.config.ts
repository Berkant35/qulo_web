import type {ReelsConfig} from '../types';

const FPS = 30;
export const s = (seconds: number) => Math.round(seconds * FPS);

export const reelsConfig: ReelsConfig = {
  durationInFrames: s(25),
  scenes: [
    {component: 'Placeholder', startFrame: s(0), durationFrames: s(25)},
  ],
  audioTracks: [],
};
