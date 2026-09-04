/**
 * Product-claim guard: the number of questions a member can write.
 *
 * The site spent months telling every visitor they write "2 to 10 questions".
 * That range is the **Premium** ceiling. The live limits come from the active
 * `economy_config_versions` row and are enforced in
 * `qulo-server/src/services/question.service.ts`:
 *
 *     free = 4   ·   Plus = 6   ·   Premium = 10   ·   minimum = 2
 *
 * So the copy quoted a paid-tier number to a free-tier reader, usually in the
 * same sentence as the word "free". The corrected form is "2 to 4, up to 10 on
 * a paid plan" — a range that names the plan is therefore allowed.
 *
 * DETECTION: this deliberately does NOT enumerate the connecting words. The
 * first version of this guard listed them ("2 to 10", "2 bis 10", …) and missed
 * fourteen of the eighteen forms actually in the repo, because every language
 * also has a bridging construction — "between 2 and 10", "2 ile 10 arasında",
 * "zwischen 2 und 10", "от 2 до 10", "2問から10問", "2개에서 10개". A guard that
 * reports green on live violations is worse than no guard, so this one matches
 * a 2 and a 10 in proximity regardless of what sits between them, plus the
 * spelled-out numerals per language.
 *
 * The MUST_MATCH / MUST_NOT_MATCH fixtures below run on every invocation. If a
 * future edit narrows the pattern, the guard fails on itself instead of quietly
 * passing.
 *
 * Run: `npm run verify:claims`
 */
import { readdirSync, readFileSync, statSync } from "node:fs";
import { join, extname } from "node:path";

const ROOTS = ["src"];
const EXTENSIONS = new Set([".ts", ".tsx", ".json"]);

/**
 * Digits 2 and 10 close together, in either order, not part of a longer number.
 *
 * The window is 12 characters because every bridging construction in the
 * sixteen languages is short — " to ", " ile ", " und ", " до ", "問から",
 * "개에서 ", " إلى " are all six characters or fewer. A wider window starts
 * flagging ordinary prose that happens to carry both numbers ("2 photos and
 * about 10 minutes"), which the fixtures below check for.
 */
const DIGITS = "(?<![0-9])(?:2(?![0-9])[^0-9]{0,12}10(?![0-9])|10(?![0-9])[^0-9]{0,12}2(?![0-9]))";

/**
 * "two … ten" spelled out, per language.
 *
 * Each numeral is fenced with a Unicode letter boundary. JavaScript's `\b` is
 * ASCII-only, which is useless for Arabic and Cyrillic and actively harmful for
 * Latin: without a fence, `two[^.!?]{0,20}ten` matches the letters "tworten"
 * *inside the German word* "Antworten", and `iki … on` fires inside "…iking
 * non". Those two bugs alone produced 75 false hits across the blog and advice
 * trees.
 *
 * The CJK numerals (二/十, 两/十, 두 개/열) are deliberately absent: ideographs
 * have no boundary to fence against and any page of Japanese or Chinese prose
 * carries them incidentally. The repo writes those ranges with digits anyway
 * ("2問から10問", "질문 2개에서 10개", "2 到 10 个问题"), which `DIGITS` covers —
 * the fixtures assert exactly that.
 */
const L = "\\p{L}";
const fence = (word) => `(?<!${L})${word}(?!${L})`;
const WORDS = [
  ["two", "ten"],
  ["iki", "on"],
  ["zwei", "zehn"],
  ["deux", "dix"],
  ["dos", "diez"],
  ["due", "dieci"],
  ["dois", "dez"],
  ["twee", "tien"],
  ["dwóch", "dziesięciu"],
  ["två", "tio"],
  ["двух", "десяти"],
  ["दो", "दस"],
].map(([a, b]) => `${fence(a)}[^.!?]{0,20}${fence(b)}`);

/**
 * Arabic is fenced on neither side: it writes conjunctions and prepositions as
 * attached prefixes, so "عشرة" appears as "وعشرة" and a left letter-fence never
 * matches. "سؤالين" ("two questions") is distinctive enough not to need one.
 */
WORDS.push("سؤالين[^.!?]{0,20}عشرة");

const RANGE = new RegExp(`${DIGITS}|${WORDS.join("|")}`, "iu");

/**
 * The claim is always about *questions*. Requiring the word on the same line is
 * what separates it from ordinary prose that happens to carry a 2 and a 10 —
 * without it the sweep returns hundreds of lines about photos, minutes and
 * dates. Every shipped language's word for question(s), plus the two the
 * product uses for a set of them.
 */
