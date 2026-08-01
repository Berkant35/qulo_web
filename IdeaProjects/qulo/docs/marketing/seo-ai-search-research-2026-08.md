# AI Search Visibility — What Actually Works (Research Report)

**Compiled:** 2026-08-01
**Scope:** Google AI Overviews / AI Mode, ChatGPT Search, Perplexity, Claude web search
**Source window:** May 2025 → July 2026 (a few older anchors where they are the only primary data)

---

## How to read this report

Every claim is tagged:

| Tag | Meaning |
|---|---|
| **[A]** | **Primary source.** The platform itself said it, in its own docs/blog. Treat as fact. |
| **[B]** | **Study finding.** Real methodology, real sample, published. Usually **correlational** — read the caveats. |
| **[C]** | **Speculation / hype.** Widely repeated, no traceable methodology, or contradicted by [A]. |

The single most important structural fact about this topic: **the SEO industry is currently flooded with AI-generated "2026 guides" that invent precise-sounding statistics** ("134–167 word optimal passage length", "4.2× more likely to be cited", "96% of AI Overview citations come from strong E-E-A-T sources"). None of those trace to a study. Section 8 lists the ones to ignore.

---

## 0. Expectation calibration (read first)

**[B]** AI platforms drive roughly **0.15%–0.25% of total global web traffic** (Similarweb, 2026) — https://www.similarweb.com/blog/marketing/geo/gen-ai-stats/ . ChatGPT referral share of website traffic rose from ~0.23% (Apr 2026) to ~0.32% (May 2026) — https://seranking.com/blog/chatgpt-referral-traffic-may-2026/ (2026-06).

**[B]** But that traffic converts unusually well — ChatGPT referrals reported at ~7.1% conversion, second only to paid search — same Similarweb dataset.

**[B]** Crawl pressure is now real: Cloudflare put AI crawlers at **20.3% of verified bot traffic** in May 2026, plus 6.5% AI-search bots (~26.7% combined) — https://blog.cloudflare.com/ai-crawler-traffic-by-purpose-and-industry/ .

**Implication:** AI search is a *cheap-insurance* channel for a small marketing site in 2026, not a primary acquisition channel. Do the low-effort/high-durability items; do not build a dedicated "GEO program".

---

## 1. Google AI Overviews / AI Mode

### 1.1 What Google has officially said [A]

**Primary doc #1 — "AI features and your website"**
https://developers.google.com/search/docs/appearance/ai-features (last updated **2025-12-10**)

Verbatim:
- *"There are no additional requirements to appear in AI Overviews or AI Mode, nor other special optimizations necessary."*
- *"You don't need to create new machine readable files, AI text files, or markup to appear in these features."*
- *"There's also no special schema.org structured data that you need to add."*
- *"AI is built into Search and integral to how Search functions, which is why robots.txt directives for Googlebot is the control."*
- Both AI Overviews and AI Mode *"may use a 'query fan-out' technique — issuing multiple related searches across subtopics and data sources"* in order to show *"a wider and more diverse set of helpful links"*.
- Eligibility = standard Search technical requirements + **indexed + snippet-eligible**. `nosnippet`, `data-nosnippet`, `max-snippet`, `noindex` limit display.
- AI-feature traffic appears in Search Console Performance under the **"Web"** search type.

**Primary doc #2 — "Optimizing your website for generative AI features on Google Search"**
https://developers.google.com/search/docs/fundamentals/ai-optimization-guide (published **2026-05-15**, last updated **2026-07-10**)
Announcement: https://developers.google.com/search/blog/2026/05/a-new-resource-for-optimizing

This is Google's first dedicated GEO/AEO doc and it is mostly a **myth-buster**. Google explicitly tells site owners to **ignore**:
- **llms.txt / AI text files / special markup** — *"Google Search itself doesn't use them."*
- **"Chunking" content into smaller pieces for AI consumption** — Google says its systems *"understand the nuance of multiple topics on a page"*; multi-topic pages are fine.
- **Rewriting content "for AI"** — systems handle synonyms and meaning; exact-phrase matching is not needed.
- **Chasing inauthentic/fabricated brand mentions** — low value vs. quality content.
- **Structured-data obsession** — *"Structured data isn't required for generative AI search"* (still useful for general SEO).
- **Third-party tools claiming access to internal Google AI metrics** — use Search Console.

It confirms the mechanism: AI features use **RAG + query fan-out grounded in existing Search ranking systems**. There is **no separate AI index and no separate AI ranking algorithm**.

**Primary doc #3 — the original May 2025 post**
"Top ways to ensure your content performs well in Google's AI experiences on Search" — https://developers.google.com/search/blog/2025/05/succeeding-in-ai-search (2025-05). Same message: unique non-commodity content, good page experience, crawlable, internally linked, no special optimizations. *(Note: the article body would not render through my fetch tool; content confirmed via the two docs above, which supersede it.)*

**Primary doc #4 — Google-Extended**
https://developers.google.com/search/docs/crawling-indexing/google-common-crawlers (last updated **2026-07-14**): Google-Extended controls Gemini model training and grounding in Gemini Apps / Vertex AI. Verbatim: *"Google-Extended does not impact a site's inclusion in Google Search nor is it used as a ranking signal in Google Search."* → **Blocking Google-Extended does NOT remove you from AI Overviews or AI Mode.**

