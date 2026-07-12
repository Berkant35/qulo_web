import type {ReelsConfig} from '../types';
import {SORULAR} from './questions';

const FPS = 30;
export const s = (seconds: number) => Math.round(seconds * FPS);

// Varyant C "Buluşma Payoff'u" — duygusal: video 1'in sorularının gerçeğe dönüşmesi (soru kartı → çift fotoğrafı).
// Aynı 25sn/750f zamanlaması ve müzik parçası (reelsConfig ile paralel).
export const bulusmaConfig: ReelsConfig = {
  durationInFrames: s(25),
  scenes: [
    {
      component: 'MatchRecap',
      startFrame: s(0),
      durationFrames: s(4),
      props: {},
    },
    {
      component: 'PayoffScene',
      startFrame: s(4),
      durationFrames: s(5.7),
      props: {
        coupleSrc: 'ai/c_cafe.png',
        question: SORULAR[0],
        caption: 'İlk kahve.',
        shapesVariant: 'hook',
      },
    },
    {
      component: 'PayoffScene',
      startFrame: s(9.7),
      durationFrames: s(5.7),
      props: {
        coupleSrc: 'ai/c_cat.png',
        question: SORULAR[1],
        caption: 'Kedisiyle tanıştın.',
        shapesVariant: 'rules',
      },
    },
    {
      component: 'PayoffScene',
      startFrame: s(15.4),
      durationFrames: s(5.6),
      props: {
        coupleSrc: 'ai/c_walk.png',
        question: SORULAR[2],
        caption: 'O yürüyüş.',
        shapesVariant: 'match',
      },
    },
    {
      component: 'S5Closing',
      startFrame: s(21),
      durationFrames: s(4),
      props: {
        topLine: 'Doğru cevaplar buluşmaya dönüşür.',
      },
    },
  ],
  audioTracks: [
    {path: 'audio/music_25s.mp3', volume: 0.65, startFrame: 0},
  ],
};
