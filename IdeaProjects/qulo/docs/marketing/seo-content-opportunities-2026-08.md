# quloapp.com — Organic Content Opportunities

**Research date:** 2026-09-01 · **Horizon:** Sept 2026 – Dec 2027
**Method:** ~40 live SERP probes + primary-source verification. Every factual claim below carries a source URL and date.

**How to read this document.** Statements are tagged:
- **[F]** — confirmed from a page or dataset I fetched/observed directly.
- **[S]** — from a search-result snippet only; directionally useful, not verified at source.
- **[I]** — my inference from observed SERPs or from combining sources. Not a fact.

---

## 0. Blocker: fix the two "cite this report" pages before publishing anything new

This is the highest-priority finding in the whole report, and it is a liability, not an opportunity.

`/en/dating-statistics/` and `/en/trends/2026/` both render an **APA + MLA "Cite This Report" block**, actively soliciting citation. **[F]** (fetched from the built output, 2026-09-01). Between them they make roughly 20 numeric claims. Most have **no source at all**, and the four that name a source name it only as a bare word — "Statista 2025", "Stanford Study", "Pew Research 2024" — with no URL, no report title, no methodology.

Specific problems found **[F]**:

| Claim on the page | Status |
|---|---|
| "'quiz dating' search volume increased by 200%" (2024–2026) | **No source.** Not verifiable in any public dataset I could find. |
| "72% of users prefer 'slow dating'" | **No source.** |
| "85% of users want to try AI-powered matching" | **No source.** |
| "30-40% usage increase during cuffing season" | **No source**, and the underlying premise is contested — see §5. |
| "80%+ ghosting rate in matches" | **No source.** |
| "115 average swipes per match" / "0.5s time reviewing a profile" | **No source.** |
| "39% of heterosexual couples meet online (2024) — Stanford Study" | **Year is wrong.** The Rosenfeld/Stanford figure comes from the 2017 *How Couples Meet and Stay Together* wave, published 2019 — not 2024. |
| "30% of US adults have used dating apps — Pew Research 2024" | **Year is wrong and the number is now stale.** Pew's 30% is from [Feb 2023](https://www.pewresearch.org/short-reads/2023/02/02/key-findings-about-online-dating-in-the-u-s/). The current figure is **37% ever / 6% currently**, [SSRS, 2 Feb 2026](https://ssrs.com/insights/online-dating-2026/), n=2,012, MoE ±2.5. **[F]** |
| "78% feel burnout from dating apps" | **True but uncited.** Real source: [Forbes Health / OnePoll, fielded 27 Mar – 1 Apr 2024](https://www.globaldatinginsights.com/news/new-forbes-study-explores-dating-app-burnout/), n=1,000 US dating-app users, MoE ±3.1. **[S]** |
| Methodology note: "Anonymous usage data from the Qulo platform is also analyzed" | No such analysis appears anywhere on the page. |

**Why this blocks everything else.** §4 shows that the single most reliable link-and-citation asset in this niche is a statistics hub. Qulo already *has* one, it already ranks (it surfaced in my probe for "dating app burnout statistics 2026" **[F]**), and it is currently unciteable. A journalist who checks one number and finds it unsourced will not cite the second. Worse, the page invites the citation first.

**Action, in order:**
1. Delete or replace every unsourced number. Do not "find a source that says 200%" — remove the claim.
2. Give every surviving stat: publisher, report title, publication date, sample size, methodology link.
3. Only then keep the "Cite This Report" block. It is a genuinely good idea attached to bad data.
4. Same treatment for `/trends/2026/`, which repeats four of the unsourced figures.

Sourced replacements ready to use are listed in §8.

---

## 1. What people actually search — and who owns it

### 1.1 The demand backdrop is real and it is moving in Qulo's direction

**[F]/[S], all sourced:**
- Dating-app market revenue fell for the first time ever in 2025, down ~2% to ~$6bn; Tinder revenue −5.2%, Bumble −9.5% ([Business of Apps](https://www.businessofapps.com/news/dating-app-market-first-annual-revenue-decline/)) **[S]** — *note: businessofapps returns HTTP 403 to automated fetches; verify manually before citing.*
- Tinder paying subscribers fell to 8.77M in Q4 2025, −8% YoY, an eighth consecutive quarterly decline **[S]**.
- Global installs −4% and sessions −7% YoY in 2025 ([Adjust, *State of Dating Apps 2026*](https://www.adjust.com/blog/state-of-dating-apps/)) **[S]**.
- NPR ran a national segment on the decline on [23 Aug 2026](https://www.npr.org/2026/08/23/nx-s1-5938103/have-dating-apps-lost-their-luster-data-shows-a-decline-in-users) **[S]** — the topic is now mainstream-news-current, which is exactly when explainer content gets cited.
- 78% of US dating-app users report burnout (Forbes Health/OnePoll, Apr 2024, n=1,000) **[S]**.

**[I]** The category's decline is Qulo's core narrative, and for the first time it is a *news* story rather than a marketing claim. Content that explains the decline with real numbers has a citation window open right now.

### 1.2 SERP difficulty, measured rather than assumed

I ran live probes on every cluster in the brief. The headline result contradicts the common assumption: **Match Group properties barely appear in dating-*advice* SERPs.** The walls are elsewhere.

| Cluster probed | Who actually ranks **[F]** | Verdict |
|---|---|---|
| "dating app without swiping" | lovefinder.blog, grass.camp, scimatch.com, nexspark.com, impressivemagazine.com, whataportrait.com, exbackpermanently.com | **Wide open.** Zero big brands. Almost all thin affiliate. |
| "slow dating 2026" | fodmapeveryday.com, itsjustlunch, tawkify, mingle2, probumble, greyjournal, sarahlouiseryan.com + Essence, Ebony | **Wide open.** A FODMAP recipe site ranks for a dating term. |
| "dating app prompts" | swipestats.io, matchshot.app, philtrum.app, debbierivers.com.au + AOL | **Open.** |
| "how to know if someone likes you over text" | marriage.com, stylecraze, anewmode, loveconnet, hilainie, decodethistext, cupid-ai | **Open but worthless** — no commercial intent (see §6). |
| "icebreaker questions dating" | eharmony, scienceofpeople, bonobology, elitedaily + meetty.com, flirtcopilot.com | **Medium.** Small sites do break in. |
| "best dating apps 2026" | grass.camp, nexspark, scimatch, impressivemagazine + Forbes Health, Tom's Guide, mindbodygreen | **Crowded affiliate warzone.** See §6. |
| "first date questions" / "deep questions to ask" | **eharmony ×2–3 per SERP**, Parade, The Knot, Calm, BetterUp, mindbodygreen, Wondermind | **Hard.** eharmony's wall — see 1.3. |
| "green flags in a relationship" | CNBC, TODAY, Calm, Wondermind, Bumble, Grindr, Paired, loveisrespect, thehotline | **Hard.** Big media + big brands + nonprofits. |
| "attachment style quiz" | simplypsychology, charliehealth, thesecurerelationship, attachedapp, BuzzFeed, myquizspot, personality-quizzes | **Medium**, but a poor link asset — see §4. |

**[I] The real competitive wall is not Tinder/Hinge/Bumble. It is (a) eharmony's question-bank library and (b) big general media on emotional-vocabulary terms.** Everything adjacent to the *mechanic* — no-swipe, quiz dating, slow dating, prompts — is defended only by thin affiliate content.

Ownership note for accuracy: **eharmony is not a Match Group property.** It was acquired in 2018 by ProSiebenSat.1's NuCom Group / Parship Elite Group, now ParshipMeet Group ([ProSiebenSat.1 newsroom](https://www.prosiebensat1.com/en/newsroom/nucom-group-and-parship-elite-group-acquire-us-matchmaking-pioneer-eharmony-en-338126)) **[S]**. Match Group owns Tinder, Hinge, OkCupid, Match, Plenty of Fish.

### 1.3 The question-bank cluster is contested, not empty — this corrects the brief's hypothesis

The brief assumed question banks were Qulo's natural open ground. They are not.

eharmony's `/dating-advice/getting-to-know/` runs a dense, internally-linked library **[F]**: "197 Top Questions to Ask on Dating Apps", "273 Questions to Ask to Get to Know Someone Better", "189 First Date Questions", "269 Random Questions", "233 Questions to Ask Your Crush", "226 Good Questions to Ask a Guy", plus a dedicated `/attraction/36-questions-to-fall-in-love/` page.

**[I]** Qulo cannot out-volume that, and shouldn't try. The winning move is structural, not numeric — see §2 items 1, 3 and 10, and §3's `/questions/` hub.

---

## 2. Prioritized article ideas

Difficulty is graded from the live SERPs above, not from a tool:
**Low** = no brand or big-media result on page 1. **Medium** = mixed; small sites present but so is at least one strong domain. **High** = big media or a dedicated category library owns it.

Priority reflects (search or citation demand) × (winnability) × (relevance to Qulo's actual mechanic).

| # | Working title | Target query cluster | Why Qulo can win it | Difficulty | Format | Candidate sources |
|---|---|---|---|---|---|---|
| 1 | **The Question Deficit: why both people think the other one isn't asking** | "question deficit", "my date didn't ask me anything", "why doesn't he ask me questions" | Hinge's own research named this problem in Nov 2025 and then published **no tool, no bank, no scoring** for it **[F]**. Qulo is the only app whose product *is* the answer. Near-zero competition on the term. | **Low** | Explainer + evidence, 1,200–1,800w | [Hinge 2025 Gen Z D.A.T.E. report, 19 Nov 2025](https://hinge.co/newsroom/2025-GenZ-Report) (62% think they ask enough; only 30% feel dates do; follow-ups 61%/interests 50%/values 49%); [Huang, Yeomans, Brooks, Minson & Gino, *JPSP* 2017](https://www.hbs.edu/ris/Publication%20Files/Huang%20et%20al%202017_6945bc5e-3b3e-4c0a-addd-254c9e603c60.pdf); [HBS Working Knowledge summary](https://www.library.hbs.edu/working-knowledge/asking-questions-can-get-you-a-better-job-or-a-second-date) |
| 2 | **Chatfishing: how to tell if you're talking to someone's AI** | "chatfishing", "is my match using ChatGPT", "AI written dating messages" | Fast-rising term with a Wikipedia page and Scientific American coverage, but the practical "how to tell" long-tail is unowned. Directly on-mechanic: an app where answers are *checked* has standing to write this. | **Medium** (SciAm/Bloomberg/Wikipedia hold the head term; the how-to tail is open) | Explainer + checklist | [Scientific American, "The Rise of AI 'Chatfishing'…"](https://www.scientificamerican.com/article/the-rise-of-ai-chatfishing-in-online-dating-poses-a-modern-turing-test/); [The Next Web, 20 Jul 2026](https://thenextweb.com/news/chatfishing-ai-dating-apps-chatgpt-claude-tinder-hinge); [Norton Cyber Safety Insights Report: Online Dating 2025](https://www.gendigital.com/media/tiyfeb1a/ncsir_online_dating_global_deck__fy25-final.pdf) (60% of app users believe they've had an AI-written conversation); Match/Kinsey via TNW (26% of US adults, 49% of Gen Z have used AI for dating) |
| 3 | **How to answer a question well (nobody writes about this half)** | "how to answer dating app prompts", "what to reply to a question on a dating app", "good answers to dating questions" | The competitor audit found **every** page in the category is "questions to ask" — there is no first-party content anywhere on what a good *answer* looks like **[F]**. This is Qulo's literal core loop. | **Low–Medium** | How-to with before/after examples | [Hinge 2025 Gen Z report](https://hinge.co/newsroom/2025-GenZ-Report); Huang et al. 2017 (responsiveness mediates liking); [Aron et al., *PSPB* 23(4), 1997, 363–377](https://journals.sagepub.com/doi/10.1177/0146167297234003) on escalating self-disclosure |
| 4 | **Is cuffing season real? What the research actually shows** | "is cuffing season real", "cuffing season meaning", "cuffing season data" | A genuinely contrarian, citable angle nobody has taken: the peer-reviewed finding is **bimodal** (winter *and* summer), which undercuts the cold-weather story every listicle repeats. Contrarian + sourced = link bait. | **Low–Medium** | Myth-check / data explainer | [Markey & Markey, *Archives of Sexual Behavior* 2013, summarized in Psychology Today](https://www.psychologytoday.com/us/blog/confessions-of-the-chronically-online/202510/finally-a-scientific-explanation-for-cuffing); [Hinge cuffing-season guide, 4 Sep 2025](https://hinge.co/newsroom/cuffing-season-guide-2025) (most messages sent in October); [Apptopia seasonality analysis, 26 Mar 2019](https://apptopia.com/en/insights/does-dating-app-seasonality-exist/) (winter sessions +14%, but summer installs +8%); [Merriam-Webster on the term's origin](https://www.merriam-webster.com/slang/cuffing-season) |
| 5 | **Why dating app downloads are falling — the numbers** | "why are dating apps dying", "dating app decline 2026", "dating apps losing users" | Live news topic (NPR, Aug 2026) with hard financial data. Neutral, factual, no competitor-bashing needed — the numbers are public filings. Very high AI-citation potential as a data explainer. | **Medium** | Data explainer with chart | [NPR, 23 Aug 2026](https://www.npr.org/2026/08/23/nx-s1-5938103/have-dating-apps-lost-their-luster-data-shows-a-decline-in-users); [Adjust, State of Dating Apps 2026](https://www.adjust.com/blog/state-of-dating-apps/); Business of Apps market-revenue piece (verify manually — 403s to bots); [SSRS, 2 Feb 2026](https://ssrs.com/insights/online-dating-2026/) |
| 6 | **Slow dating: what it means, and what it costs you** | "slow dating", "what is slow dating", "intentional dating" | Weakest SERP I found anywhere — a FODMAP recipe blog ranks page 1 **[F]**. Definitional gap, and it is the closest cultural label to Qulo's mechanic. Only Coffee Meets Bagel defends it, at ~monthly cadence **[F]**. | **Low** | Definitional explainer | [Coffee Meets Bagel, "The Slow Burn", 31 Aug 2026](https://coffeemeetsbagel.com/blog/); [Apptopia 2019](https://apptopia.com/en/insights/does-dating-app-seasonality-exist/); Forbes Health/OnePoll burnout data. **Do not** reuse the site's unsourced "72% prefer slow dating." |
| 7 | **Dating Sunday, decoded: what the 40% actually refers to** | "dating sunday", "dating sunday 2027", "when is dating sunday" | Everyone republishes the stats; nobody separates **signups** from **engagement**. Tinder's own release says ~+20% swipes / +15% likes — modest — while the 40–75% figures circulating are signup numbers **[F]**. A precise, neutral piece is uniquely citable and lands in the biggest traffic week of the year. | **Medium** | Seasonal data explainer | [Tinder Press Room, 19 Dec 2024](https://au.tinderpressroom.com/news?item=122599) (+~20% swipes, +15% likes, +~20% messages; defines "Peak Dating Season" as Jan 1–Feb 14); [Wikipedia: Dating Sunday](https://en.wikipedia.org/wiki/Dating_Sunday) (origin: Match.com, 2014–2015); [Similarweb, 9 Feb 2023](https://www.similarweb.com/blog/insights/ecommerce-news/dating-apps-valentine-day/) (no Feb 14 bump; Jan 2023 apps −14% YoY) |
| 8 | **The 12-question compatibility check (scored, not a listicle)** | "compatibility questions", "questions to test compatibility", "how compatible are we" | eharmony owns *volume*; the audit found **nobody owns structure** **[F]**. Publish an instrument with scoring and a stated rationale per question, not a 273-item dump. Doubles as a product demo. | **Medium** | Interactive + methodology page | [Aron et al. 1997](https://journals.sagepub.com/doi/10.1177/0146167297234003); Huang et al. 2017; [Hinge 2025 Gen Z report](https://hinge.co/newsroom/2025-GenZ-Report) on which question types work |
| 9 | **What singles are actually using AI for in dating** | "AI dating", "using ChatGPT for dating", "AI dating statistics" | Rich, freshly sourced, high news-adjacency. Pairs with #2 as a cluster. | **Medium** | Data explainer | Match/Kinsey *Singles in America* via [Global Dating Insights](https://www.globaldatinginsights.com/featured/ai-usage-in-dating-jumps-300-but-its-limitations-are-important/) (54% of daters using AI tools, +333% YoY); [Norton "Artificial Intimacy" report, 27 Jan 2026](https://newsroom.gendigital.com/2026-01-27-Made-For-You-Norton-Study-Reveals-77-Would-Date-an-AI); [TNW, 20 Jul 2026](https://thenextweb.com/news/chatfishing-ai-dating-apps-chatgpt-claude-tinder-hinge) |
| 10 | **Questions you can't answer with a search engine** | "questions to ask that reveal personality", "questions you can't fake", "questions to catch a liar online dating" | The purest expression of Qulo's mechanic — a question with a *verifiable* answer. No one owns this framing. Bridges the question-bank cluster without fighting eharmony's volume. | **Low** | List + rationale (each question explained) | Huang et al. 2017; [FTC, Apr 2026](https://www.ftc.gov/news-events/news/press-releases/2026/04/new-ftc-data-show-people-have-lost-billions-social-media-scams); Norton 2025 dating report |
| 11 | **Romance scams in 2026: the questions that break the script** | "romance scam", "how to spot a fake dating profile", "is he a scammer" | High-stakes, high-authority topic with **excellent** free primary data. Differentiates from the existing safety post by being scam-specific and data-led rather than general tips. | **Medium–High** (FTC, banks, security vendors rank) | Data + practical checklist | [FTC press release, Apr 2026](https://www.ftc.gov/news-events/news/press-releases/2026/04/new-ftc-data-show-people-have-lost-billions-social-media-scams); [FTC Data Spotlight, Apr 2026](https://www.ftc.gov/news-events/data-visualizations/data-spotlight/2026/04/reported-losses-scams-social-media-eight-times-higher-2020); [Norton NCSIR Online Dating 2025 (PDF)](https://www.gendigital.com/media/tiyfeb1a/ncsir_online_dating_global_deck__fy25-final.pdf) |
| 12 | **Ghosting: what the research says about who does it and why** | "ghosting statistics", "why do people ghost", "ghosting psychology" | Peer-reviewed 2025 source available; current SERP is small commercial sites. Feeds the statistics hub. | **Medium** | Data explainer | [*Journal of Social and Personal Relationships*, 2025, "Ghosting perceptions across gender, relationship contexts…"](https://journals.sagepub.com/doi/10.1177/02654075251360612); [datingadvice.com ghosting statistics](https://www.datingadvice.com/studies/ghosting-statistics-by-age-gender). **Replace** the site's unsourced "80%+ ghosting rate." |
| 13 | **Where singles are actually meeting in 2026** | "how to meet people without dating apps", "run clubs dating", "IRL dating events" | Genuinely newsworthy, heavily covered by major outlets — which means it is *linkable*, and it lets Qulo take a non-defensive position ("the mechanic was the problem, not the internet"). | **Medium–High** (Axios, CNN, Vice cover it) | Trend explainer | [Axios San Francisco, 7 Aug 2026](https://www.axios.com/local/san-francisco/2026/08/07/san-francisco-post-app-dating); [CNN singles-night feature](https://edition.cnn.com/world/dating-app-burnout-reinvents-the-singles-night-spc); [Adjust State of Dating Apps 2026](https://www.adjust.com/blog/state-of-dating-apps/) |
| 14 | **TR: "36 soru" — oynanabilir Türkçe sürüm** | "36 soru aşık olmak", "aşık eden 36 soru" | **Format gap confirmed [F]:** Turkish results are all news articles (CNN Türk, Cumhuriyet, Habertürk, Ekşi); only one tiny site offers an interactive test. Nobody owns a playable Turkish version. Home market. | **Low** | Interactive, written natively in TR | [Aron et al. 1997](https://journals.sagepub.com/doi/10.1177/0146167297234003); [The Conversation, "Can 36 questions really change your love life?"](https://theconversation.com/can-36-questions-really-change-your-love-life-273611); [CNN, 8 Feb 2025](https://www.cnn.com/2025/02/08/health/questions-lead-to-love-research-wellness/) |
| 15 | **SV: "36 frågor" + "dejtingapp utan swipe"** | Swedish core cluster | **Weakest SERP observed in any language [F]:** English-language pages and even a Korean App Store listing rank for Swedish queries; "36 frågor" is held by a hotel chain's blog. Genuinely unowned. | **Low** | Native Swedish explainer + interactive | Aron et al. 1997; [strawberry.se](https://www.strawberry.se/blog/nara-hjartat/36-fragor-for-att-bli-kar/) (the incumbent, for gap analysis) |
| 16 | **PL: "aplikacja randkowa bez przesuwania"** | Polish no-swipe + first-date questions | **[F]** Polish SERP is held only by tech-media listicles (spidersweb, antyweb, dobreprogramy, android.com.pl) and elle.pl — no dating-advice authority exists in Polish. "36 pytań" has a single beatable incumbent (National Geographic PL). | **Low–Medium** | Native Polish explainer | Aron et al. 1997; [national-geographic.pl](https://www.national-geographic.pl/ludzie/jak-sie-zakochac/) (incumbent) |
| 17 | **DE: "Dating App ohne Swipen" — was die Alternativen wirklich können** | German no-swipe cluster only | **[F]** German no-swipe SERP ranks personal-name domains and tiny blogs — no brand wall. Large market. **Avoid German "36 Fragen"**: Parship owns it. | **Medium** | Native German explainer | [Adjust State of Dating Apps 2026](https://www.adjust.com/blog/state-of-dating-apps/); Forbes Health/OnePoll 2024 |
| 18 | **The asymmetry: who opens the deep conversation** | "who should text first", "why do women wait for men to ask", "conversation asymmetry dating" | Hinge published the data — 49% of het Gen Z women hesitate to open a deep conversation vs 17% of men **[S]** — and then wrote nothing about it. Untouched territory with a brand-validated stat. | **Low** | Explainer | [Hinge 2025 Gen Z D.A.T.E. report](https://hinge.co/newsroom/2025-GenZ-Report); Huang et al. 2017 |

**Suggested sequencing.** #1, #3, #6, #10 first — all Low difficulty and all directly on-mechanic, so they compound. #4 and #7 are seasonal and have hard deadlines (§5). #14–17 should not start until the localization rule in §7 is agreed.

---

## 3. Evergreen hub / answer pages (not blog posts)

These are the assets that earn citations and hold rankings; blog posts decay.

1. **`/dating-statistics` — rebuild, not expand.** Currently ~1,500–2,000 words with ~20 claims and 4 vague attributions **[F]**. Rebuild with one row per stat: figure, publisher, report title, publication date, sample size, methodology URL. Keep the "Cite This Report" block *only after* this is done. This is the single highest-ROI page on the site.
2. **`/questions/` — a structured question hub.** Not a 273-item listicle (unwinnable vs eharmony). Sub-pages by *situation*: opening message, before meeting, first date, values, long-distance. Each question annotated with what it actually reveals. This is the long-tail net and the AI-citation surface, and it is the only version of the question cluster Qulo can defend.
3. **`/glossary` — expand with the 2026 vocabulary, one anchored answer block per term.** Missing and worth adding: *chatfishing*, *hardballing*, *beige flag*, *micro-mance*, *question deficit*, *slow dating*, *situationship*, *breadcrumbing*, *cloaking*, *dry dating*. Glossaries are answer-shaped and get pulled into AI answers. Sources: [Merriam-Webster slang pages](https://www.merriam-webster.com/slang/cuffing-season), [Psychology Today, Jan 2025](https://www.psychologytoday.com/us/blog/the-psychology-of-relationships/202501/decoding-modern-dating-the-new-lingo-you-need-to-know), [Wikipedia: Chatfishing](https://en.wikipedia.org/wiki/Chatfishing).
4. **One calculator that outputs a *public* statistic.** This is the highest-evidence recommendation in §4. Not a personal-score quiz — a tool whose output is a quotable population number.
5. **Ensure `/features/dating-without-swiping` is structured as a ranked list.** 63% of ~400M AI citations point to listicles ([Evertune via Search Engine Land, 19 May 2026](https://searchengineland.com/ai-search-loves-listicles-what-25000-urls-reveal-about-citations-477682)); for commercial-intent queries listicles take 40.9% ([Wix Studio AI Search Lab via Search Engine Land, 24 Mar 2026](https://searchengineland.com/ai-citations-favor-listicles-articles-product-pages-study-472364)). Ranked-list structure is the format AI answers reach for. Include Qulo honestly among alternatives; do not disparage others.
6. **Add visible publish + update dates everywhere.** The audit found Bumble's Buzz articles carry **no dates at all** **[F]**. That is a free differentiator on a trust signal. (Keep honoring the existing `updatedAt` rule in `blog.ts` — bump it only on real revisions.)
7. **Audit `/country` (10) and `/dating` (10 cities) for thin content** before adding more. Programmatic location pages with little unique substance are the classic scaled-content risk.

---

## 4. Formats that actually earn links and citations

Evidence, ranked by strength:

- **Listicles win AI citations.** 63% of ~400M citations across ChatGPT, Copilot, Gemini, AI Mode, AI Overviews and Perplexity pointed to listicles ([Evertune, 19 May 2026](https://searchengineland.com/ai-search-loves-listicles-what-25000-urls-reveal-about-citations-477682)); 40.9% for commercial-intent queries ([Wix, 24 Mar 2026](https://searchengineland.com/ai-citations-favor-listicles-articles-product-pages-study-472364)). *This is almost certainly the origin of the "62.4%" figure in the earlier internal research; the 9.5% app-store-listing figure could not be sourced and should be dropped.*
- **Listicles lose *backlinks*.** In the Backlinko/BuzzSumo study of 912M posts, list posts ranked **last** for referring domains, while "why"/"what" posts and infographics got 25.8% more ([Backlinko, 19 Feb 2019](https://backlinko.com/content-study)). **[I] These two findings are not in conflict — they say to write listicles for AI citation and explainers for links, and to publish both.**
- **The one verified small-brand press win in this niche is a calculator that outputs a public statistic.** Keeper's "Dating Standards Calculator" was covered by the NY Post (3 Apr 2024), Daily Mail and The Drew Barrymore Show ([keeper.ai/press](https://www.keeper.ai/press)). It worked because it produced a headline-able population number, not a personal score.
- **Personal-score quizzes are poor link assets.** Fractl's ZipHealth "Intimacy Quiz" earned **3 referring domains** in under two months, versus 560+ for a tool outputting public data ([frac.tl](https://www.frac.tl/the-most-highly-linked-to-pages-successful-content/)). Interactivity is not the variable; citability of the output is.
- **Original surveys work but need a co-sign.** Match's *Singles in America* runs annually with the Kinsey Institute (14th edition, 5,001 US singles, [10 Jun 2025](https://match.mediaroom.com/2025-06-10-Match-and-The-Kinsey-Institute-Unveil-14th-Annual-Singles-in-America-Study)). **[I]** For a small brand the replicable version is the Forbes Health template: a ~1,000-respondent OnePoll-style panel, published *with* methodology.
- **Reddit is a permanent SERP fixture.** Reddit appeared in 97.5% of 10,000 product-review keyphrases ([Detailed.com via Search Engine Land, 14 Feb 2024](https://searchengineland.com/reddit-dominates-google-search-discussions-forums-437501)); its top-3 share rose to 10.24% after the May 2026 core update ([SE Ranking](https://seranking.com/blog/google-may-2026-core-update-analysis/)). r/dating_advice ~4.5M members. Genuine participation, not link-dropping.
- **HARO is alive again.** Cision shut down Connectively on [9 Dec 2024](https://www.seroundtable.com/haro-connectively-platform-closing-38388.html); Featured.com acquired HARO and relaunched it free on [22 Apr 2025](https://www.prnewswire.com/news-releases/featuredcom-acquires-help-a-reporter-out-haro-from-cision-302428717.html). Viable for founder-as-expert quotes.
- **Unverified — do not build a plan on these:** the widely repeated "interactive content generates 4.1× more links" and "data studies attract 3.2× more links" claims appear only in secondary blogs; Fractl's own page contains no such multipliers.

**Concrete build order:** rebuild the statistics hub → ship one public-output calculator → convert its dataset into a ranked listicle on-domain → pitch the resulting number seasonally. One dataset, three assets.

---

## 5. Seasonal publishing calendar

**Lead time:** 90 days for competitive head terms, 45–60 for long-tail — indexing, technical work and link acquisition take 8–12 weeks to move visibility ([Search Engine Land SEO seasonality guide, updated 22 Apr 2026](https://searchengineland.com/guide/seo-seasonality)).

**Confirmed dates:** 1 Jan 2027 is a Friday → **Dating Sunday 2027 = Sunday 3 January 2027**. **Valentine's Day 2027 falls on a Sunday** — a rare alignment.

| Window | Event | Evidence | **Publish by** | Angle |
|---|---|---|---|---|
| Sep–Nov 2026 | Cuffing-season ramp | Hinge: most messages sent in **October** ([4 Sep 2025](https://hinge.co/newsroom/cuffing-season-guide-2025)) | **Immediately** — already inside lead time | Article #4 (myth-check) |
| ~8–14 Dec 2026 | Breakup peak | Peak two weeks before Christmas; 10,000 scraped statuses ([Fast Company](https://www.fastcompany.com/1662655/infographic-when-do-people-break-up)) — *2010, non-peer-reviewed, directional only* | 10 Sep 2026 | "What to ask before you date again" |
| 3 Dec 2026 | Tinder *Year in Swipe* slot | Locked annually: 3 Dec 2024, 3 Dec 2025 **[F]** | — | **Do not** compete |
| 26 Dec 2026 | Boxing Day signup spike | Coffee Meets Bagel: +71% signups 26 Dec (app-reported) | 27 Sep 2026 | "The 26 December reset" |
| **Sun 3 Jan 2027** | **Dating Sunday** | Tinder: ~+20% swipes, +15% likes vs annual average ([19 Dec 2024](https://au.tinderpressroom.com/news?item=122599)) | **5 Oct 2026** ⚠️ hard deadline | Article #7 |
| 1 Jan – 14 Feb 2027 | **"Peak Dating Season"** (Tinder's own definition) | Same release | 5 Oct 2026 | The real campaign unit — not one day |
| Late Jan → 14 Feb 2027 | Valentine's run-up | US searches 17.2M (Jan) → 37.9M (Feb); global 31M → 104M; peak 7–14 Feb ([Semrush, 11 Feb 2025](https://www.semrush.com/news/380949-valentines-day-a-data-driven-love-story-of-trends-searches-and-online-dating/)) | **16 Nov 2026** ⚠️ hard deadline | Articles #8, #10 |
| Mar–Apr 2027 | Secondary breakup peak | Fast Company/McCandless (same caveat) | Jan 2027 | "Spring reset" |
| May–Aug 2027 | **Installs up, engagement down** | Summer installs +8% vs winter, sessions −14% ([Apptopia, 26 Mar 2019](https://apptopia.com/en/insights/does-dating-app-seasonality-exist/)) | Feb–Mar 2027 | Target acquisition in May; expect weak Jul–Aug engagement |
| Nov 2027 | **Softest trend-report month** | Hinge's Gen Z slot moved Feb 2024 → Nov 2025 and is not stable **[F]**; Dec is Tinder's, Jun is Hinge Pride + Match | Aug 2027 | Best window for an original Qulo survey |
| Sep–Oct 2027 | Cuffing 2027 | As above | **3 Jul 2027** | Repeat |

**Two deadlines dominate everything: 5 October 2026 (Dating Sunday / Peak Season) and 16 November 2026 (Valentine's).**

⚠️ **Flags on the seasonal folklore — do not restate these as fact:**
- Every Dating Sunday percentage is app self-reporting with undisclosed methodology. [Wikipedia](https://en.wikipedia.org/wiki/Dating_Sunday) traces it to Match.com, 2014–2015.
- The 40–75% figures are **signups**; the 10–20% figures are **engagement**. Never combine them in one sentence.
- Counter-evidence exists: Apptopia (2019) concluded dating seasonality is not clean and its own hypothesis "was wrong"; [Similarweb (9 Feb 2023)](https://www.similarweb.com/blog/insights/ecommerce-news/dating-apps-valentine-day/) found **no** Feb 14 traffic bump.
- Cuffing season is **bimodal** per Markey & Markey (2013) — the cold-weather causal story is unsupported.
- I could not find a published, primary Google Trends curve for "dating apps"/"best dating apps". If you need it, pull and screenshot it yourself rather than citing a secondhand blog.

---

## 6. Don't bother — and why

| Idea | Why not |
|---|---|
| **"Best dating apps 2026" listicles** | Crowded affiliate warzone (grass.camp, nexspark, scimatch, impressivemagazine) plus Forbes Health and Tom's Guide **[F]**. Qulo is a *listed* app, not a reviewer — self-ranking is a credibility problem, and it invites the competitor-comparison tone the brand rules forbid. Win these as a *cited entity* on other people's listicles instead. |
| **"Green flags / red flags in a relationship"** (head terms) | CNBC, TODAY, Calm, Wondermind, Bumble, Grindr, loveisrespect and thehotline hold page 1 **[F]**. Nonprofit + big-media wall. `/advice/red-flags-online-dating` already exists — deepen it rather than adding posts. |
| **"36 questions to fall in love" in English or German** | eharmony has a dedicated page; German is owned by Parship, plus blick.ch, jolie.de, woman.at **[F]**. Press-saturated. Do it in **TR / SV / PL / JA** only (#14–16). |
| **Mega question listicles in English** ("200 questions to ask…") | Direct assault on eharmony's 197/273/189/269/233/226-item library with dense internal linking **[F]**. Unwinnable on volume. Compete on structure (§3.2) instead. |
| **"How to know if someone likes you over text"** | Winnable SERP but essentially zero commercial intent, off-mechanic, and it attracts readers who are not looking for an app. Traffic without conversion. |
| **"Would you rather questions for couples"** | Targets people already in relationships — the wrong funnel entirely. The Knot and Paired hold it anyway **[F]**. |
| **A generic attachment-style quiz** | Commodity format; ZipHealth's comparable intimacy quiz earned **3 referring domains** ([Fractl](https://www.frac.tl/the-most-highly-linked-to-pages-successful-content/)). Off-mechanic and a poor link asset. |
| **An annual coined-term trend report in December** | Tinder's *Year in Swipe* owns 3 December; Bumble's Global Dating Trends lands nearby **[F]**. No PR budget wins that week. Use **November** (§5). |
| **Astrology / star-sign compatibility** | Bumble owns the category, and it conflicts with the no-fabricated-claims rule. |
| **Auto-translating posts into all 16 locales** | Google's spam policies (updated 28 Aug 2026) name "automated transformations like synonymizing, **translating**, or other obfuscation techniques" under *scaled content abuse* ([developers.google.com](https://developers.google.com/search/docs/essentials/spam-policies)). Fanning one post out to 16 machine translations is the exact named pattern. |
| **Infographics as a link strategy** | The supporting evidence is the 2019 Backlinko study; no recent corroboration, and distribution channels have changed. |
| **More `llms.txt` / extra schema work** | Already tested and rejected in the [Aug 2026 AI-search research](./seo-ai-search-research-2026-08.md). Nothing here changes that. |

---

## 7. Non-English: real, but conditional

**The structural asymmetry is confirmed.** English is **49.5%** of websites with an identifiable content language ([W3Techs, snapshot 2026-09-01](https://w3techs.com/technologies/overview/content_language)) **[F]**, against roughly a quarter of internet users. Turkish is 1.6%; Polish 1.8%; Swedish does not reach the top 20.

**But there is no published keyword-difficulty-by-language study.** A commonly cited source for this was checked and does not contain the claim. Do not cite one. The evidence below is observed SERP composition.

**Ranked opportunity [I], from observed SERPs [F]:**

1. **Turkish** — thinnest SERPs tested anywhere. "flört uygulaması yorgunluğu" returned **zero Turkish results** — all English. Advice queries are owned by forums (kızlarsoruyor, Ekşi Sözlük). Home market. Clear #1.
2. **Swedish** — weakest competition observed in any language; English and even Korean pages rank for Swedish queries; "36 frågor" held by a hotel blog. Small audience caps upside.
3. **Polish** — no Polish dating-advice authority exists; only tech-media listicles.
4. **German** — large market, no brand wall on "ohne Swipen". **Avoid "36 Fragen"** (Parship).
5. **Dutch** — decent penetration (14.14%, [swipestats.io, 24 Apr 2026](https://www.swipestats.io/blog/online-dating-statistics-worldwide)) but real incumbents (Breeze, attractiongym.nl).
6. **French** — marginal; WeddingWire properties own the question queries.

**Not worth it:** **Spanish** (WeddingWire + xataka + national newspapers — a big-media wall) and **Japanese** on core dating-app terms (one of the most commercialized affiliate niches anywhere; the *only* Japanese opening is the 36-questions sub-niche, where tiny note.com blogs rank). **pt, it, ru, ar, hi, ko, zh were not tested** — no evidence either way, and ru/ar/zh carry platform and regulatory risk for dating content that should be checked first.

**Binding rule:** write natively per locale, few posts, human-reviewed. Never fan one post out to 16 translations (see §6).

*Method caveat: WebSearch is US-geolocated, so these are not true in-country SERPs. Domain composition is informative; absolute rank order is not.*

---

## 8. Sourced replacements for the unsourced stats

Use these to rebuild `/dating-statistics` and `/trends/2026`:

| Claim | Source | Date | Sample |
|---|---|---|---|
| 37% of US adults have ever used a dating site/app; 6% currently | [SSRS, *The Public and Online Dating 2026*](https://ssrs.com/insights/online-dating-2026/) | 2 Feb 2026 | n=2,012, MoE ±2.5 |
| 51% of 18–29s and 53% of 30–49s have used online dating | SSRS (same) | 2 Feb 2026 | as above |
| 57% think meeting an app match in person is generally safe; women far more sceptical (55% vs 30% say unsafe) | SSRS (same) | 2 Feb 2026 | as above |
| 78% of US dating-app users report burnout (women 80% / men 74%) | Forbes Health / OnePoll, via [Global Dating Insights](https://www.globaldatinginsights.com/news/new-forbes-study-explores-dating-app-burnout/) | fielded 27 Mar – 1 Apr 2024 | n=1,000, MoE ±3.1 |
| 62% of het Gen Z daters think they ask enough questions; only 30% feel their dates do | [Hinge 2025 Gen Z D.A.T.E. Report](https://hinge.co/newsroom/2025-GenZ-Report) | 19 Nov 2025 | ~30,000 daters |
| Consumers reported $1.16bn lost to romance scams in nine months of 2025; ~60% started on social media | [FTC](https://www.ftc.gov/news-events/news/press-releases/2026/04/new-ftc-data-show-people-have-lost-billions-social-media-scams) | Apr 2026 | FTC consumer reports |
| 60% of dating-app users believe they've had an AI-written conversation | [Norton Cyber Safety Insights Report: Online Dating 2025 (PDF)](https://www.gendigital.com/media/tiyfeb1a/ncsir_online_dating_global_deck__fy25-final.pdf) | 2025 | see deck |
| 54% of daters using AI tools, +333% YoY | Match/Kinsey via [Global Dating Insights](https://www.globaldatinginsights.com/featured/ai-usage-in-dating-jumps-300-but-its-limitations-are-important/) | 2025 | 5,001 US singles |
| Speed daters who ask more questions get more second dates | [Huang, Yeomans, Brooks, Minson & Gino, *JPSP* 2017](https://www.hbs.edu/ris/Publication%20Files/Huang%20et%20al%202017_6945bc5e-3b3e-4c0a-addd-254c9e603c60.pdf) | Sept 2017 | 110 speed daters, 15–19 dates each |
| Escalating self-disclosure generates closeness between strangers in ~45 min | [Aron, Melinat, Aron, Vallone & Bator, *PSPB* 23(4) 363–377](https://journals.sagepub.com/doi/10.1177/0146167297234003) | Apr 1997 | — |
| Global dating-app installs −4%, sessions −7% YoY (2025) | [Adjust, *State of Dating Apps 2026*](https://www.adjust.com/blog/state-of-dating-apps/) | 2026 | — |

**Delete outright** (no source found, and none likely exists): "quiz dating search volume +200%", "72% prefer slow dating", "85% want AI matching", "30-40% cuffing-season usage increase", "80%+ ghosting rate", "115 swipes per match", "0.5s per profile", and the claim that Qulo platform data was analyzed.

⚠️ **Note on #1 and #18:** both lean on the Hinge 2025 Gen Z report, which the competitor audit confirmed **[F]** but whose specific asymmetry figure (49% vs 17%) came from a snippet **[S]**. Fetch and verify the report page before publishing either.

⚠️ **Overlap check before writing:** #1, #3 and #10 sit near the existing `science-behind-question-based-matching` post, and #3 sits near `/how-to/first-chat-tips`. Read those two before drafting; if Huang et al. 2017 is already used, angle #1 around the *deficit* framing rather than the study.

---

## 9. What I could not establish

- **No public keyword-volume data.** No SEO tool was available; every difficulty grade here is read off observed SERP composition, not from a KD score. Validate the shortlist in Ahrefs/Semrush before committing the calendar.
- **No published Google Trends curve** for "dating apps" / "best dating apps" from a primary source. Pull it directly if needed.
- **The "9.5% of AI citations are app store listings"** figure from the earlier internal research could not be sourced. Drop it.
- **Business of Apps** returns HTTP 403 to automated fetches; its market-revenue figures are reported here **[S]** and should be confirmed manually.
- **A distinct Bumble "2026" trends report** could not be found — search results appear to conflate it with the 2025 edition (fielded 19–23 Sep 2024). Do not cite a Bumble 2026 report without confirming it exists.
- **No Tinder or Match report titled "Future of Dating"** exists as far as I could verify. Do not cite one.
- **Market sizing by country is unresolved** — Statista country pages are paywalled. The frequently repeated "Sweden 45% penetration" figure could not be verified; do not use it.
