import type { ArticleBlock } from "@/components/blog/ArticleBlocks";

/**
 * Dating glossary.
 *
 * SHAPE: the registry below carries only what is language-independent (slug,
 * emoji, the internal link graph, keywords). Everything a reader sees — the
 * term as it is said in their language, the one-sentence definition and the
 * body — lives in `src/app/[locale]/glossary/_content/<slug>.ts`, one file per
 * term, with a full entry for every one of the 16 locales.
 *
 * WHY: the legacy version stored definitions for 5 locales and rendered
 * `definitions[locale] || definitions.en`, so 11 languages were served English
 * prose under a `hreflang` and a JSON-LD `inLanguage` that both promised a
 * translation. That is the same duplicate-content defect that was just closed
 * across the blog, and it is fixed here the same way: no locale falls back.
 *
 * RULES for entries:
 * - Qulo is the only dating app that may be named anywhere on this site. Other
 *   apps — and their branded features — are described generically ("swipe-based
 *   apps", "a paid boost"). This holds even in neutral or positive context.
 * - Product claims must match what the app actually does. Writing questions is
 *   not identity verification; do not imply it screens out impostors.
 * - Any external figure must name its source inline and trace to a `StatSource`
 *   in `src/lib/constants/stats.ts`. Bare percentages are not publishable.
 * - Definitions describe the term as the world uses it. The Qulo angle, where
 *   there is an honest one, belongs at the end — not inside the definition.
 */
export interface GlossaryTerm {
  slug: string;
  emoji: string;
  /** Related term slugs, rendered as internal links at the foot of the page. */
  related: string[];
  keywords: string[];
  /** Optional deeper read on the same subject, linked from the term page. */
  article?: { type: "blog" | "answers"; slug: string };
}

/** One term, in one language. */
export interface GlossaryEntry {
  /** The term as it is actually said in this language. */
  term: string;
  /**
   * Self-contained one-sentence definition. Used as the answer box, the hub
   * card, the meta description and `DefinedTerm.description`, so it has to make
   * sense with nothing around it.
   */
  summary: string;
  blocks: ArticleBlock[];
}

export type LocalizedGlossaryEntry = Record<string, GlossaryEntry>;

