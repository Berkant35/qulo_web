import type {ReelsConfig} from '../types';
import {SORULAR_ERKEK} from './questions';
import type {PropSticker} from '../scenes/S2Rules';
import type {Round} from '../scenes/S3Elimination';

const FPS = 30;
export const s = (seconds: number) => Math.round(seconds * FPS);

// Varyant A "Ters Köşe" — erkek perspektifi. Aynı 5-sahne zamanlaması ve müzik parçası (reelsConfig ile paralel).
const eliminationRounds: Round[] = [
  {src: 'ai/w2.png', question: SORULAR_ERKEK[0], correct: false},
  {src: 'ai/w3.png', question: SORULAR_ERKEK[1], correct: false},
  {src: 'ai/w1_hook.png', question: SORULAR_ERKEK[2], correct: true},
];

const rulesProps: PropSticker[] = [
  {src: 'ai/prop_plak.png', width: 190, x: 900, y: 560, rotate: 12, enterFrame: 55},
  {src: 'ai/prop_pizza.png', width: 180, x: 955, y: 1395, rotate: -14, enterFrame: 95},
];

export const terskoseConfig: ReelsConfig = {
  durationInFrames: s(25),
  scenes: [
    {
      component: 'S1Hook',
      startFrame: s(0),
      durationFrames: s(3),
      props: {
        stickerSrc: 'ai/m_hook.png',
        lines: ['Kalabalık değil,', '*doğru kişi*.'],
      },
    },
    {
      component: 'S2Rules',
      startFrame: s(3),
      durationFrames: s(6),
      props: {
        stickerSrc: 'ai/m_hook.png',
        // Erkek figürü kartların soluna çekildi — gövde (çapraz kollar) kartların arkasında kaybolmasın (koordinatör revizyonu).
        stickerX: 225,
        stickerWidth: 500,
        sorular: SORULAR_ERKEK,
        props: rulesProps,
      },
    },
    {
      component: 'S3Elimination',
      startFrame: s(9),
      durationFrames: s(8),
      props: {
        rounds: eliminationRounds,
        juryStickerSrc: 'ai/m_hook.png',
      },
    },
    {
      component: 'S4Match',
      startFrame: s(17),
      durationFrames: s(5),
      props: {
        leftSrc: 'ai/m_hook.png',
        rightSrc: 'ai/w1_hook.png',
      },
    },
    {
      component: 'S5Closing',
      startFrame: s(22),
      durationFrames: s(3),
      props: {},
    },
  ],
  audioTracks: [
    {path: 'audio/music_25s.mp3', volume: 0.65, startFrame: 0},
  ],
};
