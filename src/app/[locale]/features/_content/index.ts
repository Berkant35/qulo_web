import type { LandingContent } from "@/lib/constants/landings";
import { quizDatingApp } from "./quiz-dating-app";
import { datingWithoutSwiping } from "./dating-without-swiping";
import { personalityMatchingApp } from "./personality-matching-app";

/**
 * Body content for every /features/[slug] page, keyed by slug and then locale.
 *
 * Every entry in LANDING_PAGES needs a key here, and every key needs all 16
 * locales. There is deliberately no English fallback at the lookup site: this
 * page set previously served English to fourteen locales while hreflang and the
 * canonical URL claimed a translated page, and a silent fallback is exactly
 * what let that survive. A missing locale should surface as a 404 in the build
 * output, not as quietly wrong copy.
 */
export const LANDING_CONTENT: Record<string, Record<string, LandingContent>> = {
  "quiz-dating-app": quizDatingApp,
  "dating-without-swiping": datingWithoutSwiping,
  "personality-matching-app": personalityMatchingApp,
};
