import type {ReelsConfig} from '../types';
import {SORULAR_SOV} from './questions';
import type {Round} from '../scenes/S3Elimination';

const FPS = 30;
export const s = (seconds: number) => Math.round(seconds * FPS);

// Varyant E "Retro TV Yarışması" — 70'ler yarışma programı estetiği: stüdyo intro → keskin kurallar →
// eleme podyumu → eşleşme → kapanış. Aynı 25sn/750f zamanlaması ve müzik parçası (reelsConfig ile paralel).
const sovRounds: Round[] = [
  {src: 'ai/m1.png', question: SORULAR_SOV[0], correct: false},
  {src: 'ai/m2.png', question: SORULAR_SOV[1], correct: false},
  {src: 'ai/m3.png', question: SORULAR_SOV[2], correct: true},
];

export const sovConfig: ReelsConfig = {
  durationInFrames: s(25),
  scenes: [
    {
      component: 'ShowIntro',
      startFrame: s(0),
      durationFrames: s(4),
      props: {},
    },
    {
      component: 'S2Rules',
      startFrame: s(4),
      durationFrames: s(5),
      props: {
        stickerSrc: 'ai/e_host.png',
        stickerX: 250,
        stickerWidth: 520,
        sorular: SORULAR_SOV.slice(0, 1),
        lines: ['Kural basit:', 'Yanlış cevap = *elenirsin*.'],
      },
    },
    {
      component: 'S3Elimination',
      startFrame: s(9),
      durationFrames: s(10),
      props: {
        rounds: sovRounds,
        juryStickerSrc: 'ai/w1_hook.png',
      },
    },
    {
      component: 'S4Match',
      startFrame: s(19),
      durationFrames: s(3),
      props: {
        leftSrc: 'ai/w1_hook.png',
        rightSrc: 'ai/m3.png',
      },
    },
    {
      component: 'S5Closing',
      startFrame: s(22),
      durationFrames: s(3),
      props: {
        topLine: 'Gerçek hayatta yarışma yok. Qulo var.',
      },
    },
  ],
  audioTracks: [
    {path: 'audio/music_25s.mp3', volume: 0.65, startFrame: 0},
  ],
};
