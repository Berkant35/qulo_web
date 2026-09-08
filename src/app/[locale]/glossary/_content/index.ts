import type { LocalizedGlossaryEntry } from "@/lib/constants/glossary";
import { beigeFlag } from "./beige-flag";
import { benching } from "./benching";
import { breadcrumbing } from "./breadcrumbing";
import { catfishing } from "./catfishing";
import { chatfishing } from "./chatfishing";
import { cloaking } from "./cloaking";
import { compatibility } from "./compatibility";
import { cuffingSeason } from "./cuffing-season";
import { floodlighting } from "./floodlighting";
import { fomo } from "./fomo";
import { futureFaking } from "./future-faking";
import { gaslighting } from "./gaslighting";
import { ghosting } from "./ghosting";
import { greenFlag } from "./green-flag";
import { grimKeeping } from "./grim-keeping";
import { hardballing } from "./hardballing";
import { ick } from "./ick";
import { kittenfishing } from "./kittenfishing";
import { limerence } from "./limerence";
import { loveLanguages } from "./love-languages";
import { loveBombing } from "./love-bombing";
import { match } from "./match";
import { orbiting } from "./orbiting";
import { quizDating } from "./quiz-dating";
import { redFlag } from "./red-flag";
import { romanceScam } from "./romance-scam";
import { rizz } from "./rizz";
import { situationship } from "./situationship";
import { slowDating } from "./slow-dating";
import { softLaunch } from "./soft-launch";
import { swipeFatigue } from "./swipe-fatigue";
import { talkingStage } from "./talking-stage";
import { zombieing } from "./zombieing";

/**
 * Term bodies keyed by slug. Every entry in `GLOSSARY_TERMS` needs one, and
 * every one of those must carry all 16 locales — `scripts/verify-glossary.mjs`
 * fails the build otherwise.
 */
export const GLOSSARY_CONTENT: Record<string, LocalizedGlossaryEntry> = {
  "beige-flag": beigeFlag,
  "benching": benching,
  "breadcrumbing": breadcrumbing,
  "catfishing": catfishing,
  "chatfishing": chatfishing,
  "cloaking": cloaking,
  "compatibility": compatibility,
  "cuffing-season": cuffingSeason,
  "floodlighting": floodlighting,
  "fomo": fomo,
  "future-faking": futureFaking,
  gaslighting,
  "ghosting": ghosting,
  "green-flag": greenFlag,
  "grim-keeping": grimKeeping,
  "hardballing": hardballing,
  "ick": ick,
  "kittenfishing": kittenfishing,
  "limerence": limerence,
  "love-bombing": loveBombing,
  "love-languages": loveLanguages,
  "match": match,
  "orbiting": orbiting,
  "quiz-dating": quizDating,
  "red-flag": redFlag,
  "romance-scam": romanceScam,
  "rizz": rizz,
  "situationship": situationship,
  "slow-dating": slowDating,
  "soft-launch": softLaunch,
  "swipe-fatigue": swipeFatigue,
  "talking-stage": talkingStage,
  "zombieing": zombieing,
};
