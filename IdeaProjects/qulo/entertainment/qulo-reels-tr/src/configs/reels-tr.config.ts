import type {ReelsConfig} from '../types';

const FPS = 30;
export const s = (seconds: number) => Math.round(seconds * FPS);

export const reelsConfig: ReelsConfig = {
  durationInFrames: s(25),
  scenes: [
    {component: 'S1Hook', startFrame: s(0), durationFrames: s(3)},
    {component: 'S2Rules', startFrame: s(3), durationFrames: s(6)},
    {component: 'S3Elimination', startFrame: s(9), durationFrames: s(8)},
    {component: 'S4Match', startFrame: s(17), durationFrames: s(5)},
    {component: 'Placeholder', startFrame: s(22), durationFrames: s(3)},
  ],
  audioTracks: [],
};
