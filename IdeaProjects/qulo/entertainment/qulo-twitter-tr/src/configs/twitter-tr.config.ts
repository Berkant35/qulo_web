import type {TwitterConfig} from '../types';

const FPS = 30;
const s = (seconds: number) => Math.round(seconds * FPS);

export const twitterConfig: TwitterConfig = {
  durationInFrames: s(30),
  scenes: [
    {component: 'S1ChaosCards', startFrame: s(0), durationFrames: s(4)},
    {component: 'S2Questions', startFrame: s(4), durationFrames: s(5)},
    {component: 'S3QuloReveal', startFrame: s(9), durationFrames: s(6)},
    {component: 'S4ProblemFlow', startFrame: s(15), durationFrames: s(8)},
    {component: 'Placeholder', startFrame: s(23), durationFrames: s(7), props: {label: 'sonraki sahneler'}},
  ],
};
