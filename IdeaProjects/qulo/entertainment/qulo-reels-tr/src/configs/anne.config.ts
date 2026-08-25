import type {ReelsConfig} from '../types';
import {SORULAR_ANNE} from './questions';

const FPS = 30;
export const s = (seconds: number) => Math.round(seconds * FPS);

// Varyant AN "Anne Onayı" — Türk annesi damat adayını süzer, jüri kedi değil ANNE (bkz. plan:
// 2026-07-12-qulo-reels-tr-variant-anne.md). Geçemeyen aday terlik yer (SpriteFlip animatik) →
// ELENDİ; geçen aday onaylanır → anne kızıyla eşleştirir. 30sn/900f, müzik music_30s.mp3.
// Zamanlama (s(x) = x*30 kare): AnneHook 0-120, AnneScene1 120-330 (m2, ✗ 'Kripto işleri', ELENDİ),
// AnneScene2 330-540 (erko_kasli, ✗ 'Genelde dışarıdayım', ELENDİ), AnneScene3 540-780 (m1, ✓ 'Asla
// üzmem', HELAL OLSUN + Eşleşme!), S5Closing 780-900.
// Toplam: 120+210+210+240+120 = 900 ✓
const HOOK_DUR = s(4);
const SCENE1_DUR = s(7);
const SCENE2_DUR = s(7);
const SCENE3_DUR = s(8);
const CLOSING_DUR = s(4);

export const anneConfig: ReelsConfig = {
  durationInFrames: s(30),
  scenes: [
    {
      component: 'AnneHook',
      startFrame: s(0),
      durationFrames: HOOK_DUR,
      props: {
        durationFrames: HOOK_DUR,
      },
    },
    {
      component: 'AnneScene',
      startFrame: s(4),
      durationFrames: SCENE1_DUR,
      props: {
        suspectSrc: 'ai/m2.png',
        soru: SORULAR_ANNE[0],
        correct: false,
        durationFrames: SCENE1_DUR,
      },
    },
    {
      component: 'AnneScene',
      startFrame: s(11),
      durationFrames: SCENE2_DUR,
      props: {
        suspectSrc: 'ai/erko_kasli.png',
        soru: SORULAR_ANNE[1],
        correct: false,
        durationFrames: SCENE2_DUR,
      },
    },
    {
      component: 'AnneScene',
      startFrame: s(18),
      durationFrames: SCENE3_DUR,
      props: {
        suspectSrc: 'ai/m1.png',
        soru: SORULAR_ANNE[2],
        correct: true,
        durationFrames: SCENE3_DUR,
      },
    },
    {
      component: 'S5Closing',
      startFrame: s(26),
      durationFrames: CLOSING_DUR,
      props: {
        topLine: 'Annenin onayı, doğru soruyla.',
      },
    },
  ],
  audioTracks: [{path: 'audio/music_30s.mp3', volume: 0.65, startFrame: 0}],
};