export const GLOSSARY_TERMS: GlossaryTerm[] = [
  {
    slug: "beige-flag",
    emoji: "🤎",
    related: ["green-flag", "red-flag", "ick"],
    keywords: ["beige flag", "beige flag meaning", "dating slang"],
  },
  {
    slug: "benching",
    emoji: "🪑",
    related: ["breadcrumbing", "orbiting", "situationship"],
    keywords: ["benching", "benching dating", "kept on the bench"],
  },
  {
    slug: "breadcrumbing",
    emoji: "🍞",
    related: ["benching", "hardballing", "ghosting"],
    keywords: ["breadcrumbing", "breadcrumbing meaning", "dating slang"],
    article: { type: "blog", slug: "the-question-deficit" },
  },
  {
    slug: "catfishing",
    emoji: "🐱",
    related: ["chatfishing", "red-flag", "ghosting"],
    keywords: ["catfishing", "fake profile", "online dating safety"],
    article: { type: "blog", slug: "online-dating-safety-tips" },
  },
  {
    slug: "chatfishing",
    emoji: "🤖",
    related: ["catfishing", "rizz", "quiz-dating"],
    keywords: ["chatfishing", "AI dating messages", "ChatGPT dating app"],
    article: { type: "blog", slug: "psychology-of-the-first-message" },
  },
  {
    slug: "cloaking",
    emoji: "🕳️",
    related: ["ghosting", "zombieing", "orbiting"],
    keywords: ["cloaking dating", "blocked and ghosted", "dating slang"],
  },
  {
    slug: "compatibility",
    emoji: "🧩",
    related: ["quiz-dating", "green-flag", "slow-dating"],
    keywords: ["compatibility", "what makes people compatible", "dating"],
    article: { type: "blog", slug: "what-actually-predicts-compatibility" },
  },
  {
    slug: "cuffing-season",
    emoji: "🧣",
    related: ["situationship", "talking-stage", "soft-launch"],
    keywords: ["cuffing season", "cuffing season meaning", "winter dating"],
  },
  {
    slug: "floodlighting",
    emoji: "🔦",
    related: ["love-bombing", "slow-dating", "talking-stage"],
    keywords: ["floodlighting", "oversharing dating", "dating trend"],
  },
  {
    slug: "fomo",
    emoji: "😰",
    related: ["swipe-fatigue", "slow-dating", "benching"],
    keywords: ["FOMO dating", "fear of missing out", "dating apps"],
    article: { type: "blog", slug: "dating-app-burnout-signs" },
  },
  {
    slug: "future-faking",
    emoji: "🔮",
    related: ["love-bombing", "red-flag", "hardballing"],
    keywords: ["future faking", "empty promises dating", "manipulation"],
  },
  {
    slug: "ghosting",
    emoji: "👻",
    related: ["cloaking", "zombieing", "orbiting"],
    keywords: ["ghosting", "ghosting meaning", "why people ghost"],
    article: { type: "blog", slug: "dating-app-burnout-signs" },
  },
  {
    slug: "green-flag",
    emoji: "🟢",
    related: ["red-flag", "beige-flag", "compatibility"],
    keywords: ["green flag", "green flags dating", "good signs"],
    article: { type: "blog", slug: "what-actually-predicts-compatibility" },
  },
  {
    slug: "hardballing",
    emoji: "🎯",
    related: ["situationship", "breadcrumbing", "talking-stage"],
    keywords: ["hardballing", "hardballing dating trend", "clear intentions"],
    article: { type: "answers", slug: "what-makes-a-good-dating-app-question" },
  },
  {
    slug: "ick",
    emoji: "😬",
    related: ["beige-flag", "red-flag", "talking-stage"],
    keywords: ["the ick", "ick meaning", "dating slang"],
  },
  {
    slug: "love-bombing",
    emoji: "💣",
    related: ["future-faking", "floodlighting", "red-flag"],
    keywords: ["love bombing", "love bombing signs", "manipulation"],
    article: { type: "blog", slug: "online-dating-safety-tips" },
  },
  {
    slug: "match",
    emoji: "💕",
    related: ["quiz-dating", "compatibility", "talking-stage"],
    keywords: ["match", "dating app match", "what is a match"],
    article: { type: "answers", slug: "how-question-based-matching-works" },
  },
  {
    slug: "orbiting",
    emoji: "🛰️",
    related: ["ghosting", "benching", "zombieing"],
    keywords: ["orbiting", "orbiting dating", "watching stories after ghosting"],
  },
  {
    slug: "quiz-dating",
    emoji: "❓",
    related: ["match", "compatibility", "swipe-fatigue"],
    keywords: ["quiz dating", "question based dating", "dating without swiping"],
    article: { type: "answers", slug: "how-question-based-matching-works" },
  },
  {
    slug: "red-flag",
    emoji: "🚩",
    related: ["green-flag", "beige-flag", "love-bombing"],
    keywords: ["red flag", "red flags dating", "warning signs"],
    article: { type: "blog", slug: "online-dating-safety-tips" },
  },
  {
    slug: "rizz",
    emoji: "😎",
    related: ["talking-stage", "chatfishing", "ick"],
    keywords: ["rizz", "rizz meaning", "charisma dating slang"],
    article: { type: "blog", slug: "psychology-of-the-first-message" },
  },
  {
    slug: "situationship",
    emoji: "🤷",
    related: ["hardballing", "talking-stage", "cuffing-season"],
    keywords: ["situationship", "situationship meaning", "undefined relationship"],
  },
  {
    slug: "slow-dating",
    emoji: "🐌",
    related: ["swipe-fatigue", "compatibility", "quiz-dating"],
    keywords: ["slow dating", "intentional dating", "dating slowly"],
    article: { type: "blog", slug: "dating-apps-without-swiping" },
  },
  {
    slug: "soft-launch",
    emoji: "🌗",
    related: ["situationship", "talking-stage", "cuffing-season"],
    keywords: ["soft launch relationship", "hard launch", "social media dating"],
  },
  {
    slug: "swipe-fatigue",
    emoji: "😩",
    related: ["slow-dating", "quiz-dating", "fomo"],
    keywords: ["swipe fatigue", "dating app burnout", "tired of swiping"],
    article: { type: "blog", slug: "what-is-swipe-fatigue" },
  },
  {
    slug: "talking-stage",
    emoji: "💬",
    related: ["situationship", "rizz", "hardballing"],
    keywords: ["talking stage", "talking stage meaning", "before dating"],
    article: { type: "blog", slug: "psychology-of-the-first-message" },
  },
  {
    slug: "zombieing",
    emoji: "🧟",
    related: ["ghosting", "cloaking", "orbiting"],
    keywords: ["zombieing", "zombieing dating", "ghost came back"],
  },
];

/** Terms sorted the way both the hub and the sitemap present them. */
export const SORTED_GLOSSARY_TERMS = [...GLOSSARY_TERMS].sort((a, b) =>
  a.slug.localeCompare(b.slug),
);
