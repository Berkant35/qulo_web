import type {ReelsConfig} from '../types';
import {KADIKOY_SORULARI} from './questions';

const FPS = 30;
export const s = (seconds: number) => Math.round(seconds * FPS);

// Varyant K2 "Kadıköy Kedileri" — Kadıköy'de yaşayan kadının jürisi mahalle kedileri; 3 aday sırayla
// dener (erko_zengin_araba, erko_kasli, italyan), kediler onaylamazsa ELENDİ (bkz. plan:
// 2026-07-12-qulo-reels-tr-variant-k2.md). 30sn/900f, müzik music_30s.mp3.
// Zamanlama (s(x) = x*30 kare): KadikoyHook 0-120, KadikoyScene1 120-330 (erko_zengin_araba, ELENDİ,
// bg_kadikoy), KadikoyScene2 330-540 (erko_kasli, ELENDİ, bg_kadikoy), KadikoyScene3 540-780 (italyan,
// EŞLEŞME, bg_moda — mekân sahile taşınır), S5Closing 780-900.
// Toplam: 120+210+210+240+120 = 900 ✓
const HOOK_DUR = s(4);
const SCENE1_DUR = s(7);
const SCENE2_DUR = s(7);
const SCENE3_DUR = s(8);
const CLOSING_DUR = s(4);

export const k2Config: ReelsConfig = {
  durationInFrames: s(30),
  scenes: [
    {
      component: 'KadikoyHook',
      startFrame: s(0),
      durationFrames: HOOK_DUR,
      props: {
        durationFrames: HOOK_DUR,
      },
    },
    {
      component: 'KadikoyScene',
      startFrame: s(4),
      durationFrames: SCENE1_DUR,
      props: {
        bg: 'ai/bg_kadikoy.png',
        suspectSrc: 'ai/erko_zengin_araba.png',
        suspectAspect: '3:4',
        suspectWidth: 700,
        soru: KADIKOY_SORULARI[0],
        correct: false,
        durationFrames: SCENE1_DUR,
      },
    },
    {
      component: 'KadikoyScene',
      startFrame: s(11),
      durationFrames: SCENE2_DUR,
      props: {
        bg: 'ai/bg_kadikoy.png',
        suspectSrc: 'ai/erko_kasli.png',
        soru: KADIKOY_SORULARI[1],
        correct: false,
        durationFrames: SCENE2_DUR,
      },
    },
    {
      component: 'KadikoyScene',
      startFrame: s(18),
      durationFrames: SCENE3_DUR,
      props: {
        bg: 'ai/bg_moda.png',
        suspectSrc: 'ai/italyan.png',
        soru: KADIKOY_SORULARI[2],
        correct: true,
        durationFrames: SCENE3_DUR,
      },
    },
    {
      component: 'S5Closing',
      startFrame: s(26),
      durationFrames: CLOSING_DUR,
      props: {
        topLine: "Kadıköy'de kedilerin onayı şart.",
      },
    },
  ],
  audioTracks: [{path: 'audio/music_30s.mp3', volume: 0.65, startFrame: 0}],
};
