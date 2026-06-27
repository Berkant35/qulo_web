import type {TwitterConfig} from '../types';

const FPS = 30;
const s = (seconds: number) => Math.round(seconds * FPS);

export const twitterConfig: TwitterConfig = {
  durationInFrames: s(30),
  scenes: [
    {component: 'Placeholder', startFrame: s(0), durationFrames: s(30), props: {label: 'Qulo Twitter Ad — iskelet'}},
  ],
};