const MENTIONS_QUESTIONS =
  /question|soru|frage|pregunta|domanda|pergunta|vraag|vrage|pytan|pytań|fråg|вопрос|سؤال|أسئلة|質問|問\b|질문|问题|सवाल|प्रश्न|quiz/i;

/**
 * The corrected form names the paid tier alongside the range, so a line that
 * mentions a plan is describing the real limits rather than overstating them.
 */
const NAMES_A_PLAN =
  /premium|plus\b|paid plan|ücretli|abonelik|bezahlt|Abo\b|payant|abonnement|de pago|suscripci|a pagamento|abbonamento|pago|assinatura|betaald|abonnem|płatn|subskrypc|betald|prenumerat|платн|подписк|مدفوع|اشتراك|有料|プラン|유료|플랜|付费|会员|सशुल्क|प्लान/i;

const flagged = (line) =>
  RANGE.test(line) && MENTIONS_QUESTIONS.test(line) && !NAMES_A_PLAN.test(line);

/* ---- fixtures: the guard checks itself before it checks the repo ---- */

const MUST_MATCH = [
  "2-10 questions", "2–10 soru", "2 to 10 questions", "between 2 and 10 questions",
  "between two and ten of them", "2 ile 10 arasında soru", "zwischen 2 und 10 Fragen",
  "entre 2 et 10 questions", "entre 2 y 10 preguntas", "tra 2 e 10 domande",
  "entre 2 e 10 perguntas", "tussen de 2 en 10 vragen", "od 2 do 10 pytań",
  "mellan 2 och 10 frågor", "от 2 до 10 вопросов", "من 2 إلى 10 أسئلة",
  "بين سؤالين وعشرة", "2問から10問の質問", "질문 2개에서 10개", "2 到 10 个问题", "2 से 10 सवाल",
];

const MUST_NOT_MATCH = [
  // The corrected wording, in a few languages.
  "2 to 4 questions, up to 10 on a paid plan",
  "2 ile 4 arasında soru (ücretli planlarda 10'a kadar)",
  "2問から4問（有料プランなら最大10問）",
  // Ordinary prose that happens to carry both numbers.
  "You have 2 photos and about 10 minutes before the conversation goes cold, so make them count either way.",
  "Add 2 photos and give it 10 days.",
  "Zwischen 2 und 10 Minuten dauert ein Gespräch, das nirgendwo hinführt.",
  "Bir kafe buluşması 2 ile 10 kilometre uzakta olabilir.",
];

const selfTestFailures = [
  ...MUST_MATCH.filter((s) => !RANGE.test(s)).map((s) => `should match: ${s}`),
  ...MUST_NOT_MATCH.filter((s) => flagged(s)).map((s) => `should NOT flag: ${s}`),
];

if (selfTestFailures.length) {
  console.error(`FAIL — the guard's own fixtures do not pass (${selfTestFailures.length}):`);
  for (const failure of selfTestFailures) console.error(`  - ${failure}`);
  console.error("\nFix the pattern before trusting a green run.");
  process.exit(1);
}

/* ---- the actual sweep ---- */

const hits = [];

function walk(dir) {
  for (const name of readdirSync(dir)) {
    const path = join(dir, name);
    if (statSync(path).isDirectory()) {
      if (name === "node_modules" || name === ".next") continue;
      walk(path);
      continue;
    }
    if (!EXTENSIONS.has(extname(name))) continue;
    readFileSync(path, "utf8")
      .split("\n")
      .forEach((line, i) => {
        if (/^\s*(\*|\/\/)/.test(line)) return; // doc comments record the fix
        if (flagged(line)) {
          hits.push(`${path}:${i + 1} — ${line.trim().slice(0, 110)}`);
        }
      });
  }
}

for (const root of ROOTS) walk(root);

if (hits.length) {
  console.error(`FAIL — ${hits.length} line(s) quote a 2-to-10 question range with no plan named:`);
  for (const hit of hits) console.error(`  - ${hit}`);
  console.error('\nFree accounts cap at 4. Write "2 to 4, up to 10 on a paid plan".');
  process.exit(1);
}
console.log(`PASS — self-test ${MUST_MATCH.length + MUST_NOT_MATCH.length} fixtures, no unqualified question-count range in ${ROOTS.join(", ")}`);
