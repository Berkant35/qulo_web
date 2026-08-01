import type {ReelsConfig} from '../types';
import {SORULAR_TANIM} from './questions';

const FPS = 30;
export const s = (seconds: number) => Math.round(seconds * FPS);

// Varyant S1 "Biz Neyiz?" — loş kokteyl barında situationship'ten kaçan adaylar BELİRSİZLİK SİSİ'ne
// dönüşüp kaybolur; net cevap veren kalır (bkz. plan: 2026-07-12-qulo-reels-tr-variant-s1.md).
// Araştırma dayanağı: Gen Z'nin üçte biri situationship yaşamış; bekârların ~%55'i bağlanmada karamsar
// (IJIAP; Yahoo romantic recession) → "Üçte biri" hook istatistiği.
// 30sn/900f, müzik music_30s.mp3.
// Zamanlama (s(x) = x*30 kare): TanimHook 0-120, TanimScene1 120-330 (m_kacamak, ✗ 'Etiket koymayalım',
// TANIMSIZ), TanimScene2 330-540 (m_fit, ✗ 'Arkadaşım işte', TANIMSIZ), TanimScene3 540-780 (m3, ✓
// 'Beraberiz', NET + Eşleşme!), S5Closing 780-900.
// Toplam: 120+210+210+240+120 = 900 ✓
const HOOK_DUR = s(4);
const SCENE1_DUR = s(7);
const SCENE2_DUR = s(7);
const SCENE3_DUR = s(8);
const CLOSING_DUR = s(4);

export const s1Config: ReelsConfig = {
  durationInFrames: s(30),
  scenes: [
    {
      component: 'TanimHook',
      startFrame: s(0),
      durationFrames: HOOK_DUR,
      props: {
        durationFrames: HOOK_DUR,
      },
    },
    {
      component: 'TanimScene',
      startFrame: s(4),
      durationFrames: SCENE1_DUR,
      props: {
        suspectSrc: 'ai/m_kacamak.png',
        soru: SORULAR_TANIM[0],
        correct: false,
        durationFrames: SCENE1_DUR,
      },
    },
    {
      component: 'TanimScene',
      startFrame: s(11),
      durationFrames: SCENE2_DUR,
      props: {
        suspectSrc: 'ai/m_fit.png',
        soru: SORULAR_TANIM[1],
        correct: false,
        durationFrames: SCENE2_DUR,
      },
    },
    {
      component: 'TanimScene',
      startFrame: s(18),
      durationFrames: SCENE3_DUR,
      props: {
        suspectSrc: 'ai/m3.png',
        soru: SORULAR_TANIM[2],
        correct: true,
        durationFrames: SCENE3_DUR,
      },
    },
    {
      component: 'S5Closing',
      startFrame: s(26),
      durationFrames: CLOSING_DUR,
      props: {
        topLine: 'Belirsizlik değil, net cevap.',
      },
    },
  ],
  audioTracks: [{path: 'audio/music_30s.mp3', volume: 0.65, startFrame: 0}],
};
