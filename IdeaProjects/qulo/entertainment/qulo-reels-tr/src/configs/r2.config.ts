import type {ReelsConfig} from '../types';
import {SORGU_SORULARI} from './questions';

const FPS = 30;
export const s = (seconds: number) => Math.round(seconds * FPS);

// Varyant R2 "Sorgu Odası" — karakol sorgu odası: adaylar 4 şıklı ifade veriyor; kaçamak/komik şık
// ELENDİ'ye (mugshot kesiti) götürüyor, dürüst şık TEMİZ'e (eşleşme). TEK varyant burada 30sn/900f'dir
// (diğer tüm varyantlar 25sn/750f) — müzik de music_30s.mp3 (qulo-twitter-tr'den kopyalandı, git-ignored).
// Zamanlama (s(x) = x*30 kare): SorguHook 0-120, SorguKurallar 120-210, Sorgu1 210-405 (m1, ELENDİ),
// Sorgu2 405-600 (m2, ELENDİ), Sorgu3 600-780 (m3, TEMİZ), S5Closing 780-900.
// Toplam: 120+90+195+195+180+120 = 900 ✓
const HOOK_DUR = s(4);
const KURALLAR_DUR = s(3);
const SORGU1_DUR = s(6.5);
const SORGU2_DUR = s(6.5);
const SORGU3_DUR = s(6);
const CLOSING_DUR = s(4);

export const r2Config: ReelsConfig = {
  durationInFrames: s(30),
  scenes: [
    {
      component: 'SorguHook',
      startFrame: s(0),
      durationFrames: HOOK_DUR,
      props: {
        durationFrames: HOOK_DUR,
      },
    },
    {
      component: 'SorguKurallar',
      startFrame: s(4),
      durationFrames: KURALLAR_DUR,
      props: {
        durationFrames: KURALLAR_DUR,
      },
    },
    {
      component: 'InterrogationScene',
      startFrame: s(7),
      durationFrames: SORGU1_DUR,
      props: {
        suspectSrc: 'ai/m1.png',
        sorgu: SORGU_SORULARI[0],
        eliminated: true,
        durationFrames: SORGU1_DUR,
      },
    },
    {
      component: 'InterrogationScene',
      startFrame: s(13.5),
      durationFrames: SORGU2_DUR,
      props: {
        suspectSrc: 'ai/m2.png',
        sorgu: SORGU_SORULARI[1],
        eliminated: true,
        durationFrames: SORGU2_DUR,
      },
    },
    {
      component: 'InterrogationScene',
      startFrame: s(20),
      durationFrames: SORGU3_DUR,
      props: {
        suspectSrc: 'ai/m3.png',
        sorgu: SORGU_SORULARI[2],
        eliminated: false,
        durationFrames: SORGU3_DUR,
      },
    },
    {
      component: 'S5Closing',
      startFrame: s(26),
      durationFrames: CLOSING_DUR,
      props: {
        topLine: 'Yalanı olan giremez.',
      },
    },
  ],
  audioTracks: [{path: 'audio/music_30s.mp3', volume: 0.65, startFrame: 0}],
};
