import type {ReelsConfig} from '../types';
import {SORULAR_KIRINTI} from './questions';

const FPS = 30;
export const s = (seconds: number) => Math.round(seconds * FPS);

// Varyant B1 "Kırıntı" — bekleme kafesinde kadın oyalanıyor; kaçamak/"bir ara" cevabı veren aday
// KIRINTILARA UFALANIR (bkz. plan: 2026-07-12-qulo-reels-tr-variant-b1.md).
// Araştırma dayanağı: breadcrumbing ~%35 (The Daily Star/MDPI) — duygusal olarak aç bırakıp ilgiyi
// canlı tutma, adım atmadan kırıntı bırakma → yalnızlık/çaresizlik.
// 30sn/900f, müzik music_30s.mp3.
// Zamanlama (s(x) = x*30 kare): KirintiHook 0-120, KirintiScene1 120-330 (m_hook, ✗ 'Bir ara bakarız',
// KIRINTI), KirintiScene2 330-540 (m2, ✗ 'Duruma göre', KIRINTI), KirintiScene3 540-780 (m3, ✓ 'Netçe
// evet', NET + Eşleşme!), S5Closing 780-900.
// Toplam: 120+210+210+240+120 = 900 ✓
const HOOK_DUR = s(4);
const SCENE1_DUR = s(7);
const SCENE2_DUR = s(7);
const SCENE3_DUR = s(8);
const CLOSING_DUR = s(4);

export const b1Config: ReelsConfig = {
  durationInFrames: s(30),
  scenes: [
    {
      component: 'KirintiHook',
      startFrame: s(0),
      durationFrames: HOOK_DUR,
      props: {
        durationFrames: HOOK_DUR,
      },
    },
    {
      component: 'KirintiScene',
      startFrame: s(4),
      durationFrames: SCENE1_DUR,
      props: {
        suspectSrc: 'ai/m_hook.png',
        soru: SORULAR_KIRINTI[0],
        correct: false,
        durationFrames: SCENE1_DUR,
      },
    },
    {
      component: 'KirintiScene',
      startFrame: s(11),
      durationFrames: SCENE2_DUR,
      props: {
        suspectSrc: 'ai/m2.png',
        soru: SORULAR_KIRINTI[1],
        correct: false,
        durationFrames: SCENE2_DUR,
      },
    },
    {
      component: 'KirintiScene',
      startFrame: s(18),
      durationFrames: SCENE3_DUR,
      props: {
        suspectSrc: 'ai/m3.png',
        soru: SORULAR_KIRINTI[2],
        correct: true,
        durationFrames: SCENE3_DUR,
      },
    },
    {
      component: 'S5Closing',
      startFrame: s(26),
      durationFrames: CLOSING_DUR,
      props: {
        topLine: 'Kırıntı değil, net cevap.',
      },
    },
  ],
  audioTracks: [{path: 'audio/music_30s.mp3', volume: 0.65, startFrame: 0}],
};
