import type {ReelsConfig} from '../types';
import {SORULAR_PARTI} from './questions';

const FPS = 30;
export const s = (seconds: number) => Math.round(seconds * FPS);

// Varyant H "Kalabalık Yalnızlığı" — dolu bir parti, herkes telefonda → bir bakış → sorular → eşleşme.
// Aynı 25sn/750f zamanlaması ve müzik parçası (reelsConfig ile paralel).
export const partiConfig: ReelsConfig = {
  durationInFrames: s(25),
  scenes: [
    {
      component: 'PartyCrowd',
      startFrame: s(0),
      durationFrames: s(5),
      props: {},
    },
    {
      component: 'EyeContact',
      startFrame: s(5),
      durationFrames: s(5),
      props: {},
    },
    {
      component: 'S2Rules',
      startFrame: s(10),
      durationFrames: s(6),
      props: {
        stickerSrc: 'ai/h_look_w.png',
        stickerX: 240,
        stickerWidth: 500,
        sorular: SORULAR_PARTI,
        lines: ['Önce', 'sorularımı *geç*.'],
      },
    },
    {
      component: 'S4Match',
      startFrame: s(16),
      durationFrames: s(5),
      props: {
        leftSrc: 'ai/h_look_w.png',
        rightSrc: 'ai/h_look_m.png',
        confetti: true,
      },
    },
    {
      component: 'S5Closing',
      startFrame: s(21),
      durationFrames: s(4),
      props: {
        topLine: 'Kalabalıkta değil, doğru soruda tanışırsınız.',
      },
    },
  ],
  audioTracks: [
    {path: 'audio/music_25s.mp3', volume: 0.65, startFrame: 0},
  ],
};
