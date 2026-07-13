import type {ReelsConfig} from '../types';
import {SORULAR_DM} from './questions';
import type {Round} from '../scenes/S3Elimination';

const FPS = 30;
export const s = (seconds: number) => Math.round(seconds * FPS);

// Varyant P "İlgi Bombardımanı" — çekici/özgüvenli kadın yüzlerce boş DM'e boğulur; Qulo'nun soru-kapısı
// filtre olur, kontrol kadına geçer. Aynı 25sn/750f zamanlaması ve müzik parçası (reelsConfig ile paralel).
// Zamanlama (s(x) = x*30 kare): DmFlood 0-105, DmProblem 105-210, S2Rules 210-345, S3Elimination 345-585
// (240f -> varsayılan firstRoundStart=30 ile roundlar 375/445/515'te başlar, hepsi sığar), S4Match 585-660,
// S5Closing 660-750.
const dmRounds: Round[] = [
  {src: 'ai/m1.png', question: SORULAR_DM[0], correct: false},
  {src: 'ai/m2.png', question: SORULAR_DM[1], correct: false},
  {src: 'ai/m3.png', question: SORULAR_DM[2], correct: true},
];

export const pConfig: ReelsConfig = {
  durationInFrames: s(25),
  scenes: [
    {
      component: 'DmFlood',
      startFrame: s(0),
      durationFrames: s(3.5),
      props: {},
    },
    {
      component: 'DmProblem',
      startFrame: s(3.5),
      durationFrames: s(3.5),
      props: {},
    },
    {
      component: 'S2Rules',
      startFrame: s(7),
      durationFrames: s(4.5),
      props: {
        stickerSrc: 'ai/w1_point.png',
        sorular: SORULAR_DM.slice(0, 2),
        lines: ['Artık', 'kurallar *sende*.'],
      },
    },
    {
      component: 'S3Elimination',
      startFrame: s(11.5),
      durationFrames: s(8),
      props: {
        rounds: dmRounds,
        juryStickerSrc: 'ai/w1_hook.png',
      },
    },
    {
      component: 'S4Match',
      startFrame: s(19.5),
      durationFrames: s(2.5),
      props: {
        leftSrc: 'ai/w1_hook.png',
        rightSrc: 'ai/m3.png',
        confetti: true,
      },
    },
    {
      component: 'S5Closing',
      startFrame: s(22),
      durationFrames: s(3),
      props: {
        topLine: 'Görünürlüğün yükün değil, filtren olsun.',
      },
    },
  ],
  audioTracks: [
    {path: 'audio/music_25s.mp3', volume: 0.65, startFrame: 0},
  ],
};
