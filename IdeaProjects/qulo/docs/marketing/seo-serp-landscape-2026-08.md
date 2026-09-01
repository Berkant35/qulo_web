# Qulo — SERP & AI-Answer Landscape (Research Report)

**Observation window:** 2026-08-27 → 2026-09-01
**Method:** live `WebSearch` queries + `WebFetch` verification of individual pages.
**Scope:** English-language US-biased SERPs, plus a Turkish-language spot check.

## 0. Read this first — tool limitations (be honest about these)

Three limits shape what this report can and cannot claim:

1. **Reddit is not crawlable by our agent.** `reddit.com` is explicitly blocked to
   this user-agent (`API Error 400: domains not accessible`). Our search provider
   also returned **zero** `reddit.com` URLs even for a control query where Reddit
   certainly ranks ("best mechanical keyboard reddit" → returned only Tom's Guide,
   TechRadar, Adorama). **Conclusion: the absence of Reddit in the tables below is
   a tool artifact, not evidence that Reddit doesn't rank.** Section 2 works around
   this with third-party citation studies instead of direct observation.
2. **We cannot observe Google AI Overviews directly.** The search tool returns a
   link list, not the rendered Google SERP. No claim in this report about "AI
   Overviews showed X" is first-hand; Section 4 uses published citation studies and
   labels them as such.
3. **Result ordering is approximate.** The tool returns ~6–10 results without
   position numbers. Treat "top ~10" as "present on page one", not "ranked #3".

Anything below that we could not verify is marked **[unverified]**.

---

## 1. Per-query SERP tables

### 1.1 `dating app without swiping`

