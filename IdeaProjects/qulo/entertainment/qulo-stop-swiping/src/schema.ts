import { VIDEO } from "./theme";

const fps = VIDEO.fps;
const sec = (s: number) => Math.round(s * fps);

export const TIMINGS = {
  shot1: { startFrame: sec(0), durationFrames: sec(3.0) },
  shot2: { startFrame: sec(3.0), durationFrames: sec(3.5) },
  pause: { startFrame: sec(6.5), durationFrames: sec(0.5) },
  shot3: { startFrame: sec(7.0), durationFrames: sec(4.0) },
  shot4: { startFrame: sec(11.0), durationFrames: sec(2.5) },
  end: { startFrame: sec(13.5), durationFrames: sec(1.5) },
} as const;

export const VO_KEYFRAMES = {
  weSwipe1: sec(0.5),
  weScroll: sec(1.5),
  weSwipe2: sec(2.5),
  theOneWeNeeded: sec(4.0),
  driftsAway: sec(6.7),
  stopSwiping: sec(11.5),
  startSolving: sec(12.5),
} as const;

export type StopSwipingAdProps = Record<string, never>;
