import { GLOSSARY_CONTENT } from "@/app/[locale]/glossary/_content";

/**
 * Index of glossary terms per locale, longest first.
 *
 * Why this exists: the structured content model renders text only — when the
 * advice guides were migrated off per-locale JSX their inline links became
 * prose, and none of the 14 articles or 27 term pages linked to each other.
 * That left 432 new glossary URLs reachable only from the hub and the XML
 * sitemap, with no contextual internal links pointing into them.
 *
 * Rather than hand-authoring links into 16 translations of every article, the
 * renderer links the first mention of a term it recognises. Longest term first,
 * so "green flag" wins over "flag" where both are indexed.
 */
export interface IndexedTerm {
  slug: string;
  term: string;
}

const INDEX = new Map<string, IndexedTerm[]>();

export function glossaryTerms(locale: string): IndexedTerm[] {
  const cached = INDEX.get(locale);
  if (cached) return cached;

  const terms: IndexedTerm[] = [];
  for (const [slug, localized] of Object.entries(GLOSSARY_CONTENT)) {
    const entry = localized[locale];
    // Single-word terms shorter than four characters match too much ordinary
    // prose to be safe (zh 下头, en "ick"); the hub still lists them.
    if (entry && entry.term.length >= 4) terms.push({ slug, term: entry.term });
  }
  terms.sort((a, b) => b.term.length - a.term.length);

  INDEX.set(locale, terms);
  return terms;
}

/**
 * Scripts written without spaces between words, where a letter-boundary check
 * is meaningless and a plain substring match is the correct behaviour.
 */
const UNSPACED_SCRIPTS = new Set(["ja", "zh", "ko"]);

/**
 * Does `term` occur in `text` as a standalone word?
 *
 * Uses a Unicode letter boundary rather than `\b`, which is ASCII-only and so
 * fails outright for Arabic, Russian and Hindi — the same trap that made an
 * earlier guard match "two…ten" inside the German word "Antworten".
 */
export function findTerm(text: string, term: string, locale: string): number {
  const lowerText = text.toLowerCase();
  const lowerTerm = term.toLowerCase();

  if (UNSPACED_SCRIPTS.has(locale)) return lowerText.indexOf(lowerTerm);

  let from = 0;
  for (;;) {
    const at = lowerText.indexOf(lowerTerm, from);
    if (at < 0) return -1;
    const before = text[at - 1];
    const after = text[at + term.length];
    const isLetter = (char?: string) => char !== undefined && /\p{L}/u.test(char);
    if (!isLetter(before) && !isLetter(after)) return at;
    from = at + 1;
  }
}
