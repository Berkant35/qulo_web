import type {ReelsConfig} from '../types';
import {SORULAR_GHOST} from './questions';

const FPS = 30;
export const s = (seconds: number) => Math.round(seconds * FPS);

// Varyant G1 "Hayalet Avı" — gece sokağında hayaletler süzülür; kadının sorularına kaçamak cevap
// verenler hayalete dönüşüp uçar, net cevap veren kalır (bkz. plan: 2026-07-12-qulo-reels-tr-variant-g1.md).
// Araştırma dayanağı: ghosting %76 (Forbes Health/Gitnux) → "5 kişiden 4'ü" hook istatistiği.
// 30sn/900f, müzik music_30s.mp3.
// Zamanlama (s(x) = x*30 kare): GhostHook 0-120, GhostScene1 120-330 (m_fit, ✗ 'Yazıyor...',
// GHOSTLANDI), GhostScene2 330-540 (m_zengin2, ✗ 'Bakarız', GHOSTLANDI), GhostScene3 540-780 (m1, ✓
// 'Konuşurum', KALDI + Eşleşme!), S5Closing 780-900.
// Toplam: 120+210+210+240+120 = 900 ✓
const HOOK_DUR = s(4);
const SCENE1_DUR = s(7);
const SCENE2_DUR = s(7);
const SCENE3_DUR = s(8);
const CLOSING_DUR = s(4);

export const g1Config: ReelsConfig = {
  durationInFrames: s(30),
  scenes: [
    {
      component: 'GhostHook',
      startFrame: s(0),
      durationFrames: HOOK_DUR,
      props: {
        durationFrames: HOOK_DUR,
      },
    },
    {
      component: 'GhostScene',
      startFrame: s(4),
      durationFrames: SCENE1_DUR,
      props: {
        suspectSrc: 'ai/m_fit.png',
        soru: SORULAR_GHOST[0],
        correct: false,
        durationFrames: SCENE1_DUR,
      },
    },
    {
      component: 'GhostScene',
      startFrame: s(11),
      durationFrames: SCENE2_DUR,
      props: {
        suspectSrc: 'ai/m_zengin2.png',
        soru: SORULAR_GHOST[1],
        correct: false,
        durationFrames: SCENE2_DUR,
      },
    },
    {
      component: 'GhostScene',
      startFrame: s(18),
      durationFrames: SCENE3_DUR,
      props: {
        suspectSrc: 'ai/m1.png',
        soru: SORULAR_GHOST[2],
        correct: true,
        durationFrames: SCENE3_DUR,
      },
    },
    {
      component: 'S5Closing',
      startFrame: s(26),
      durationFrames: CLOSING_DUR,
      props: {
        topLine: 'Hayaletlere değil, cevaplara eşleş.',
      },
    },
  ],
  audioTracks: [{path: 'audio/music_30s.mp3', volume: 0.65, startFrame: 0}],
};