**Primary doc #5 — Search Console generative AI reports + opt-out (June 2026)**
https://developers.google.com/search/blog/2026/06/gen-ai-performance-reports (2026-06)
Reported by Search Engine Land (2026-06-18, Nick LeRoy — https://searchengineland.com/google-ai-opt-out-feature-competitors-480375) and ppc.land (https://ppc.land/google-finally-gives-search-console-its-own-generative-ai-visibility-reports/):
- A **separate Search Console view** for impressions in AI Overviews / AI Mode / gen-AI Discover. Data starts **2026-05-18**, no backfill. **Impressions only** — no clicks, CTR, or query data at launch. Rolling out to a subset of properties.
- A **new opt-out toggle** that removes a site from AI Overviews/AI Mode **without affecting regular Search rankings** — the first control with no organic-snippet trade-off (previously you had to use `nosnippet`, which also kills your normal snippet). Early beta, UK-first, driven by the UK CMA consultation.
- **Do not enable this.** It only removes you and lets competitors fill the slot.

### 1.2 Query fan-out — what it actually implies

**[A]** Google confirms fan-out exists and that its purpose is *diversity of links*, not depth on one page.

**[B]** Patent + architecture analysis (iPullRank, Lazarina Stoy, **2025-12-11**, https://ipullrank.com/expanding-queries-with-fanout) traces it to Google's "Thematic Search" patent (US12158907B1) and identifies eight synthetic query types: *Equivalent, Follow-up, Generalization, Specification, Canonicalization, Language Translation, Entailment, Clarification*. This is **document analysis, not measurement** — no empirical sub-query counts.

**Honest implication:** fan-out means **query coverage breadth beats page depth**. If Google decomposes "is Qulo worth it" into "Qulo pricing", "Qulo vs Tinder", "how does Qulo matching work", "Qulo reviews", "Qulo safety" — you want a *page or clearly-labelled section that is the best answer for each sub-query*. That is standard topical-cluster SEO with question-shaped URLs. It is **not** the same as "chunk your content", which Google explicitly calls a myth [A].

### 1.3 Third-party findings on AI Overview citation selection

**[B]** **Ahrefs, top-10 overlap collapse.**
- 2025-07-21 (https://ahrefs.com/blog/search-rankings-ai-citations/): 1.9M citations from 1M AI Overviews. **76.10%** of cited pages ranked in the organic top 10; 9.5% at 11–100; 14.4% not in top 100. Median position of the first citation = **2**.
- Early 2026 re-run (863k keywords, 4M AIO URLs): **38%**. Reported at https://www.searchenginejournal.com/google-ai-overview-citations-from-top-ranking-pages-drop-sharply/568637/ .
- BrightEdge (2026-02-12) reported ~**17%** with a different methodology — the two are not directly comparable.
- **Reading:** ranking well still helps enormously (it's the largest single input), but Google is increasingly pulling citations from pages that do *not* rank on page one for the head query — consistent with fan-out pulling from sub-query SERPs.

**[B]** **seoClarity:** 97% of AI Overviews cite at least one top-20 result — https://www.seoclarity.net/research/ai-overviews-impact . Also measured AI Overview prevalence on US mobile keywords up ~475% YoY (Sep 2024 → Sep 2025).

**[B]** **Zyppy / Cyrus Shepard, "23 factors" meta-analysis (2026-05-07)** — a synthesis of 54 experiments, patents and case studies scored on repeatability × evidence strength × official support. Summarized at https://ppc.land/23-factors-that-actually-get-your-content-cited-by-ai-search-engines/ . Top-scored factors (out of 10):

| Rank | Factor | Score |
|---|---|---|
| 1 | URL accessibility (crawlable, fetchable) | 9.5 |
| 2 | Search rank | 9.4 |
| 3 | Fan-out rank | 9.3 |
| 4 | Preview controls (`nosnippet`/`max-snippet` not blocking) | 9.2 |
| 5 | Query–answer match | 9.2 |
| 6 | Intent–format match | 9.0 |
| 7 | Answer near the top of the page | 8.8 |
| 8 | AI-ready structure (headings, lists, tables) | 8.6 |
| 9 | Factually specific | 8.3 |
| 10 | Explicit phrasing (no vague pronouns) | 8.1 |
| 11 | Cites sources | 8.0 |
| 12 | Self-contained passages | 8.0 |
| 13 | Content visibility (in raw HTML) | 7.6 |
| 14 | Freshness | 7.0 |
| 15 | Brand and entity trust | 6.8 |
| 16 | Content length | 6.7 |
| 18 | Entity consistency | 5.8 |
| 19 | **Structured data** | 5.6 |
| 21 | Domain authority | 5.0 |
| 23 | **llms.txt** | **2.0** |

This is the best available *synthesis* — it is a weighted expert judgement, not an experiment. But its ordering matches the primary sources: **access + rank + answer-shape at the top; schema and llms.txt at the bottom.**

---

## 2. llms.txt — verdict: **cargo cult** (for a marketing site)

### Evidence

**[A] Google — explicitly not used.**
- The AI-optimization guide (2026-05-15) lists llms.txt under tactics to ignore: *"You don't need to create new machine readable files… Google Search itself doesn't use them."* — https://developers.google.com/search/docs/fundamentals/ai-optimization-guide
- John Mueller, Reddit, reported 2026-06-02 (https://www.searchenginejournal.com/google-says-llms-txt-is-purely-speculative-for-now/577576/): *"I don't think anyone knows – it's purely speculative for now (the file has existed for years, yet none of the AI systems use it — what does it mean?)."* and *"When an AI platform that brings you clients complains that it needs the file for your site, then I'd recommend taking the time to create one."* He also said he prefers the **WebMCP** approach.
- Mueller on Bluesky, asked whether Google publishing llms.txt on some properties constituted endorsement: *"I'm tempted to say something snarky since this has come up so often, but to be direct, no."* — https://www.seroundtable.com/google-does-not-endorse-llms-txt-40789.html (site returned 403 to my fetcher; quote via SEJ/SER coverage). Google's own llms.txt files appeared because an internal CMS added support, not as a signal.

**[A] OpenAI — silent.** OpenAI's crawler docs (https://developers.openai.com/api/docs/bots) and Publishers FAQ document robots.txt, user agents and `noindex`. **llms.txt is not mentioned anywhere.**

**[A] Anthropic — the one partial exception, and it is about *developer docs*, not marketing sites.** Anthropic publishes its own llms.txt and recommends LLM-friendly flat-Markdown docs in its agent-authoring guidance. This is about **coding agents fetching API documentation in-context**, not about being cited in Claude's consumer web search.

**[B] Ahrefs adoption/usage study** (137,000 domains; data May 2026; page updated 2026-06-15) — https://ahrefs.com/blog/what-is-llms-txt/ , coverage: https://www.searchenginejournal.com/97-of-llms-txt-files-got-no-requests-ahrefs-data-shows/579478/ and https://ppc.land/llms-txt-adoption-rises-8-8x-but-97-of-files-get-zero-ai-requests/
- **28%** of monitored domains publish an llms.txt (adoption up 8.8× YoY).
- **97% of those files received ZERO requests in May 2026.** Of ~38,000 valid files, only ~1,100 got any traffic at all.
- Of the requests that did occur, ~96% were bots; **~12% were audit/scanner tools**; AI *retrieval* bots (ChatGPT, Perplexity) were **~1%**.
- **Anthropic's Claude Code was the second-biggest fetcher of llms.txt** — i.e. a coding agent reading docs, exactly the one legitimate use case.

### Verdict

| Site type | Verdict |
|---|---|
| Marketing site / blog / app landing page | **Do not bother.** Zero evidence of benefit; Google explicitly names it a non-factor. |
| Developer documentation / API reference | **Marginal, real.** Coding agents (Claude Code, Cursor, Copilot) do fetch it. |

If you build one anyway, treat it as a 15-minute vanity file with an expected value near zero. It costs nothing and it does nothing. What it must **never** do is displace effort from the items in §9.

---

## 3. Structured data / schema.org for AI

### 3.1 Current Google status by type [A]

Source: https://developers.google.com/search/docs/appearance/structured-data/search-gallery (last updated **2026-06-15**) + type-level docs.

| Type | Google rich result status (Aug 2026) | Notes |
|---|---|---|
| **Article / NewsArticle** | Supported | Still in the gallery |
| **Organization** | Supported | Knowledge-panel / entity signal |
| **WebSite** (+ SearchAction) | Supported | Sitelinks searchbox largely retired but type still used |
| **BreadcrumbList** | Supported | Live in SERP |
| **Product / Offer / Review snippet** | Supported | |
| **Software app (SoftwareApplication)** | **Still supported** — https://developers.google.com/search/docs/appearance/structured-data/software-app | Relevant for an app marketing site |
| **Speakable** | Still listed in the gallery | Limited feature, news-publisher oriented; **no evidence LLMs use it** |
| **FAQPage** | **DEPRECATED.** Notice added ~**2026-05-08**; rich result stopped showing **2026-05-07**; documentation removed **2026-06-15**; Search Console reporting/Rich Results Test removed June 2026; Search Console API data removed August 2026 | Coverage: https://www.searchenginejournal.com/google-drops-faq-rich-results-from-search/574429/ |
| **HowTo** | **DEPRECATED since 2023-09-14** (Google changelog: *"Removed the How-to structured data documentation, as this rich result is no longer shown in search results, on both desktop and mobile devices."*) | Confirms the premise in the brief |

**Both FAQPage and HowTo remain valid schema.org vocabulary.** They just produce zero Google SERP feature. Leaving existing, *accurate* markup in place is harmless; Google's guidance is that unused structured data does not hurt Search.

### 3.2 Does schema help LLM extraction? The evidence says: barely, and not causally.

**[B] Ahrefs difference-in-differences experiment — the strongest evidence available.**
"We Tracked 1,885 Pages Adding Schema. AI Citations Barely Moved." — Louise Linehan & Xibeijia Guan, **2026-05-11** — https://ahrefs.com/blog/schema-ai-citations/ (coverage: https://www.searchenginejournal.com/schema-markup-didnt-move-ai-citations-in-ahrefs-test/574568/)

- Method: 1,885 pages that **added JSON-LD** between Aug 2025 and Mar 2026, matched against ~4,000 control pages with similar pre-treatment citation levels. 30 days before vs 30 days after. Four tests: two-sample t-test, matched DiD, event study, sensitivity re-run.
- Results: **Google AI Overviews −4.6%** (statistically significant, ~1-in-2,500 by chance), **Google AI Mode +2.4%** (n.s.), **ChatGPT +2.2%** (n.s.). All four tests pointed the same way: **no citation growth**.
- The correlation it *disproved*: in a prior pass over **6 million URLs**, AI-cited pages were ~**3× more likely** to carry JSON-LD. That correlation is the one every "schema is essential for AI" blog post quotes. It does not survive a causal test.
- Ahrefs' own conclusion: *"if the only reason you're adding it is to get more AI citations on pages that are already visible, our data doesn't support that bet."*
- **Limitations (stated by the authors, and they matter):** only pages that already had **100+ AI Overview citations** — so it cannot tell you whether schema helps a page that is currently *invisible*; 30-day window; all schema types pooled; HTML-embedded JSON-LD only.

**[B] searchVIU live-fetch experiment (Michael, published 2025-12-02, test run 2025-10-30)** — https://www.searchviu.com/en/schema-markup-and-ai-in-2025-what-chatgpt-claude-perplexity-gemini-really-see/
- Built a fictional product page with a price exposed **eight different ways**: visible HTML, JS-injected, JSON-LD-only, JSON-LD+JS, hidden Microdata, visible Microdata, RDFa/JSON-LD conflict, visible RDFa. Then asked ChatGPT, Claude, Gemini, Perplexity and Google AI Mode for all prices, 10× each.
- **Zero of five systems extracted the JSON-LD-only price on direct fetch.** Hidden Microdata and hidden RDFa also universally ignored. Only *visible* markup was read.
- Extraction success: Gemini 4/8 (only system that rendered JS on live fetch), ChatGPT 3/8, Google AI Mode 2/8, Perplexity 1/8, **Claude 0/8**.
- **Limitation (author's own):** this tests the *live fetch* path only. It does not test index-time use of schema (Google/Bing do parse JSON-LD into their indexes, and AI features are grounded in those indexes).

**[A/B] The one platform that says schema helps:** Fabrice Canel (Principal PM, Microsoft Bing) stated on stage at SMX Munich (March 2025) that **schema markup helps Microsoft's LLMs understand content** for Copilot, and recommended IndexNow for freshness — https://searchengineland.com/microsoft-bing-copilot-use-schema-for-its-llms-453455 , https://www.seroundtable.com/schema-llms-copilot-bing-microsoft-39093.html . This is a verbal claim from a platform rep, not documentation, but it is the only affirmative platform statement that exists.

### 3.3 Practical rule

> **Anything you want an LLM to quote must be visible text in the server-rendered HTML.** Schema is an *index-time* signal (Google, Bing), not a *retrieval-time* one. Put the price, the feature list, the availability, the founding date in prose/tables **and** mirror it in JSON-LD — never JSON-LD alone.

Keep: `Organization`, `WebSite`, `BreadcrumbList`, `Article`, `SoftwareApplication`/`MobileApplication` (entity + Bing + knowledge-graph value, near-zero cost).
Don't add for AI reasons: `FAQPage`, `HowTo`, `Speakable`. Keep them only if they accurately describe visible content already on the page.

---

## 4. Content structure for LLM extraction

### 4.1 The one methodologically solid study

**[B] Semrush, "How We Built a Content Optimization Tool for AI Search"** — published **2026-01-14**, data collected **2025-07-15 → 2025-08-06** — https://www.semrush.com/blog/content-optimization-ai-search-study/

Method: 11,882 prompts across **ChatGPT Search, Google AI Mode, Perplexity**; 59,410 Google keywords; **304,805 LLM-cited URLs** (positive sample) vs **921,614 Google top-20 URLs** (negative sample); 337,785 unique URLs; scored on 13 content parameters. **Deliberately excluded** metadata, HTML structure, schema markup, layout and technical SEO — it measures *visible page text only*.

Differentiators between cited and merely-ranking pages:

| Parameter | Effect |
|---|---|
| Clarity & summarization | **+32.83%** |
| E-E-A-T signals | **+30.64%** |
| Q&A format | **+25.45%** |
| Section structure (clear headings/sections) | **+22.91%** |
| Structured data *elements in the text* (lists, tables, definitions) | **+21.60%** |
| Non-promotional tone | **−26.19%** |
| 7 other parameters | negligible |

Note the counter-intuitive one: **promotional tone was associated with *more* citations**, not fewer. The authors read this as professional, well-optimized commercial content simply being better written overall. This directly contradicts a very common piece of GEO advice ("strip all marketing language").

### 4.2 Freshness

**[B] Ahrefs (2025-07-28)** — 16.975M cited URLs across ChatGPT, Perplexity, Gemini, Copilot, AI Overviews + organic — https://ahrefs.com/blog/do-ai-assistants-prefer-to-cite-fresh-content/
- AI-cited pages average **1,064 days old** vs **1,432 days** for organic results → AI citations are **25.7% fresher**. Last-update gap is smaller (13.1%).
- Ranked oldest→newest: AI Overviews (1,432d, same as organic) > Perplexity (1,166) > Gemini (1,118) > Copilot (1,056) > ChatGPT (958–1,023).
- **Author's caveat:** average cited age is still **2.9 years**. AI assistants, like Search, still prefer long-lived content.

**[B] Seer Interactive (Sonny Vasquez, 2026-07-24)** — 7,683 dated pages carrying 47,097 citations, Mar–Jun 2026, ChatGPT/Gemini/Perplexity, four verticals — https://www.seerinteractive.com/insights/study-content-recencys-impact-on-ai-visibility-in-2026
- **75% of cited pages were updated in the last year**; 88% within two; >3 years old is essentially absent.
- **The update date matters more than the publish date**: by last-update 72% look fresh, by publish date only 42%. Over 25% of "fresh" cited pages were originally published 2+ years ago. Gap of +22 to +35 percentage points across verticals.
- Per engine (updated ≤1yr): Gemini 78%, ChatGPT 73%, **Perplexity 65%** (most tolerant of older reference content).
- "Always-on" pages (cited all four months) = 45% of dated citations, median 6 months old.
- **Caveats:** only ~67% of pages had readable date signals; unequal vertical samples; percentages not raw counts.

**Practical:** maintain and genuinely update a small number of durable pages; expose `dateModified` in schema, HTTP headers **and** visible text; keep sitemap `lastmod` honest. Date-stamp bumping without content change is detectable and is not the mechanism.

### 4.3 Format

**[B]** Ahrefs reports **almost no correlation between word count and AI Overview citation** across ~174,000 cited pages. Length is not the lever.

**[B]** "Best X" listicle-format pages are reported as the single most-cited page type for ChatGPT (~43.8% of cited page types). *This figure circulates widely attributed to Ahrefs but I could not locate the primary post; treat as [B-weak].* It is directionally consistent with the app-discovery data in §7, which is properly sourced.

### 4.4 What Google says about all of this [A]

Google's own guide asks for: **clear organization with headings and sections, written for humans, unique first-hand content, no scaled variations**. It explicitly rejects **chunking** and **writing for AI**. So the defensible synthesis is:

> Write a normal, well-structured, well-edited page. Put the direct answer in the first paragraph under a question-shaped heading. Use tables and lists where they're genuinely the right format. Be specific (numbers, dates, prices, named entities). Cite your sources. Update it. That's it — and it is the same advice as good SEO, which is exactly what Google says.

---

## 5. Crawler access — the complete 2026 picture

### 5.1 Reference table [A unless noted]

| User agent | Operator | Purpose | Honors robots.txt | Allow if you want citations? |
|---|---|---|---|---|
| **Googlebot** | Google | Search index — **and the grounding source for AI Overviews & AI Mode** | Yes | **Yes — mandatory** |
| **Google-Extended** | Google | Gemini model *training* + grounding in **Gemini Apps / Vertex AI** only | Yes | Optional. **Blocking it does not remove you from AI Overviews/AI Mode.** Allow if you want Gemini app grounding. |
| **Google-CloudVertexBot** | Google | Site-owner-requested Vertex AI agent builds | Yes | Irrelevant for most sites |
| **GoogleOther** | Google | Misc. product-team fetches | Yes | Allow |
| **OAI-SearchBot** | OpenAI | *"Surfaces websites in ChatGPT's search features"* | Yes | **YES — critical.** *"Sites that are opted out of OAI-SearchBot will not be shown in ChatGPT search answers, though can still appear as navigational links."* |
| **GPTBot** | OpenAI | Foundation-model **training** | Yes | Your call. Disallowing = opt out of training. Does **not** block ChatGPT search. |
| **ChatGPT-User** | OpenAI | **User-initiated** fetch (user pasted/asked about your URL) | *"Because these actions are initiated by a user, robots.txt rules may not apply."* | Allow |
| **OAI-AdsBot** | OpenAI | Safety-checks pages submitted as ChatGPT ads | Only visits submitted ad pages | N/A |
| **ClaudeBot** | Anthropic | Model **training** | Yes | Your call |
| **Claude-User** | Anthropic | User-initiated fetch during a Claude conversation | **Yes** (Anthropic honors robots.txt even here — stricter than OpenAI/Perplexity) | **Yes** |
| **Claude-SearchBot** | Anthropic | *"Navigates the web to improve search result quality"* — Claude's search index | Yes | **Yes** |
| **PerplexityBot** | Perplexity | *"Designed to surface and link websites in search results on Perplexity"* | Yes; Perplexity **recommends allowing it** | **Yes** |
| **Perplexity-User** | Perplexity | User-initiated fetch | *"Generally disregards robots.txt since a user requested the fetch"* | Allow |
| **Applebot** | Apple | Siri / Spotlight / Apple search index | Yes | **Yes** — matters for an iOS app |
| **Applebot-Extended** | Apple | **Not a crawler.** A robots.txt token that controls whether Applebot-crawled data may be used to train Apple foundation models | Yes | Your call — blocking it does not affect Apple search surfaces |
| **meta-externalagent** | Meta | AI training + product improvement | Yes [B] | Your call; no live-answer impact |
| **Bytespider** | ByteDance | Doubao / ByteDance AI training | **Widely reported to ignore robots.txt** [B] | Block at WAF/CDN if load is a problem — robots.txt alone won't stop it |
| **Amazonbot** | Amazon | Alexa / Rufus | Yes | Allow |
| **Bingbot** | Microsoft | Bing index → Copilot (and historically part of ChatGPT retrieval) | Yes | **Yes** |

Primary sources:
- OpenAI: https://developers.openai.com/api/docs/bots ; Publishers & Developers FAQ https://help.openai.com/en/articles/12627856-publishers-and-developers-faq (403 to automated fetch; quote *"Any public website can appear in ChatGPT search… make sure you aren't blocking OAI-SearchBot"* via secondary coverage — **[A-secondary]**)
- Anthropic: https://support.claude.com/en/articles/8896518-does-anthropic-crawl-data-from-the-web-and-how-can-site-owners-block-the-crawler (last updated **2026-04-07**). IP list: https://claude.com/crawling/bots.json . Supports the non-standard `Crawl-delay`. Coverage of the three-bot split: https://searchengineland.com/anthropic-claude-bots-470171 , https://www.seroundtable.com/anthropic-updates-its-crawler-docs-40978.html
- Perplexity: https://docs.perplexity.ai/guides/bots — neither bot is used for foundation-model training.
- Google: https://developers.google.com/search/docs/crawling-indexing/google-common-crawlers (2026-07-14)
- Apple: https://support.apple.com/en-us/119829
- Community list: https://github.com/ai-robots-txt/ai.robots.txt

### 5.2 The critical technical constraint: **AI crawlers do not render JavaScript**

**[B] Vercel + MERJ, "The rise of the AI crawler" (2024-12-17)** — https://vercel.com/blog/the-rise-of-the-ai-crawler
- 500M+ GPTBot fetches analysed across nextjs.org and the Vercel network.
- **None of the major AI crawlers render JavaScript** — OpenAI, Anthropic, Meta, ByteDance, Perplexity. They *download* JS files (GPTBot 11.50% of requests, ClaudeBot 23.84%) but never execute them.
- **AppleBot and Gemini (via Google's Web Rendering Service) DO render.**
- Monthly volumes at the time: Googlebot 4.5B, GPTBot 569M, ClaudeBot 370M, AppleBot 314M, PerplexityBot 24.4M.
- Efficiency: ChatGPT wasted 34.82% of requests on 404s, Claude 34.16%, vs Googlebot 8.22%.

**[B]** Multiple 2026 replications and the searchVIU test (§3.2) confirm this still holds as of mid-2026 — only Gemini rendered JS on live fetch in the searchVIU run.

**This is the single highest-leverage technical fact in this report.** A client-side-rendered React/Next app can rank fine on Google (which renders) and be **completely blank** to ChatGPT, Claude and Perplexity.

### 5.3 Recommended robots.txt posture for a site that WANTS citations

Default `User-agent: * / Allow: /` already permits everything. Explicit allow-blocks are **belt-and-braces** — they matter mainly because (a) they document intent, (b) they survive a future well-meaning "block the AI bots" edit, and (c) some CDN/WAF UIs key off them. The real risk is not robots.txt — it's **Cloudflare/Netlify bot-management rules silently 403'ing AI user agents**. Verify with real requests, not by reading config.

Also: **do not `Disallow: /_next/`** or any path holding CSS/JS/images. Google has asked for years that resources stay crawlable; for AI crawlers it costs nothing but removes a category of risk.

---

## 6. Entity / brand SEO — off-site vs on-site

### 6.1 The correlational case for off-site

**[B] Ahrefs brand-correlation study (2025-05-26)** — 75,000 brands, DR>40, keywords with ≥800 monthly volume, Spearman correlations against AI Overview brand mentions — https://ahrefs.com/blog/ai-overview-brand-correlation/

| Factor | Spearman ρ |
|---|---|
| **Branded web mentions** | **0.664** |
| Branded anchors | 0.527 |
| Branded search volume | 0.392 |
| Domain Rating | 0.326 |
| Referring domains | 0.295 |
| Branded traffic | 0.274 |
| **Number of backlinks** | **0.218** |
| URL Rating | 0.180 |
| Number of site pages | 0.170 |

~26% of studied brands had **zero** AI Overview mentions. **Ahrefs' own caveat, verbatim: "Correlation ≠ causation"** — and they note all factors show "moderate to very weak" relationships.

The widely-quoted "YouTube mentions predict AI visibility at 0.737" figure comes from a companion Ahrefs analysis (https://ahrefs.com/blog/ai-brand-visibility-correlations) — same caveat, amplified: brands with high AI visibility also have high cross-platform presence. Starting a YouTube channel does not cause citations.

### 6.2 Who actually gets cited

**[B] Profound, "AI Platform Citation Patterns"** — 680M citations, Aug 2024 – Jun 2025, published 2025-06-05 (updated Aug 2025) — https://www.tryprofound.com/blog/ai-platform-citation-patterns

| Platform | Top cited domains (share of all citations) |
|---|---|
| ChatGPT | Wikipedia **7.8%**, Reddit 1.8%, Forbes 1.1%, G2 1.1% |
| Google AI Overviews | Reddit **2.2%**, YouTube 1.9%, Quora 1.5%, LinkedIn 1.3% |
| Perplexity | Reddit **6.6%**, YouTube 2.0%, Gartner 1.0%, Yelp 0.8% |

TLD split: .com 80.41%, .org 11.29%. **Only ~11% of domains are cited by both ChatGPT and Perplexity** — the platforms have genuinely different retrieval logic.

**[B] Muck Rack, "What Is AI Reading?" May 2026 edition (2026-05-07)** — 25M+ links, ChatGPT/Claude/Gemini, 17 industries, third edition of a series running since July 2025 — https://muckrack.com/blog/what-is-ai-reading-may-2026
- **Earned media = 84% of AI citations** (stable across all three editions). Journalism alone = 27%. **Paid/advertorial = 0.3%.**
- Citation behaviour by model: ChatGPT cites in 96% of responses (~5 citations), Gemini 82% (~8), Claude 55% (~13).
- **Conflict-of-interest flag:** Muck Rack is a PR-software vendor and this study is its core marketing asset. The direction is corroborated elsewhere; the exact 84% should be held loosely.

### 6.3 Wikipedia / Wikidata

**[B]** Wikipedia is the #1 or #2 cited domain on every major platform (Profound above). Entities with a Wikipedia article appear more often in AI answers.

**[C]** The figure "**Wikipedia = 47.9% of ChatGPT's citations**" is circulating heavily via PR-agency press releases (5W). It **conflicts with Profound's measured 7.8%**. The 47.9% number appears to describe share *within a top-10-domains subset for factual queries*, not share of all citations. **Do not repeat it as "half of ChatGPT citations are Wikipedia."**

**[C]** "Edelman raised a client's LLM mention rate from 11% to 34% with nine Wikipedia edits in 60 days" — single uncontrolled agency anecdote. No baseline, no control, obvious incentive. Ignore.

**Wikidata** is the honest, low-cost move: it is a machine-readable entity record with no notability bar comparable to Wikipedia's, feeds knowledge-graph construction, and is cheap to create and keep accurate. Wikipedia itself requires genuine third-party notability — **do not attempt to create your own article**; it will be deleted and can damage the brand.

### 6.4 The counterweight [A]

Google's own AI-optimization guide (2026-05) explicitly lists **"pursuing inauthentic product mentions"** as a low-value tactic. And Reddit reported catching ~25,000 spam posts/comments daily in Q1 2026 amid a wave of AI-generated astroturfing aimed specifically at AI citations (https://www.mediapost.com/publications/article/416312/, 2026-07-07).

**Net position:** off-site mention volume is the strongest *observed* correlate of AI visibility, and it is also the hardest and slowest thing to build honestly. It is real PR/partnerships work, not an SEO tactic. Manufacturing it is detected and punished on both ends.

---

## 7. Mobile app / dating app discovery in AI search

This is the most directly actionable section for Qulo.

### 7.1 The key study

**[B] "AI App Discoverability Index 2026", Growth by Kev, March 2026** — https://www.growthbykev.com/research/ai-app-discoverability-index-2026
- Method: **195 queries × 15 app categories**, run against ChatGPT (gpt-4o), Claude (sonnet-4-6), Gemini (2.0-flash), Perplexity (sonar). **4,265 recommendations**, 1,230 unique apps.
- **Where the citations come from (Perplexity, 1,285 citation URLs):**
  - **Editorial listicles / reviews: 62.4%**
  - YouTube: 14.2%
  - **App store listings: only 9.5%**
  - Other: 13.9%
  - Top editorial sources: Zapier (31 mentions across 6 categories), NerdWallet (17), TechRadar (16).
- **Cross-platform fragmentation:** only **16.2%** of apps appeared on all four platforms; **54.8% appeared on only one**. You must win each platform separately.
- **Query qualifiers reshape the entire result set**: adding a price qualifier moved free-app representation from 31.9% → **70.5%**.
- **Caveat: dating was NOT one of the 15 categories tested.** Extrapolate with care — dating is a higher-YMYL-adjacent, higher-editorial-coverage category than most.

### 7.2 App-store ↔ AI-search relationship

**[B] AppTweak (2026-02-18)** — https://www.apptweak.com/en/aso-blog/ai-app-discovery-llm-search
- *"App store rankings are not directly used as a primary decision input"* by AI systems — popular apps benefit **indirectly**, via the volume of web mentions their popularity generates.
- AppTweak's own worked example is **dating apps**: comparing ChatGPT's recommendations (2026-02-13) against the US App Store dating chart showed **meaningful overlap** (Tinder, Hinge prominent in both) but **not identical lists** — some high-charting apps were absent from ChatGPT, and some lower-charting apps over-indexed.
- Recommendations: clear intent alignment ("app for X"), strong web representation via reviews/comparisons/editorial, structured comparisons and unambiguous descriptions over promotional vagueness.

**Interpretation for Qulo:** ASO and AI discoverability are **separate funnels fed by different inputs**. Climbing the App Store dating chart will not, by itself, get Qulo into "best dating apps" answers. Getting into ~10–20 credible "best dating apps 2026" listicles will.

### 7.3 What "best dating apps 2026" SERPs actually look like

A live search for `best dating apps 2026` returns: Vice, mindbodygreen, Tom's Guide, Medium personal-experience posts, and a long tail of affiliate comparison sites — i.e. **exactly the editorial-listicle layer the Growth-by-Kev data says AI cites 62.4% of the time.** Qulo's own site is structurally incapable of winning that query; a Qulo *mention inside those pages* is what wins it.

### 7.4 Platform-level app discovery changes to watch

**[B]** Google announced **"Ask Play"** at I/O 2026 — a conversational layer on Play Store listings that answers natural-language questions about an app, generated from **the app's description, the developer's website, and aggregate reviews** (https://appfollow.io/blog/aso-news). If accurate, **the developer website becomes a direct input to store-level Q&A** — a strong reason to keep quloapp.com's factual copy precise and machine-readable-in-prose.

**[B]** Apple's LLM-based Siri overhaul is expected in the iOS 27 timeframe; Applebot access matters for that surface.

---

## 8. Commonly repeated claims that are NOT supported by evidence

| Claim | Status | Why |
|---|---|---|
| "llms.txt improves AI visibility" | **[C] False/unsupported** | Google says it doesn't use it [A]; 97% of files get zero requests [B]; no platform documents it as a ranking or citation input |
| "Chunk your content into 134–167 word passages" | **[C] Invented precision** | No traceable study. Google explicitly names chunking a myth [A] |
| "Content scoring 8.5/10 semantic completeness is 4.2× more likely to be cited" | **[C] Fabricated-looking** | Appears only on AI-generated SEO blogs; no methodology, no author, no dataset |
| "96% of AI Overview citations come from strong E-E-A-T sources" | **[C]** | Unsourced. E-E-A-T is not a measurable score Google exposes |
| "55% of citations pull from the top 30% of a page" | **[C]** | Unsourced |
| "Add FAQPage schema to get into AI Overviews" | **[C] Contradicted** | FAQ rich results deprecated May 2026 [A]; Ahrefs DiD found schema addition produced no lift and a small negative on AIO [B] |
| "HowTo markup outperforms unstructured procedural content in AI Overviews" | **[C]** | Asserted repeatedly with no citable study; HowTo has been dead in Google since 2023 [A] |
| "Speakable schema is the new FAQ schema for AI" | **[C]** | Speakable is a narrow news/Assistant feature. Zero evidence any LLM reads it |
| "Perplexity's 2026 algorithm prioritizes llms.txt and MCP" | **[C]** | Perplexity's own docs (https://docs.perplexity.ai/guides/bots) say nothing of the sort |
| "Wikipedia is ~48% of ChatGPT citations" | **[C] Misquoted** | Profound's measured figure is **7.8%** of all citations [B]. The 48% is a subset statistic from a PR press release |
| "Blocking Google-Extended removes you from AI Overviews" | **[C] False** | Google states Google-Extended does not affect Search inclusion or ranking [A] |
| "Strip promotional language so LLMs will cite you" | **[C] Contradicted** | Semrush found non-promotional tone **negatively** differentiated cited pages (−26.19%) [B] |
| "Longer content gets cited more" | **[C] Contradicted** | Ahrefs found ~no correlation between word count and AIO citation [B] |
| "Backlinks are what drive AI citations" | **[C] Weak** | Backlinks correlate at 0.218 vs 0.664 for brand mentions [B] — and both are correlational |
| "AI search is replacing Google traffic now" | **[C] Premature** | AI platforms ≈0.15–0.25% of global web traffic [B] |

---

## 9. What a small static Next.js marketing site should actually do

Written for **quloapp.com** (Next.js `output: 'export'` → fully static HTML on Netlify, 16 locales, existing `/features`, `/pricing`, `/help`, `/how-to`, `/glossary`, `/blog`, `/dating/[city]`, `/country/[slug]` routes, and already-comprehensive JSON-LD including Organization/WebSite/SoftwareApplication/BreadcrumbList/Article/ItemList).

Ordered by **impact ÷ effort**. Items 1–5 are the ones that matter.

### Tier 1 — do this week (hours, high impact)

**1. Prove AI crawlers can actually read the rendered page. (30 min)**
`output: 'export'` means you already ship static HTML — you are in the top decile here. **Verify it, don't assume it.** Fetch production with each AI user agent and confirm the H1, pricing, and feature copy are present in the raw bytes:
```
curl -sA "GPTBot/1.4" https://quloapp.com/en/ | grep -c "<h1"
curl -sA "OAI-SearchBot/1.4" https://quloapp.com/en/pricing/ | grep -i "price\|free"
curl -sA "ClaudeBot" https://quloapp.com/en/features/ | wc -c
curl -sA "PerplexityBot" https://quloapp.com/en/help/ | grep -i "<h2"
```
Non-200s or thin bodies mean **Netlify bot protection / edge rules are the blocker**, not your code. Evidence: no major AI crawler executes JS (§5.2).

**2. Fix robots.txt. (20 min)**
Current output has two `User-agent: *` groups — a malformed pattern where some parsers keep only the last group, silently discarding `Allow: /`. Also `Disallow: /_next/` blocks your CSS/JS/font assets. In `next-sitemap.config.js`:
- Merge into **one** `*` group.
- Drop `Disallow: /_next/` (keep `/api/`, `/404`).
- Add explicit allow-blocks for `Googlebot`, `Google-Extended`, `OAI-SearchBot`, `GPTBot`, `ChatGPT-User`, `ClaudeBot`, `Claude-User`, `Claude-SearchBot`, `PerplexityBot`, `Perplexity-User`, `Applebot`, `Applebot-Extended`, `Bingbot`, `Amazonbot`, `meta-externalagent` — documents intent and survives future edits.
- Optionally `Disallow` `Bytespider` (it ignores robots.txt; block at Netlify edge if load matters).

**3. Bing Webmaster Tools + IndexNow. (1 hour)**
ChatGPT's retrieval has historically leaned on Bing-derived index data, and Bing is the one platform that has *affirmatively said* schema helps its LLMs [A/B, §3.2]. Submit the sitemap; wire IndexNow on deploy (Netlify build hook → ping). Near-zero maintenance.

**4. Put every quotable fact in visible HTML, not only JSON-LD. (2–4 hours)**
The searchVIU experiment is unambiguous: **zero of five AI systems read JSON-LD-only values on live fetch** (§3.2). Audit `/pricing`, `/features`, `/about`, `/help` and make sure the following exist as **visible prose or a table**, in a self-contained sentence, near the top of the relevant page:
- What Qulo is, in one declarative sentence: *"Qulo is a question-based dating app where you match by correctly answering 2–10 questions written by the other person, instead of swiping."*
- Price / free tier / diamond economy, with actual numbers and currency.
- Platforms (iOS + Android), minimum OS versions, App Store / Play links.
- Supported languages/locales (the 16), countries/cities where it's active.
- Company name, founding year, location.
Keep the JSON-LD mirror — it feeds Google's and Bing's index. But the **text is what gets quoted**.

**5. Add visible `Last updated: <date>` + accurate `dateModified` on evergreen pages. (1–2 hours)**
75% of AI-cited pages were updated within a year; update date >> publish date (§4.2). Make sure `next-sitemap` emits real `lastmod` (not build time for every URL) and that `/features`, `/how-to/*`, `/glossary`, `/dating/[city]` show a human-readable update date. **Only bump it when content genuinely changes** — date-only bumps are detectable and worthless.

### Tier 2 — do this month (days, high impact)

**6. Build answer-shaped pages for the fan-out sub-queries. (2–4 days)**
This is the on-site work with the best evidence behind it (Semrush: Q&A format +25.45%, section structure +22.91%, clarity +32.83% — §4.1). Target the sub-questions a fan-out would generate around "is Qulo any good":
- `/is-qulo-free` — direct answer in sentence one, then a pricing table.
- `/qulo-vs-tinder`, `/qulo-vs-bumble`, `/qulo-vs-hinge` — honest comparison tables. **No competitor-bashing** (existing project rule) — factual mechanic differences only: swipe vs. question-gate, matching criteria, pricing model.
- `/how-qulo-matching-works` — the 2–10 question mechanic explained precisely, with numbers.
- `/is-qulo-safe` — verification, reporting, moderation, data handling.
- `/dating-app-without-swiping` — the category-definition query Qulo can plausibly own.
Format each as: **question-shaped H1 → 2–3 sentence direct answer → supporting table/list → specifics with dates and numbers**. Do **not** slice these into artificial micro-chunks; Google explicitly calls that a myth [A].

**7. Get into third-party "best dating apps" listicles. Highest impact of anything in this document, highest effort. (ongoing)**
62.4% of app-recommendation citations came from editorial listicles vs 9.5% from app store listings (§7.1); 84% of AI citations overall are earned media (§6.2); branded web mentions correlate at 0.664 vs 0.218 for backlinks (§6.1). Concretely:
- Build a proper **press kit page** (`/press` already exists — make it complete): high-res logo pack, founder bio + headshot, one-paragraph and one-sentence boilerplate, key stats with dates, screenshots, contact. Journalists and listicle authors copy this verbatim, which propagates a **consistent entity description** across the web.
- Pitch TR + EU tech/lifestyle press, dating-app review blogs, Product Hunt, app-review YouTube channels.
- Target the specific sites that already rank for `best dating apps 2026` and `dating apps for [city]`.
- **Never** buy placements framed as editorial — paid/advertorial is 0.3% of citations anyway (§6.2), so it's poor ROI even setting ethics aside.

**8. Entity consistency + Wikidata. (half a day)**
- Ensure one canonical brand description, one canonical name spelling, and identical `sameAs` arrays (App Store, Play, X, Instagram, LinkedIn, Crunchbase, Product Hunt) across `Organization` JSON-LD, App Store listing, Play listing, and all social bios. Entity consistency scored 5.8/10 in the Zyppy synthesis; it is cheap.
- Create a **Wikidata item** for Qulo — legitimate, low bar, machine-readable, feeds knowledge graphs. **Do not create a Wikipedia article yourself** (notability + COI rules; it will be deleted).

**9. Measurement. (half a day)**
- Enable the Search Console **Generative AI performance report** if the property has it (impressions only, data from 2026-05-18).
- Add GA4 referral segments for `chatgpt.com`, `perplexity.ai`, `claude.ai`, `gemini.google.com`, `copilot.microsoft.com`.
- Log AI user agents at the Netlify edge so you can see crawl vs. referral. Crawl-to-refer ratios are brutal for training bots (§0) — knowing yours prevents over-investment.
- Manually spot-check monthly: ask each of ChatGPT/Claude/Perplexity/Gemini `best dating apps 2026`, `dating app where you answer questions`, `alternatives to Tinder` and record whether Qulo appears and what was cited.

### Tier 3 — cheap hygiene, do when convenient

**10. Prune schema that no longer earns anything, keep what does.**
Keep `Organization`, `WebSite`, `BreadcrumbList`, `Article`, `SoftwareApplication`, `ItemList`. `FAQPage` and `HowTo` produce zero Google features now — keep them **only where they describe genuinely visible on-page Q&A/steps** (harmless, may help other engines); delete any instance where the markup describes content that isn't visible. Don't add `Speakable`.

**11. Consider `MobileApplication` alongside `SoftwareApplication`** with `operatingSystem`, `applicationCategory: "SocialNetworkingApplication"`, `offers`, `installUrl` pointing at both stores. Still a supported Google rich-result type; cheap entity reinforcement.

**12. Add IndexNow-style freshness pings and keep `/blog` cadence honest.** The SEO blog pipeline already in `docs/marketing/seo-blog-pipeline/` is the right shape — the freshness data (§4.2) says **updating a small set of durable pages beats publishing volume**.

### Explicitly do NOT do

- ❌ **Do not create llms.txt** expecting benefit (§2). If it's already on someone's backlog, kill the ticket.
- ❌ **Do not enable Google's AI opt-out toggle** (§1.1).
- ❌ **Do not block Google-Extended** thinking it protects AI Overview presence — it does nothing to Search, and it *does* remove you from Gemini app grounding (§5.1).
- ❌ **Do not chunk content into micro-passages** or write "for AI" — Google names both as myths [A].
- ❌ **Do not astroturf Reddit/Quora** for citations. Reddit is removing ~25k spam items/day and Google flags inauthentic mentions [A] (§6.4).
- ❌ **Do not strip all marketing language** — the only measured study found the opposite direction (§4.1).
- ❌ **Do not buy an "AI visibility score" tool** that claims internal Google metrics — Google explicitly warns against these [A].

---

## 10. Source index

### Primary (platform documentation & statements)
| Source | Date | URL |
|---|---|---|
| Google — AI features and your website | upd. 2025-12-10 | https://developers.google.com/search/docs/appearance/ai-features |
| Google — Optimizing your website for generative AI features | pub. 2026-05-15, upd. 2026-07-10 | https://developers.google.com/search/docs/fundamentals/ai-optimization-guide |
| Google — A new resource for optimizing for generative AI | 2026-05 | https://developers.google.com/search/blog/2026/05/a-new-resource-for-optimizing |
| Google — Search Generative AI performance reports in Search Console | 2026-06 | https://developers.google.com/search/blog/2026/06/gen-ai-performance-reports |
| Google — Top ways to ensure your content performs well in AI experiences | 2025-05 | https://developers.google.com/search/blog/2025/05/succeeding-in-ai-search |
| Google — Common crawlers (Google-Extended) | upd. 2026-07-14 | https://developers.google.com/search/docs/crawling-indexing/google-common-crawlers |
| Google — Structured data search gallery | upd. 2026-06-15 | https://developers.google.com/search/docs/appearance/structured-data/search-gallery |
| Google — Software app structured data | current | https://developers.google.com/search/docs/appearance/structured-data/software-app |
| OpenAI — Bots / crawler documentation | current | https://developers.openai.com/api/docs/bots |
| OpenAI — Publishers & Developers FAQ | current | https://help.openai.com/en/articles/12627856-publishers-and-developers-faq |
| Anthropic — Crawler documentation | upd. 2026-04-07 | https://support.claude.com/en/articles/8896518-does-anthropic-crawl-data-from-the-web-and-how-can-site-owners-block-the-crawler |
| Anthropic — bots.json IP list | current | https://claude.com/crawling/bots.json |
| Perplexity — Bots guide | current | https://docs.perplexity.ai/guides/bots |
| Apple — About Applebot | current | https://support.apple.com/en-us/119829 |

### Studies (correlational / experimental)
| Study | Date | Sample | URL |
|---|---|---|---|
| Ahrefs — Schema DiD experiment | 2026-05-11 | 1,885 treated + 4,000 control pages | https://ahrefs.com/blog/schema-ai-citations/ |
| Ahrefs — Brand mentions correlation | 2025-05-26 | 75,000 brands | https://ahrefs.com/blog/ai-overview-brand-correlation/ |
| Ahrefs — Rankings vs AI citations | 2025-07-21 | 1.9M citations / 1M AIOs | https://ahrefs.com/blog/search-rankings-ai-citations/ |
| Ahrefs — Freshness preference | 2025-07-28 | 16.975M cited URLs | https://ahrefs.com/blog/do-ai-assistants-prefer-to-cite-fresh-content/ |
| Ahrefs — llms.txt adoption/usage | upd. 2026-06-15 | 137,000 domains | https://ahrefs.com/blog/what-is-llms-txt/ |
| Semrush — Content optimization for AI search | 2026-01-14 | 11,882 prompts / 337,785 URLs | https://www.semrush.com/blog/content-optimization-ai-search-study/ |
| Semrush — AI Visibility Index 2026 | 2026 | 126M US AI prompts | https://www.semrush.com/news/463141-semrush-releases-expanded-2026-ai-visibility-index-analyzing-126-million-ai-search-prompts/ |
| Profound — AI platform citation patterns | 2025-06-05 (upd. 08/2025) | 680M citations | https://www.tryprofound.com/blog/ai-platform-citation-patterns |
| Muck Rack — What Is AI Reading? (May 2026) | 2026-05-07 | 25M+ links, 17 industries | https://muckrack.com/blog/what-is-ai-reading-may-2026 |
| Seer Interactive — Content recency & AI visibility | 2026-07-24 | 7,683 pages / 47,097 citations | https://www.seerinteractive.com/insights/study-content-recencys-impact-on-ai-visibility-in-2026 |
| searchVIU — What AI really sees (schema live-fetch test) | 2025-12-02 | 8 markup variants × 5 systems | https://www.searchviu.com/en/schema-markup-and-ai-in-2025-what-chatgpt-claude-perplexity-gemini-really-see/ |
| Vercel + MERJ — The rise of the AI crawler | 2024-12-17 | 500M+ GPTBot fetches | https://vercel.com/blog/the-rise-of-the-ai-crawler |
| Growth by Kev — AI App Discoverability Index 2026 | 2026-03 | 195 queries / 4,265 recommendations | https://www.growthbykev.com/research/ai-app-discoverability-index-2026 |
| AppTweak — AI app discovery & LLM search | 2026-02-18 | qualitative + dating-app example | https://www.apptweak.com/en/aso-blog/ai-app-discovery-llm-search |
| iPullRank — Expanding queries with fan-out (Stoy) | 2025-12-11 | patent/architecture analysis | https://ipullrank.com/expanding-queries-with-fanout |
| Zyppy (Shepard) — 23 AI citation factors | 2026-05-07 | synthesis of 54 studies | https://ppc.land/23-factors-that-actually-get-your-content-cited-by-ai-search-engines/ |
| Cloudflare — AI crawler traffic by purpose & industry | 2026 | Cloudflare network | https://blog.cloudflare.com/ai-crawler-traffic-by-purpose-and-industry/ |
| Similarweb — Gen AI traffic stats | 2026 | Similarweb panel | https://www.similarweb.com/blog/marketing/geo/gen-ai-stats/ |
| seoClarity — AI Overviews impact research | 2025–2026 | Research Grid | https://www.seoclarity.net/research/ai-overviews-impact |

### Trade coverage used for quotes/dates
- SEJ — Google says llms.txt is purely speculative (2026-06-02): https://www.searchenginejournal.com/google-says-llms-txt-is-purely-speculative-for-now/577576/
- SEJ — 97% of llms.txt files got no requests: https://www.searchenginejournal.com/97-of-llms-txt-files-got-no-requests-ahrefs-data-shows/579478/
- SEJ — Schema markup didn't move AI citations (2026-05-11): https://www.searchenginejournal.com/schema-markup-didnt-move-ai-citations-in-ahrefs-test/574568/
- SEJ — Google drops FAQ rich results (2026-05): https://www.searchenginejournal.com/google-drops-faq-rich-results-from-search/574429/
- SEJ — AIO citations from top-ranking pages drop sharply: https://www.searchenginejournal.com/google-ai-overview-citations-from-top-ranking-pages-drop-sharply/568637/
- Search Engine Land — Google AI opt-out feature (2026-06-18, Nick LeRoy): https://searchengineland.com/google-ai-opt-out-feature-competitors-480375
- Search Engine Land — Anthropic clarifies Claude bots: https://searchengineland.com/anthropic-claude-bots-470171
- Search Engine Land — Bing/Copilot use schema for LLMs (2025-03): https://searchengineland.com/microsoft-bing-copilot-use-schema-for-its-llms-453455
- Search Engine Roundtable — Google does not endorse llms.txt: https://www.seroundtable.com/google-does-not-endorse-llms-txt-40789.html
- Search Engine Roundtable — Anthropic crawler doc update: https://www.seroundtable.com/anthropic-updates-its-crawler-docs-40978.html
- ppc.land — Search Console gen-AI reports: https://ppc.land/google-finally-gives-search-console-its-own-generative-ai-visibility-reports/
- MediaPost — Reddit infiltrated by AI stealth marketing (2026-07-07): https://www.mediapost.com/publications/article/416312/
- AppFollow — ASO news 2026 (Ask Play): https://appfollow.io/blog/aso-news

### Notes on fetch failures (transparency)
- `seroundtable.com` and `help.openai.com` returned HTTP 403 to the automated fetcher; their quotes here are sourced through SEJ / Search Engine Land coverage and are marked as such.
- `developers.google.com/search/blog/...` article bodies did not render through the fetcher (navigation shell only) for the 2025-05, 2026-05 and 2026-06 posts; content for those is taken from the corresponding **documentation** pages (which did render fully) plus trade coverage. The two Search Central *documentation* pages — the primary evidence in this report — rendered completely.