| # | Result | Page type | Own-brand site? |
|---|---|---|---|
| 1 | [thecrimson.com/sponsored/article/pickable](https://www.thecrimson.com/sponsored/article/pickable/) | **Sponsored** advertorial on a student-newspaper domain | No |
| 2 | [goodmorningamerica.com — "No more swiping right: 3 dating apps"](https://www.goodmorningamerica.com/living/story/swiping-dating-apps-adventurous-57228861) | Legacy news listicle (old, still ranking) | No |
| 3 | [refinery29.com — "Swiping Is Dead"](https://www.refinery29.com/en-gb/2018/06/201108/dating-apps-no-swiping) | Magazine trend piece (2018, still ranking) | No |
| 4 | [techcrunch.com — Gen Z dating apps like Ditto ditch swiping (2026-08-06)](https://techcrunch.com/2026/08/06/gen-z-dating-apps-like-ditto-ditch-swiping-in-favor-of-ai-matchmaking/) | Tier-1 tech press, **fresh** | No |
| 5 | [play.google.com — Yeet: Dating Powered by Yeeta](https://play.google.com/store/apps/details?id=com.dating.yeet&hl=en_US) | App store listing | Store |
| 6 | [trendhunter.com — No-Swipe Gen Z Dating App](https://www.trendhunter.com/trends/noswipe-dating-app) | Trend-directory entry | No |
| 7 | [two-dating.com](https://www.two-dating.com/en/) | **Brand homepage** | **Yes** |
| 8–10 | [datopia.world](https://www.datopia.world/en/alternative-dating-approaches/no-profile-dating-apps/) ×3 clustered pages | Programmatic/thin SEO cluster | No |
| 11 | [breeze.social](https://breeze.social/) | **Brand homepage** | **Yes** |

**Read:** this query is *not* locked up by big publishers. Two indie brand homepages
(Breeze, twoLove) hold page one, and a thin programmatic site (datopia.world) holds
three slots. That is a soft SERP. The fresh TechCrunch piece shows the topic is
editorially live right now.

### 1.2 `dating app where you answer questions`

| # | Result | Page type | Own-brand site? |
|---|---|---|---|
| 1 | [Google Play — Question: Dating App](https://play.google.com/store/apps/details?id=com.questionDatingApp) | App store | Store |
| 2 | [App Store — Question: Dating App](https://apps.apple.com/us/app/question-dating-app/id1529064641) | App store | Store |
| 3 | [App Store editorial story — "Find the Perfect Dating App for You"](https://apps.apple.com/us/story/id1600372033) | Apple editorial | Store |
| 4 | [bustle.com — String, inspired by "36 Questions"](https://www.bustle.com/articles/154834-string-dating-app-inspired-by-the-36-questions-that-lead-to-love-study-is-the-anti-tinder) | Magazine feature | No |
| 5 | [Google Play — Paired](https://play.google.com/store/apps/details?id=com.getpaired.app) | App store (couples app, not dating) | Store |
| 6 | [prnewswire.com press release](https://www.prnewswire.com/news-releases/this-app-matches-you-based-on-the-last-question-you-would-ask-before-the-world-ends-300863338.html) | **Press release, still ranking** | No |
| 7 | [Google Play — askBae](https://play.google.com/store/apps/details?id=at.davidschindler.askbae) | App store | Store |
| 8 | [buzzfeed.com dating-app review](https://www.buzzfeed.com/laraparker/dating-apps-review) | First-person review | No |
| 9 | [tiktok.com/discover topic page](https://www.tiktok.com/discover/app-where-you-and-partner-answer-questions) | **TikTok topic page** | No |
| 10 | [mamamia.com.au](https://www.mamamia.com.au/dating-app-pick-up-lines/) | Lifestyle magazine | No |

**Read:** app-store listings take ~half of page one. **Qulo does not rank here** even
though this query describes Qulo's mechanic almost literally. The intent is muddled —
Google is mixing dating apps with *couples* question apps (Paired, askBae). A
disambiguating page ("dating app where you answer *their* questions, not a quiz about
yourself") is an open slot. Note slot 6: a **PRNewswire press release from a tiny app
still ranks page one** — cheap, repeatable tactic.

### 1.3 `quiz based dating app` — **Qulo already ranks here**

| # | Result | Page type | Own-brand site? |
|---|---|---|---|
| 1 | [Google Play — Firefly, Quiz based matches](https://play.google.com/store/apps/details?id=com.datefirefly) | App store | Store |
| 2 | [trendhunter.com — Quiz-Based Dating Apps: short quizzes](https://www.trendhunter.com/trends/short-quizzes) | Trend directory | No |
| 3 | [trendhunter.com — Koko dating app](https://www.trendhunter.com/trends/koko-dating-app) | Trend directory | No |
| 4 | [App Store — Firefly](https://apps.apple.com/us/app/firefly-quiz-based-matches/id6443572946) | App store | Store |
| 5 | [App Store — Question: Dating App](https://apps.apple.com/us/app/question-dating-app/id1529064641) | App store | Store |
| 6 | [techcrunch.com — Cosmic uses personality quizzes (2023)](https://techcrunch.com/2023/08/28/free-dating-app-cosmic-uses-personality-quizzes-to-make-a-profile-for-you/) | Tech press | No |
| 7 | [quiz.getthursday.com](https://quiz.getthursday.com/) | **Brand microsite** | Yes |
| 8 | **[quloapp.com/en/features/quiz-dating-app/](https://quloapp.com/en/features/quiz-dating-app/)** | **Qulo feature page** | **YES — Qulo** |
| 9 | [blog.chatib.us dating-app-quiz](https://blog.chatib.us/online-chats/dating-app-quiz/) | Thin affiliate blog | No |

**This is the single most important finding in the report.** Qulo's own feature page
ranks page one for a commercial-intent query, and the search engine's own summary
carried Qulo's positioning verbatim ("the world's first quiz-based dating app…create
2–10 questions…match when someone answers them all correctly"). The `quiz dating`
head-term cluster is **winnable and partly already won**. See §6 for how to defend and
extend it.

Confirmed again on the variant query `"quiz dating" app match through questions no
swiping`: **both** `quloapp.com/en/` and `quloapp.com/en/features/quiz-dating-app/`
plus the Qulo Google Play listing appeared on page one.

### 1.4 `best dating apps 2026` — **do not fight for this**

| # | Result | Page type |
|---|---|---|
| 1 | [grass.camp — 12 Best Dating Apps for Serious Relationships](https://grass.camp/en-US/blog/best-dating-apps-serious-relationships) | **Competitor's own content-marketing blog** |
| 2 | [grass.camp — Best Dating Apps 2026: 13 Ranked](https://grass.camp/en-US/blog/best-dating-apps-2026-ranking) | Same — a competitor app owns two slots |
| 3 | [mindbodygreen.com](https://www.mindbodygreen.com/articles/best-dating-apps) | Major wellness publisher |
| 4 | [nexspark.com](https://nexspark.com/blog/best-dating-apps-2026) | Small SEO blog |
| 5 | [scimatch.com — Best Free Dating Apps 2026](https://scimatch.com/best-free-dating-apps/) | Competitor blog |
| 6 | [impressivemagazine.com](https://impressivemagazine.com/best-dating-apps-2026/) | Low-authority magazine |
| 7 | [forbes.com/health/dating](https://www.forbes.com/health/dating/best-online-dating-websites/) | Forbes Health |
| 8 | [tomsguide.com](https://tomsguide.com/best-picks/best-dating-apps) | Tier-1 tech publisher |

**Read:** three useful signals.

(a) The head term is defended by Forbes/Tom's Guide/mindbodygreen — hopeless to rank
against directly. Note these are the exact outlets AI assistants cite (§4), so being
*inside* their listicles matters far more than outranking them.

(b) **But `grass.camp` and `scimatch.com` — both dating apps themselves — hold slots 1,
2 and 5 with their own blogs.** The winning shape is not "outrank Forbes", it is
"publish a genuinely useful comparison post on your own domain and pick up the softer
positions".

(c) **There is a right and a wrong way to do (b), and both are on this SERP.** Verified
by fetch:
- **GRASS does it well.** Its post ranks 13 apps and says up front: *"Full disclosure:
  this article is written by the GRASS team. We'll give honest pros and cons for every
  app — including our own."* It then places **itself 4th**, behind Tinder, Bumble and
  Hinge. Two page-one slots earned with a disclosed, self-deprecating ranking.
- **SciMatch does it badly.** Its "Free Dating Index™" ranks **SciMatch #1** with
  perfect scores, above Hinge, Bumble and Tinder, on a proprietary scoring system it
  owns. Structurally biased, and obvious to any reader.

**Recommendation for Qulo: copy GRASS's pattern exactly.** A disclosed comparison post
that ranks Qulo honestly — mid-table, with real pros and cons for every app named and
no disparagement of any of them — is both the more credible artifact and the one
demonstrably holding the better SERP positions. Contact: `service@grass.camp`,
`info@scimatch.com` / `scimatch.com/contacts/`.

### 1.5 `alternatives to swiping dating`

| # | Result | Page type |
|---|---|---|
| 1 | [the-messenger.com — 7 dating app alternatives](https://www.the-messenger.com/features/lifestyles/article_638763fc-2513-5970-ba75-d9b16d4f64b2.html) | News-syndication listicle |
| 2 | [vidaselect.com — 10 Proven Alternatives to Online Dating](https://www.vidaselect.com/alternatives-to-online-dating) | Dating-coach blog (high authority in niche) |
| 3 | [lovefinder.blog — Dating Apps for People Who Hate Swiping (2026)](https://lovefinder.blog/dating-apps-for-people-who-hate-swiping/) | Editorial-leaning affiliate blog |
| 4–8 | [datopia.world](https://www.datopia.world/en/alternative-dating-approaches/alternative-dating-apps/) ×4 clustered pages | Programmatic SEO cluster |
| 6 | [mastermatchmakers.com](https://www.mastermatchmakers.com/tv-media/blogs/id/18630/the-best-alternatives-to-dating-apps-2026) | Matchmaking-service blog |
| 9–10 | [alternativeto.net](https://alternativeto.net/software/rove-dating) product-alternative pages | **User-editable directory** |

**Read:** `datopia.world` occupying 4+ slots across two different queries with
programmatic pages proves this SERP has **low competitive quality**. `alternativeto.net`
ranking is directly actionable — it is a directory anyone can add a product to.

Verified by fetch: **lovefinder.blog** names Hinge, eHarmony, OkCupid, Coffee Meets
Bagel, EliteSingles, Match.com. **Qulo is absent.** It has a working contact form at
`https://lovefinder.blog/contact/`.
Verified by fetch: **datopia.world** names essentially only *CarpeDM* plus generic
categories — it is thin/likely-sponsored content with **no visible submission path**.

### 1.6 `dating app for meaningful connections` — **do not fight for this**

| # | Result | Page type |
|---|---|---|
| 1 | [feeld.co](https://feeld.co/) | Brand homepage (major app) |
| 2 | [Google Play — Bumble](https://play.google.com/store/apps/details?id=com.bumble.app) | App store (major app) |
| 3–4 | Google Play — Connect Dating, Perfect Match | App store |
| 5–6 | [mindbodygreen.com](https://www.mindbodygreen.com/articles/best-dating-apps) ×2 | Major publisher |
| 7 | [shannonkathleenphotography.com](https://shannonkathleenphotography.com/2025/06/06/best-dating-apps-for-long-term-relationships-2025-guide/) | Off-topic blog (weak result) |
| 8–9 | [match.com](https://www.match.com/p/singles/serious-dating/) ×2 | Brand landing pages |
| 10 | [findyourwalnut.com](https://www.findyourwalnut.com/post/best-dating-apps-for-healthy-relationships) | Small blog |

**Read:** dominated by brands with budget. The phrase "meaningful connections" is also
generic-marketing language — it maps to no distinctive Qulo mechanic. **Deprioritise.**

### 1.7 `how does question based matching work` — **informational, wide open**

| # | Result | Page type |
|---|---|---|
| 1 | [arxiv.org 1401.5710](https://arxiv.org/pdf/1401.5710) | Academic paper |
| 2–3 | USPTO patent PDFs (8010546, 7676466) | Patent documents |
| 4 | [getstream.io — How Dating App Algorithms Work](https://getstream.io/blog/dating-app-algorithms/) | **Developer-tooling blog — the only real explainer** |
| 5 | [woorise.com dating questionnaire template](https://woorise.com/templates/dating-questionnaire-form) | Form-builder template |
| 6 | [hdsr.mitpress.mit.edu — Matching Algorithms in Online Dating](https://hdsr.mitpress.mit.edu/pub/i4eb4e8b) | Academic journal |
| 7 | [datingadvice.com — How Does Match Work](https://www.datingadvice.com/online-dating/how-does-match-work) | Dating-review publisher |
| 8–9 | More patents / arxiv | Academic |

**Read: this is the best pure-SEO opening in the whole set.** The SERP is filled with
patents and arXiv PDFs because **no consumer-grade explainer exists**. A well-built
"How question-based matching works" explainer with a diagram, an honest comparison of
the three models (OkCupid-style compatibility %, eHarmony-style questionnaire, and
Qulo-style answer-the-author's-questions), and cited sources can plausibly take the top
non-academic slot. It is also the exact page shape AI assistants quote from.

### 1.8 `is there a dating app without photos first`

| # | Result | Page type |
|---|---|---|
| 1 | [salon.com — Would you try a dating app that didn't use photos?](https://www.salon.com/2017/05/28/dating-app-appentence/) | Magazine (2017, still ranking) |
| 2 | [App Store — Lovetastic: Pictureless Dating](https://apps.apple.com/us/app/lovetastic-pictureless-dating/id1482035379) | App store |
| 3 | [time.com — Meet Willow](https://time.com/3705332/meet-willow-the-dating-app-that-wont-judge-you-by-your-looks/) | Tier-1 magazine |
| 4 | [thecrimson.com/sponsored — Pickable](https://www.thecrimson.com/sponsored/article/pickable/) | Sponsored advertorial |
| 5 | [datingadvice.com — 9 Dating Sites That Don't Require Photos (Aug. 2026)](https://www.datingadvice.com/online-dating/dating-sites-that-dont-require-photos) | **Freshly updated niche listicle** |
| 6 | [hidnn.com/blog/dating-app-without-photos](https://hidnn.com/blog/dating-app-without-photos) | Brand blog |
| 7 | [freeappsforme.com — 12 Best Dating Apps Without Pictures](https://freeappsforme.com/dating-apps-without-pictures/) | App-listicle site |
| 8 | [swipetogether.com — Best Dating Apps Without Photos](https://swipetogether.com/blog/best-dating-apps-without-photos) | Independent review/quiz site (verified: not itself an app) |
| 9 | [datopia.world](https://www.datopia.world/en/alternative-dating-approaches/no-profile-dating-solutions/) | Thin SEO |

**Read:** Qulo is a **partial** fit here — photos exist, but they are gated behind
solving the questions. That is a real, honest angle ("photos come after the questions,
not before") and this SERP is soft below position 3. `datingadvice.com` updating its
page monthly ("Aug. 2026") is the single best outreach target on this query.

### 1.9 Turkish spot check — `soru sorarak eşleşme uygulaması / kaydırmasız tanışma uygulaması`

| # | Result | Page type |
|---|---|---|
| 1 | [tamindir.com — En Popüler Arkadaş Bulma ve Sohbet Uygulamaları 2026](https://www.tamindir.com/blog/android-icin-arkadas-bulma-ve-sohbet-uygulamalari_14497/) | Download-portal listicle |
| 2 | [donanimhaber.com — En iyi tanışma, flört & arkadaşlık uygulaması önerileri](https://www.donanimhaber.com/en-iyi-tanisma-flort-arkadaslik-uygulamasi-onerileri--192130) | Major TR tech forum/publisher |
| 3 | [App Store TR — Tinder](https://apps.apple.com/tr/app/tinder-arkada%C5%9F-edin-ve-bulu%C5%9F/id547702041?l=tr) | App store |
| 4 | [tamindir.com — Tinder Benzeri Arkadaşlık Uygulamaları](https://www.tamindir.com/liste/tinder-benzeri-arkadaslik-uygulamalari/) | Listicle |
| 5, 8 | [kizlarsoruyor.com](https://www.kizlarsoruyor.com/internet-teknoloji/q21412147-en-iyi-tanisma-uygulamalari-hangisi) ×2 | **Q&A forum — the TR equivalent of Reddit** |
| 6 | [teknolojioku.com](https://www.teknolojioku.com/sosyal-medya/en-iyi-5-ucretsiz-arkadas-bulma-uygulamasi-6948da6af11c0a650607ade2) | Tech blog |
| 7 | [10layn.com](https://10layn.com/10-arkadaslik-uygulamasi/) | Listicle blog |
| 9 | [techmedya.com](https://www.techmedya.com/yabancilarla-tanisma-uygulamasi/) | Listicle blog |

**Qulo appears in none of them**, despite Turkey being its home market.
Verified by fetch: `tamindir.com/liste/tinder-benzeri-arkadaslik-uygulamalari/` lists
OkCupid, Happn, Bumble, Badoo, Skout, MeetMe, Waplog, LivU, Azar — no Qulo — and the
page is stale ("2 YIL ÖNCE GÜNCELLENDİ"). Tamindir has a footer CTA literally labelled
**"UYGULAMA/OYUN EKLE VE TANIT"** (add & promote your app) and a contact page at
`https://www.tamindir.com/sayfa/iletisim/`. **This is the highest-conviction, lowest-
effort outreach target in the entire report** — a stale list, in Qulo's home market,
with an explicit "add your app" door.

---

## 2. Reddit / forum presence

**We could not observe Reddit directly** (see §0). What we can report:

- Our provider returned **no reddit.com URLs for any query in this report**, including
  a control query designed to force them. Treat Reddit's real SERP presence as
  **[unverified]** rather than absent.
- Reddit's influence is nonetheless measurable through AI-citation studies. Per
  [MaxAEO's Q1 2026 study](https://maxaeo.ai/blog/reddit-chatgpt-recommendations/)
  (1.21M citations, 3,200 weekly prompts × 12 weeks, Jan 5 – Mar 29 2026, 7 platforms,
  25,000 Reddit URLs sampled), Reddit's share of citations on recommendation-style
  prompts was: **Perplexity 17.9% (Jan) falling to 5.8% (late Mar)**, Google AI Mode
  9.6%, **ChatGPT 8.1%**, Google AI Overviews 7.2%, Grok 4.4%, Copilot 0.9%,
  Gemini 0.3%.
- Same study, useful mechanics: **71% of cited threads came from subreddits under
  500K members**; **comments produced 58% of citations, not posts**; the **median cited
  comment had only 38 upvotes**. Small subreddits and ordinary comments are what get
  cited — not viral posts.
- **Astroturfing is explicitly counter-productive and we are not doing it.** The same
  study found undisclosed promotional comments survived at **18%**, versus **83%** for
  comments where the author disclosed their affiliation. Account bans retro-actively
  delete previously-cited comments, so a burned account destroys past gains too.

**The language real people use** (harvested from the titles and body copy that actually
rank — these are the phrasings the SERP rewards, and they should drive page titles and
ad copy):

- "swipe fatigue", "dating app fatigue", "swipe burnout", "dating burnout"
- "tired of swiping", "people who hate swiping", "done with the apps"
- "ditch the swipe", "anti-swipe", "no-swipe", "swipeless"
- "slow dating", "intentional dating", "personality-first", "no-profile dating"
- "chat first, match later"
- Turkish: "kaydırmasız", "tanışma uygulaması", "arkadaş bulma uygulaması", "flört uygulaması"

Sources for these phrasings include [simplypsychology's 2026 dating-burnout
piece](https://www.simplypsychology.com/articles/dating-burnout-psychology),
[breeze-wellbeing.com](https://breeze-wellbeing.com/blog/dating-app-fatigue/),
[baredating.app's swipe-fatigue post](https://www.baredating.app/blog/swipe-fatigue),
and [Yahoo's round-up of Reddit men quitting the
apps](https://creators.yahoo.com/lifestyle/story/finding-joy-after-quitting-dating-apps-men-on-reddit-share-why-thy-never-going-back-to-swiping-141500144.html).

**Non-Reddit forum surfaces that *did* rank and are reachable:**
`kizlarsoruyor.com` (TR, twice on page one for the TR query), `tiktok.com/discover`
topic pages (page one for query 1.2), and `quora.com`.

---

## 3. Outreach target list

> **41 targets across six tiers.** Compiled from pages that **actually appeared** in the
> SERPs above, plus a directory sweep. Every contact path was verified by loading the
> page on 2026-09-01 (via browser for sites that 403 automated fetchers). Nothing here
> is invented — "no visible submission path found" and "unverified" mean exactly that.
> **Read §3.6 before pitching anyone**: six of the eight niche "review sites" that rank
> for our queries are actually competitor dating products.

### 3.1 Tier A — ranked for our target queries AND has a door

| Site / page | Ranks for | Character | Contact / submit path |
|---|---|---|---|
| [tamindir.com — Tinder Benzeri Arkadaşlık Uygulamaları](https://www.tamindir.com/liste/tinder-benzeri-arkadaslik-uygulamalari/) | TR "tanışma uygulaması" (page 1, ×2) | TR download portal, real editorial, list is **2 years stale** | `https://www.tamindir.com/sayfa/iletisim/` + footer CTA **"UYGULAMA/OYUN EKLE VE TANIT"** |
| [datingadvice.com — 9 Dating Sites That Don't Require Photos (Aug. 2026)](https://www.datingadvice.com/online-dating/dating-sites-that-dont-require-photos) | "dating app without photos first" | Established niche publisher, title carries an **Aug 2026** date → refreshed frequently | **`https://www.datingadvice.com/contact`** — embedded form (POSTs to `/contact-us`, reCAPTCHA-protected), **no mailto anywhere on the page**. Hard-403s automated fetchers but loads in a real browser. ⚠️ **Same publisher as DatingNews.com** (shared Gainesville FL office) — pitch one or the other, not both |
| [lovefinder.blog — Dating Apps for People Who Hate Swiping (2026)](https://lovefinder.blog/dating-apps-for-people-who-hate-swiping/) | "alternatives to swiping dating" | Editorial-leaning affiliate blog; verified Qulo absent | **`https://lovefinder.blog/contact/`** (verified live) |
| [alternativeto.net](https://alternativeto.net/) | "alternatives to swiping dating" (×2 slots) | **User-editable software directory**, listing is **free in 2026** | Account + email verification, then user icon → **"Suggest new application"** (step 2 auto-pulls from the iOS App Store). **Free submission sits in a review backlog of "at least a few months"; a $5 optional priority review turns it around in 1–2 business days with no approval guarantee** (per `alternativeto.net/faq/`). Contact `hello@alternativeto.net`; partnerships `partners@alternativeto.com`. Also add Qulo as an alternative on the Tinder/Hinge/OkCupid/Firefly pages |
| [trendhunter.com — Quiz-Based Dating Apps](https://www.trendhunter.com/trends/short-quizzes) | **"quiz based dating app" (#2 and #3)**, plus "dating app without swiping" | Trend directory; owns 2 of 9 slots on Qulo's best query | **`https://www.trendhunter.com/submit`** ("Add a Trend") and **`https://www.trendhunter.com/join`** (become a contributor). Submissions go to an editorial team for review. *(Article pages themselves returned 403 to our fetcher.)* |
| [donanimhaber.com — En iyi tanışma uygulaması önerileri](https://www.donanimhaber.com/en-iyi-tanisma-flort-arkadaslik-uygulamasi-onerileri--192130) | TR query #2 | Major TR tech publisher + forum | Editorial contact; forum thread is a legitimate participation surface |
| [iapplist.com — 11 Best Non-Swipe Dating Apps](https://iapplist.com/best-non-swipe-dating-apps/) | "dating apps without swiping" | App listicle, published 2026-01-07; lists Coffee Meets Bagel, Once, eHarmony, Hinge, OkCupid, Thursday, Boo, The League, Inner Circle, Match, POF — **Qulo absent** | **`https://iapplist.com/contact/` (verified live)** — form has an explicit **"App Suggestion"** dropdown option + a direct email. Caveat: the site's own About text says it "only write[s] about the apps Apple already put on your iPhone", which contradicts this listicle — treat as medium-probability |
| [freeappsforme.com — 12 Best Dating Apps Without Pictures](https://freeappsforme.com/dating-apps-without-pictures/) | "dating app without photos" | App-review listicle site | ⚠️ **Unverified** — returned HTTP 429 (rate-limited) to both fetch and browser attempts. Site is likely live but **no contact path was confirmed**. My earlier assumption of a submit page was not verified |
| [DatingNews.com](https://www.datingnews.com/) — e.g. [Best Dating Sites to Browse Without Signing Up](https://www.datingnews.com/apps-and-sites/best-dating-sites-to-browse-without-signing-up/) | "dating app without signup / without photos" cluster | **Trade press for the dating industry — the single strongest editorial target found.** Its "Apps & Sites" and "Movers & Shakers" sections literally exist to cover new app launches | **`https://www.datingnews.com/contact-us/`** — page verbatim invites "site suggestions, questions, partnership inquiries" but states it **cannot accommodate "guest posts, link exchanges, or other promotional content."** Editor `shanna@datingnews.com`, press `colleen@datingnews.com`. ⚠️ Same publisher as DatingAdvice.com — **pitch one, not both** |
| [DatingSiteReviews.com](https://www.datingsitereviews.com/write-for-us/) *(singular "Site" — a different site from datingsitesreviews.com in Tier C)* | Dating review site | Real review site; explicitly **refuses affiliate links and links to dating sites**, so this is a bylined-expertise play, not a backlink play | **`https://www.datingsitereviews.com/write-for-us/`** — wants 2000+ word dating-industry articles, advice, true stories, reader reviews. `netreviews@aol.com` or their contact form. Free, unpaid |
| [mindbodygreen — best dating apps](https://www.mindbodygreen.com/articles/best-dating-apps) | **"best dating apps 2026" #3 and "meaningful connections" #5–6** | High-authority publisher; one of the outlets AI assistants actually cite (§4) | **`https://www.mindbodygreen.com/contribute`** → "Email us at **submit@mindbodygreen.com**". Wants credentialed experts (M.D./Ph.D.), sourced health claims, no attachments; replies within 14 days only if accepted. **Long shot for an indie app — but the address is real** |

### 3.2 Tier B — ranked, but weaker or no door found

*(swipetogether.com and impressivemagazine.com moved to Tier D, where their contact paths are verified.)*

| Site / page | Ranks for | Character | Contact path |
|---|---|---|---|
| [vidaselect.com — Alternatives to Online Dating](https://www.vidaselect.com/alternatives-to-online-dating) | "alternatives to swiping dating" #2 | Matchmaking / profile-writing **service** with a marketing blog — not independent editorial | `contact@vidaselect.com` (general), `press@vidaselect.com` (media), via `https://www.vidaselect.com/contact/` |
| [mastermatchmakers.com](https://www.mastermatchmakers.com/tv-media/blogs/id/18630/the-best-alternatives-to-dating-apps-2026) | "alternatives to swiping" | Matchmaking service blog | Business contact |
| [datescout.us — Best Dating Apps 2026: Ultimate Ranking](https://datescout.us/blog/best-dating-apps-2026-ultimate-ranking) | "quiz dating / question based dating" long tail | **Genuine editorial** — publishes a real methodology ("real accounts on every major app, in four US metros, 30+ days each"), cites Stanford/CDC/Pew. Ranks 12 apps, **Qulo absent** | No submit form found; editorial contact via `https://datescout.us/about` and `https://datescout.us/editorial-policy` |
| [datingnav.com — Best Dating Apps of 2026](https://www.datingnav.com/blog/best-dating-apps-2026) | same cluster | **Genuine editorial** — discloses methodology, has `/methodology`, `/about`, `/editorial-independence`. **Qulo absent** | No submit form found; editorial contact via `/about` |
| [blog.chatib.us](https://blog.chatib.us/online-chats/dating-app-quiz/) | "quiz based dating app" #9 | Thin affiliate blog on a chat site | Not verified |
| [teknolojioku.com](https://www.teknolojioku.com/sosyal-medya/en-iyi-5-ucretsiz-arkadas-bulma-uygulamasi-6948da6af11c0a650607ade2), [10layn.com](https://10layn.com/10-arkadaslik-uygulamasi/), [techmedya.com](https://www.techmedya.com/yabancilarla-tanisma-uygulamasi/) | TR page one | TR listicle blogs, Qulo absent from all three | Standard TR blog contact pages |

### 3.3 Tier C — press & launch surfaces (not query-ranked, but they feed the citation graph)

| Target | Why | Path |
|---|---|---|
| **PRNewswire (or any wire)** | A wire release for a no-name app **ranked page one** for query 1.2 ([this one](https://www.prnewswire.com/news-releases/this-app-matches-you-based-on-the-last-question-you-would-ask-before-the-world-ends-300863338.html)) | Paid wire distribution |
| [techcrunch.com](https://techcrunch.com/2026/08/06/gen-z-dating-apps-like-ditto-ditch-swiping-in-favor-of-ai-matchmaking/) — Gen Z no-swipe beat | Ran a no-swipe dating story on 2026-08-06; the beat is live | Tip line / author outreach |
| [Forbes — "Gen Z Founders Reinventing Dating Apps, Without The Swipe" (2026-07-11)](https://www.forbes.com/sites/sofiachierchio/2026/07/11/these-gen-z-founders-are-reinventing-dating-apps-without-the-swipe/) | Same beat at Forbes, one month earlier. **Forbes returned 403 to our fetch — contents [unverified]** | Contributor outreach |
| [webrazzi.com](https://webrazzi.com/) | Leading TR startup publication; Qulo is a TR startup and has never been covered | `tech@webrazzi.com` appeared in a search snippet describing their app-support address — **[unverified], and it is an app-support inbox, not necessarily an editorial tip line.** Their `/iletisim/` page returned 403 to our fetcher. Confirm the correct editorial contact before pitching |
| [Product Hunt](https://www.producthunt.com/launch) | Verified: **no Qulo listing exists** | **`producthunt.com/launch` → Submit → New Product** (login). Verbatim: "It's 100% free to use"; no hunter payment needed. Note `/products/new` 404s — go via the Submit button |
| [datingsitesreviews.com](https://www.datingsitesreviews.com/staticpages/index.php?page=11DatingSites) *(plural "Sites")* | Long-running dating review site + industry news; covers emerging platforms | **Two verified routes:** "Write for Us" at `https://www.datingsitesreviews.com/staticpages/index.php?page=Blog-Write-for-Us`, and a **"Submit Dating News"** route at `/profiles.php?uid=2&subject=Dating%20News`. **Free to submit news.** Paid writing exists but requires pre-approval and is US/Canada only |
| [onlinedatingmagazine.com directory](https://www.onlinedatingmagazine.com/onlinedatinglistings/submitlink.html) | Human-edited dating directory | Submit-link page; **states a paid listing (~$35/yr standard)** |
| [directorycritic.com dating directory list](https://www.directorycritic.com/dating-directory-list.html) | Meta-list of dating directories accepting free/paid listings | Index of onward targets |
| [blogpros.com — 50+ app directories](https://blogpros.com/app-directories-submit-app/) | Meta-list of general app-submission directories | Index of onward targets |

### 3.4 Tier D — smaller dating blogs with an open "Write for Us" door

All verified 2026-09-01. These are bylined-expertise plays, not backlink plays.

| Site | Submit path | Terms |
|---|---|---|
| [TopDatingBlog.com](https://topdatingblog.com/write-for-us/) | `/write-for-us/` — contact form only, **no email published**; subject line must be "Write for Us Submission" | 700–1500 words, Word format. Free, unpaid (byline + author bio) |
| [DatingTechniques.com](https://datingtechniques.com/write-for-us/) | `/write-for-us/` — embedded form | 1000-word minimum, wants links to major publications. No fee. ⚠️ Freshest content seen was **June 2025 — possibly semi-dormant** |
| [AskTheRomanceExpert.com](https://www.asktheromanceexpert.com/write-for-us/) | `/write-for-us/` — routes to contact form, **no direct email** | 700+ words on dating/romance/marriage. Free. Genuine small blog (©2006–2026), explicitly rejects article-directory filler |
| [swipetogether.com](https://swipetogether.com/contact) | `/contact` — **hello@swipetogether.com** | Independent review/quiz site (not itself an app). No submission mechanism advertised |
| [impressivemagazine.com](https://impressivemagazine.com/contact-us/) | `/contact-us/` — form with math captcha, **no email published** | Mid-tier lifestyle magazine, bylined and dated |

### 3.5 Tier E — launch / startup directories (verified free-vs-paid)

**The free launch surface has shrunk.** Several directories commonly recommended in
older guides have since closed their free paths — verified below.

| Directory | Submit URL | Cost | Verified detail |
|---|---|---|---|
| **Product Hunt** | `producthunt.com/launch` → Submit → New Product | **FREE** | "It's 100% free to use." No hunter payment needed |
| **AlternativeTo** | Account → user icon → "Suggest new application" | **FREE**, or **$5** priority | Free = backlog of "at least a few months"; $5 = 1–2 business days, no approval guarantee |
| **Fazier** | [fazier.com/submit](https://fazier.com/submit) | **FREE tier** | Basic free; Lite $29, Premium $49, Super $149 |
| **MicroLaunch** | [microlaunch.net/submit](https://microlaunch.net/submit) | **FREE tier** | Free "Regular launch"; Pro Launch $39 |
| **Launching Next** | [launchingnext.com/submit/](https://www.launchingnext.com/submit/) | **FREE** + optional $99 | Verbatim: "Submitting to Launching Next is free, but if you want your startup to be considered for publication within 1-business day, we offer a $99 upgrade." Form asks for a 90-day marketing budget |
| **Indie Hackers** | [indiehackers.com/products/new](https://www.indiehackers.com/products/new) | Appears **FREE** (account required) | No fee stated anywhere |
| **Peerlist Launchpad** | [peerlist.io/launchpad](https://peerlist.io/launchpad) | Profile free; submit behind login | Live weekly launch board. Exact submit form not reachable anonymously |
| **StartupBase** | [startupbase.io/submit](https://startupbase.io/submit) → `/launch` | **Price not stated** | Auth wall; no pricing visible pre-login |
| **Startup Stash** | [startupstash.com/add-listing/](https://startupstash.com/add-listing/) | **Price not visible** | Form is JS-embedded and did not render. `Hello@startupstash.com` |
| **BetaList** | [betalist.com/submit](https://betalist.com/submit) | ⚠️ **PAID ONLY** | FAQ verbatim: "All submissions are paid. There is no free submission option." Auto-refund if not selected. **Requires an own domain — app-store links rejected**, so Qulo must submit `quloapp.com` |
| **Uneed** | [uneed.best/submit-a-tool](https://uneed.best/submit-a-tool) | ⚠️ **Effectively PAID** | "The free waiting line is closed to new products." Fast-track $14.99, skip-the-line $29.99 |

**Negative findings — do not waste time on these:**

| Target | Status |
|---|---|
| **Slant.co** | ❌ **DEAD.** Returns Cloudflare error **526 "Invalid SSL certificate"** — origin not serving. Remove from any list that still recommends it |
| **SaaSHub** | ⚠️ Submit page sits behind a Cloudflare bot challenge; **not verified** (we did not attempt to bypass it) |
| **Tom's Guide** | `/about-us/how-to-pitch-toms-guide` 404s — **no visible submission path found** |
| **apps400.com** | `/submit-app/` 404s — **no visible submission path found** |

### 3.6 Do NOT pitch — these rank for our queries but are competitor products

An important correction to the naive read of the SERP: **most of the "niche no-swipe
review sites" are actually dating products marketing themselves.** Of the eight niche
sites that surfaced across queries 1.1 / 1.5 / 1.8, **six turned out to be dating apps
or services**, not reviewers. Pitching them is pointless.

| Site | What it actually is |
|---|---|
| `grass.camp` | Its own dating app; blog post is disclosed as biased toward its own product |
| `scimatch.com` | Its own AI dating app — ranks **itself 9.5/10** above Hinge at 7.5 |
| `datopia.world` | Its own dating product, running a whole "anti-swipe" content cluster |
| `findyourwalnut.com` | Its own dating app (Walnut) |
| `hidnn.com` | Anonymous dating app (Android); landing page only |
| `nexspark.com` | Human matchmaking service, $599/connection |
| `appmakersla.com` | App-development agency using "9 Tinder Alternatives" as SEO for dating-app dev services |

**The strategic implication is the real prize:** the no-swipe editorial space is
thinner than the SERP makes it look, and it is currently being filled by apps writing
about themselves. **A genuinely differentiated no-swipe app has room to become the
thing those listicles cite** — which is what §1.4c and recommendation 5 are about.

**Outreach angle that works across all of these** (and stays inside the no-competitor-
bashing rule): *"You already cover no-swipe / question-based dating. Here's a mechanic
none of the apps on your list have: the other person writes 2–10 questions themselves,
and you only match if you get them all right. Screenshots, a 40-second demo, and store
links attached — happy to answer anything."* Never frame it as "X is bad"; frame it as
"here's a category your list is missing".

---

## 4. What AI assistants actually say today

All figures below are from published third-party studies, fetched and verified. **We
did not run ChatGPT/Perplexity ourselves** — treat this as evidence about the system,
not a transcript.

### 4.1 Which dating apps dominate AI answers

**[5WPR Dating App AI Visibility Index 2026](https://www.5wpr.com/ai-visibility-index/dating-app-ai-visibility-index-2026/)** — 60+ consumer-intent
queries × 4 platforms (ChatGPT, Claude, Perplexity, Google AI Overviews), Q1 2026,
25 apps tracked. Citation share:

| App | Share | | App | Share |
|---|---|---|---|---|
| Tinder | 13.0% | | Feeld | 3.5% |
| Hinge | 11.0% | | Plenty of Fish | 3.0% |
| Bumble | 10.0% | | Muzz | 2.5% |
| Match.com | 6.0% | | JDate / Her / Christian Mingle | 2.0% ea. |
| Grindr | 5.0% | | Coffee Meets Bagel / OurTime | 1.5% ea. |
| eHarmony | 5.0% | | | |
| OkCupid | 4.0% | | | |

**[AppTweak AI Visibility, 2026-05-08](https://www.apptweak.com/en/reports/the-most-visible-dating-apps-in-chatgpt)** — ChatGPT only:
Bumble score 86 (sentiment 69.1%), Hinge 79 (60.8%), Tinder 71 (41.4%), Feeld 47.

**The load-bearing insight from 5WPR:** smaller apps "hold AI citation shares
disproportionate to their revenue or user base **because they own demographic query
surfaces mass-market apps cannot efficiently compete for**" — they cite Chispa, BLK and
Lex. Muzz at 2.5% outranks Coffee Meets Bagel at 1.5% on exactly this logic. **This is
Qulo's whole strategy in one sentence:** own `quiz dating` / `question-based matching`
completely rather than contest `best dating app`.

### 4.2 What sources the AI systems actually cite — and they differ sharply

| System | Dominant source type | Evidence |
|---|---|---|
| **ChatGPT** | **App store listings — 47.5%** (Apple App Store 38%, Google Play 9.5%) | [AppTweak](https://www.apptweak.com/en/aso-blog/optimize-app-store-listing-for-ai-search), 125,000+ responses across 9,000+ app prompts, US, May 2026 |
| **Perplexity** | **Editorial listicles/reviews — 62%**; YouTube 14.2% (Zapier, NerdWallet, TechRadar dominate) | [AI App Discoverability Index 2026](https://www.growthbykev.com/research/ai-app-discoverability-index-2026), 195 queries × 4 platforms, 4,265 recommendations, March 2026 |
| **Google AI Overviews** | **Third-party "best of" lists — 63%**; vendor's own site 17%; YouTube 9%; review sites 5%; Reddit/forums 5% | [Derivatex, June 2026](https://derivatex.agency/blog/what-content-gets-cited-google-ai-overviews/), 1,259 citations from 100 searches. **Caveat: sampled B2B SaaS categories, not dating — treat as directional proxy** |
| **Claude / Gemini** | Do not expose sources | growthbykev |

### 4.3 Three findings that should change what Qulo builds

1. **Only 16.2% of apps appear on all four AI platforms; 54.8% appear on just one.**
   (growthbykev.) Winning ChatGPT ≠ winning Perplexity. They need different assets:
   ChatGPT needs a **better App Store listing**; Perplexity and AI Overviews need
   **third-party listicle placements**.
2. **Specific queries surface niche apps; broad queries do not.** Broad queries
   returned 34.3% niche apps; specific queries returned **64–66%**. Long-tail,
   mechanic-specific phrasing is where a small app can get named at all.
3. **Adding "free" to a query flips the result set almost entirely** — from 31.9% free
   apps to **70.5%**, with "only 2 of the top 20 apps overlap between price-qualified
   and unqualified queries." Qulo's core is free. **The store listing and site copy
   must say "free" explicitly and early**, and Qulo should target
   "free dating app without swiping" as a first-class query.

AppTweak's six concrete ASO-for-AI recommendations, worth applying to Qulo's store
listing verbatim: lead with **who it's for** in the opening line; pick 3–5 use cases and
repeat them; delete vague words ("all-in-one", "ultimate"); tie each feature to an
outcome; **structure the description as Q&A that mirrors how people prompt**; and add
verifiable details (user numbers, certifications) to raise model confidence.

---

## 5. Qulo's current footprint — honest assessment

### 5.1 What exists

| Asset | Status |
|---|---|
| **quloapp.com** | The **only genuinely healthy asset.** Multi-locale (`/en/`, `/it/`, …), with `/features/`, `/advice/`, `/blog/`, `/help/`, `/pricing/`, `/how-to/`, `/glossary/`, `/press/`, `/dating-statistics/`, `/trends/2026/`, city pages (`/en/dating/istanbul|london|new-york|paris|tokyo/`), `/country/`, and an HTML sitemap. **Ranks page one for `quiz based dating app`** and for `"quiz dating"` variants. |
| **Google Play** | Live: `com.wordpress.calikusuberkant.qulo`, "Qulo — Meet Through Questions". **Install count, rating and review count could not be retrieved** — Play blocks our fetcher. **[unverified]** |
| **Apple App Store** | Live: [id1626734572](https://apps.apple.com/us/app/qulo-meet-through-questions/id1626734572), "Qulo — Meet Through Questions", subtitle "Match by answering", Lifestyle, 18+, v2.0.7. **"Not enough ratings or reviews to display an overview."** IAP: Premium $4.99/$9.99, Purple Diamonds $0.99–$39.99. |
| **Instagram @quloapp** | Exists. Bio "Qulo dating application Google Play and Apple Store". **11 followers, 0 following, ~1 post** (a reel dated 2026-06-10). Effectively dormant. |
| **Third-party coverage** | **Zero.** A deliberately broad search excluding quloapp.com, Google Play and the App Store returned **no independent mention of Qulo anywhere** — no review, no listicle, no directory, no press, no forum thread. |
| **Product Hunt / AlternativeTo / AppBrain** | **No listing on any of them** (verified). |

### 5.2 Five concrete problems found

**(a) Brand-name collision — the most urgent finding.**
There is a *different, better-resourced* product also called **Qulo**:
[**Qulo – Smart AI for Kids**](https://apps.apple.com/us/app/qulo/id6755727213) by
Artur Chigin (Education, $8.99/week), with an active Instagram
[**@qulo_ai**](https://www.instagram.com/qulo_ai/) at **8,831 followers** — roughly
**800× the dating app's following**. It already occupies the plain `apps.apple.com/us/app/qulo/`
URL slot and surfaced *above* the dating app in our `"Qulo" dating app review` search.
Anyone searching the bare word "Qulo" is increasingly likely to land on the kids' AI app.
**Practical consequence:** Qulo cannot rely on the bare brand name for discovery and
must consistently market the full string **"Qulo — Meet Through Questions"** and the
mechanic ("quiz dating"), not "Qulo".

**(b) A stale, off-brand third-party mirror is circulating.**
[apkcombo.com's Qulo page](https://apkcombo.com/qulo/com.wordpress.calikusuberkant.qulo/)
serves a **2023 snapshot**: version 1.30, updated 2023-12-31, developer "Socrepho",
category Social, **500+ installs, 4.9★ from 89 reviews**, and a description saying the
app is about "meeting new people **and also making money** with user interaction" and
"diamonds that can be converted to **real money**." That monetary framing is no longer
how Qulo works, and mirrors like this are exactly the kind of page an LLM ingests.
Worth a takedown/update request.

**(c) The App Store listing is English-only while the app supports 16 languages.**
The US listing declares **English** as its only language. Given ChatGPT draws **47.5%**
of its app citations from store listings (§4.2), localised store metadata is one of
the highest-leverage fixes available — it directly buys AI visibility in 15 more markets.

**(d) Qulo's own unsourced statistics are already being echoed back as fact.**
Across three separate searches, the search engine's generated summary repeated Qulo's
positioning and numbers verbatim — "the world's first quiz-based dating app", and
*"Between 2025-2026, 'quiz dating' search volume increased by 200%"*. That 200% figure
traces back to **quloapp.com's own `/trends/2026/` page** and appears nowhere else. This
cuts both ways: it proves Qulo's content is being ingested and trusted by generative
search (a real win), and it means an **unverified self-published claim is now
circulating as third-party-sounding fact**. Either substantiate the number with a
citable source (Google Trends export, dated screenshot, methodology note) or restate it
as an internal observation. A journalist who checks it and finds nothing will not come
back.

**(e) The ranking page cites statistics with no attribution.**
`/en/features/quiz-dating-app/` (~800–900 words, good structure, has a 6-question FAQ)
asserts "over 80% of swipe-based matches never lead to a lasting connection" and
"only 2–5% of swipe matches lead to real-life meetings" **with no source links**.
Unsourced numbers are a liability twice over: they are the thing AI systems are least
willing to quote, and they are a credibility risk if a journalist checks them. Every
statistic on the site needs a linked, checkable source — or it should be cut.

### 5.3 Honest summary

Qulo's footprint is **one good website and two quiet store listings**. The site punches
above its weight — it genuinely ranks for its category term. Everything *around* the
site is absent: no reviews, no directory entries, no press, no third-party listicle
placement, essentially no social. And the brand name is being actively out-competed by
an unrelated app. The gap is not content quality; **it is off-site presence**.

---

## 6. What to do — priority order

1. **Defend and extend the `quiz dating` cluster.** It is already won. Add the
   explainer that query 1.7 is begging for ("How question-based matching works"),
   and add FAQ/schema markup.
2. **Substantiate or retire every unsourced statistic on the site** — the "200% quiz
   dating search growth", the "2–5% of swipe matches", the "80%". Generative search is
   already repeating them back as fact (§5.2d), which makes them a live credibility
   exposure. Sourced numbers are also the format AI systems cite most readily.
3. **Localise the App Store and Play listings into all 16 supported languages**, and
   rewrite the description per AppTweak's Q&A-shaped guidance — this is the single
   highest-leverage move for ChatGPT visibility (47.5% of its citations).
4. **Say "free" explicitly** in store metadata, title/subtitle and site copy. Target
   "free dating app without swiping" as a first-class query (70.5% vs 31.9% effect).
5. **Publish a disclosed comparison post on quloapp.com, GRASS-style** (§1.4c): rank
   10–13 apps, disclose authorship in the first paragraph, give honest pros *and* cons
   for every app including Qulo, and place Qulo where it actually belongs rather than
   #1. This is a proven page-one play for the "best dating apps" cluster and it stays
   inside the no-competitor-bashing rule by construction.
6. **Work the Tier A outreach list in this order:**
   **(i) DatingNews.com** — dating-industry trade press whose "Apps & Sites" and
   "Movers & Shakers" beats exist to cover exactly this, with named editors reachable
   by email (`shanna@`, `colleen@`). **(ii) Tamindir** — home market, stale list,
   explicit "UYGULAMA/OYUN EKLE VE TANIT" door. **(iii) DatingAdvice.com** — refreshes
   monthly. ⚠️ **DatingNews and DatingAdvice share a publisher** (same Gainesville FL
   office) — pitch one, not both, or it reads as spray-and-pray. Note both explicitly
   refuse guest posts and link exchanges, so pitch the *story*, never a link.
7. **Claim the free directory slots — and only the free ones.** Verified free:
   **Product Hunt** (`/launch`, 100% free), **AlternativeTo** (free, or $5 to skip a
   multi-month backlog), **Fazier**, **MicroLaunch**, **Launching Next**, **Indie
   Hackers**. Also add Qulo as an *alternative* on the Tinder/Hinge/OkCupid/Firefly
   AlternativeTo pages. ⚠️ **BetaList and Uneed have closed their free paths** — paid
   only now; BetaList also rejects app-store links, so it needs `quloapp.com`.
   **Slant.co is dead** (SSL 526). Skip both unless there's budget to spare.
8. **Get the apkcombo 2023 mirror corrected or removed.**
9. **Pitch the live no-swipe press beat** (TechCrunch and Forbes both ran it in
   Jul–Aug 2026) and Webrazzi for the TR angle. A wire release is a proven cheap
   page-one play on these queries.
10. **Do not chase** `best dating apps 2026` or `dating app for meaningful connections`.
   Both are defended by budget and neither maps to a distinctive Qulo mechanic.
11. **No astroturfing on Reddit or forums.** The data says disclosed participation
   survives at 83% vs 18% for undisclosed, and bans erase past citations retroactively.
   If Qulo participates, it participates with disclosure.

---

## Appendix — sources cited in this report

- AppTweak, "The most visible dating apps in AI search now" — https://www.apptweak.com/en/reports/the-most-visible-dating-apps-in-chatgpt
- AppTweak, "How to optimize your app store listing for AI search engines" — https://www.apptweak.com/en/aso-blog/optimize-app-store-listing-for-ai-search
- growthbykev, "The AI App Discoverability Index 2026" — https://www.growthbykev.com/research/ai-app-discoverability-index-2026
- MaxAEO, "How Reddit Shapes ChatGPT Recommendations (1.2M-Citation Study)" — https://maxaeo.ai/blog/reddit-chatgpt-recommendations/
- 5WPR, "The Dating App AI Visibility Index 2026" — https://www.5wpr.com/ai-visibility-index/dating-app-ai-visibility-index-2026/
- Derivatex, "What Content Gets Cited in Google AI Overviews: 2026 Data" — https://derivatex.agency/blog/what-content-gets-cited-google-ai-overviews/
- TechCrunch, "Gen Z dating apps like Ditto ditch swiping in favor of AI matchmaking" (2026-08-06) — https://techcrunch.com/2026/08/06/gen-z-dating-apps-like-ditto-ditch-swiping-in-favor-of-ai-matchmaking/
- Forbes, "These Gen Z Founders Are Reinventing Dating Apps, Without The Swipe" (2026-07-11) — https://www.forbes.com/sites/sofiachierchio/2026/07/11/these-gen-z-founders-are-reinventing-dating-apps-without-the-swipe/ *(403 to our fetcher; contents unverified)*
- Simply Psychology, "Dating Burnout: Why the Apps Exhausted Everyone (2026)" — https://www.simplypsychology.com/articles/dating-burnout-psychology
