import type {ReelsConfig} from '../types';
import {SORULAR} from './questions';
import type {Round} from '../scenes/S3Elimination';

const FPS = 30;
export const s = (seconds: number) => Math.round(seconds * FPS);

// Varyant B "Kaos'tan Kurala" — en yoğun kolaj varyantı: kart yağmuru (KaosRain) → süpürme (KaosSweep) →
// sıkıştırılmış mekanik akışı (2 soru, 2 round). Aynı 25sn/750f zamanlaması ve müzik parçası.
const kaosRounds: Round[] = [
  {src: 'ai/m1.png', question: SORULAR[0], correct: false},
  {src: 'ai/m3.png', question: SORULAR[1], correct: true},
];

export const kaosConfig: ReelsConfig = {
  durationInFrames: s(25),
  scenes: [
    {
      component: 'KaosRain',
      startFrame: s(0),
      durationFrames: s(4.5),
      props: {},
    },
    {
      component: 'KaosSweep',
      startFrame: s(4.5),
      durationFrames: s(2.5),
      props: {},
    },
    {
      component: 'S2Rules',
      startFrame: s(7),
      durationFrames: s(5),
      props: {
        stickerSrc: 'ai/w1_point.png',
        sorular: [...SORULAR].slice(0, 2),
        lines: ['Kurallar *sende*.', 'Cevabı sen belirle.'],
      },
    },
    {
      component: 'S3Elimination',
      startFrame: s(12),
      durationFrames: s(7),
      props: {
        rounds: kaosRounds,
        juryStickerSrc: 'ai/w1_hook.png',
        // Sahne süresi sıkıştırıldığı için round'lar varsayılan 30 yerine 16'da başlar (bkz. S3Elimination doc yorumu).
        firstRoundStart: 16,
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
        topLine: 'Kaydırma bitti. Qulo başladı.',
      },
    },
  ],
  audioTracks: [
    {path: 'audio/music_25s.mp3', volume: 0.65, startFrame: 0},
  ],
};
