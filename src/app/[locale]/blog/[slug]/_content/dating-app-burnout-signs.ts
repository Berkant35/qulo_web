import type { LocalizedArticle } from "@/components/blog/ArticleBlocks";

/**
 * "Dating App Burnout Signs" — migrated from inline per-locale JSX.
 * Canonical source: `en`; every one of the 16 locales is a full translation, so
 * no locale falls back to English any more (the legacy component shipped only
 * `tr` and `en`, serving the English body under 14 locales whose `hreflang`
 * promised otherwise). `**bold**` renders as <strong>.
 *
 * Statistics policy: the legacy post carried three bare percentages. Two are
 * gone. "90% of conversations on dating apps end within the first 5 messages"
 * had no source and no denominator — rewritten as "most exchanges fade out
 * after the first few messages". "Non-verbal communication constitutes over 65%
 * of the process of getting to know someone" is a mangled restatement of the
 * Mehrabian folk-statistic and is not defensible — rewritten as "carries a
 * great deal of what you learn about a person". Also removed: "the average time
 * spent on a single profile is between 0.5 and 2 seconds", a bare duration
 * presented as a research finding with nothing behind it.
 *
 * The one figure kept is the **78%** burnout rate, now attributed inline in
 * every locale to the 2024 **Forbes Health** survey conducted with **OnePoll**
 * among **1,000** US adults who had used a dating app in the past year (see
 * `FORBES_ONEPOLL_2024` in `src/lib/constants/stats.ts`). The remaining numbers
 * in the body are prescriptive advice explicitly framed as examples (a 15-minute
 * window, ten profiles per session, a one-week detox, one or two apps) or real
 * product mechanics (two to ten questions, four options each) — neither is a
 * claim about the world, so neither needs a source. Do not reintroduce a
 * statistic here without a named primary source.
 *
 * Attribution policy: the legacy "Why It Happens" for Sign 1 opened with
 * "According to psychologist Dr. Helen Fisher…" and then described learned
 * helplessness, which is Seligman's concept, not Fisher's. The misattribution
 * is removed; the mechanism is described without a name attached to it.
 *
 * Product-claim policy: the Qulo section describes only mechanisms that exist —
 * each member writes two to ten of their own questions with four options each,
 * and matching requires answering them all correctly. No automated moderation,
 * photo screening, trust-and-safety team or ID verification is claimed, and the
 * old "the person who solves your questions is genuinely compatible" line is
 * softened to what the mechanic actually proves: they read what you wrote and
 * got it right.
 *
 * Brand rule: Qulo is the only dating app nameable on this site. Everything
 * else is described generically as "dating apps" / "swipe-based apps".
 *
 * Note: the block model has no h3, so the original h3 sub-headings ("How to
 * Recognize It", "Why It Happens", "What to Do") are authored as purple h2.
 * The two headings the original markup rendered in `text-qulo-green` — "How
 * Qulo Combats Burnout by Design" and the closing "Conclusion" — keep
 * `accent: "green"` at the same positions (block indices 38 and 45); every
 * other heading is purple. That is the complete green count: 2. (The legacy
 * blockquote carried `border-qulo-purple`; `ArticleBlocks` renders every quote
 * with a green border, which is the shared house style and not an accent.)
 */
export const datingAppBurnoutSigns: LocalizedArticle = {
  en: [
    { type: "h2", text: "What Is Dating App Burnout?" },
    { type: "p", text: "Dating app burnout is the emotional, mental and motivational exhaustion that builds up over prolonged use of dating applications. It shows up across a wide spectrum — from quietly losing interest in the apps to a general apathy toward dating altogether. It is also common enough to have been measured: in a 2024 **Forbes Health** survey conducted with **OnePoll** among **1,000** US adults who had used a dating app in the past year, **78%** said they had felt burned out by it." },
    { type: "p", text: "Burnout doesn't mean you have to give up on dating apps entirely. But recognizing the signs and taking the right steps matters — for your digital dating life and for your real one. So what are the signs of dating app burnout, and how do you break out of it?" },

    { type: "h2", text: "Sign 1: Dreading Opening the App" },
    { type: "h2", text: "How to Recognize It" },
    { type: "p", text: "You keep dismissing dating app notifications. You feel a small internal resistance when you see the app icon on your phone. What once felt exciting now feels like a chore. This is one of the earliest and most common signs of dating app burnout: opening the app has moved from something you want to do to another item on a to-do list." },
    { type: "h2", text: "Why It Happens" },
    { type: "p", text: "Repeating an action that rarely pays off gradually teaches you that the effort is pointless — the pattern psychologists call learned helplessness. When you spend real time on an app without meaningful results, your brain files the activity under \"insufficient reward\" and motivation drops. Opening the app stops registering as a reward and starts registering as a burden." },
    { type: "h2", text: "What to Do" },
    { type: "p", text: "Give yourself defined \"dating app hours\". Open the app once a day, at a time you pick in advance, for a short window — fifteen minutes is plenty. Intentional use beats constant access. Switching to a question-based app like Qulo also breaks the endless-scroll loop and makes each session feel like it was worth opening." },

    { type: "h2", text: "Sign 2: Mindless Swiping" },
    { type: "h2", text: "How to Recognize It" },
    { type: "p", text: "You swipe left or right almost reflexively, without really looking at profiles. You don't read bios. You barely register the photos. Swiping has turned into a game that lost its point. In dating app culture this is called \"mindless swiping\", and it is a serious indicator of burnout." },
    { type: "h2", text: "Why It Happens" },
    { type: "p", text: "A profile gets a glance measured in the blink of an eye, which is nowhere near enough to reach a considered judgement about a person. To cope with that volume the brain switches to autopilot: decision quality falls, and who you match with becomes close to random. It is decision fatigue in its most literal form — too many near-identical choices, made too fast, for too long." },
    { type: "h2", text: "What to Do" },
    { type: "p", text: "Set a limit for each session — a maximum of ten profiles, say — and give each of them a few unhurried seconds. Better still, move to apps that remove the swipe mechanic altogether. On Qulo the question-solving step makes every interaction deliberate by construction: there is no way to progress on reflex." },

    { type: "h2", text: "Sign 3: Avoiding Responses to Messages" },
    { type: "h2", text: "How to Recognize It" },
    { type: "p", text: "You see match notifications but have no motivation to answer them. You tell yourself you'll reply later, and then you forget. Messages pile up and you avoid even opening them. The \"New match!\" alert that once sparked something now feels like nothing at all." },
    { type: "h2", text: "Why It Happens" },
    { type: "p", text: "Repetitive, fruitless conversations erode the will to communicate. Most exchanges on dating apps fade out after the first few messages, and that pattern quietly teaches you that nothing you write will matter. Psychologists describe the result as social exhaustion, and it tends to hit hardest for introverts, who spend more energy per conversation to begin with." },
    { type: "h2", text: "What to Do" },
    { type: "p", text: "Go for quality over coverage. Rather than trying to answer everyone, pick the one or two people who genuinely interest you and write them something worth reading. Qulo's question-and-answer mechanic does part of that work for you: because matching requires solving the questions someone wrote themselves, a match already means real attention was paid." },

    { type: "h2", text: "Sign 4: Everyone Looks the Same" },
    { type: "h2", text: "How to Recognize It" },
    { type: "p", text: "Profiles stop differentiating themselves. Everyone appears in the same poses, with the same filters, under the same bio. You feel like you have read \"I love traveling, coffee and running\" for the hundred-thousandth time. That flattening effect is a serious sign of burnout." },
    { type: "h2", text: "Why It Happens" },
    { type: "p", text: "Brains habituate. Exposed to enough near-identical stimuli in a row, your capacity to notice individual differences drops — the differences are still there, you simply stop registering them. Swipe-based apps present every profile in one standardized format, which strips away most of the signal a person would otherwise give off. Everyone starts to look the same because you can no longer tell them apart." },
    { type: "h2", text: "What to Do" },
    { type: "p", text: "Move to platforms where personality leads. On Qulo every member writes their own questions — between two and ten of them, each with four options — and those questions introduce a person far better than a photo can. What someone chooses to ask, and which three wrong answers they invent, says something about their humor, their attention and their values. It is very hard for two people to write the same set." },

    { type: "h2", text: "Sign 5: Preferring to Meet in Real Life" },
    { type: "h2", text: "How to Recognize It" },
    { type: "p", text: "You catch yourself thinking, \"I wish I could just meet someone the normal way.\" Dating apps feel unnatural to you, persistently. You miss the accident of running into somebody rather than being introduced by an algorithm. This feeling is completely normal, and it reflects a healthy instinct." },
    { type: "h2", text: "Why It Happens" },
    { type: "p", text: "The human brain evolved for face-to-face contact. Tone of voice, body language and eye contact carry a great deal of what you learn about a person in the first minutes, and dating apps strip all of it away, reducing getting to know someone to the evaluation of text and photographs. The result is a process that works, but rarely feels natural." },
    { type: "h2", text: "What to Do" },
    { type: "p", text: "Treat meeting in real life and meeting online as complements rather than alternatives. Join hobby groups, go to events. On the digital side, pick platforms where the interaction itself feels less mechanical. Working through someone's questions on Qulo is closer to a conversation in a café than to sorting a deck of cards — which gives even a digital introduction something of the texture of a real one." },

    { type: "h2", accent: "green", text: "How Qulo Combats Burnout by Design" },
    { type: "p", text: "Qulo was built around what actually causes dating app burnout. Every member writes between two and ten of their own questions, each with four options, and you match by answering all of them correctly. That single mechanic addresses most of what the swipe loop gets wrong:" },
    { type: "ul", items: [
      "**No infinite scroll:** every interaction is deliberate and finite",
      "**No autopilot:** solving a question requires actually thinking",
      "**Matches that mean something:** whoever matched with you read what you wrote and got it right",
      "**Natural openers:** you already have something specific to talk about",
      "**Profiles that differ:** the questions someone writes make them hard to confuse with anyone else",
    ] },

    { type: "h2", text: "Digital Detox Tips" },
    { type: "p", text: "If you're already burned out, a short digital detox is worth trying:" },
    { type: "ul", items: [
      "Take a break from every dating app for a week",
      "Spend the time on yourself: exercise, hobbies, friends",
      "Before you come back, answer one question honestly: what am I actually looking for?",
      "Keep the number of apps you use down to one or two",
      "Return with a quality-first approach: fewer profiles, more attention",
    ] },

    { type: "quote", text: "\"Burnout doesn't come from looking for the wrong people — it comes from looking in the wrong way. Change the method and the search becomes enjoyable again.\"" },

    { type: "h2", accent: "green", text: "Conclusion" },
    { type: "p", text: "Dating app burnout is real, widespread and worth taking seriously — and it does not mean you should give up on meeting people online. Recognizing the signs is the first step; changing your approach is the second. A question-based system moves the experience from surface to substance, which reduces burnout as a side effect rather than as a feature. On Qulo you can rediscover what it feels like to be genuinely curious about someone." },
  ],

  tr: [
    { type: "h2", text: "Dating Uygulaması Tükenmişliği Nedir?" },
    { type: "p", text: "Dating uygulaması tükenmişliği, uygulamaları uzun süre kullanmanın biriktirdiği duygusal, zihinsel ve motivasyonel yorgunluktur. Geniş bir yelpazede kendini gösterir: uygulamalara karşı sessizce ilgi kaybetmekten flörtün tamamına yönelik genel bir umursamazlığa kadar. Aynı zamanda ölçülebilecek kadar yaygın: **Forbes Health**'in **OnePoll** ile birlikte 2024'te, son bir yılda dating uygulaması kullanmış **1.000** ABD'li yetişkinle yaptığı ankette katılımcıların **%78**'i tükenmişlik hissettiğini söyledi." },
    { type: "p", text: "Tükenmişlik, dating uygulamalarından tamamen vazgeçmeniz gerektiği anlamına gelmez. Ama belirtileri tanımak ve doğru adımları atmak önemlidir — hem dijital hem de gerçek hayattaki ilişki deneyiminiz için. Peki dating uygulaması tükenmişliğinin belirtileri neler ve bu durumdan nasıl çıkarsınız?" },

    { type: "h2", text: "Belirti 1: Uygulamayı Açmak İstememe" },
    { type: "h2", text: "Nasıl Anlarsınız?" },
    { type: "p", text: "Dating uygulamasının bildirimlerini sürekli erteliyorsunuz. Telefonunuzda uygulamanın ikonunu gördüğünüzde içinizde küçük bir direnç beliriyor. Bir zamanlar heyecan veren şey artık bir angarya gibi. Bu, dating uygulaması tükenmişliğinin en erken ve en yaygın belirtilerinden biri: uygulamayı açmak, istediğiniz bir şey olmaktan çıkıp yapılacaklar listenizdeki bir maddeye dönüşmüştür." },
    { type: "h2", text: "Neden Olur?" },
    { type: "p", text: "Karşılığını nadiren veren bir eylemi tekrarlamak, zamanla çabanın boşuna olduğunu öğretir — psikologların öğrenilmiş çaresizlik dediği örüntü tam olarak budur. Uygulamada ciddi zaman harcayıp anlamlı bir sonuç alamadığınızda beyniniz bu eylemi \"ödülü yetersiz\" diye kodlar ve motivasyon düşer. Uygulamayı açmak artık bir ödül değil, bir yük olarak kaydedilir." },
    { type: "h2", text: "Ne Yapmalısınız?" },
    { type: "p", text: "Kendinize tanımlı \"dating uygulaması saatleri\" belirleyin. Uygulamayı günde bir kez, önceden seçtiğiniz bir saatte ve kısa bir aralık için açın — on beş dakika fazlasıyla yeter. Sürekli erişim yerine bilinçli kullanım işe yarar. Qulo gibi soru tabanlı bir uygulamaya geçmek de sonsuz kaydırma döngüsünü kırar ve her oturumu açmaya değer kılar." },

    { type: "h2", text: "Belirti 2: Düşünmeden Kaydırma" },
    { type: "h2", text: "Nasıl Anlarsınız?" },
    { type: "p", text: "Profillere gerçekten bakmadan, neredeyse refleks halinde sağa sola kaydırıyorsunuz. Biyografileri okumuyorsunuz. Fotoğraflara bile doğru dürüst bakmıyorsunuz. Kaydırma, amacını yitirmiş bir oyuna dönüşmüş. Dating kültüründe buna \"düşüncesiz kaydırma\" deniyor ve ciddi bir tükenmişlik göstergesi." },
    { type: "h2", text: "Neden Olur?" },
    { type: "p", text: "Bir profile göz açıp kapayıncaya kadar bakılıyor; bu süre bir insan hakkında düşünülmüş bir yargıya varmaya asla yetmez. Beyin bu hacimle baş etmek için otomatik pilota geçer: karar kalitesi düşer, kiminle eşleştiğiniz neredeyse rastlantısal hale gelir. Bu, karar yorgunluğunun en düz haliyle kendisidir — birbirine çok benzeyen, çok hızlı verilen ve çok uzun süren seçimler." },
    { type: "h2", text: "Ne Yapmalısınız?" },
    { type: "p", text: "Her oturuma bir sınır koyun — diyelim en fazla on profil — ve her birine acele etmeden birkaç saniye ayırın. Daha iyisi, kaydırma mekaniğini tümüyle ortadan kaldıran uygulamalara yönelin. Qulo'da soru çözme adımı her etkileşimi yapısı gereği bilinçli kılar: refleksle ilerlemenin bir yolu yoktur." },

    { type: "h2", text: "Belirti 3: Mesajlara Cevap Vermekten Kaçınma" },
    { type: "h2", text: "Nasıl Anlarsınız?" },
    { type: "p", text: "Eşleşme bildirimlerini görüyorsunuz ama cevap yazacak motivasyonunuz yok. \"Sonra yazarım\" diyorsunuz, sonra unutuyorsunuz. Mesajlar birikiyor, siz onları açmaktan bile kaçınıyorsunuz. Bir zamanlar içinizi kıpırdatan \"Yeni eşleşme!\" bildirimi artık hiçbir şey hissettirmiyor." },
    { type: "h2", text: "Neden Olur?" },
    { type: "p", text: "Tekrar eden ve sonuçsuz sohbetler, iletişim isteğini aşındırır. Dating uygulamalarındaki yazışmaların çoğu ilk birkaç mesajdan sonra söner; bu örüntü de ne yazarsanız yazın bir şeyin değişmeyeceğini sessizce öğretir. Psikologlar bunun sonucuna sosyal tükenmişlik diyor ve bu en çok, her sohbete zaten daha fazla enerji harcayan içedönük insanları vuruyor." },
    { type: "h2", text: "Ne Yapmalısınız?" },
    { type: "p", text: "Kapsam yerine kaliteyi seçin. Herkese yetişmeye çalışmak yerine, gerçekten ilginizi çeken bir iki kişiye odaklanın ve onlara okunmaya değer bir şey yazın. Qulo'nun soru-cevap mekaniği bu işin bir kısmını sizin yerinize yapar: eşleşmek için karşınızdakinin kendi yazdığı soruları çözmek gerektiğinden, bir eşleşme zaten gerçek bir dikkatin harcandığı anlamına gelir." },

    { type: "h2", text: "Belirti 4: Herkesin Aynı Göründüğünü Hissetme" },
    { type: "h2", text: "Nasıl Anlarsınız?" },
    { type: "p", text: "Profiller birbirinden ayrışmıyor. Herkes aynı pozlarda, aynı filtrelerle, aynı biyografiyle karşınıza çıkıyor. \"Seyahat etmeyi, kahveyi ve koşmayı seviyorum\" cümlesini yüz bininci kez okuduğunuzu hissediyorsunuz. Bu düzleşme etkisi ciddi bir tükenmişlik belirtisidir." },
    { type: "h2", text: "Neden Olur?" },
    { type: "p", text: "Beyin alışır. Arka arkaya yeterince benzer uyarana maruz kaldığınızda bireysel farkları fark etme kapasiteniz düşer — farklar hâlâ oradadır, siz onları kaydetmeyi bırakırsınız. Kaydırma tabanlı uygulamalar her profili tek ve standart bir biçimde sunduğu için insanın verdiği sinyalin çoğu daha baştan silinir. Herkes aynı görünmeye başlar, çünkü artık birbirinden ayıramazsınız." },
    { type: "h2", text: "Ne Yapmalısınız?" },
    { type: "p", text: "Kişiliğin öne çıktığı platformlara geçin. Qulo'da her üye kendi sorularını yazar — iki ile on arasında, her biri dört seçenekli — ve bu sorular bir insanı hiçbir fotoğrafın yapamayacağı kadar iyi tanıtır. Birinin ne sormayı seçtiği ve yanlış şıkları nasıl uydurduğu; mizahı, dikkati ve değerleri hakkında bir şey söyler. İki kişinin aynı soru setini yazması çok zordur." },

    { type: "h2", text: "Belirti 5: Gerçek Hayatta Tanışmayı Tercih Etme" },
    { type: "h2", text: "Nasıl Anlarsınız?" },
    { type: "p", text: "Kendinizi \"keşke biriyle normal yoldan tanışabilsem\" diye düşünürken buluyorsunuz. Dating uygulamaları size ısrarla yapay geliyor. Bir algoritmanın tanıştırmasındansa birine denk gelmenin tesadüfünü özlüyorsunuz. Bu his tamamen normal ve sağlıklı bir içgüdüyü yansıtıyor." },
    { type: "h2", text: "Neden Olur?" },
    { type: "p", text: "İnsan beyni yüz yüze temas için evrildi. Ses tonu, beden dili ve göz teması, bir insan hakkında ilk dakikalarda öğrendiklerinizin büyük bölümünü taşır; dating uygulamaları bunların hepsini eler ve tanışmayı metin ile fotoğraf değerlendirmesine indirger. Sonuç, işleyen ama nadiren doğal hissettiren bir süreçtir." },
    { type: "h2", text: "Ne Yapmalısınız?" },
    { type: "p", text: "Gerçek hayatta ve çevrimiçi tanışmayı birbirinin alternatifi değil, tamamlayıcısı olarak görün. Hobi gruplarına katılın, etkinliklere gidin. Dijital tarafta ise etkileşimin daha az mekanik hissettiği platformları seçin. Qulo'da birinin sorularını çözmek, bir deste kâğıdı ayıklamaktan çok bir kafe sohbetine benzer — bu da dijital bir tanışmaya bile gerçeğin dokusundan bir şey katar." },

    { type: "h2", accent: "green", text: "Qulo'nun Farkı: Tükenmişliği Azaltan Tasarım" },
    { type: "p", text: "Qulo, dating uygulaması tükenmişliğine gerçekte neyin yol açtığı düşünülerek kuruldu. Her üye kendi sorularından iki ile on tanesini yazar, her biri dört seçeneklidir ve eşleşmek için hepsini doğru cevaplamanız gerekir. Bu tek mekanik, kaydırma döngüsünün yanlış yaptığı şeylerin çoğunu ortadan kaldırır:" },
    { type: "ul", items: [
      "**Sonsuz kaydırma yok:** her etkileşim bilinçli ve sınırlı",
      "**Otomatik pilot yok:** soru çözmek gerçekten düşünmeyi gerektirir",
      "**Bir anlamı olan eşleşmeler:** sizinle eşleşen kişi yazdıklarınızı okudu ve doğru bildi",
      "**Doğal sohbet başlangıcı:** konuşacak somut bir şey zaten elinizde",
      "**Birbirine benzemeyen profiller:** kişinin yazdığı sorular onu başkasıyla karıştırmayı zorlaştırır",
    ] },

    { type: "h2", text: "Dijital Detoks Önerileri" },
    { type: "p", text: "Halihazırda tükendiyseniz, kısa bir dijital detoks denemeye değer:" },
    { type: "ul", items: [
      "Bir hafta boyunca tüm dating uygulamalarına ara verin",
      "Bu süreyi kendinize ayırın: spor, hobiler, arkadaşlar",
      "Geri dönmeden önce tek bir soruyu dürüstçe cevaplayın: ben aslında ne arıyorum?",
      "Kullandığınız uygulama sayısını bir ya da ikiyle sınırlayın",
      "Kalite öncelikli bir yaklaşımla dönün: daha az profil, daha çok dikkat",
    ] },

    { type: "quote", text: "\"Tükenmişlik yanlış insanları aramaktan değil, yanlış biçimde aramaktan gelir. Yöntemi değiştirdiğinizde arayış yeniden keyifli hale gelir.\"" },

    { type: "h2", accent: "green", text: "Sonuç" },
    { type: "p", text: "Dating uygulaması tükenmişliği gerçek, yaygın ve ciddiye alınması gereken bir olgu — ama bu, çevrimiçi tanışmaktan vazgeçmeniz gerektiği anlamına gelmiyor. İlk adım belirtileri tanımak, ikinci adım yaklaşımı değiştirmek. Soru tabanlı bir sistem deneyimi yüzeyden özün olduğu yere taşır; tükenmişliği bir özellik olarak değil, yan etki olarak azaltır. Qulo'da birine gerçekten merak duymanın nasıl bir his olduğunu yeniden keşfedebilirsiniz." },
  ],

  de: [
    { type: "h2", text: "Was ist Dating-App-Burnout?" },
    { type: "p", text: "Dating-App-Burnout ist die emotionale, mentale und motivationale Erschöpfung, die sich bei längerer Nutzung von Dating-Apps aufbaut. Sie zeigt sich auf einem breiten Spektrum — vom stillen Verlust des Interesses an den Apps bis zu einer allgemeinen Gleichgültigkeit gegenüber dem Daten überhaupt. Und sie ist verbreitet genug, um gemessen worden zu sein: In einer **Forbes Health**-Umfrage von 2024, durchgeführt mit **OnePoll** unter **1.000** US-Erwachsenen, die im vergangenen Jahr eine Dating-App genutzt hatten, gaben **78 %** an, sich davon ausgebrannt gefühlt zu haben." },
    { type: "p", text: "Burnout bedeutet nicht, dass Sie Dating-Apps ganz aufgeben müssen. Aber die Anzeichen zu erkennen und die richtigen Schritte zu gehen, macht einen Unterschied — für Ihr digitales Dating-Leben wie für Ihr reales. Was sind also die Anzeichen von Dating-App-Burnout, und wie kommen Sie wieder heraus?" },

    { type: "h2", text: "Anzeichen 1: Angst davor, die App zu öffnen" },
    { type: "h2", text: "Woran Sie es erkennen" },
    { type: "p", text: "Sie wischen Dating-App-Benachrichtigungen ständig weg. Beim Anblick des App-Symbols auf Ihrem Handy spüren Sie einen kleinen inneren Widerstand. Was sich einmal aufregend anfühlte, fühlt sich jetzt wie eine Pflicht an. Das ist eines der frühesten und häufigsten Anzeichen von Dating-App-Burnout: Die App zu öffnen ist von etwas, das Sie tun wollen, zu einem weiteren Punkt auf einer To-do-Liste geworden." },
    { type: "h2", text: "Warum es passiert" },
    { type: "p", text: "Eine Handlung zu wiederholen, die sich selten auszahlt, lehrt einen mit der Zeit, dass die Mühe sinnlos ist — Psychologen nennen dieses Muster erlernte Hilflosigkeit. Wenn Sie viel Zeit in einer App verbringen, ohne dass etwas dabei herauskommt, verbucht Ihr Gehirn die Tätigkeit unter \"zu geringe Belohnung\", und die Motivation sinkt. Die App zu öffnen wird nicht mehr als Belohnung registriert, sondern als Last." },
    { type: "h2", text: "Was Sie tun können" },
    { type: "p", text: "Legen Sie sich feste \"Dating-App-Zeiten\" fest. Öffnen Sie die App einmal am Tag, zu einer vorher gewählten Uhrzeit, für ein kurzes Fenster — fünfzehn Minuten reichen völlig. Bewusste Nutzung schlägt ständigen Zugriff. Der Wechsel zu einer fragenbasierten App wie Qulo durchbricht zusätzlich die Endlos-Scroll-Schleife und macht jede Sitzung zu einer, für die sich das Öffnen gelohnt hat." },

    { type: "h2", text: "Anzeichen 2: Gedankenloses Wischen" },
    { type: "h2", text: "Woran Sie es erkennen" },
    { type: "p", text: "Sie wischen fast reflexhaft nach links oder rechts, ohne die Profile wirklich anzusehen. Sie lesen keine Bios. Die Fotos nehmen Sie kaum wahr. Das Wischen ist zu einem Spiel geworden, das seinen Sinn verloren hat. In der Dating-App-Kultur heißt das gedankenloses Wischen, und es ist ein ernstes Anzeichen von Burnout." },
    { type: "h2", text: "Warum es passiert" },
    { type: "p", text: "Ein Profil bekommt einen Blick von der Länge eines Wimpernschlags — nicht annähernd genug, um zu einem überlegten Urteil über einen Menschen zu kommen. Um diese Menge zu bewältigen, schaltet das Gehirn auf Autopilot: Die Qualität der Entscheidungen sinkt, und wen Sie matchen, wird beinahe zufällig. Das ist Entscheidungsmüdigkeit in ihrer buchstäblichsten Form — zu viele fast identische Entscheidungen, zu schnell getroffen, über zu lange Zeit." },
    { type: "h2", text: "Was Sie tun können" },
    { type: "p", text: "Setzen Sie sich pro Sitzung ein Limit — höchstens zehn Profile zum Beispiel — und geben Sie jedem davon ein paar Sekunden ohne Eile. Noch besser: Wechseln Sie zu Apps, die die Wisch-Mechanik ganz abschaffen. Bei Qulo macht der Schritt des Fragenlösens jede Interaktion schon strukturell bewusst: Per Reflex kommt man hier nicht weiter." },

    { type: "h2", text: "Anzeichen 3: Nachrichten nicht mehr beantworten" },
    { type: "h2", text: "Woran Sie es erkennen" },
    { type: "p", text: "Sie sehen Match-Benachrichtigungen, haben aber keine Motivation zu antworten. Sie sagen sich, dass Sie später schreiben — und vergessen es dann. Nachrichten stapeln sich, und Sie vermeiden es, sie überhaupt zu öffnen. Das \"Neues Match!\", das früher etwas ausgelöst hat, fühlt sich jetzt nach gar nichts an." },
    { type: "h2", text: "Warum es passiert" },
    { type: "p", text: "Wiederholte, ergebnislose Gespräche zehren an der Lust zu kommunizieren. Die meisten Unterhaltungen in Dating-Apps verlaufen nach den ersten paar Nachrichten im Sand, und dieses Muster lehrt Sie leise, dass nichts, was Sie schreiben, etwas ändert. Psychologen beschreiben das Ergebnis als soziale Erschöpfung; am härtesten trifft es introvertierte Menschen, die ohnehin mehr Energie pro Gespräch aufwenden." },
    { type: "h2", text: "Was Sie tun können" },
    { type: "p", text: "Setzen Sie auf Qualität statt auf Reichweite. Statt allen antworten zu wollen, konzentrieren Sie sich auf die ein oder zwei Menschen, die Sie wirklich interessieren, und schreiben Sie ihnen etwas, das zu lesen sich lohnt. Qulos Frage-Antwort-Mechanik nimmt Ihnen einen Teil dieser Arbeit ab: Weil ein Match voraussetzt, dass jemand die selbst geschriebenen Fragen löst, bedeutet ein Match bereits, dass echte Aufmerksamkeit investiert wurde." },

    { type: "h2", text: "Anzeichen 4: Alle sehen gleich aus" },
    { type: "h2", text: "Woran Sie es erkennen" },
    { type: "p", text: "Profile unterscheiden sich nicht mehr voneinander. Alle erscheinen in denselben Posen, mit denselben Filtern, unter derselben Bio. Sie haben das Gefühl, \"Ich liebe Reisen, Kaffee und Laufen\" zum hunderttausendsten Mal gelesen zu haben. Dieser Einebnungseffekt ist ein ernstes Anzeichen von Burnout." },
    { type: "h2", text: "Warum es passiert" },
    { type: "p", text: "Gehirne gewöhnen sich. Wenn Sie genug fast identischen Reizen hintereinander ausgesetzt sind, sinkt Ihre Fähigkeit, individuelle Unterschiede wahrzunehmen — die Unterschiede sind noch da, Sie registrieren sie nur nicht mehr. Wisch-basierte Apps präsentieren jedes Profil in einem einzigen standardisierten Format, was den größten Teil des Signals wegnimmt, das ein Mensch sonst aussendet. Alle beginnen gleich auszusehen, weil Sie sie nicht mehr auseinanderhalten können." },
    { type: "h2", text: "Was Sie tun können" },
    { type: "p", text: "Wechseln Sie zu Plattformen, auf denen die Persönlichkeit vorangeht. Bei Qulo schreibt jedes Mitglied eigene Fragen — zwischen zwei und zehn, jede mit vier Antwortmöglichkeiten — und diese Fragen stellen einen Menschen weit besser vor, als ein Foto es kann. Was jemand zu fragen wählt und welche drei falschen Antworten er sich ausdenkt, sagt etwas über Humor, Aufmerksamkeit und Werte. Dass zwei Menschen denselben Satz Fragen schreiben, ist sehr unwahrscheinlich." },

    { type: "h2", text: "Anzeichen 5: Lieber im echten Leben kennenlernen" },
    { type: "h2", text: "Woran Sie es erkennen" },
    { type: "p", text: "Sie ertappen sich bei dem Gedanken: \"Ich wünschte, ich könnte einfach jemanden auf normalem Weg kennenlernen.\" Dating-Apps fühlen sich für Sie hartnäckig unnatürlich an. Sie vermissen den Zufall, jemandem zu begegnen, statt von einem Algorithmus vorgestellt zu werden. Dieses Gefühl ist völlig normal und spiegelt einen gesunden Instinkt." },
    { type: "h2", text: "Warum es passiert" },
    { type: "p", text: "Das menschliche Gehirn ist für den direkten Kontakt entstanden. Tonfall, Körpersprache und Blickkontakt tragen einen großen Teil dessen, was Sie in den ersten Minuten über einen Menschen erfahren; Dating-Apps streichen das alles und reduzieren das Kennenlernen auf die Bewertung von Text und Fotos. Das Ergebnis ist ein Verfahren, das funktioniert, sich aber selten natürlich anfühlt." },
    { type: "h2", text: "Was Sie tun können" },
    { type: "p", text: "Betrachten Sie das Kennenlernen im echten Leben und online nicht als Alternativen, sondern als Ergänzung. Treten Sie Hobbygruppen bei, gehen Sie zu Veranstaltungen. Wählen Sie auf der digitalen Seite Plattformen, auf denen sich die Interaktion selbst weniger mechanisch anfühlt. Sich bei Qulo durch die Fragen eines Menschen zu arbeiten, ist einem Gespräch im Café näher als dem Sortieren eines Kartenstapels — und das gibt selbst einer digitalen Begegnung etwas von der Textur einer echten." },

    { type: "h2", accent: "green", text: "Wie Qulo Burnout schon im Design entgegenwirkt" },
    { type: "p", text: "Qulo ist um die Frage herum gebaut, was Dating-App-Burnout tatsächlich verursacht. Jedes Mitglied schreibt zwischen zwei und zehn eigene Fragen mit je vier Antwortmöglichkeiten, und ein Match entsteht, wenn man alle richtig beantwortet. Diese eine Mechanik adressiert das meiste, was die Wisch-Schleife falsch macht:" },
    { type: "ul", items: [
      "**Kein endloses Scrollen:** jede Interaktion ist bewusst und endlich",
      "**Kein Autopilot:** eine Frage zu lösen verlangt tatsächliches Nachdenken",
      "**Matches mit Bedeutung:** wer mit Ihnen matcht, hat gelesen, was Sie geschrieben haben, und es richtig getroffen",
      "**Natürliche Gesprächsanfänge:** Sie haben bereits etwas Konkretes zum Reden",
      "**Profile, die sich unterscheiden:** die selbst geschriebenen Fragen machen jemanden schwer verwechselbar",
    ] },

    { type: "h2", text: "Tipps für einen digitalen Detox" },
    { type: "p", text: "Wenn Sie bereits ausgebrannt sind, lohnt sich ein kurzer digitaler Detox:" },
    { type: "ul", items: [
      "Legen Sie eine Woche Pause von allen Dating-Apps ein",
      "Verbringen Sie die Zeit mit sich selbst: Sport, Hobbys, Freunde",
      "Beantworten Sie vor der Rückkehr eine Frage ehrlich: Wonach suche ich eigentlich?",
      "Beschränken Sie die Zahl der genutzten Apps auf ein oder zwei",
      "Kommen Sie mit einem Qualitätsanspruch zurück: weniger Profile, mehr Aufmerksamkeit",
    ] },

    { type: "quote", text: "\"Burnout kommt nicht davon, die falschen Menschen zu suchen — sondern davon, auf die falsche Art zu suchen. Ändern Sie die Methode, und die Suche macht wieder Freude.\"" },

    { type: "h2", accent: "green", text: "Fazit" },
    { type: "p", text: "Dating-App-Burnout ist real, weit verbreitet und ernst zu nehmen — und er bedeutet nicht, dass Sie das Online-Kennenlernen aufgeben sollten. Die Anzeichen zu erkennen ist der erste Schritt, den eigenen Ansatz zu ändern der zweite. Ein fragenbasiertes System verlagert die Erfahrung von der Oberfläche zur Substanz und senkt Burnout dadurch als Nebenwirkung, nicht als Funktion. Bei Qulo können Sie wiederentdecken, wie es sich anfühlt, auf jemanden wirklich neugierig zu sein." },
  ],

  fr: [
    { type: "h2", text: "Qu'est-ce que l'épuisement lié aux applis de rencontre ?" },
    { type: "p", text: "L'épuisement lié aux applis de rencontre est la fatigue émotionnelle, mentale et motivationnelle qui s'installe à force d'utiliser ces applications. Il se manifeste sur un large spectre — de la perte discrète d'intérêt pour les applis à une indifférence générale envers les rencontres elles-mêmes. Il est aussi assez répandu pour avoir été mesuré : dans une enquête **Forbes Health** de 2024, menée avec **OnePoll** auprès de **1 000** adultes américains ayant utilisé une appli de rencontre dans l'année écoulée, **78 %** ont déclaré s'être sentis épuisés." },
    { type: "p", text: "L'épuisement ne signifie pas qu'il faut abandonner les applis de rencontre. Mais reconnaître les signes et prendre les bonnes mesures compte — pour votre vie amoureuse numérique comme pour la vraie. Quels sont donc les signes de cet épuisement, et comment en sortir ?" },

    { type: "h2", text: "Signe 1 : redouter d'ouvrir l'appli" },
    { type: "h2", text: "Comment le reconnaître" },
    { type: "p", text: "Vous repoussez sans cesse les notifications de l'appli. Vous ressentez une petite résistance intérieure en voyant son icône sur votre téléphone. Ce qui était excitant ressemble maintenant à une corvée. C'est l'un des signes les plus précoces et les plus fréquents : ouvrir l'appli est passé d'une envie à une ligne de plus sur une liste de tâches." },
    { type: "h2", text: "Pourquoi cela arrive" },
    { type: "p", text: "Répéter une action qui paie rarement finit par vous apprendre que l'effort est vain — les psychologues appellent ce schéma l'impuissance apprise. Quand vous passez vraiment du temps sur une appli sans résultat, votre cerveau classe l'activité sous \"récompense insuffisante\" et la motivation chute. Ouvrir l'appli cesse d'être enregistré comme une récompense et devient une charge." },
    { type: "h2", text: "Quoi faire" },
    { type: "p", text: "Fixez-vous des \"heures d'appli\" définies. Ouvrez-la une fois par jour, à une heure choisie à l'avance, sur une courte fenêtre — quinze minutes suffisent largement. L'usage intentionnel vaut mieux que l'accès permanent. Passer à une appli fondée sur des questions comme Qulo casse aussi la boucle de défilement infini et donne à chaque session une raison d'exister." },

    { type: "h2", text: "Signe 2 : le balayage machinal" },
    { type: "h2", text: "Comment le reconnaître" },
    { type: "p", text: "Vous balayez à gauche ou à droite presque par réflexe, sans vraiment regarder les profils. Vous ne lisez pas les descriptions. Vous enregistrez à peine les photos. Le balayage est devenu un jeu qui a perdu son objet. Dans la culture des applis, on parle de balayage machinal, et c'est un signe sérieux d'épuisement." },
    { type: "h2", text: "Pourquoi cela arrive" },
    { type: "p", text: "Un profil reçoit un regard de la durée d'un clignement d'œil, ce qui est très loin de suffire pour porter un jugement réfléchi sur quelqu'un. Pour absorber ce volume, le cerveau passe en pilote automatique : la qualité des décisions baisse et vos matchs deviennent presque aléatoires. C'est la fatigue décisionnelle au sens le plus littéral — trop de choix quasi identiques, trop vite, trop longtemps." },
    { type: "h2", text: "Quoi faire" },
    { type: "p", text: "Fixez une limite par session — dix profils au maximum, par exemple — et accordez à chacun quelques secondes sans précipitation. Mieux encore : passez à des applis qui suppriment complètement le balayage. Sur Qulo, l'étape de résolution des questions rend chaque interaction délibérée par construction : impossible d'avancer par réflexe." },

    { type: "h2", text: "Signe 3 : éviter de répondre aux messages" },
    { type: "h2", text: "Comment le reconnaître" },
    { type: "p", text: "Vous voyez les notifications de match mais n'avez aucune motivation pour répondre. Vous vous dites que vous écrirez plus tard, puis vous oubliez. Les messages s'accumulent et vous évitez même de les ouvrir. Le \"Nouveau match !\" qui déclenchait quelque chose ne vous fait plus rien du tout." },
    { type: "h2", text: "Pourquoi cela arrive" },
    { type: "p", text: "Les conversations répétitives et sans suite érodent l'envie de communiquer. La plupart des échanges sur les applis s'éteignent après les premiers messages, et ce schéma vous enseigne discrètement que rien de ce que vous écrivez ne changera quoi que ce soit. Les psychologues parlent d'épuisement social ; il frappe le plus fort les personnes introverties, qui dépensent déjà plus d'énergie par conversation." },
    { type: "h2", text: "Quoi faire" },
    { type: "p", text: "Privilégiez la qualité à la couverture. Plutôt que de répondre à tout le monde, concentrez-vous sur les une ou deux personnes qui vous intéressent vraiment et écrivez-leur quelque chose qui mérite d'être lu. Le mécanisme de questions-réponses de Qulo fait une partie du travail pour vous : puisqu'un match exige de résoudre les questions écrites par la personne elle-même, un match signifie déjà qu'une vraie attention a été portée." },

    { type: "h2", text: "Signe 4 : tout le monde se ressemble" },
    { type: "h2", text: "Comment le reconnaître" },
    { type: "p", text: "Les profils ne se distinguent plus. Tout le monde apparaît dans les mêmes poses, avec les mêmes filtres, sous la même description. Vous avez l'impression d'avoir lu \"J'aime voyager, le café et la course à pied\" pour la cent millième fois. Cet effet d'aplatissement est un signe sérieux d'épuisement." },
    { type: "h2", text: "Pourquoi cela arrive" },
    { type: "p", text: "Le cerveau s'habitue. Exposé à assez de stimuli quasi identiques à la suite, il perd sa capacité à percevoir les différences individuelles — elles sont toujours là, vous cessez simplement de les enregistrer. Les applis fondées sur le balayage présentent chaque profil dans un format unique et standardisé, ce qui efface l'essentiel du signal qu'une personne émettrait autrement. Tout le monde se met à se ressembler parce que vous ne distinguez plus rien." },
    { type: "h2", text: "Quoi faire" },
    { type: "p", text: "Passez à des plateformes où la personnalité prime. Sur Qulo, chaque membre écrit ses propres questions — entre deux et dix, chacune avec quatre options — et ces questions présentent une personne bien mieux qu'une photo. Ce que quelqu'un choisit de demander, et les trois mauvaises réponses qu'il invente, disent quelque chose de son humour, de son attention et de ses valeurs. Il est très difficile que deux personnes écrivent le même ensemble." },

    { type: "h2", text: "Signe 5 : préférer rencontrer dans la vraie vie" },
    { type: "h2", text: "Comment le reconnaître" },
    { type: "p", text: "Vous vous surprenez à penser : \"J'aimerais juste rencontrer quelqu'un normalement.\" Les applis vous semblent obstinément artificielles. Le hasard d'une rencontre vous manque, face à une présentation faite par un algorithme. Ce sentiment est parfaitement normal et traduit un instinct sain." },
    { type: "h2", text: "Pourquoi cela arrive" },
    { type: "p", text: "Le cerveau humain a évolué pour le contact direct. Le ton de la voix, le langage du corps et le regard portent une grande part de ce que vous apprenez d'une personne dans les premières minutes ; les applis suppriment tout cela et réduisent la rencontre à l'évaluation d'un texte et de photos. Le résultat est un procédé qui fonctionne, mais qui semble rarement naturel." },
    { type: "h2", text: "Quoi faire" },
    { type: "p", text: "Voyez la rencontre dans la vraie vie et en ligne comme complémentaires, non comme des alternatives. Rejoignez des groupes de loisirs, allez à des événements. Côté numérique, choisissez des plateformes où l'interaction elle-même paraît moins mécanique. Répondre aux questions de quelqu'un sur Qulo tient plus d'une conversation au café que du tri d'un paquet de cartes — ce qui donne même à une rencontre en ligne un peu de la texture d'une vraie." },

    { type: "h2", accent: "green", text: "Comment Qulo combat l'épuisement dès la conception" },
    { type: "p", text: "Qulo a été construit autour de ce qui cause réellement l'épuisement lié aux applis. Chaque membre écrit entre deux et dix questions personnelles, chacune avec quatre options, et le match se fait en répondant correctement à toutes. Ce seul mécanisme corrige l'essentiel de ce que la boucle de balayage fait mal :" },
    { type: "ul", items: [
      "**Pas de défilement infini :** chaque interaction est délibérée et finie",
      "**Pas de pilote automatique :** résoudre une question demande de penser vraiment",
      "**Des matchs qui veulent dire quelque chose :** la personne qui vous a matché a lu ce que vous avez écrit et a vu juste",
      "**Des amorces naturelles :** vous avez déjà un sujet concret de conversation",
      "**Des profils qui diffèrent :** les questions qu'on écrit soi-même rendent difficile de vous confondre avec un autre",
    ] },

    { type: "h2", text: "Conseils de détox numérique" },
    { type: "p", text: "Si l'épuisement est déjà là, une courte détox numérique vaut la peine :" },
    { type: "ul", items: [
      "Faites une pause d'une semaine de toutes les applis de rencontre",
      "Consacrez ce temps à vous : sport, loisirs, amis",
      "Avant de revenir, répondez honnêtement à une question : qu'est-ce que je cherche vraiment ?",
      "Limitez à une ou deux le nombre d'applis que vous utilisez",
      "Revenez avec une exigence de qualité : moins de profils, plus d'attention",
    ] },

    { type: "quote", text: "\"L'épuisement ne vient pas de chercher les mauvaises personnes — il vient de chercher de la mauvaise manière. Changez de méthode et la recherche redevient agréable.\"" },

    { type: "h2", accent: "green", text: "Conclusion" },
    { type: "p", text: "L'épuisement lié aux applis de rencontre est réel, répandu et mérite d'être pris au sérieux — et il ne signifie pas qu'il faut renoncer à rencontrer des gens en ligne. Reconnaître les signes est la première étape, changer d'approche est la seconde. Un système fondé sur des questions déplace l'expérience de la surface vers le fond, et réduit l'épuisement comme effet secondaire plutôt que comme fonctionnalité. Sur Qulo, vous pouvez redécouvrir ce que c'est que d'être vraiment curieux de quelqu'un." },
  ],

  es: [
    { type: "h2", text: "¿Qué es el desgaste por apps de citas?" },
    { type: "p", text: "El desgaste por apps de citas es el agotamiento emocional, mental y motivacional que se acumula tras un uso prolongado de estas aplicaciones. Se manifiesta en un espectro amplio: desde perder el interés en silencio hasta una apatía general hacia las citas en sí. También es lo bastante común como para haberse medido: en una encuesta de **Forbes Health** de 2024, realizada con **OnePoll** entre **1.000** adultos estadounidenses que habían usado una app de citas en el último año, el **78 %** dijo haberse sentido quemado por ellas." },
    { type: "p", text: "El desgaste no significa que debas dejar las apps de citas por completo. Pero reconocer las señales y dar los pasos adecuados importa, tanto para tu vida amorosa digital como para la real. ¿Cuáles son entonces las señales del desgaste por apps de citas y cómo se sale de él?" },

    { type: "h2", text: "Señal 1: no querer abrir la app" },
    { type: "h2", text: "Cómo reconocerlo" },
    { type: "p", text: "Descartas las notificaciones de la app una y otra vez. Sientes una pequeña resistencia interna al ver su icono en el teléfono. Lo que antes emocionaba ahora se parece a una obligación. Es una de las señales más tempranas y frecuentes del desgaste: abrir la app ha pasado de ser algo que quieres hacer a un punto más en una lista de tareas." },
    { type: "h2", text: "Por qué ocurre" },
    { type: "p", text: "Repetir una acción que rara vez da fruto acaba enseñándote que el esfuerzo es inútil; los psicólogos llaman a ese patrón indefensión aprendida. Cuando dedicas tiempo real a una app sin resultados, tu cerebro archiva la actividad como \"recompensa insuficiente\" y la motivación cae. Abrir la app deja de registrarse como premio y pasa a registrarse como carga." },
    { type: "h2", text: "Qué hacer" },
    { type: "p", text: "Fíjate unas \"horas de app\" definidas. Ábrela una vez al día, a una hora elegida de antemano, durante una ventana corta: quince minutos sobran. El uso intencionado vence al acceso constante. Pasarte a una app basada en preguntas como Qulo rompe además el bucle de desplazamiento infinito y hace que valga la pena abrirla." },

    { type: "h2", text: "Señal 2: deslizar sin pensar" },
    { type: "h2", text: "Cómo reconocerlo" },
    { type: "p", text: "Deslizas a izquierda o derecha casi por reflejo, sin mirar de verdad los perfiles. No lees las descripciones. Apenas registras las fotos. Deslizar se ha convertido en un juego que perdió su sentido. En la cultura de estas apps se le llama deslizamiento automático y es un indicador serio de desgaste." },
    { type: "h2", text: "Por qué ocurre" },
    { type: "p", text: "Un perfil recibe una mirada del tamaño de un parpadeo, muy lejos de lo necesario para formarse un juicio meditado sobre alguien. Para lidiar con ese volumen, el cerebro pasa al piloto automático: la calidad de las decisiones baja y con quién haces match se vuelve casi aleatorio. Es fatiga de decisión en su sentido más literal: demasiadas opciones casi idénticas, demasiado rápido, durante demasiado tiempo." },
    { type: "h2", text: "Qué hacer" },
    { type: "p", text: "Ponte un límite por sesión —diez perfiles como máximo, por ejemplo— y dedica a cada uno unos segundos sin prisa. Mejor aún: cámbiate a apps que eliminen el deslizamiento por completo. En Qulo, el paso de resolver preguntas hace que cada interacción sea deliberada por construcción: no hay forma de avanzar por reflejo." },

    { type: "h2", text: "Señal 3: evitar responder a los mensajes" },
    { type: "h2", text: "Cómo reconocerlo" },
    { type: "p", text: "Ves las notificaciones de match pero no tienes motivación para responder. Te dices que escribirás luego y después lo olvidas. Los mensajes se acumulan y evitas incluso abrirlos. El \"¡Nuevo match!\" que antes encendía algo ahora no te dice nada." },
    { type: "h2", text: "Por qué ocurre" },
    { type: "p", text: "Las conversaciones repetitivas y sin recorrido erosionan las ganas de comunicarse. La mayoría de los intercambios en apps de citas se apagan tras los primeros mensajes, y ese patrón te enseña en voz baja que nada de lo que escribas va a importar. Los psicólogos describen el resultado como agotamiento social, y golpea más fuerte a las personas introvertidas, que ya gastan más energía por conversación." },
    { type: "h2", text: "Qué hacer" },
    { type: "p", text: "Elige calidad antes que cobertura. En lugar de intentar responder a todo el mundo, céntrate en la una o dos personas que de verdad te interesan y escríbeles algo que merezca leerse. El mecanismo de preguntas y respuestas de Qulo hace parte de ese trabajo por ti: como para hacer match hay que resolver las preguntas que esa persona escribió, un match ya significa que hubo atención real." },

    { type: "h2", text: "Señal 4: todo el mundo parece igual" },
    { type: "h2", text: "Cómo reconocerlo" },
    { type: "p", text: "Los perfiles dejan de diferenciarse. Todos aparecen con las mismas poses, los mismos filtros, la misma descripción. Sientes que has leído \"Me encanta viajar, el café y salir a correr\" por cienmilésima vez. Ese efecto de aplanamiento es una señal seria de desgaste." },
    { type: "h2", text: "Por qué ocurre" },
    { type: "p", text: "El cerebro se habitúa. Expuesto a suficientes estímulos casi idénticos seguidos, pierde capacidad para percibir diferencias individuales: siguen ahí, simplemente dejas de registrarlas. Las apps basadas en deslizar presentan cada perfil en un único formato estandarizado, lo que borra buena parte de la señal que una persona emitiría de otro modo. Todos empiezan a parecer iguales porque ya no puedes distinguirlos." },
    { type: "h2", text: "Qué hacer" },
    { type: "p", text: "Cámbiate a plataformas donde mande la personalidad. En Qulo cada usuario escribe sus propias preguntas —entre dos y diez, cada una con cuatro opciones— y esas preguntas presentan a alguien mucho mejor que una foto. Lo que decide preguntar, y las tres respuestas falsas que inventa, dicen algo de su humor, su atención y sus valores. Es muy difícil que dos personas escriban el mismo conjunto." },

    { type: "h2", text: "Señal 5: preferir conocerse en la vida real" },
    { type: "h2", text: "Cómo reconocerlo" },
    { type: "p", text: "Te sorprendes pensando: \"Ojalá pudiera conocer a alguien de forma normal\". Las apps te resultan artificiales de manera persistente. Echas de menos el azar de cruzarte con alguien en vez de que te presente un algoritmo. Ese sentimiento es completamente normal y refleja un instinto sano." },
    { type: "h2", text: "Por qué ocurre" },
    { type: "p", text: "El cerebro humano evolucionó para el contacto cara a cara. El tono de voz, el lenguaje corporal y la mirada llevan buena parte de lo que aprendes de alguien en los primeros minutos; las apps eliminan todo eso y reducen el conocerse a evaluar texto y fotos. El resultado es un procedimiento que funciona, pero que rara vez se siente natural." },
    { type: "h2", text: "Qué hacer" },
    { type: "p", text: "Trata el conocerse en persona y en línea como complementos, no como alternativas. Únete a grupos de aficiones, ve a eventos. En lo digital, elige plataformas donde la interacción se sienta menos mecánica. Resolver las preguntas de alguien en Qulo se parece más a una charla de café que a ordenar una baraja, y eso da incluso a un encuentro digital algo de la textura de uno real." },

    { type: "h2", accent: "green", text: "Cómo Qulo combate el desgaste desde el diseño" },
    { type: "p", text: "Qulo se construyó alrededor de lo que realmente provoca el desgaste por apps de citas. Cada usuario escribe entre dos y diez preguntas propias, cada una con cuatro opciones, y el match se produce al acertarlas todas. Ese único mecanismo corrige casi todo lo que el bucle de deslizamiento hace mal:" },
    { type: "ul", items: [
      "**Sin desplazamiento infinito:** cada interacción es deliberada y finita",
      "**Sin piloto automático:** resolver una pregunta exige pensar de verdad",
      "**Matches que significan algo:** quien hizo match contigo leyó lo que escribiste y acertó",
      "**Aperturas naturales:** ya tienes algo concreto de lo que hablar",
      "**Perfiles que se distinguen:** las preguntas que alguien escribe hacen difícil confundirlo con otra persona",
    ] },

    { type: "h2", text: "Consejos de desintoxicación digital" },
    { type: "p", text: "Si el desgaste ya está ahí, merece la pena una breve desintoxicación digital:" },
    { type: "ul", items: [
      "Tómate una semana de descanso de todas las apps de citas",
      "Dedica ese tiempo a ti: deporte, aficiones, amigos",
      "Antes de volver, responde con honestidad a una pregunta: ¿qué estoy buscando en realidad?",
      "Limita a una o dos el número de apps que usas",
      "Vuelve con una exigencia de calidad: menos perfiles, más atención",
    ] },

    { type: "quote", text: "\"El desgaste no viene de buscar a las personas equivocadas, sino de buscar de la manera equivocada. Cambia el método y la búsqueda vuelve a ser agradable.\"" },

    { type: "h2", accent: "green", text: "Conclusión" },
    { type: "p", text: "El desgaste por apps de citas es real, está extendido y merece tomarse en serio; y no significa que debas renunciar a conocer gente en línea. Reconocer las señales es el primer paso; cambiar de enfoque, el segundo. Un sistema basado en preguntas mueve la experiencia de la superficie al fondo y reduce el desgaste como efecto secundario, no como función. En Qulo puedes redescubrir lo que se siente al tener verdadera curiosidad por alguien." },
  ],

  ar: [
    { type: "h2", text: "ما هو الإرهاق من تطبيقات المواعدة؟" },
    { type: "p", text: "الإرهاق من تطبيقات المواعدة هو التعب العاطفي والذهني وفقدان الدافع الذي يتراكم مع الاستخدام الطويل لهذه التطبيقات. ويظهر على طيف واسع: من فقدان الاهتمام بالتطبيقات بهدوء إلى لامبالاة عامة تجاه المواعدة نفسها. وهو شائع بما يكفي ليُقاس: في استطلاع أجرته **Forbes Health** عام 2024 بالتعاون مع **OnePoll** وشمل **1000** بالغ أمريكي استخدموا تطبيق مواعدة خلال العام السابق، قال **78%** إنهم شعروا بالإرهاق منها." },
    { type: "p", text: "الإرهاق لا يعني أن عليك التخلي عن تطبيقات المواعدة تمامًا. لكن التعرف على العلامات واتخاذ الخطوات الصحيحة أمر مهم، لحياتك العاطفية الرقمية ولحياتك الواقعية على حد سواء. فما هي علامات الإرهاق من تطبيقات المواعدة، وكيف تخرج منه؟" },

    { type: "h2", text: "العلامة 1: التهرب من فتح التطبيق" },
    { type: "h2", text: "كيف تعرف ذلك" },
    { type: "p", text: "تتجاهل إشعارات التطبيق مرة بعد مرة. تشعر بمقاومة داخلية صغيرة حين ترى أيقونته على هاتفك. ما كان مثيرًا صار يشبه الواجب. هذه من أبكر علامات الإرهاق وأكثرها شيوعًا: فتح التطبيق تحوّل من شيء ترغب فيه إلى بند إضافي على قائمة مهامك." },
    { type: "h2", text: "لماذا يحدث" },
    { type: "p", text: "تكرار فعل نادرًا ما يؤتي ثماره يعلّمك مع الوقت أن الجهد بلا جدوى — وهو النمط الذي يسميه علماء النفس العجز المكتسب. حين تقضي وقتًا حقيقيًا في تطبيق دون نتيجة، يصنّف دماغك هذا النشاط تحت \"مكافأة غير كافية\" فينخفض الدافع. لم يعد فتح التطبيق يُسجَّل كمكافأة، بل كعبء." },
    { type: "h2", text: "ماذا تفعل" },
    { type: "p", text: "حدّد لنفسك \"ساعات تطبيق\" واضحة. افتحه مرة واحدة يوميًا، في وقت تختاره مسبقًا، ولمدة قصيرة — خمس عشرة دقيقة تكفي تمامًا. الاستخدام الواعي أفضل من الوصول الدائم. والانتقال إلى تطبيق قائم على الأسئلة مثل Qulo يكسر أيضًا حلقة التمرير اللانهائي ويجعل كل جلسة تستحق الفتح." },

    { type: "h2", text: "العلامة 2: التمرير بلا وعي" },
    { type: "h2", text: "كيف تعرف ذلك" },
    { type: "p", text: "تمرّر يمينًا أو يسارًا بشكل شبه انعكاسي دون أن تنظر إلى الملفات الشخصية فعلًا. لا تقرأ النبذات. بالكاد تلاحظ الصور. صار التمرير لعبة فقدت هدفها. في ثقافة هذه التطبيقات يُسمّى ذلك التمرير الغافل، وهو مؤشر جدي على الإرهاق." },
    { type: "h2", text: "لماذا يحدث" },
    { type: "p", text: "ينال الملف الشخصي نظرة بطول رمشة عين، وهي أبعد ما تكون عن الكفاية لتكوين حكم متأنٍ عن إنسان. ولمواجهة هذا الكم ينتقل الدماغ إلى الطيار الآلي: تنخفض جودة القرار ويصبح من تتطابق معه شبه عشوائي. هذا هو إرهاق القرار بأدق معانيه: خيارات كثيرة شديدة التشابه، تُتخذ بسرعة كبيرة، ولمدة طويلة." },
    { type: "h2", text: "ماذا تفعل" },
    { type: "p", text: "ضع حدًا لكل جلسة — عشرة ملفات كحد أقصى مثلًا — وامنح كل واحد منها بضع ثوانٍ دون عجلة. والأفضل: انتقل إلى تطبيقات تلغي آلية التمرير تمامًا. في Qulo تجعل خطوة حل الأسئلة كل تفاعل مقصودًا بحكم البنية: لا سبيل للتقدم بردة فعل." },

    { type: "h2", text: "العلامة 3: تجنّب الرد على الرسائل" },
    { type: "h2", text: "كيف تعرف ذلك" },
    { type: "p", text: "ترى إشعارات التطابق لكن لا دافع لديك للرد. تقول لنفسك إنك ستكتب لاحقًا، ثم تنسى. تتراكم الرسائل وتتجنب فتحها أصلًا. إشعار \"تطابق جديد!\" الذي كان يحرّك شيئًا في داخلك لم يعد يعني لك شيئًا." },
    { type: "h2", text: "لماذا يحدث" },
    { type: "p", text: "المحادثات المتكررة التي لا تفضي إلى شيء تستنزف الرغبة في التواصل. معظم المحادثات على تطبيقات المواعدة تنطفئ بعد الرسائل الأولى، وهذا النمط يعلّمك بهدوء أن ما تكتبه لن يغيّر شيئًا. يصف علماء النفس النتيجة بالإرهاق الاجتماعي، وهو يضرب بأشد قوته الأشخاص الانطوائيين الذين يبذلون أصلًا طاقة أكبر في كل محادثة." },
    { type: "h2", text: "ماذا تفعل" },
    { type: "p", text: "اختر الجودة بدل الاتساع. بدل محاولة الرد على الجميع، ركّز على شخص أو شخصين يثيران اهتمامك حقًا واكتب لهما شيئًا يستحق القراءة. آلية السؤال والجواب في Qulo تقوم بجزء من هذا العمل عنك: بما أن التطابق يتطلب حل الأسئلة التي كتبها الشخص بنفسه، فإن أي تطابق يعني أن انتباهًا حقيقيًا قد بُذل." },

    { type: "h2", text: "العلامة 4: الجميع يبدو متشابهًا" },
    { type: "h2", text: "كيف تعرف ذلك" },
    { type: "p", text: "لم تعد الملفات الشخصية تتمايز. الجميع بالوضعيات نفسها والفلاتر نفسها والنبذة نفسها. تشعر أنك قرأت \"أحب السفر والقهوة والجري\" للمرة المئة ألف. هذا التسطيح علامة جدية على الإرهاق." },
    { type: "h2", text: "لماذا يحدث" },
    { type: "p", text: "الدماغ يعتاد. حين تتعرض لعدد كافٍ من المؤثرات شبه المتطابقة تباعًا، تنخفض قدرتك على ملاحظة الفروق الفردية — الفروق ما زالت موجودة، لكنك تتوقف عن تسجيلها. تعرض التطبيقات القائمة على التمرير كل ملف بصيغة موحدة واحدة، فتمحو معظم الإشارات التي يبعثها الإنسان عادة. يبدأ الجميع بالتشابه لأنك لم تعد قادرًا على التمييز بينهم." },
    { type: "h2", text: "ماذا تفعل" },
    { type: "p", text: "انتقل إلى منصات تتقدم فيها الشخصية. في Qulo يكتب كل عضو أسئلته الخاصة — بين سؤالين وعشرة أسئلة، لكل منها أربعة خيارات — وهذه الأسئلة تعرّف بالإنسان أفضل بكثير مما تفعل صورة. ما يختار المرء أن يسأل عنه، والإجابات الثلاث الخاطئة التي يبتكرها، تقول شيئًا عن حسّه الفكاهي وانتباهه وقيمه. ومن الصعب جدًا أن يكتب شخصان المجموعة نفسها." },

    { type: "h2", text: "العلامة 5: تفضيل التعارف في الحياة الواقعية" },
    { type: "h2", text: "كيف تعرف ذلك" },
    { type: "p", text: "تجد نفسك تفكر: \"ليتني أتعرف على أحد بالطريقة الطبيعية\". تبدو لك تطبيقات المواعدة مصطنعة على نحو مستمر. تفتقد مصادفة اللقاء بشخص بدل أن تقدّمه لك خوارزمية. هذا الشعور طبيعي تمامًا ويعكس غريزة سليمة." },
    { type: "h2", text: "لماذا يحدث" },
    { type: "p", text: "تطوّر الدماغ البشري للتواصل وجهًا لوجه. نبرة الصوت ولغة الجسد وتلاقي النظرات تحمل جزءًا كبيرًا مما تتعلمه عن شخص في الدقائق الأولى؛ وتطبيقات المواعدة تحذف ذلك كله وتختزل التعارف في تقييم نص وصور. والنتيجة عملية تؤدي وظيفتها لكنها نادرًا ما تبدو طبيعية." },
    { type: "h2", text: "ماذا تفعل" },
    { type: "p", text: "تعامل مع التعارف في الواقع والتعارف عبر الإنترنت باعتبارهما مكمّلين لا بديلين. انضم إلى مجموعات الهوايات، واحضر الفعاليات. وفي الجانب الرقمي، اختر منصات يبدو فيها التفاعل نفسه أقل ميكانيكية. حلّ أسئلة شخص ما في Qulo أقرب إلى حديث في مقهى منه إلى فرز مجموعة أوراق — وهذا يمنح حتى التعارف الرقمي شيئًا من ملمس التعارف الحقيقي." },

    { type: "h2", accent: "green", text: "كيف يواجه Qulo الإرهاق بحكم التصميم" },
    { type: "p", text: "بُني Qulo حول ما يسبب الإرهاق من تطبيقات المواعدة فعلًا. يكتب كل عضو بين سؤالين وعشرة أسئلة خاصة به، لكل منها أربعة خيارات، ويحدث التطابق عند الإجابة عنها جميعًا بشكل صحيح. هذه الآلية وحدها تعالج معظم ما تخطئ فيه حلقة التمرير:" },
    { type: "ul", items: [
      "**لا تمرير لا نهائي:** كل تفاعل مقصود ومحدود",
      "**لا طيار آلي:** حل السؤال يتطلب تفكيرًا فعليًا",
      "**تطابقات لها معنى:** من تطابق معك قرأ ما كتبته وأصاب فيه",
      "**بدايات حديث طبيعية:** لديك بالفعل شيء محدد للحديث عنه",
      "**ملفات مختلفة:** الأسئلة التي يكتبها المرء تجعل الخلط بينه وبين غيره صعبًا",
    ] },

    { type: "h2", text: "نصائح للاستراحة الرقمية" },
    { type: "p", text: "إذا كان الإرهاق قد أصابك بالفعل، فاستراحة رقمية قصيرة تستحق التجربة:" },
    { type: "ul", items: [
      "خذ استراحة أسبوع من جميع تطبيقات المواعدة",
      "اصرف هذا الوقت على نفسك: الرياضة والهوايات والأصدقاء",
      "قبل العودة، أجب بصدق عن سؤال واحد: عمّا أبحث في الحقيقة؟",
      "اجعل عدد التطبيقات التي تستخدمها واحدًا أو اثنين",
      "عد بمعيار الجودة: ملفات أقل وانتباه أكبر",
    ] },

    { type: "quote", text: "\"الإرهاق لا يأتي من البحث عن الأشخاص الخطأ، بل من البحث بالطريقة الخطأ. غيّر الطريقة يعد البحث ممتعًا من جديد.\"" },

    { type: "h2", accent: "green", text: "الخلاصة" },
    { type: "p", text: "الإرهاق من تطبيقات المواعدة حقيقي وواسع الانتشار ويستحق أن يُؤخذ على محمل الجد — وهو لا يعني أن عليك التخلي عن التعارف عبر الإنترنت. التعرف على العلامات هو الخطوة الأولى، وتغيير أسلوبك هو الخطوة الثانية. النظام القائم على الأسئلة ينقل التجربة من السطح إلى العمق، فيقلل الإرهاق كأثر جانبي لا كميزة. في Qulo يمكنك أن تكتشف من جديد شعور الفضول الحقيقي تجاه إنسان." },
  ],

  ru: [
    { type: "h2", text: "Что такое выгорание от приложений для знакомств?" },
    { type: "p", text: "Выгорание от приложений для знакомств — это эмоциональная, ментальная и мотивационная усталость, которая накапливается при долгом использовании таких приложений. Она проявляется в широком диапазоне: от тихой потери интереса к приложениям до общего равнодушия к знакомствам как таковым. И она достаточно распространена, чтобы её измерили: в опросе **Forbes Health** 2024 года, проведённом совместно с **OnePoll** среди **1000** взрослых американцев, пользовавшихся приложением для знакомств за последний год, **78 %** сказали, что чувствовали себя выгоревшими." },
    { type: "p", text: "Выгорание не означает, что от приложений нужно отказаться совсем. Но распознать признаки и сделать правильные шаги важно — и для цифровой части вашей личной жизни, и для реальной. Итак, каковы признаки выгорания от приложений для знакомств и как из него выйти?" },

    { type: "h2", text: "Признак 1: нежелание открывать приложение" },
    { type: "h2", text: "Как распознать" },
    { type: "p", text: "Вы раз за разом смахиваете уведомления приложения. При виде его иконки на телефоне возникает лёгкое внутреннее сопротивление. То, что когда-то радовало, теперь ощущается как обязанность. Это один из самых ранних и частых признаков выгорания: открыть приложение из желания превратилось в ещё один пункт списка дел." },
    { type: "h2", text: "Почему так происходит" },
    { type: "p", text: "Повторение действия, которое редко окупается, постепенно учит, что усилие бессмысленно, — психологи называют этот паттерн выученной беспомощностью. Когда вы тратите на приложение реальное время без результата, мозг относит это занятие к категории «недостаточное вознаграждение», и мотивация падает. Открыть приложение перестаёт восприниматься как награда и начинает восприниматься как нагрузка." },
    { type: "h2", text: "Что делать" },
    { type: "p", text: "Установите себе определённые «часы приложения». Открывайте его один раз в день, в заранее выбранное время, на короткое окно — пятнадцати минут вполне достаточно. Осознанное использование лучше постоянного доступа. Переход на приложение, построенное на вопросах, вроде Qulo, к тому же разрывает петлю бесконечной прокрутки и делает каждую сессию такой, ради которой стоило его открыть." },

    { type: "h2", text: "Признак 2: бездумные свайпы" },
    { type: "h2", text: "Как распознать" },
    { type: "p", text: "Вы свайпаете влево или вправо почти рефлекторно, не разглядывая анкеты по-настоящему. Не читаете описания. Едва замечаете фотографии. Свайп превратился в игру, потерявшую смысл. В культуре приложений это называют бездумным свайпом, и это серьёзный признак выгорания." },
    { type: "h2", text: "Почему так происходит" },
    { type: "p", text: "Анкете достаётся взгляд длиной в моргание — этого и близко не хватает, чтобы вынести обдуманное суждение о человеке. Чтобы справиться с таким объёмом, мозг переходит на автопилот: качество решений падает, а то, с кем вы совпадёте, становится почти случайным. Это усталость от решений в самом буквальном смысле: слишком много почти одинаковых выборов, слишком быстро и слишком долго." },
    { type: "h2", text: "Что делать" },
    { type: "p", text: "Ставьте предел на сессию — скажем, не больше десяти анкет — и уделяйте каждой несколько неторопливых секунд. А лучше перейдите в приложения, где механики свайпа нет вовсе. В Qulo этап решения вопросов делает каждое взаимодействие осознанным по устройству: продвинуться на рефлексе нельзя." },

    { type: "h2", text: "Признак 3: избегание ответов на сообщения" },
    { type: "h2", text: "Как распознать" },
    { type: "p", text: "Вы видите уведомления о совпадениях, но отвечать нет никакого желания. Говорите себе, что напишете позже, и забываете. Сообщения копятся, а вы избегаете даже открывать их. Уведомление «Новое совпадение!», которое раньше что-то зажигало, теперь не значит ничего." },
    { type: "h2", text: "Почему так происходит" },
    { type: "p", text: "Повторяющиеся разговоры, которые никуда не ведут, подтачивают желание общаться. Большинство переписок в приложениях гаснет после первых нескольких сообщений, и этот паттерн тихо учит, что от написанного вами ничего не изменится. Психологи описывают результат как социальное истощение; сильнее всего оно бьёт по интровертам, которые и так тратят больше энергии на каждый разговор." },
    { type: "h2", text: "Что делать" },
    { type: "p", text: "Выбирайте качество вместо охвата. Вместо попыток ответить всем сосредоточьтесь на одном-двух людях, которые вам действительно интересны, и напишите им что-то, что стоит прочесть. Механика вопросов и ответов Qulo делает часть этой работы за вас: поскольку для совпадения нужно решить вопросы, написанные самим человеком, совпадение уже означает, что настоящее внимание было потрачено." },

    { type: "h2", text: "Признак 4: все выглядят одинаково" },
    { type: "h2", text: "Как распознать" },
    { type: "p", text: "Анкеты перестают отличаться друг от друга. Все в одинаковых позах, с одинаковыми фильтрами, под одинаковым описанием. Кажется, что «Люблю путешествия, кофе и бег» вы прочли в стотысячный раз. Этот эффект сглаживания — серьёзный признак выгорания." },
    { type: "h2", text: "Почему так происходит" },
    { type: "p", text: "Мозг привыкает. При достаточном количестве почти одинаковых стимулов подряд способность замечать индивидуальные различия снижается — различия никуда не делись, вы просто перестаёте их регистрировать. Приложения, построенные на свайпе, показывают каждую анкету в едином стандартном формате, что стирает большую часть сигнала, который человек иначе подал бы. Все начинают выглядеть одинаково, потому что вы больше не различаете их." },
    { type: "h2", text: "Что делать" },
    { type: "p", text: "Переходите на площадки, где на первом месте личность. В Qulo каждый участник пишет собственные вопросы — от двух до десяти, у каждого по четыре варианта ответа, — и эти вопросы представляют человека куда лучше любой фотографии. То, о чём человек решает спросить, и три неверных варианта, которые он придумывает, говорят о его юморе, внимании и ценностях. Двум людям очень трудно написать одинаковый набор." },

    { type: "h2", text: "Признак 5: желание знакомиться в реальной жизни" },
    { type: "h2", text: "Как распознать" },
    { type: "p", text: "Вы ловите себя на мысли: «Хочу просто познакомиться с кем-то обычным способом». Приложения кажутся вам стойко искусственными. Вам не хватает случайности встречи вместо представления от алгоритма. Это чувство совершенно нормально и отражает здоровый инстинкт." },
    { type: "h2", text: "Почему так происходит" },
    { type: "p", text: "Человеческий мозг развивался для общения лицом к лицу. Тон голоса, язык тела и взгляд несут значительную часть того, что вы узнаёте о человеке в первые минуты; приложения убирают всё это и сводят знакомство к оценке текста и фотографий. В итоге получается процедура, которая работает, но редко ощущается естественной." },
    { type: "h2", text: "Что делать" },
    { type: "p", text: "Считайте знакомства в жизни и онлайн не альтернативами, а дополнением друг друга. Ходите в клубы по интересам, бывайте на мероприятиях. В цифровой части выбирайте площадки, где само взаимодействие ощущается менее механическим. Разбирать чьи-то вопросы в Qulo ближе к разговору в кафе, чем к перебиранию колоды карт, — и это придаёт даже цифровому знакомству что-то от фактуры настоящего." },

    { type: "h2", accent: "green", text: "Как Qulo борется с выгоранием на уровне устройства" },
    { type: "p", text: "Qulo построен вокруг того, что на самом деле вызывает выгорание от приложений для знакомств. Каждый участник пишет от двух до десяти собственных вопросов, у каждого по четыре варианта ответа, и совпадение происходит, когда вы отвечаете верно на все. Одна эта механика закрывает большую часть того, что петля свайпа делает не так:" },
    { type: "ul", items: [
      "**Никакой бесконечной прокрутки:** каждое взаимодействие осознанно и конечно",
      "**Никакого автопилота:** решение вопроса требует настоящего размышления",
      "**Совпадения со смыслом:** тот, кто совпал с вами, прочитал написанное вами и ответил верно",
      "**Естественное начало разговора:** у вас уже есть конкретная тема",
      "**Анкеты, которые различаются:** написанные человеком вопросы трудно спутать с чужими",
    ] },

    { type: "h2", text: "Советы по цифровому детоксу" },
    { type: "p", text: "Если выгорание уже наступило, короткий цифровой детокс стоит попробовать:" },
    { type: "ul", items: [
      "Сделайте недельный перерыв от всех приложений для знакомств",
      "Потратьте это время на себя: спорт, хобби, друзья",
      "Перед возвращением честно ответьте на один вопрос: что я на самом деле ищу?",
      "Ограничьте число используемых приложений одним-двумя",
      "Вернитесь с установкой на качество: меньше анкет, больше внимания",
    ] },

    { type: "quote", text: "«Выгорание приходит не от поиска не тех людей, а от поиска не тем способом. Смените метод — и поиск снова станет приятным.»" },

    { type: "h2", accent: "green", text: "Заключение" },
    { type: "p", text: "Выгорание от приложений для знакомств реально, широко распространено и заслуживает серьёзного отношения — и оно не означает, что от знакомств онлайн нужно отказаться. Распознать признаки — первый шаг, изменить подход — второй. Система, построенная на вопросах, переносит опыт с поверхности в глубину и снижает выгорание как побочный эффект, а не как функцию. В Qulo вы можете заново открыть, каково это — по-настоящему интересоваться человеком." },
  ],

  pt: [
    { type: "h2", text: "O que é o esgotamento por apps de namoro?" },
    { type: "p", text: "O esgotamento por apps de namoro é o cansaço emocional, mental e motivacional que se acumula com o uso prolongado desses aplicativos. Ele aparece num espectro amplo: da perda silenciosa de interesse nos apps a uma apatia geral em relação a namorar. E é comum o suficiente para ter sido medido: numa pesquisa da **Forbes Health** de 2024, feita com a **OnePoll** entre **1.000** adultos americanos que haviam usado um app de namoro no último ano, **78%** disseram ter se sentido esgotados." },
    { type: "p", text: "Esgotamento não significa que você precise abandonar os apps de namoro por completo. Mas reconhecer os sinais e dar os passos certos faz diferença — tanto para a sua vida amorosa digital quanto para a real. Quais são, então, os sinais do esgotamento por apps de namoro, e como sair dele?" },

    { type: "h2", text: "Sinal 1: não querer abrir o app" },
    { type: "h2", text: "Como reconhecer" },
    { type: "p", text: "Você dispensa as notificações do app repetidamente. Sente uma pequena resistência interna ao ver o ícone no celular. O que antes era empolgante agora parece obrigação. Esse é um dos sinais mais precoces e comuns do esgotamento: abrir o app deixou de ser algo que você quer fazer e virou mais um item da lista de tarefas." },
    { type: "h2", text: "Por que acontece" },
    { type: "p", text: "Repetir uma ação que raramente compensa vai ensinando que o esforço é inútil — os psicólogos chamam esse padrão de desamparo aprendido. Quando você dedica tempo real a um app sem resultado, seu cérebro arquiva a atividade como \"recompensa insuficiente\" e a motivação cai. Abrir o app deixa de ser registrado como prêmio e passa a ser registrado como peso." },
    { type: "h2", text: "O que fazer" },
    { type: "p", text: "Defina \"horários de app\" para você. Abra-o uma vez por dia, num horário escolhido de antemão, por uma janela curta — quinze minutos bastam. Uso intencional vence acesso constante. Migrar para um app baseado em perguntas como o Qulo também quebra o ciclo de rolagem infinita e faz cada sessão valer a abertura." },

    { type: "h2", text: "Sinal 2: deslizar no automático" },
    { type: "h2", text: "Como reconhecer" },
    { type: "p", text: "Você desliza para a esquerda ou para a direita quase por reflexo, sem olhar os perfis de verdade. Não lê as descrições. Mal registra as fotos. Deslizar virou um jogo que perdeu o sentido. Na cultura desses apps isso é chamado de deslizar no automático, e é um indicador sério de esgotamento." },
    { type: "h2", text: "Por que acontece" },
    { type: "p", text: "Um perfil recebe um olhar do tamanho de um piscar de olhos, muito longe do necessário para formar um juízo pensado sobre alguém. Para dar conta desse volume, o cérebro entra no piloto automático: a qualidade da decisão cai e com quem você dá match fica quase aleatório. É fadiga de decisão no sentido mais literal: escolhas demais, quase idênticas, rápidas demais, por tempo demais." },
    { type: "h2", text: "O que fazer" },
    { type: "p", text: "Ponha um limite por sessão — no máximo dez perfis, por exemplo — e dê a cada um alguns segundos sem pressa. Melhor ainda: migre para apps que eliminam a mecânica de deslizar. No Qulo, a etapa de resolver perguntas torna cada interação deliberada por construção: não há como avançar no reflexo." },

    { type: "h2", text: "Sinal 3: evitar responder às mensagens" },
    { type: "h2", text: "Como reconhecer" },
    { type: "p", text: "Você vê as notificações de match, mas não tem motivação para responder. Diz a si mesmo que escreve depois e esquece. As mensagens se acumulam e você evita até abri-las. O \"Novo match!\" que antes acendia alguma coisa agora não diz nada." },
    { type: "h2", text: "Por que acontece" },
    { type: "p", text: "Conversas repetitivas e sem desdobramento corroem a vontade de se comunicar. A maioria das trocas nos apps de namoro se apaga depois das primeiras mensagens, e esse padrão ensina em voz baixa que nada do que você escrever fará diferença. Os psicólogos descrevem o resultado como exaustão social, e ela atinge com mais força quem é introvertido e já gasta mais energia por conversa." },
    { type: "h2", text: "O que fazer" },
    { type: "p", text: "Escolha qualidade em vez de alcance. Em vez de tentar responder a todo mundo, concentre-se nas uma ou duas pessoas que realmente interessam e escreva algo que valha a leitura. A mecânica de perguntas e respostas do Qulo faz parte desse trabalho por você: como dar match exige resolver as perguntas que a pessoa escreveu, um match já significa que houve atenção real." },

    { type: "h2", text: "Sinal 4: todo mundo parece igual" },
    { type: "h2", text: "Como reconhecer" },
    { type: "p", text: "Os perfis param de se diferenciar. Todos aparecem nas mesmas poses, com os mesmos filtros, sob a mesma descrição. Você sente que leu \"Amo viajar, café e correr\" pela centésima milésima vez. Esse efeito de achatamento é um sinal sério de esgotamento." },
    { type: "h2", text: "Por que acontece" },
    { type: "p", text: "O cérebro se habitua. Exposto a estímulos quase idênticos em sequência, ele perde capacidade de perceber diferenças individuais — elas continuam ali, você é que para de registrá-las. Apps baseados em deslizar apresentam cada perfil num único formato padronizado, o que apaga boa parte do sinal que uma pessoa emitiria de outro modo. Todos começam a parecer iguais porque você já não consegue distingui-los." },
    { type: "h2", text: "O que fazer" },
    { type: "p", text: "Migre para plataformas onde a personalidade vem primeiro. No Qulo cada pessoa escreve as próprias perguntas — entre duas e dez, cada uma com quatro opções — e essas perguntas apresentam alguém muito melhor do que uma foto. O que a pessoa escolhe perguntar, e as três respostas erradas que inventa, dizem algo sobre o humor, a atenção e os valores dela. É muito difícil duas pessoas escreverem o mesmo conjunto." },

    { type: "h2", text: "Sinal 5: preferir conhecer na vida real" },
    { type: "h2", text: "Como reconhecer" },
    { type: "p", text: "Você se pega pensando: \"Queria só conhecer alguém do jeito normal\". Os apps parecem artificiais para você, de forma persistente. Sente falta do acaso de esbarrar em alguém em vez de ser apresentado por um algoritmo. Esse sentimento é completamente normal e reflete um instinto saudável." },
    { type: "h2", text: "Por que acontece" },
    { type: "p", text: "O cérebro humano evoluiu para o contato cara a cara. Tom de voz, linguagem corporal e olhar carregam boa parte do que você aprende sobre alguém nos primeiros minutos; os apps retiram tudo isso e reduzem o conhecer alguém à avaliação de texto e fotos. O resultado é um processo que funciona, mas raramente parece natural." },
    { type: "h2", text: "O que fazer" },
    { type: "p", text: "Trate conhecer pessoas na vida real e online como complementos, não como alternativas. Entre em grupos de hobby, vá a eventos. No lado digital, escolha plataformas em que a interação em si pareça menos mecânica. Resolver as perguntas de alguém no Qulo está mais perto de uma conversa de café do que de organizar um baralho — e isso dá até a um encontro digital algo da textura de um real." },

    { type: "h2", accent: "green", text: "Como o Qulo combate o esgotamento por design" },
    { type: "p", text: "O Qulo foi construído em torno do que de fato causa o esgotamento por apps de namoro. Cada pessoa escreve entre duas e dez perguntas próprias, cada uma com quatro opções, e o match acontece quando você acerta todas. Essa única mecânica resolve a maior parte do que o ciclo de deslizar faz errado:" },
    { type: "ul", items: [
      "**Sem rolagem infinita:** cada interação é deliberada e finita",
      "**Sem piloto automático:** resolver uma pergunta exige pensar de verdade",
      "**Matches com significado:** quem deu match com você leu o que você escreveu e acertou",
      "**Aberturas naturais:** você já tem algo concreto para conversar",
      "**Perfis que se distinguem:** as perguntas que alguém escreve tornam difícil confundi-lo com outra pessoa",
    ] },

    { type: "h2", text: "Dicas de detox digital" },
    { type: "p", text: "Se o esgotamento já chegou, vale tentar um curto detox digital:" },
    { type: "ul", items: [
      "Dê uma pausa de uma semana em todos os apps de namoro",
      "Use esse tempo com você: exercício, hobbies, amigos",
      "Antes de voltar, responda com honestidade a uma pergunta: o que eu procuro de verdade?",
      "Limite a uma ou duas a quantidade de apps que usa",
      "Volte com uma exigência de qualidade: menos perfis, mais atenção",
    ] },

    { type: "quote", text: "\"O esgotamento não vem de procurar as pessoas erradas — vem de procurar do jeito errado. Mude o método e a busca volta a ser prazerosa.\"" },

    { type: "h2", accent: "green", text: "Conclusão" },
    { type: "p", text: "O esgotamento por apps de namoro é real, difundido e merece ser levado a sério — e não significa que você deva desistir de conhecer gente online. Reconhecer os sinais é o primeiro passo; mudar de abordagem é o segundo. Um sistema baseado em perguntas leva a experiência da superfície para a substância e reduz o esgotamento como efeito colateral, não como funcionalidade. No Qulo você pode redescobrir como é sentir curiosidade de verdade por alguém." },
  ],

  it: [
    { type: "h2", text: "Che cos'è il burnout da app di incontri?" },
    { type: "p", text: "Il burnout da app di incontri è la stanchezza emotiva, mentale e motivazionale che si accumula con l'uso prolungato di queste applicazioni. Si manifesta su uno spettro ampio: dal perdere in silenzio interesse per le app a un'indifferenza generale verso gli incontri in sé. Ed è abbastanza diffuso da essere stato misurato: in un sondaggio **Forbes Health** del 2024, condotto con **OnePoll** su **1.000** adulti statunitensi che avevano usato un'app di incontri nell'ultimo anno, il **78%** ha dichiarato di essersi sentito esaurito." },
    { type: "p", text: "Il burnout non significa che tu debba abbandonare del tutto le app di incontri. Ma riconoscere i segnali e fare i passi giusti conta — per la tua vita sentimentale digitale come per quella reale. Quali sono, allora, i segnali del burnout da app di incontri, e come se ne esce?" },

    { type: "h2", text: "Segnale 1: temere di aprire l'app" },
    { type: "h2", text: "Come riconoscerlo" },
    { type: "p", text: "Rimandi di continuo le notifiche dell'app. Provi una piccola resistenza interiore quando ne vedi l'icona sul telefono. Ciò che un tempo era eccitante ora sembra un dovere. È uno dei segnali più precoci e comuni del burnout: aprire l'app è passato dall'essere un desiderio a un'altra voce nella lista delle cose da fare." },
    { type: "h2", text: "Perché succede" },
    { type: "p", text: "Ripetere un'azione che raramente ripaga insegna col tempo che lo sforzo è inutile — gli psicologi chiamano questo schema impotenza appresa. Quando dedichi tempo vero a un'app senza risultati, il cervello archivia l'attività sotto \"ricompensa insufficiente\" e la motivazione crolla. Aprire l'app smette di essere registrato come premio e comincia a essere registrato come peso." },
    { type: "h2", text: "Cosa fare" },
    { type: "p", text: "Datti delle \"ore da app\" definite. Aprila una volta al giorno, a un orario scelto in anticipo, per una finestra breve — quindici minuti bastano e avanzano. L'uso intenzionale batte l'accesso continuo. Passare a un'app basata sulle domande come Qulo spezza anche il circolo dello scorrimento infinito e rende ogni sessione degna di essere aperta." },

    { type: "h2", text: "Segnale 2: scorrere senza pensare" },
    { type: "h2", text: "Come riconoscerlo" },
    { type: "p", text: "Scorri a sinistra o a destra quasi per riflesso, senza guardare davvero i profili. Non leggi le descrizioni. Registri a malapena le foto. Lo scorrimento è diventato un gioco che ha perso il suo scopo. Nella cultura di queste app lo si chiama scorrimento distratto, ed è un indicatore serio di burnout." },
    { type: "h2", text: "Perché succede" },
    { type: "p", text: "Un profilo riceve uno sguardo lungo quanto un battito di ciglia, che non basta neanche lontanamente per arrivare a un giudizio ponderato su una persona. Per reggere quel volume il cervello passa al pilota automatico: la qualità delle decisioni cala e con chi fai match diventa quasi casuale. È affaticamento decisionale nel senso più letterale: troppe scelte quasi identiche, prese troppo in fretta, per troppo tempo." },
    { type: "h2", text: "Cosa fare" },
    { type: "p", text: "Fissa un limite per ogni sessione — dieci profili al massimo, per esempio — e concedi a ciascuno qualche secondo senza fretta. Meglio ancora: passa ad app che eliminano del tutto la meccanica dello scorrimento. Su Qulo il passaggio di risoluzione delle domande rende ogni interazione deliberata per costruzione: non c'è modo di procedere per riflesso." },

    { type: "h2", text: "Segnale 3: evitare di rispondere ai messaggi" },
    { type: "h2", text: "Come riconoscerlo" },
    { type: "p", text: "Vedi le notifiche di match ma non hai nessuna motivazione per rispondere. Ti dici che scriverai dopo, e poi te ne dimentichi. I messaggi si accumulano ed eviti persino di aprirli. Il \"Nuovo match!\" che una volta accendeva qualcosa ora non ti dice più niente." },
    { type: "h2", text: "Perché succede" },
    { type: "p", text: "Le conversazioni ripetitive e senza seguito erodono la voglia di comunicare. La maggior parte degli scambi sulle app di incontri si spegne dopo i primi messaggi, e questo schema ti insegna sottovoce che nulla di ciò che scrivi conterà. Gli psicologi descrivono il risultato come esaurimento sociale, e colpisce più duramente le persone introverse, che già spendono più energia per ogni conversazione." },
    { type: "h2", text: "Cosa fare" },
    { type: "p", text: "Scegli la qualità invece della copertura. Invece di provare a rispondere a tutti, concentrati sulle una o due persone che ti interessano davvero e scrivi loro qualcosa che valga la lettura. Il meccanismo di domande e risposte di Qulo fa una parte di questo lavoro per te: poiché per fare match bisogna risolvere le domande che quella persona ha scritto, un match significa già che è stata dedicata attenzione vera." },

    { type: "h2", text: "Segnale 4: sembrano tutti uguali" },
    { type: "h2", text: "Come riconoscerlo" },
    { type: "p", text: "I profili smettono di distinguersi. Tutti compaiono nelle stesse pose, con gli stessi filtri, sotto la stessa descrizione. Ti sembra di aver letto \"Amo viaggiare, il caffè e correre\" per la centomillesima volta. Questo effetto di appiattimento è un segnale serio di burnout." },
    { type: "h2", text: "Perché succede" },
    { type: "p", text: "Il cervello si abitua. Esposto a un numero sufficiente di stimoli quasi identici di fila, la capacità di notare le differenze individuali cala — le differenze ci sono ancora, sei tu che smetti di registrarle. Le app basate sullo scorrimento presentano ogni profilo in un unico formato standardizzato, cancellando gran parte del segnale che una persona emetterebbe altrimenti. Cominciano tutti a sembrare uguali perché non riesci più a distinguerli." },
    { type: "h2", text: "Cosa fare" },
    { type: "p", text: "Passa a piattaforme in cui viene prima la personalità. Su Qulo ogni iscritto scrive le proprie domande — da due a dieci, ciascuna con quattro opzioni — e queste domande presentano una persona molto meglio di quanto possa fare una foto. Che cosa qualcuno sceglie di chiedere, e quali tre risposte sbagliate inventa, dice qualcosa del suo umorismo, della sua attenzione e dei suoi valori. È molto difficile che due persone scrivano lo stesso insieme." },

    { type: "h2", text: "Segnale 5: preferire di conoscersi nella vita reale" },
    { type: "h2", text: "Come riconoscerlo" },
    { type: "p", text: "Ti sorprendi a pensare: \"Vorrei solo conoscere qualcuno nel modo normale\". Le app ti sembrano ostinatamente artificiali. Ti manca il caso di incontrare qualcuno invece di essere presentato da un algoritmo. È un sentimento del tutto normale e riflette un istinto sano." },
    { type: "h2", text: "Perché succede" },
    { type: "p", text: "Il cervello umano si è evoluto per il contatto faccia a faccia. Tono di voce, linguaggio del corpo e sguardo portano gran parte di ciò che impari di una persona nei primi minuti; le app tolgono tutto questo e riducono il conoscersi alla valutazione di testo e fotografie. Il risultato è un procedimento che funziona, ma che raramente sembra naturale." },
    { type: "h2", text: "Cosa fare" },
    { type: "p", text: "Tratta il conoscersi dal vivo e online come complementari, non come alternative. Iscriviti a gruppi di hobby, vai agli eventi. Sul versante digitale, scegli piattaforme in cui l'interazione stessa sembri meno meccanica. Risolvere le domande di qualcuno su Qulo somiglia più a una chiacchierata al bar che a smazzare un mazzo di carte — e questo dà anche a un incontro digitale qualcosa della trama di uno reale." },

    { type: "h2", accent: "green", text: "Come Qulo contrasta il burnout fin dal design" },
    { type: "p", text: "Qulo è costruito attorno a ciò che causa davvero il burnout da app di incontri. Ogni iscritto scrive da due a dieci domande proprie, ciascuna con quattro opzioni, e il match avviene rispondendo correttamente a tutte. Questa sola meccanica risolve la maggior parte di ciò che il circolo dello scorrimento sbaglia:" },
    { type: "ul", items: [
      "**Niente scorrimento infinito:** ogni interazione è deliberata e finita",
      "**Niente pilota automatico:** risolvere una domanda richiede di pensare davvero",
      "**Match che significano qualcosa:** chi ha fatto match con te ha letto ciò che hai scritto e ci ha azzeccato",
      "**Aperture naturali:** hai già qualcosa di concreto di cui parlare",
      "**Profili che si distinguono:** le domande che uno scrive lo rendono difficile da confondere con altri",
    ] },

    { type: "h2", text: "Consigli per un detox digitale" },
    { type: "p", text: "Se il burnout è già arrivato, vale la pena provare un breve detox digitale:" },
    { type: "ul", items: [
      "Prenditi una settimana di pausa da tutte le app di incontri",
      "Dedica quel tempo a te: sport, hobby, amici",
      "Prima di tornare, rispondi onestamente a una domanda: che cosa sto cercando davvero?",
      "Limita a una o due il numero di app che usi",
      "Torna con un criterio di qualità: meno profili, più attenzione",
    ] },

    { type: "quote", text: "\"Il burnout non nasce dal cercare le persone sbagliate — nasce dal cercare nel modo sbagliato. Cambia metodo e la ricerca torna piacevole.\"" },

    { type: "h2", accent: "green", text: "Conclusione" },
    { type: "p", text: "Il burnout da app di incontri è reale, diffuso e merita di essere preso sul serio — e non significa che tu debba rinunciare a conoscere persone online. Riconoscere i segnali è il primo passo; cambiare approccio è il secondo. Un sistema basato sulle domande sposta l'esperienza dalla superficie alla sostanza e riduce il burnout come effetto collaterale, non come funzione. Su Qulo puoi riscoprire che cosa si prova a essere davvero curioso di qualcuno." },
  ],

  ja: [
    { type: "h2", text: "マッチングアプリ疲れとは？" },
    { type: "p", text: "マッチングアプリ疲れとは、アプリを長く使い続けるうちに積み重なる感情的・精神的・意欲的な消耗のことです。現れ方は幅広く、静かにアプリへの関心を失う段階から、恋愛そのものへの無関心にまで及びます。しかも測定できるほど一般的です。**Forbes Health** が **OnePoll** と共同で2024年に実施した調査では、過去1年にマッチングアプリを使った米国の成人**1,000**人のうち、**78%**が燃え尽きを感じたことがあると答えました。" },
    { type: "p", text: "疲れているからといって、マッチングアプリを完全にやめる必要はありません。ただ、兆候に気づいて適切な手を打つことは、オンラインでの出会いにとっても現実の関係にとっても大切です。では、マッチングアプリ疲れの兆候とは何で、どうすれば抜け出せるのでしょうか。" },

    { type: "h2", text: "兆候1：アプリを開きたくない" },
    { type: "h2", text: "見分け方" },
    { type: "p", text: "アプリの通知を何度も後回しにしています。スマホでアイコンを目にすると、小さな抵抗を感じます。かつて胸が高鳴ったものが、いまは義務のように感じられる。これはマッチングアプリ疲れの最も早い、そして最もよくある兆候のひとつです。アプリを開くことが「したいこと」から「やることリストの一項目」へ変わってしまったのです。" },
    { type: "h2", text: "なぜ起きるのか" },
    { type: "p", text: "報われることの少ない行動をくり返すと、努力は無駄だと少しずつ学習してしまいます。心理学で学習性無力感と呼ばれるパターンです。まとまった時間を使っても成果が出ないと、脳はその行動を「報酬が足りない」と分類し、意欲が下がります。アプリを開くことは報酬ではなく負担として記録されるようになります。" },
    { type: "h2", text: "どうすればいいか" },
    { type: "p", text: "「アプリを見る時間」をはっきり決めましょう。1日1回、あらかじめ決めた時刻に、短い枠だけ開く。15分もあれば十分です。いつでも見られる状態より、意識的な使い方のほうが効きます。Qulo のような質問ベースのアプリに移ることも、無限スクロールの輪を断ち切り、開く価値のある時間に変えてくれます。" },

    { type: "h2", text: "兆候2：何も考えずにスワイプしている" },
    { type: "h2", text: "見分け方" },
    { type: "p", text: "プロフィールをろくに見ないまま、ほとんど反射で左右にスワイプしています。自己紹介は読まない。写真もほとんど目に入っていない。スワイプは目的を失ったゲームになっています。この無自覚なスワイプは、深刻な疲れのサインです。" },
    { type: "h2", text: "なぜ起きるのか" },
    { type: "p", text: "ひとつのプロフィールに向けられるのはまばたきほどの時間で、人について落ち着いた判断を下すにはまるで足りません。その量をさばくために脳はオートパイロットに入ります。判断の質は落ち、誰とマッチするかはほとんど偶然になります。ほぼ同じ選択を、速すぎる速度で、長すぎる時間くり返す——文字どおりの決断疲れです。" },
    { type: "h2", text: "どうすればいいか" },
    { type: "p", text: "1回あたりの上限を決めましょう。たとえば最大10人まで、そして一人ひとりに数秒、急がずに目を向ける。さらに良いのは、スワイプという仕組み自体がないアプリに移ることです。Qulo では質問に答える工程があるため、あらゆるやり取りが構造的に意識的になります。反射だけで先へ進む方法はありません。" },

    { type: "h2", text: "兆候3：メッセージに返信しなくなる" },
    { type: "h2", text: "見分け方" },
    { type: "p", text: "マッチの通知は見えているのに、返す気力がわきません。あとで書こうと思って、そのまま忘れる。メッセージがたまり、開くことすら避けている。かつて何かをともした「新しいマッチ！」の通知が、いまは何も感じさせません。" },
    { type: "h2", text: "なぜ起きるのか" },
    { type: "p", text: "くり返される、実らない会話は、話そうという気持ちをすり減らします。マッチングアプリでのやり取りの多くは最初の数通で途切れ、その反復が「何を書いても変わらない」と静かに教え込みます。心理学ではこの状態を社会的消耗と呼びます。もともと会話ひとつに多くのエネルギーを使う内向的な人ほど強く出ます。" },
    { type: "h2", text: "どうすればいいか" },
    { type: "p", text: "広さより質を選びましょう。全員に返そうとするのではなく、本当に気になる1人か2人に絞り、読む価値のある文章を書く。Qulo の質問と回答の仕組みは、その一部を代わりに引き受けます。マッチには相手が自分で書いた質問を解く必要があるため、マッチした時点ですでに本当の注意が払われているからです。" },

    { type: "h2", text: "兆候4：みんな同じに見える" },
    { type: "h2", text: "見分け方" },
    { type: "p", text: "プロフィールの違いが分からなくなります。同じポーズ、同じフィルター、同じ自己紹介。「旅行とコーヒーとランニングが好きです」を十万回目に読んだ気分になる。この平板化は深刻な疲れのサインです。" },
    { type: "h2", text: "なぜ起きるのか" },
    { type: "p", text: "脳は慣れます。ほとんど同じ刺激を連続して浴びると、個々の違いに気づく力が落ちます。違いは消えていないのに、こちらが記録しなくなるのです。スワイプ型のアプリはすべてのプロフィールを単一の規格に流し込むため、人が本来発している情報の多くが削ぎ落とされます。見分けられないから、みんな同じに見え始めるのです。" },
    { type: "h2", text: "どうすればいいか" },
    { type: "p", text: "人柄が先に立つ場に移りましょう。Qulo では一人ひとりが自分の質問を書きます。2問から10問、それぞれに4つの選択肢。この質問は、どんな写真よりもその人をよく伝えます。何を尋ねるかという選択も、間違いの選択肢を3つどう作るかも、ユーモアや注意深さや価値観を映します。二人の人が同じ組み合わせを書くことは、まずありません。" },

    { type: "h2", text: "兆候5：現実で出会いたいと思う" },
    { type: "h2", text: "見分け方" },
    { type: "p", text: "「普通に誰かと出会えたらいいのに」と考えている自分に気づきます。マッチングアプリがどうしても不自然に感じられる。アルゴリズムに紹介されるより、偶然すれ違う出会いが恋しい。この感覚はまったく正常で、健全な直感の表れです。" },
    { type: "h2", text: "なぜ起きるのか" },
    { type: "p", text: "人の脳は対面のやり取りに合わせて進化してきました。声の調子、身ぶり、視線は、最初の数分で相手について知ることの大きな部分を運びます。マッチングアプリはそれをすべて取り払い、出会いを文章と写真の評価に縮めてしまう。結果として、機能はするけれど自然には感じられない過程が残ります。" },
    { type: "h2", text: "どうすればいいか" },
    { type: "p", text: "現実の出会いとオンラインの出会いを、代替ではなく補い合うものとして捉えましょう。趣味の集まりに入り、イベントに足を運ぶ。デジタル側では、やり取りそのものが機械的に感じられない場を選ぶ。Qulo で誰かの質問を解く時間は、カードの束を仕分ける作業よりも、カフェでの会話に近いものです。だからオンラインの出会いにも、現実の手触りが少し宿ります。" },

    { type: "h2", accent: "green", text: "Qulo が設計で疲れに抗う理由" },
    { type: "p", text: "Qulo は、マッチングアプリ疲れの本当の原因を軸に作られています。一人ひとりが自分の質問を2問から10問書き、それぞれに4つの選択肢を用意する。すべて正解するとマッチが成立します。この一つの仕組みが、スワイプの輪が抱える問題の大半に答えます。" },
    { type: "ul", items: [
      "**無限スクロールがない：** すべてのやり取りが意識的で、終わりがある",
      "**オートパイロットがない：** 質問を解くには実際に考える必要がある",
      "**意味のあるマッチ：** マッチした相手は、あなたが書いたものを読んで正解している",
      "**自然な話し始め：** 話題がすでに具体的に用意されている",
      "**見分けのつくプロフィール：** 自分で書いた質問が、その人を他の誰かと取り違えにくくする",
    ] },

    { type: "h2", text: "デジタルデトックスのヒント" },
    { type: "p", text: "すでに疲れているなら、短いデジタルデトックスを試す価値があります。" },
    { type: "ul", items: [
      "1週間、すべてのマッチングアプリから離れる",
      "その時間を自分に使う。運動、趣味、友人",
      "戻る前に、ひとつだけ正直に答える。自分は本当は何を探しているのか",
      "使うアプリの数を1つか2つに絞る",
      "質を基準に戻る。プロフィールは少なく、注意は多く",
    ] },

    { type: "quote", text: "「疲れは、間違った人を探すことから来るのではなく、間違ったやり方で探すことから来る。方法を変えれば、探すことはまた楽しくなる。」" },

    { type: "h2", accent: "green", text: "まとめ" },
    { type: "p", text: "マッチングアプリ疲れは実在し、広く見られ、真剣に受け止める価値があります。それでも、オンラインで人と出会うことをやめる理由にはなりません。兆候に気づくのが第一歩、やり方を変えるのが第二歩です。質問ベースの仕組みは体験を表面から中身へ移し、機能としてではなく副作用として疲れを減らします。Qulo でなら、誰かに本当に興味を持つ感覚をもう一度見つけられます。" },
  ],

  ko: [
    { type: "h2", text: "데이팅 앱 번아웃이란?" },
    { type: "p", text: "데이팅 앱 번아웃은 앱을 오래 쓰면서 쌓이는 정서적·정신적·동기적 소진입니다. 앱에 대한 관심이 조용히 식는 단계부터 연애 자체에 대한 무관심까지, 폭넓은 스펙트럼으로 나타납니다. 게다가 측정될 만큼 흔합니다. **Forbes Health**가 **OnePoll**과 함께 2024년에 지난 1년간 데이팅 앱을 사용한 미국 성인 **1,000**명을 조사한 결과, **78%**가 번아웃을 느낀 적이 있다고 답했습니다." },
    { type: "p", text: "번아웃이 왔다고 해서 데이팅 앱을 완전히 끊어야 하는 것은 아닙니다. 다만 신호를 알아차리고 올바른 조치를 취하는 일은 온라인에서의 만남에도, 현실의 관계에도 중요합니다. 그렇다면 데이팅 앱 번아웃의 신호는 무엇이고, 어떻게 빠져나올 수 있을까요?" },

    { type: "h2", text: "신호 1: 앱을 열기 싫다" },
    { type: "h2", text: "어떻게 알아차리나" },
    { type: "p", text: "앱 알림을 계속 미룹니다. 휴대폰에서 아이콘을 볼 때마다 작은 저항감이 듭니다. 한때 설렜던 일이 이제는 숙제처럼 느껴집니다. 번아웃의 가장 이른, 가장 흔한 신호 중 하나입니다. 앱을 여는 일이 하고 싶은 일에서 할 일 목록의 한 항목으로 바뀐 것입니다." },
    { type: "h2", text: "왜 그럴까" },
    { type: "p", text: "좀처럼 보상이 없는 행동을 반복하면, 노력은 소용없다는 사실을 서서히 학습하게 됩니다. 심리학에서 학습된 무기력이라 부르는 패턴입니다. 실제로 시간을 들였는데도 결과가 없으면 뇌는 그 활동을 \"보상 부족\"으로 분류하고 동기가 떨어집니다. 앱을 여는 일이 더는 보상이 아니라 부담으로 기록됩니다." },
    { type: "h2", text: "무엇을 할까" },
    { type: "p", text: "\"앱 보는 시간\"을 분명히 정하세요. 하루 한 번, 미리 정해둔 시각에, 짧은 시간만 엽니다. 15분이면 충분합니다. 언제든 열 수 있는 상태보다 의도적인 사용이 낫습니다. Qulo처럼 질문 기반의 앱으로 옮기는 것도 무한 스크롤의 고리를 끊고, 열 만한 가치가 있는 시간으로 바꿔 줍니다." },

    { type: "h2", text: "신호 2: 생각 없이 넘기기" },
    { type: "h2", text: "어떻게 알아차리나" },
    { type: "p", text: "프로필을 제대로 보지도 않고 거의 반사적으로 좌우로 넘깁니다. 소개글은 읽지 않습니다. 사진도 거의 눈에 들어오지 않습니다. 넘기기는 목적을 잃은 게임이 되었습니다. 이런 무의식적 스와이프는 심각한 번아웃 지표입니다." },
    { type: "h2", text: "왜 그럴까" },
    { type: "p", text: "프로필 하나에 주어지는 시간은 눈 깜빡할 정도라, 사람에 대해 숙고한 판단을 내리기엔 턱없이 부족합니다. 그 양을 감당하려고 뇌는 자동조종으로 넘어갑니다. 판단의 질은 떨어지고, 누구와 매칭되는지는 거의 우연이 됩니다. 거의 같은 선택을 너무 빠르게, 너무 오래 반복하는 문자 그대로의 결정 피로입니다." },
    { type: "h2", text: "무엇을 할까" },
    { type: "p", text: "한 번에 볼 수를 정하세요. 예를 들어 최대 열 명, 그리고 한 사람에게 서두르지 않고 몇 초를 씁니다. 더 좋은 방법은 스와이프 장치 자체가 없는 앱으로 옮기는 것입니다. Qulo에서는 질문을 푸는 단계 때문에 모든 상호작용이 구조적으로 의도적입니다. 반사만으로 넘어갈 방법이 없습니다." },

    { type: "h2", text: "신호 3: 메시지에 답하지 않게 된다" },
    { type: "h2", text: "어떻게 알아차리나" },
    { type: "p", text: "매칭 알림은 보이는데 답할 마음이 나지 않습니다. 나중에 쓰겠다고 미루다가 잊습니다. 메시지가 쌓이고, 열어보는 것조차 피합니다. 예전에는 무언가를 켜던 \"새 매칭!\" 알림이 이제는 아무 감흥도 주지 않습니다." },
    { type: "h2", text: "왜 그럴까" },
    { type: "p", text: "반복되고 결실 없는 대화는 소통하려는 마음을 갉아먹습니다. 데이팅 앱의 대화 대부분은 처음 몇 통이 지나면 꺼지고, 그 반복이 무엇을 써도 달라지지 않는다고 조용히 가르칩니다. 심리학에서는 이 결과를 사회적 소진이라 부르며, 대화 하나에 더 많은 에너지를 쓰는 내향적인 사람에게 특히 세게 옵니다." },
    { type: "h2", text: "무엇을 할까" },
    { type: "p", text: "넓이보다 질을 택하세요. 모두에게 답하려 애쓰는 대신, 정말 궁금한 한두 사람에게 집중해 읽을 만한 글을 씁니다. Qulo의 질문·답변 방식은 그 일의 일부를 대신해 줍니다. 매칭하려면 상대가 직접 쓴 질문을 풀어야 하므로, 매칭이 되었다는 것은 이미 진짜 주의가 쓰였다는 뜻입니다." },

    { type: "h2", text: "신호 4: 다들 똑같아 보인다" },
    { type: "h2", text: "어떻게 알아차리나" },
    { type: "p", text: "프로필이 서로 구분되지 않습니다. 같은 포즈, 같은 필터, 같은 소개글. \"여행과 커피와 러닝을 좋아합니다\"를 십만 번째 읽는 기분이 듭니다. 이 평평해지는 현상은 심각한 번아웃 신호입니다." },
    { type: "h2", text: "왜 그럴까" },
    { type: "p", text: "뇌는 익숙해집니다. 거의 똑같은 자극을 연달아 충분히 받으면 개별 차이를 알아채는 능력이 떨어집니다. 차이는 그대로인데 우리가 등록하기를 멈추는 것입니다. 스와이프 기반 앱은 모든 프로필을 하나의 표준 형식에 담기 때문에, 사람이 원래 내보내는 신호의 대부분이 지워집니다. 구분할 수 없으니 다들 똑같아 보이기 시작합니다." },
    { type: "h2", text: "무엇을 할까" },
    { type: "p", text: "성격이 앞서는 플랫폼으로 옮기세요. Qulo에서는 각자 자신의 질문을 씁니다. 두 개에서 열 개까지, 각각 네 개의 선택지가 붙습니다. 이 질문들은 어떤 사진보다 그 사람을 잘 소개합니다. 무엇을 묻기로 했는지, 오답 세 개를 어떻게 지어냈는지가 그 사람의 유머와 주의력과 가치관을 보여 줍니다. 두 사람이 같은 묶음을 쓰기란 매우 어렵습니다." },

    { type: "h2", text: "신호 5: 현실에서 만나고 싶어진다" },
    { type: "h2", text: "어떻게 알아차리나" },
    { type: "p", text: "\"그냥 자연스럽게 누군가를 만나면 좋겠다\"고 생각하는 자신을 발견합니다. 데이팅 앱이 계속 인위적으로 느껴집니다. 알고리즘의 소개보다 우연히 마주치는 만남이 그립습니다. 이 감정은 완전히 정상이며 건강한 본능을 반영합니다." },
    { type: "h2", text: "왜 그럴까" },
    { type: "p", text: "사람의 뇌는 얼굴을 마주하는 접촉에 맞춰 진화했습니다. 목소리의 결, 몸짓, 눈 맞춤은 처음 몇 분 동안 상대에 대해 알게 되는 것의 큰 부분을 실어 나릅니다. 데이팅 앱은 그것을 모두 걷어내고 사람을 알아가는 일을 글과 사진의 평가로 줄입니다. 그래서 작동은 하지만 좀처럼 자연스럽게 느껴지지 않는 과정이 남습니다." },
    { type: "h2", text: "무엇을 할까" },
    { type: "p", text: "현실의 만남과 온라인의 만남을 대체재가 아니라 보완재로 보세요. 취미 모임에 나가고 행사에 참여하세요. 디지털 쪽에서는 상호작용 자체가 덜 기계적으로 느껴지는 플랫폼을 고르세요. Qulo에서 누군가의 질문을 푸는 시간은 카드 뭉치를 정리하는 일보다 카페에서 나누는 대화에 가깝습니다. 그래서 온라인 만남에도 현실의 결이 조금 스밉니다." },

    { type: "h2", accent: "green", text: "Qulo가 설계로 번아웃에 맞서는 방식" },
    { type: "p", text: "Qulo는 데이팅 앱 번아웃의 실제 원인을 중심에 두고 만들어졌습니다. 각자 자신의 질문을 두 개에서 열 개까지 쓰고, 각 질문에는 네 개의 선택지가 있으며, 전부 맞혀야 매칭이 성사됩니다. 이 하나의 장치가 스와이프 고리의 문제 대부분을 해결합니다." },
    { type: "ul", items: [
      "**무한 스크롤 없음:** 모든 상호작용이 의도적이고 끝이 있다",
      "**자동조종 없음:** 질문을 풀려면 실제로 생각해야 한다",
      "**의미 있는 매칭:** 당신과 매칭된 사람은 당신이 쓴 것을 읽고 맞혔다",
      "**자연스러운 첫 마디:** 이야기할 구체적인 소재가 이미 있다",
      "**구분되는 프로필:** 직접 쓴 질문이 그 사람을 다른 사람과 혼동하기 어렵게 만든다",
    ] },

    { type: "h2", text: "디지털 디톡스 팁" },
    { type: "p", text: "이미 번아웃이 왔다면 짧은 디지털 디톡스를 해볼 만합니다." },
    { type: "ul", items: [
      "일주일 동안 모든 데이팅 앱에서 손을 뗀다",
      "그 시간을 자신에게 쓴다: 운동, 취미, 친구",
      "돌아오기 전에 한 가지 질문에 솔직히 답한다: 나는 정말 무엇을 찾고 있나?",
      "사용하는 앱 수를 한두 개로 줄인다",
      "질을 기준으로 돌아온다: 프로필은 적게, 주의는 많이",
    ] },

    { type: "quote", text: "\"번아웃은 잘못된 사람을 찾아서가 아니라 잘못된 방식으로 찾아서 옵니다. 방법을 바꾸면 찾는 일이 다시 즐거워집니다.\"" },

    { type: "h2", accent: "green", text: "결론" },
    { type: "p", text: "데이팅 앱 번아웃은 실재하고, 널리 퍼져 있으며, 진지하게 받아들일 가치가 있습니다. 그렇다고 온라인에서 사람을 만나는 일을 포기해야 한다는 뜻은 아닙니다. 신호를 알아차리는 것이 첫걸음이고, 접근 방식을 바꾸는 것이 두 번째입니다. 질문 기반 시스템은 경험을 표면에서 내용으로 옮기고, 기능이 아니라 부수 효과로 번아웃을 줄입니다. Qulo에서 누군가에게 진짜로 궁금해지는 감각을 다시 발견할 수 있습니다." },
  ],

  zh: [
    { type: "h2", text: "什么是交友软件倦怠？" },
    { type: "p", text: "交友软件倦怠，是长期使用这类应用所累积的情绪、心理与动力上的疲惫。它的表现跨度很广：从悄悄对软件失去兴趣，到对恋爱本身普遍的无所谓。而且它常见到已被测量：**Forbes Health** 与 **OnePoll** 于2024年对过去一年使用过交友软件的 **1,000** 名美国成年人所做的调查中，**78%** 的人表示自己曾感到倦怠。" },
    { type: "p", text: "倦怠并不意味着你必须彻底放弃交友软件。但辨认出信号、采取正确的做法很重要——对线上的感情生活和现实生活都一样。那么，交友软件倦怠有哪些信号，又该如何走出来？" },

    { type: "h2", text: "信号一：不想打开软件" },
    { type: "h2", text: "如何辨认" },
    { type: "p", text: "你一次又一次地把软件的通知划掉。在手机上看到那个图标时，心里会浮起一点小小的抗拒。曾经让人期待的事，如今更像一项任务。这是倦怠最早、也最常见的信号之一：打开软件从你想做的事，变成了待办清单上的又一条。" },
    { type: "h2", text: "为什么会这样" },
    { type: "p", text: "反复做一件很少有回报的事，会慢慢教会人：努力没有意义。心理学称这种模式为习得性无助。当你在软件上花了实打实的时间却没有结果，大脑会把这件事归入\"回报不足\"，动力随之下降。打开软件不再被记录为奖励，而是被记录为负担。" },
    { type: "h2", text: "该怎么做" },
    { type: "p", text: "给自己定下明确的\"软件时间\"。每天打开一次，在事先选好的时刻，只用一小段时间——十五分钟足够了。有意识的使用胜过随时可及。转向像 Qulo 这样以问题为核心的应用，也能打破无限滑动的循环，让每一次打开都值得。" },

    { type: "h2", text: "信号二：机械式滑动" },
    { type: "h2", text: "如何辨认" },
    { type: "p", text: "你几乎是条件反射地左划右划，并没有真的在看资料。简介不读。照片也几乎没进眼睛。滑动变成了一场失去目的的游戏。这种无意识滑动是严重的倦怠指标。" },
    { type: "h2", text: "为什么会这样" },
    { type: "p", text: "一份资料得到的目光只有一眨眼那么长，远不足以对一个人形成经过思考的判断。为了应付这样的数量，大脑切换到自动驾驶：决策质量下降，和谁匹配几乎变成随机。这就是最字面意义上的决策疲劳——太多几乎一样的选择，做得太快，持续太久。" },
    { type: "h2", text: "该怎么做" },
    { type: "p", text: "给每次使用设一个上限——比如最多十份资料——并且给每一份几秒不赶时间的注意。更好的办法是转向根本没有滑动机制的应用。在 Qulo，答题这一步让每一次互动在结构上就是有意为之：没有办法靠反射前进。" },

    { type: "h2", text: "信号三：回避回复消息" },
    { type: "h2", text: "如何辨认" },
    { type: "p", text: "你看到了匹配通知，却提不起回复的动力。心想等会儿再写，然后就忘了。消息越积越多，你连打开都不愿意。那句曾经让人心头一动的\"新匹配！\"，如今什么感觉也没有。" },
    { type: "h2", text: "为什么会这样" },
    { type: "p", text: "重复而无果的对话会磨损沟通的意愿。交友软件上的大多数交流在最初几条消息之后就熄灭了，这种反复悄悄教会你：写什么都不会有区别。心理学把这种结果称为社交耗竭，它对本来每场对话就要花更多能量的内向者打击最重。" },
    { type: "h2", text: "该怎么做" },
    { type: "p", text: "选择质量而不是覆盖面。与其试图回复所有人，不如把注意力放在真正让你感兴趣的一两个人身上，写一些值得一读的话。Qulo 的问答机制替你完成了一部分工作：因为匹配需要解开对方亲手写下的问题，一次匹配本身就意味着有人付出了真正的注意力。" },

    { type: "h2", text: "信号四：觉得所有人都长得一样" },
    { type: "h2", text: "如何辨认" },
    { type: "p", text: "资料之间不再有区别。同样的姿势、同样的滤镜、同样的简介。你感觉\"喜欢旅行、咖啡和跑步\"这句话已经读了十万遍。这种被抹平的感受是严重的倦怠信号。" },
    { type: "h2", text: "为什么会这样" },
    { type: "p", text: "大脑会习惯。连续接受足够多几乎相同的刺激后，你察觉个体差异的能力会下降——差异仍然存在，只是你不再记录它们。基于滑动的应用把每份资料塞进同一套标准格式，抹去了一个人本来会散发的大部分信息。你分辨不出来了，所以所有人开始看起来一样。" },
    { type: "h2", text: "该怎么做" },
    { type: "p", text: "转向让性格先说话的平台。在 Qulo，每个人都写自己的问题——两到十道，每道四个选项——这些问题对一个人的介绍远胜任何照片。一个人选择问什么，以及编出哪三个错误答案，都会透露他的幽默感、注意力和价值观。两个人写出同一组问题，几乎不可能。" },

    { type: "h2", text: "信号五：更想在现实里认识人" },
    { type: "h2", text: "如何辨认" },
    { type: "p", text: "你会发现自己在想：\"要是能用平常的方式认识一个人就好了。\"交友软件让你持续觉得不自然。比起被算法介绍，你更怀念偶然遇见一个人的机会。这种感觉完全正常，而且反映了一种健康的直觉。" },
    { type: "h2", text: "为什么会这样" },
    { type: "p", text: "人的大脑是为面对面的接触演化出来的。语气、身体语言和眼神，承载了你在最初几分钟里对一个人所了解的大部分内容；交友软件把这些统统拿掉，把认识一个人压缩成对文字和照片的评估。结果是一个能运转、却很少让人觉得自然的过程。" },
    { type: "h2", text: "该怎么做" },
    { type: "p", text: "把现实中的相识和线上的相识看作互补，而不是替代。加入兴趣小组，去参加活动。在数字这一侧，选择互动本身不那么机械的平台。在 Qulo 解开一个人的问题，更像咖啡馆里的一场对话，而不是整理一副牌——这让线上的相识也带上了几分真实的质感。" },

    { type: "h2", accent: "green", text: "Qulo 如何用设计对抗倦怠" },
    { type: "p", text: "Qulo 是围绕交友软件倦怠的真正成因建立的。每个人写下两到十道自己的问题，每道四个选项，全部答对才会匹配。仅这一个机制，就化解了滑动循环大部分做错的地方：" },
    { type: "ul", items: [
      "**没有无限滑动：** 每一次互动都是有意的、有尽头的",
      "**没有自动驾驶：** 解一道题需要真的思考",
      "**有意义的匹配：** 和你匹配的人读了你写的东西并且答对了",
      "**自然的开场：** 你手上已经有具体可聊的内容",
      "**彼此有别的资料：** 一个人写下的问题让他很难与别人混淆",
    ] },

    { type: "h2", text: "数字排毒建议" },
    { type: "p", text: "如果倦怠已经来了，短暂的数字排毒值得一试：" },
    { type: "ul", items: [
      "用一周时间远离所有交友软件",
      "把这段时间花在自己身上：运动、爱好、朋友",
      "回来之前，诚实回答一个问题：我到底在找什么？",
      "把使用的软件数量控制在一两个",
      "带着对质量的要求回来：更少的资料，更多的注意",
    ] },

    { type: "quote", text: "\"倦怠不是来自寻找错的人，而是来自用错的方式寻找。换个方法，寻找会重新变得愉快。\"" },

    { type: "h2", accent: "green", text: "结语" },
    { type: "p", text: "交友软件倦怠是真实的、普遍的，也值得被认真对待——但它并不意味着你该放弃在线上认识人。辨认信号是第一步，改变方式是第二步。以问题为基础的系统把体验从表面推向内容，让倦怠作为副作用而非功能被削弱。在 Qulo，你可以重新找回真正对一个人好奇的感觉。" },
  ],

  nl: [
    { type: "h2", text: "Wat is dating-app-burn-out?" },
    { type: "p", text: "Dating-app-burn-out is de emotionele, mentale en motivationele uitputting die zich opbouwt bij langdurig gebruik van datingapps. Het uit zich op een breed spectrum: van stilletjes je interesse in de apps verliezen tot een algemene onverschilligheid tegenover daten zelf. En het komt vaak genoeg voor om gemeten te zijn: in een **Forbes Health**-onderzoek uit 2024, uitgevoerd met **OnePoll** onder **1.000** Amerikaanse volwassenen die het afgelopen jaar een datingapp hadden gebruikt, zei **78%** zich opgebrand te hebben gevoeld." },
    { type: "p", text: "Burn-out betekent niet dat je datingapps helemaal moet opgeven. Maar de signalen herkennen en de juiste stappen zetten doet ertoe — voor je digitale liefdesleven en voor je echte. Wat zijn dan de signalen van dating-app-burn-out, en hoe kom je eruit?" },

    { type: "h2", text: "Signaal 1: opzien tegen het openen van de app" },
    { type: "h2", text: "Hoe je het herkent" },
    { type: "p", text: "Je schuift meldingen van de app steeds weg. Bij het zien van het icoontje op je telefoon voel je een kleine innerlijke weerstand. Wat ooit spannend voelde, voelt nu als een klus. Dit is een van de vroegste en meest voorkomende signalen van burn-out: de app openen is van iets wat je wilt doen veranderd in nog een punt op een takenlijst." },
    { type: "h2", text: "Waarom het gebeurt" },
    { type: "p", text: "Een handeling herhalen die zelden iets oplevert, leert je gaandeweg dat de moeite zinloos is — psychologen noemen dat patroon aangeleerde hulpeloosheid. Als je echt tijd in een app steekt zonder resultaat, boekt je brein de activiteit onder \"te weinig beloning\" en zakt de motivatie. De app openen wordt niet langer geregistreerd als beloning, maar als last." },
    { type: "h2", text: "Wat je kunt doen" },
    { type: "p", text: "Geef jezelf duidelijke \"app-uren\". Open hem één keer per dag, op een vooraf gekozen tijdstip, voor een kort venster — vijftien minuten is ruim voldoende. Bewust gebruik verslaat voortdurende toegang. Overstappen op een vragengebaseerde app als Qulo doorbreekt bovendien de eindeloze scroll en maakt elke sessie het openen waard." },

    { type: "h2", text: "Signaal 2: gedachteloos swipen" },
    { type: "h2", text: "Hoe je het herkent" },
    { type: "p", text: "Je swipet bijna reflexmatig naar links of rechts, zonder de profielen echt te bekijken. Je leest de teksten niet. De foto's dringen nauwelijks door. Swipen is een spel geworden dat zijn doel kwijt is. In de cultuur rond deze apps heet dat gedachteloos swipen, en het is een serieus teken van burn-out." },
    { type: "h2", text: "Waarom het gebeurt" },
    { type: "p", text: "Een profiel krijgt een blik ter lengte van een oogwenk, bij lange na niet genoeg om tot een overwogen oordeel over een mens te komen. Om die hoeveelheid aan te kunnen schakelt het brein over op de automatische piloot: de kwaliteit van je beslissingen daalt en met wie je matcht wordt bijna willekeurig. Dat is beslismoeheid in de meest letterlijke zin — te veel bijna identieke keuzes, te snel gemaakt, te lang volgehouden." },
    { type: "h2", text: "Wat je kunt doen" },
    { type: "p", text: "Stel per sessie een limiet — bijvoorbeeld maximaal tien profielen — en geef elk daarvan een paar onhaastige seconden. Beter nog: stap over op apps die de swipe-mechaniek helemaal weglaten. Bij Qulo maakt de stap van vragen oplossen elke interactie al door de opzet bewust: op de reflex kom je niet verder." },

    { type: "h2", text: "Signaal 3: berichten niet meer beantwoorden" },
    { type: "h2", text: "Hoe je het herkent" },
    { type: "p", text: "Je ziet matchmeldingen, maar hebt geen motivatie om te antwoorden. Je zegt tegen jezelf dat je later schrijft, en vergeet het dan. Berichten stapelen zich op en je vermijdt het zelfs om ze te openen. Het \"Nieuwe match!\" dat ooit iets in gang zette, zegt je nu helemaal niets meer." },
    { type: "h2", text: "Waarom het gebeurt" },
    { type: "p", text: "Herhaalde gesprekken zonder vervolg vreten aan de zin om te communiceren. De meeste uitwisselingen op datingapps doven na de eerste paar berichten uit, en dat patroon leert je stilletjes dat niets van wat je schrijft ertoe doet. Psychologen noemen het resultaat sociale uitputting; het treft introverte mensen het hardst, die toch al meer energie per gesprek kwijt zijn." },
    { type: "h2", text: "Wat je kunt doen" },
    { type: "p", text: "Kies kwaliteit boven bereik. In plaats van iedereen te willen beantwoorden, richt je je op de één of twee mensen die je echt interesseren en schrijf je hun iets wat het lezen waard is. De vraag-en-antwoordmechaniek van Qulo neemt een deel van dat werk over: omdat matchen vereist dat je de zelfgeschreven vragen van iemand oplost, betekent een match al dat er echte aandacht is besteed." },

    { type: "h2", text: "Signaal 4: iedereen lijkt op elkaar" },
    { type: "h2", text: "Hoe je het herkent" },
    { type: "p", text: "Profielen onderscheiden zich niet meer. Iedereen verschijnt in dezelfde poses, met dezelfde filters, onder dezelfde tekst. Je hebt het gevoel dat je \"Ik hou van reizen, koffie en hardlopen\" voor de honderdduizendste keer leest. Dat afvlakkende effect is een serieus teken van burn-out." },
    { type: "h2", text: "Waarom het gebeurt" },
    { type: "p", text: "Breinen wennen. Als je genoeg bijna identieke prikkels achter elkaar krijgt, daalt je vermogen om individuele verschillen op te merken — de verschillen zijn er nog, jij registreert ze alleen niet meer. Op swipen gebaseerde apps presenteren elk profiel in één gestandaardiseerd format, waardoor het grootste deel van het signaal dat iemand anders zou afgeven verdwijnt. Iedereen begint hetzelfde te lijken omdat je ze niet meer uit elkaar houdt." },
    { type: "h2", text: "Wat je kunt doen" },
    { type: "p", text: "Stap over naar platforms waar de persoonlijkheid voorop staat. Bij Qulo schrijft elk lid eigen vragen — tussen de twee en tien, elk met vier antwoordopties — en die vragen introduceren iemand veel beter dan een foto kan. Wat iemand kiest te vragen, en welke drie foute antwoorden diegene verzint, zegt iets over humor, aandacht en waarden. Dat twee mensen dezelfde set schrijven, is heel onwaarschijnlijk." },

    { type: "h2", text: "Signaal 5: liever in het echt kennismaken" },
    { type: "h2", text: "Hoe je het herkent" },
    { type: "p", text: "Je betrapt jezelf op de gedachte: \"Ik zou gewoon iemand op de normale manier willen leren kennen.\" Datingapps voelen hardnekkig onnatuurlijk. Je mist het toeval van iemand tegenkomen in plaats van voorgesteld te worden door een algoritme. Dat gevoel is volkomen normaal en weerspiegelt een gezond instinct." },
    { type: "h2", text: "Waarom het gebeurt" },
    { type: "p", text: "Het menselijk brein is geëvolueerd voor contact van aangezicht tot aangezicht. Toonhoogte, lichaamstaal en oogcontact dragen een groot deel van wat je in de eerste minuten over iemand leert; datingapps halen dat allemaal weg en reduceren kennismaken tot het beoordelen van tekst en foto's. Het resultaat is een procedure die werkt, maar zelden natuurlijk aanvoelt." },
    { type: "h2", text: "Wat je kunt doen" },
    { type: "p", text: "Zie kennismaken in het echt en online als aanvulling op elkaar, niet als alternatieven. Sluit je aan bij hobbygroepen, ga naar evenementen. Kies aan de digitale kant platforms waar de interactie zelf minder mechanisch aanvoelt. Je door iemands vragen heen werken op Qulo lijkt meer op een gesprek in een café dan op het sorteren van een kaartspel — en dat geeft zelfs een digitale kennismaking iets van de textuur van een echte." },

    { type: "h2", accent: "green", text: "Hoe Qulo burn-out al in het ontwerp tegengaat" },
    { type: "p", text: "Qulo is gebouwd rond wat dating-app-burn-out werkelijk veroorzaakt. Elk lid schrijft tussen de twee en tien eigen vragen, elk met vier antwoordopties, en je matcht door ze allemaal goed te beantwoorden. Die ene mechaniek pakt het meeste aan van wat de swipe-lus verkeerd doet:" },
    { type: "ul", items: [
      "**Geen oneindig scrollen:** elke interactie is bewust en eindig",
      "**Geen automatische piloot:** een vraag oplossen vraagt om echt nadenken",
      "**Matches die iets betekenen:** wie met jou matcht, heeft gelezen wat je schreef en had het goed",
      "**Natuurlijke openers:** je hebt al iets concreets om over te praten",
      "**Profielen die verschillen:** de vragen die iemand schrijft maken diegene lastig te verwarren met een ander",
    ] },

    { type: "h2", text: "Tips voor een digitale detox" },
    { type: "p", text: "Als de burn-out er al is, is een korte digitale detox het proberen waard:" },
    { type: "ul", items: [
      "Neem een week pauze van alle datingapps",
      "Besteed die tijd aan jezelf: sport, hobby's, vrienden",
      "Beantwoord voor je terugkomt eerlijk één vraag: waar ben ik eigenlijk naar op zoek?",
      "Houd het aantal apps dat je gebruikt op één of twee",
      "Kom terug met een kwaliteitseis: minder profielen, meer aandacht",
    ] },

    { type: "quote", text: "\"Burn-out komt niet van het zoeken naar de verkeerde mensen — het komt van zoeken op de verkeerde manier. Verander de methode en het zoeken wordt weer leuk.\"" },

    { type: "h2", accent: "green", text: "Conclusie" },
    { type: "p", text: "Dating-app-burn-out is echt, wijdverbreid en verdient het serieus genomen te worden — en het betekent niet dat je het online leren kennen van mensen moet opgeven. De signalen herkennen is de eerste stap; je aanpak veranderen de tweede. Een vragengebaseerd systeem verplaatst de ervaring van oppervlakte naar inhoud en vermindert burn-out als bijwerking, niet als functie. Bij Qulo kun je herontdekken hoe het voelt om echt nieuwsgierig naar iemand te zijn." },
  ],

  pl: [
    { type: "h2", text: "Czym jest wypalenie aplikacjami randkowymi?" },
    { type: "p", text: "Wypalenie aplikacjami randkowymi to emocjonalne, psychiczne i motywacyjne wyczerpanie, które narasta przy długim korzystaniu z takich aplikacji. Objawia się na szerokim spektrum: od cichej utraty zainteresowania aplikacjami po ogólną obojętność wobec randkowania w ogóle. Jest przy tym na tyle powszechne, że zostało zmierzone: w badaniu **Forbes Health** z 2024 roku, przeprowadzonym z **OnePoll** wśród **1000** dorosłych Amerykanów, którzy w ciągu ostatniego roku korzystali z aplikacji randkowej, **78%** przyznało, że czuło się wypalonych." },
    { type: "p", text: "Wypalenie nie oznacza, że musisz całkowicie zrezygnować z aplikacji randkowych. Ale rozpoznanie sygnałów i podjęcie właściwych kroków ma znaczenie — zarówno dla twojego cyfrowego życia uczuciowego, jak i tego prawdziwego. Jakie są więc sygnały wypalenia aplikacjami randkowymi i jak z niego wyjść?" },

    { type: "h2", text: "Sygnał 1: niechęć do otwierania aplikacji" },
    { type: "h2", text: "Jak to rozpoznać" },
    { type: "p", text: "Wciąż odsuwasz powiadomienia z aplikacji. Na widok ikony na telefonie czujesz drobny wewnętrzny opór. To, co kiedyś ekscytowało, przypomina teraz obowiązek. To jeden z najwcześniejszych i najczęstszych sygnałów wypalenia: otwarcie aplikacji zmieniło się z czegoś, na co masz ochotę, w kolejny punkt na liście zadań." },
    { type: "h2", text: "Dlaczego tak się dzieje" },
    { type: "p", text: "Powtarzanie czynności, która rzadko się opłaca, z czasem uczy, że wysiłek nie ma sensu — psychologowie nazywają ten wzorzec wyuczoną bezradnością. Kiedy poświęcasz aplikacji realny czas bez efektów, mózg zapisuje tę aktywność jako \"niewystarczającą nagrodę\" i motywacja spada. Otwarcie aplikacji przestaje być rejestrowane jako nagroda, a zaczyna jako obciążenie." },
    { type: "h2", text: "Co robić" },
    { type: "p", text: "Wyznacz sobie konkretne \"godziny aplikacji\". Otwieraj ją raz dziennie, o wcześniej wybranej porze, na krótkie okno — piętnaście minut w zupełności wystarczy. Świadome korzystanie bije stały dostęp. Przejście na aplikację opartą na pytaniach, taką jak Qulo, dodatkowo przerywa pętlę nieskończonego przewijania i sprawia, że każde otwarcie ma sens." },

    { type: "h2", text: "Sygnał 2: bezmyślne przesuwanie" },
    { type: "h2", text: "Jak to rozpoznać" },
    { type: "p", text: "Przesuwasz w lewo albo w prawo niemal odruchowo, nie przyglądając się profilom. Nie czytasz opisów. Ledwie rejestrujesz zdjęcia. Przesuwanie stało się grą, która straciła cel. W kulturze tych aplikacji mówi się o bezmyślnym przesuwaniu i jest to poważny wskaźnik wypalenia." },
    { type: "h2", text: "Dlaczego tak się dzieje" },
    { type: "p", text: "Profil dostaje spojrzenie długości mrugnięcia, co nawet w przybliżeniu nie wystarcza, by wyrobić sobie przemyślaną opinię o człowieku. Żeby poradzić sobie z taką liczbą, mózg przełącza się na autopilota: jakość decyzji spada, a to, z kim się dopasujesz, staje się niemal losowe. To zmęczenie decyzyjne w najbardziej dosłownym sensie — zbyt wiele niemal identycznych wyborów, podejmowanych zbyt szybko, przez zbyt długi czas." },
    { type: "h2", text: "Co robić" },
    { type: "p", text: "Ustaw limit na sesję — na przykład maksymalnie dziesięć profili — i poświęć każdemu kilka niespiesznych sekund. Jeszcze lepiej: przejdź do aplikacji, które w ogóle rezygnują z mechaniki przesuwania. W Qulo etap rozwiązywania pytań sprawia, że każda interakcja jest świadoma z założenia: nie da się przejść dalej odruchem." },

    { type: "h2", text: "Sygnał 3: unikanie odpowiadania na wiadomości" },
    { type: "h2", text: "Jak to rozpoznać" },
    { type: "p", text: "Widzisz powiadomienia o dopasowaniach, ale nie masz motywacji, żeby odpisać. Mówisz sobie, że napiszesz później, a potem zapominasz. Wiadomości się piętrzą, a ty unikasz nawet ich otwierania. \"Nowe dopasowanie!\", które kiedyś coś w tobie zapalało, dziś nie znaczy nic." },
    { type: "h2", text: "Dlaczego tak się dzieje" },
    { type: "p", text: "Powtarzalne, donikąd nieprowadzące rozmowy podkopują chęć komunikowania się. Większość wymian w aplikacjach randkowych gaśnie po pierwszych kilku wiadomościach, a ten wzorzec po cichu uczy, że nic, co napiszesz, nie będzie miało znaczenia. Psychologowie opisują ten stan jako wyczerpanie społeczne; najmocniej uderza w osoby introwertyczne, które i tak wkładają w każdą rozmowę więcej energii." },
    { type: "h2", text: "Co robić" },
    { type: "p", text: "Wybierz jakość zamiast zasięgu. Zamiast próbować odpisać wszystkim, skup się na jednej czy dwóch osobach, które naprawdę cię interesują, i napisz im coś, co warto przeczytać. Mechanika pytań i odpowiedzi w Qulo wykonuje część tej pracy za ciebie: skoro dopasowanie wymaga rozwiązania pytań napisanych przez daną osobę, samo dopasowanie znaczy już, że ktoś poświęcił prawdziwą uwagę." },

    { type: "h2", text: "Sygnał 4: wszyscy wyglądają tak samo" },
    { type: "h2", text: "Jak to rozpoznać" },
    { type: "p", text: "Profile przestają się od siebie różnić. Wszyscy w tych samych pozach, z tymi samymi filtrami, pod tym samym opisem. Masz wrażenie, że \"Kocham podróże, kawę i bieganie\" czytasz po raz stutysięczny. To spłaszczenie jest poważnym sygnałem wypalenia." },
    { type: "h2", text: "Dlaczego tak się dzieje" },
    { type: "p", text: "Mózg się przyzwyczaja. Przy odpowiednio dużej liczbie niemal identycznych bodźców pod rząd spada zdolność dostrzegania różnic — różnice wciąż tam są, to ty przestajesz je rejestrować. Aplikacje oparte na przesuwaniu prezentują każdy profil w jednym ustandaryzowanym formacie, co usuwa większość sygnału, który człowiek inaczej by wysłał. Wszyscy zaczynają wyglądać tak samo, bo już ich nie odróżniasz." },
    { type: "h2", text: "Co robić" },
    { type: "p", text: "Przejdź na platformy, gdzie na pierwszym miejscu jest osobowość. W Qulo każda osoba pisze własne pytania — od dwóch do dziesięciu, każde z czterema odpowiedziami — a te pytania przedstawiają człowieka o wiele lepiej niż zdjęcie. To, o co ktoś postanawia zapytać, i jakie trzy błędne odpowiedzi wymyśla, mówi coś o jego poczuciu humoru, uwadze i wartościach. Bardzo trudno, żeby dwie osoby napisały ten sam zestaw." },

    { type: "h2", text: "Sygnał 5: chęć poznawania ludzi na żywo" },
    { type: "h2", text: "Jak to rozpoznać" },
    { type: "p", text: "Łapiesz się na myśli: \"Chciałbym po prostu poznać kogoś normalnie\". Aplikacje wydają ci się uporczywie sztuczne. Brakuje ci przypadku spotkania kogoś zamiast przedstawienia przez algorytm. To uczucie jest całkowicie normalne i odzwierciedla zdrowy instynkt." },
    { type: "h2", text: "Dlaczego tak się dzieje" },
    { type: "p", text: "Ludzki mózg wyewoluował do kontaktu twarzą w twarz. Ton głosu, mowa ciała i kontakt wzrokowy niosą znaczną część tego, czego dowiadujesz się o kimś w pierwszych minutach; aplikacje usuwają to wszystko i sprowadzają poznawanie do oceny tekstu i zdjęć. Efektem jest procedura, która działa, ale rzadko wydaje się naturalna." },
    { type: "h2", text: "Co robić" },
    { type: "p", text: "Traktuj poznawanie ludzi na żywo i w sieci jako uzupełnienie, a nie alternatywę. Dołącz do grup hobbystycznych, chodź na wydarzenia. Po stronie cyfrowej wybieraj platformy, na których sama interakcja wydaje się mniej mechaniczna. Rozwiązywanie czyichś pytań w Qulo jest bliższe rozmowie w kawiarni niż przekładaniu talii kart — i to daje nawet cyfrowemu poznaniu coś z faktury prawdziwego." },

    { type: "h2", accent: "green", text: "Jak Qulo przeciwdziała wypaleniu już w projekcie" },
    { type: "p", text: "Qulo zbudowano wokół tego, co naprawdę wywołuje wypalenie aplikacjami randkowymi. Każda osoba pisze od dwóch do dziesięciu własnych pytań, każde z czterema odpowiedziami, a dopasowanie następuje po poprawnym odpowiedzeniu na wszystkie. Ta jedna mechanika rozwiązuje większość tego, co pętla przesuwania robi źle:" },
    { type: "ul", items: [
      "**Bez nieskończonego przewijania:** każda interakcja jest świadoma i skończona",
      "**Bez autopilota:** rozwiązanie pytania wymaga prawdziwego myślenia",
      "**Dopasowania, które coś znaczą:** kto się z tobą dopasował, przeczytał to, co napisałeś, i trafił",
      "**Naturalne otwarcie rozmowy:** masz już konkretny temat",
      "**Profile, które się różnią:** pytania napisane przez kogoś sprawiają, że trudno go pomylić z kimś innym",
    ] },

    { type: "h2", text: "Wskazówki na cyfrowy detoks" },
    { type: "p", text: "Jeśli wypalenie już się pojawiło, warto spróbować krótkiego cyfrowego detoksu:" },
    { type: "ul", items: [
      "Zrób tygodniową przerwę od wszystkich aplikacji randkowych",
      "Poświęć ten czas sobie: sport, hobby, przyjaciele",
      "Zanim wrócisz, odpowiedz szczerze na jedno pytanie: czego właściwie szukam?",
      "Ogranicz liczbę używanych aplikacji do jednej lub dwóch",
      "Wróć z wymogiem jakości: mniej profili, więcej uwagi",
    ] },

    { type: "quote", text: "\"Wypalenie nie bierze się z szukania niewłaściwych ludzi — bierze się z szukania w niewłaściwy sposób. Zmień metodę, a szukanie znów stanie się przyjemne.\"" },

    { type: "h2", accent: "green", text: "Podsumowanie" },
    { type: "p", text: "Wypalenie aplikacjami randkowymi jest realne, powszechne i zasługuje na poważne potraktowanie — i nie oznacza, że masz zrezygnować z poznawania ludzi w sieci. Rozpoznanie sygnałów to pierwszy krok, zmiana podejścia to drugi. System oparty na pytaniach przenosi doświadczenie z powierzchni w głąb i zmniejsza wypalenie jako efekt uboczny, a nie jako funkcję. W Qulo możesz na nowo odkryć, jak to jest być kimś naprawdę zaciekawionym." },
  ],

  sv: [
    { type: "h2", text: "Vad är utmattning av dejtingappar?" },
    { type: "p", text: "Utmattning av dejtingappar är den känslomässiga, mentala och motivationsmässiga trötthet som byggs upp vid långvarigt användande av sådana appar. Den visar sig på ett brett spektrum: från att i tysthet tappa intresset för apparna till en allmän likgiltighet inför dejting överhuvudtaget. Den är också tillräckligt vanlig för att ha mätts: i en **Forbes Health**-undersökning från 2024, genomförd tillsammans med **OnePoll** bland **1 000** amerikanska vuxna som använt en dejtingapp det senaste året, sa **78 %** att de känt sig utbrända av det." },
    { type: "p", text: "Utmattning betyder inte att du måste ge upp dejtingappar helt. Men att känna igen tecknen och ta rätt steg spelar roll — både för ditt digitala kärleksliv och för ditt verkliga. Vilka är då tecknen på utmattning av dejtingappar, och hur tar man sig ur den?" },

    { type: "h2", text: "Tecken 1: att bäva för att öppna appen" },
    { type: "h2", text: "Hur du känner igen det" },
    { type: "p", text: "Du sveper bort appens notiser gång på gång. När du ser ikonen på telefonen känner du ett litet inre motstånd. Det som en gång kändes spännande känns nu som en syssla. Det är ett av de tidigaste och vanligaste tecknen på utmattning: att öppna appen har gått från något du vill göra till ännu en punkt på en att göra-lista." },
    { type: "h2", text: "Varför det händer" },
    { type: "p", text: "Att upprepa en handling som sällan lönar sig lär dig med tiden att ansträngningen är meningslös — psykologer kallar mönstret inlärd hjälplöshet. När du lägger riktig tid på en app utan resultat bokför hjärnan aktiviteten som \"otillräcklig belöning\" och motivationen sjunker. Att öppna appen registreras inte längre som en belöning utan som en börda." },
    { type: "h2", text: "Vad du kan göra" },
    { type: "p", text: "Ge dig själv tydliga \"apptider\". Öppna den en gång om dagen, vid en tid du väljer i förväg, under ett kort fönster — femton minuter räcker gott. Medvetet användande slår ständig tillgång. Att byta till en frågebaserad app som Qulo bryter dessutom den oändliga scrollen och gör varje session värd att öppna." },

    { type: "h2", text: "Tecken 2: att svepa utan att tänka" },
    { type: "h2", text: "Hur du känner igen det" },
    { type: "p", text: "Du sveper åt vänster eller höger nästan reflexmässigt, utan att egentligen titta på profilerna. Du läser inte texterna. Du registrerar knappt bilderna. Svepandet har blivit ett spel som tappat sitt syfte. I kulturen kring de här apparna kallas det tanklöst svepande, och det är ett allvarligt tecken på utmattning." },
    { type: "h2", text: "Varför det händer" },
    { type: "p", text: "En profil får en blick lång som en blinkning, långt ifrån vad som krävs för att komma fram till ett övervägt omdöme om en människa. För att klara den mängden går hjärnan över på autopilot: beslutskvaliteten sjunker och vem du matchar med blir nästan slumpmässigt. Det är beslutströtthet i mest bokstavlig mening — för många nästan identiska val, tagna för snabbt, under för lång tid." },
    { type: "h2", text: "Vad du kan göra" },
    { type: "p", text: "Sätt en gräns per session — till exempel högst tio profiler — och ge var och en några oskyndade sekunder. Ännu bättre: byt till appar som tar bort svepmekaniken helt. I Qulo gör steget med att lösa frågor varje interaktion medveten redan genom sin konstruktion: det går inte att komma vidare på reflex." },

    { type: "h2", text: "Tecken 3: att undvika att svara på meddelanden" },
    { type: "h2", text: "Hur du känner igen det" },
    { type: "p", text: "Du ser matchningsnotiserna men har ingen motivation att svara. Du säger till dig själv att du skriver senare, och glömmer sedan bort det. Meddelandena hopar sig och du undviker till och med att öppna dem. \"Ny matchning!\" som en gång tände något säger dig numera ingenting alls." },
    { type: "h2", text: "Varför det händer" },
    { type: "p", text: "Upprepade samtal som inte leder någonstans nöter ner lusten att kommunicera. De flesta utbyten i dejtingappar slocknar efter de första meddelandena, och det mönstret lär dig i det tysta att inget du skriver kommer att spela roll. Psykologer beskriver resultatet som social utmattning, och det slår hårdast mot introverta personer, som redan lägger mer energi på varje samtal." },
    { type: "h2", text: "Vad du kan göra" },
    { type: "p", text: "Välj kvalitet framför räckvidd. I stället för att försöka svara alla, fokusera på den eller de två personer som verkligen intresserar dig och skriv något värt att läsa. Qulos fråga-och-svar-mekanik gör en del av det arbetet åt dig: eftersom en matchning kräver att man löser frågorna personen själv skrivit betyder en matchning redan att verklig uppmärksamhet lagts ner." },

    { type: "h2", text: "Tecken 4: alla ser likadana ut" },
    { type: "h2", text: "Hur du känner igen det" },
    { type: "p", text: "Profilerna slutar skilja sig åt. Alla dyker upp i samma poser, med samma filter, under samma text. Du känner att du läst \"Jag älskar att resa, kaffe och att springa\" för hundratusende gången. Den utplattande effekten är ett allvarligt tecken på utmattning." },
    { type: "h2", text: "Varför det händer" },
    { type: "p", text: "Hjärnor vänjer sig. Utsatt för tillräckligt många nästan identiska intryck i rad sjunker din förmåga att lägga märke till individuella skillnader — skillnaderna finns kvar, du slutar bara registrera dem. Svepbaserade appar presenterar varje profil i ett enda standardiserat format, vilket suddar ut det mesta av den signal en människa annars skulle sända. Alla börjar se likadana ut för att du inte längre kan skilja dem åt." },
    { type: "h2", text: "Vad du kan göra" },
    { type: "p", text: "Byt till plattformar där personligheten kommer först. I Qulo skriver varje medlem sina egna frågor — mellan två och tio, var och en med fyra svarsalternativ — och de frågorna presenterar en människa långt bättre än ett foto kan. Vad någon väljer att fråga om, och vilka tre felaktiga svar hen hittar på, säger något om humor, uppmärksamhet och värderingar. Att två personer skriver samma uppsättning är mycket osannolikt." },

    { type: "h2", text: "Tecken 5: att hellre vilja träffas i verkliga livet" },
    { type: "h2", text: "Hur du känner igen det" },
    { type: "p", text: "Du kommer på dig själv med tanken: \"Jag skulle bara vilja träffa någon på vanligt sätt.\" Dejtingappar känns envist onaturliga. Du saknar slumpen i att stöta på någon i stället för att bli presenterad av en algoritm. Känslan är helt normal och speglar en sund instinkt." },
    { type: "h2", text: "Varför det händer" },
    { type: "p", text: "Den mänskliga hjärnan utvecklades för kontakt ansikte mot ansikte. Tonfall, kroppsspråk och ögonkontakt bär en stor del av det du lär dig om en människa under de första minuterna; dejtingappar tar bort allt det och reducerar att lära känna någon till att bedöma text och foton. Resultatet är ett förfarande som fungerar men sällan känns naturligt." },
    { type: "h2", text: "Vad du kan göra" },
    { type: "p", text: "Se att träffas i verkliga livet och på nätet som komplement, inte som alternativ. Gå med i hobbygrupper, gå på evenemang. På den digitala sidan, välj plattformar där själva samspelet känns mindre mekaniskt. Att arbeta sig igenom någons frågor i Qulo ligger närmare ett samtal på ett kafé än att sortera en kortlek — och det ger även en digital bekantskap något av en verklig bekantskaps textur." },

    { type: "h2", accent: "green", text: "Hur Qulo motverkar utmattning genom sin design" },
    { type: "p", text: "Qulo är byggt kring vad som faktiskt orsakar utmattning av dejtingappar. Varje medlem skriver mellan två och tio egna frågor, var och en med fyra svarsalternativ, och matchningen sker genom att svara rätt på alla. Den enda mekaniken tar itu med det mesta som svepslingan gör fel:" },
    { type: "ul", items: [
      "**Ingen oändlig scroll:** varje interaktion är medveten och ändlig",
      "**Ingen autopilot:** att lösa en fråga kräver att man faktiskt tänker",
      "**Matchningar som betyder något:** den som matchade med dig läste det du skrev och svarade rätt",
      "**Naturliga inledningar:** du har redan något konkret att prata om",
      "**Profiler som skiljer sig:** frågorna någon skriver gör personen svår att förväxla med någon annan",
    ] },

    { type: "h2", text: "Tips för digital detox" },
    { type: "p", text: "Om utmattningen redan är här är en kort digital detox värd att pröva:" },
    { type: "ul", items: [
      "Ta en veckas paus från alla dejtingappar",
      "Lägg tiden på dig själv: träning, hobbyer, vänner",
      "Innan du kommer tillbaka, svara ärligt på en fråga: vad letar jag egentligen efter?",
      "Håll antalet appar du använder till en eller två",
      "Kom tillbaka med ett kvalitetskrav: färre profiler, mer uppmärksamhet",
    ] },

    { type: "quote", text: "\"Utmattning kommer inte av att leta efter fel människor — den kommer av att leta på fel sätt. Byt metod, så blir letandet roligt igen.\"" },

    { type: "h2", accent: "green", text: "Slutsats" },
    { type: "p", text: "Utmattning av dejtingappar är verklig, utbredd och värd att ta på allvar — och den betyder inte att du ska ge upp att träffa människor på nätet. Att känna igen tecknen är första steget; att ändra sitt sätt är det andra. Ett frågebaserat system flyttar upplevelsen från yta till innehåll och minskar utmattningen som en bieffekt snarare än som en funktion. I Qulo kan du återupptäcka hur det känns att vara genuint nyfiken på någon." },
  ],

  hi: [
    { type: "h2", text: "डेटिंग ऐप बर्नआउट क्या है?" },
    { type: "p", text: "डेटिंग ऐप बर्नआउट वह भावनात्मक, मानसिक और प्रेरणा से जुड़ी थकान है जो इन ऐप्स के लंबे इस्तेमाल से जमा होती जाती है। यह एक चौड़े दायरे में दिखती है: ऐप्स में चुपचाप दिलचस्पी खो देने से लेकर डेटिंग के प्रति सामान्य उदासीनता तक। और यह इतनी आम है कि इसे मापा भी जा चुका है: **Forbes Health** ने **OnePoll** के साथ 2024 में ऐसे **1,000** अमेरिकी वयस्कों पर सर्वे किया जिन्होंने पिछले साल कोई डेटिंग ऐप इस्तेमाल की थी, और **78%** ने कहा कि उन्होंने खुद को थका हुआ महसूस किया।" },
    { type: "p", text: "बर्नआउट का मतलब यह नहीं कि आपको डेटिंग ऐप्स पूरी तरह छोड़ देनी चाहिए। लेकिन संकेतों को पहचानना और सही कदम उठाना मायने रखता है — आपकी डिजिटल और असल, दोनों तरह की ज़िंदगी के लिए। तो डेटिंग ऐप बर्नआउट के संकेत क्या हैं, और इससे बाहर कैसे निकला जाए?" },

    { type: "h2", text: "संकेत 1: ऐप खोलने का मन न होना" },
    { type: "h2", text: "कैसे पहचानें" },
    { type: "p", text: "आप ऐप की सूचनाओं को बार-बार टालते रहते हैं। फोन पर उसका आइकॉन देखते ही भीतर एक छोटा-सा प्रतिरोध उठता है। जो कभी रोमांचक लगता था, अब किसी काम जैसा लगता है। यह बर्नआउट के सबसे शुरुआती और सबसे आम संकेतों में से एक है: ऐप खोलना अब आपकी इच्छा नहीं, आपकी सूची का एक और काम बन गया है।" },
    { type: "h2", text: "ऐसा क्यों होता है" },
    { type: "p", text: "जिस काम का नतीजा कम ही मिलता है, उसे दोहराते रहने से धीरे-धीरे यही सीख बनती है कि मेहनत बेकार है — मनोवैज्ञानिक इसे सीखी हुई असहायता कहते हैं। जब आप ऐप पर सचमुच समय देते हैं और कुछ हासिल नहीं होता, तो दिमाग उस काम को \"इनाम कम है\" के खाते में डाल देता है और प्रेरणा गिर जाती है। ऐप खोलना अब इनाम नहीं, बोझ के रूप में दर्ज होने लगता है।" },
    { type: "h2", text: "क्या करें" },
    { type: "p", text: "अपने लिए तय \"ऐप के घंटे\" बनाइए। दिन में एक बार, पहले से चुने हुए समय पर, थोड़ी देर के लिए ही खोलिए — पंद्रह मिनट काफी हैं। लगातार पहुँच से बेहतर है सोच-समझकर इस्तेमाल। Qulo जैसी सवालों पर टिकी ऐप पर जाना भी अंतहीन स्क्रॉल का चक्र तोड़ता है और हर सत्र को खोलने लायक बनाता है।" },

    { type: "h2", text: "संकेत 2: बिना सोचे स्वाइप करना" },
    { type: "h2", text: "कैसे पहचानें" },
    { type: "p", text: "आप प्रोफाइल को ठीक से देखे बिना, लगभग सजगता से बाएँ-दाएँ स्वाइप करते हैं। परिचय नहीं पढ़ते। तस्वीरें भी मुश्किल से दर्ज होती हैं। स्वाइप करना एक ऐसा खेल बन गया है जिसका मकसद खो चुका है। इसे बिना सोचे स्वाइप करना कहा जाता है और यह बर्नआउट का गंभीर संकेत है।" },
    { type: "h2", text: "ऐसा क्यों होता है" },
    { type: "p", text: "एक प्रोफाइल को पलक झपकने भर की नज़र मिलती है, जो किसी इंसान के बारे में सोची-समझी राय बनाने के लिए कहीं से भी काफी नहीं। इतनी मात्रा से निपटने के लिए दिमाग ऑटोपायलट पर चला जाता है: फैसलों की गुणवत्ता गिरती है और किससे मैच होगा यह लगभग संयोग बन जाता है। यह शब्दशः निर्णय-थकान है — बहुत सारे लगभग एक जैसे विकल्प, बहुत तेज़ी से, बहुत लंबे समय तक।" },
    { type: "h2", text: "क्या करें" },
    { type: "p", text: "हर बार के लिए एक सीमा तय कीजिए — मान लीजिए ज़्यादा से ज़्यादा दस प्रोफाइल — और हर एक को बिना जल्दबाज़ी के कुछ सेकंड दीजिए। इससे भी बेहतर: ऐसी ऐप्स पर जाइए जहाँ स्वाइप की व्यवस्था ही नहीं है। Qulo में सवाल हल करने का चरण हर बातचीत को बनावट से ही सोच-समझकर बनाता है: सजगता के भरोसे आगे बढ़ने का कोई रास्ता नहीं।" },

    { type: "h2", text: "संकेत 3: संदेशों का जवाब देने से बचना" },
    { type: "h2", text: "कैसे पहचानें" },
    { type: "p", text: "मैच की सूचनाएँ दिखती हैं, पर जवाब देने का मन नहीं करता। खुद से कहते हैं कि बाद में लिखेंगे, और फिर भूल जाते हैं। संदेश जमा होते जाते हैं और आप उन्हें खोलने से भी बचते हैं। \"नया मैच!\" की जो सूचना कभी कुछ जगाती थी, अब कुछ भी महसूस नहीं कराती।" },
    { type: "h2", text: "ऐसा क्यों होता है" },
    { type: "p", text: "दोहराव वाली और बेनतीजा बातचीत संवाद की इच्छा को घिस देती है। डेटिंग ऐप्स पर ज़्यादातर बातचीत पहले कुछ संदेशों के बाद बुझ जाती है, और यह दोहराव चुपचाप सिखा देता है कि आप जो भी लिखें, फर्क नहीं पड़ेगा। मनोवैज्ञानिक इस स्थिति को सामाजिक थकावट कहते हैं, और यह उन अंतर्मुखी लोगों पर सबसे ज़्यादा असर डालती है जो हर बातचीत में पहले से ही अधिक ऊर्जा लगाते हैं।" },
    { type: "h2", text: "क्या करें" },
    { type: "p", text: "फैलाव के बजाय गुणवत्ता चुनिए। सबको जवाब देने की कोशिश करने के बजाय उन एक-दो लोगों पर ध्यान दीजिए जिनमें आपकी सचमुच दिलचस्पी है, और उन्हें पढ़ने लायक कुछ लिखिए। Qulo की सवाल-जवाब की व्यवस्था इस काम का एक हिस्सा आपके लिए कर देती है: मैच के लिए सामने वाले के खुद लिखे सवाल हल करने पड़ते हैं, इसलिए मैच होना ही इस बात का संकेत है कि असली ध्यान दिया गया।" },

    { type: "h2", text: "संकेत 4: सब एक जैसे लगने लगते हैं" },
    { type: "h2", text: "कैसे पहचानें" },
    { type: "p", text: "प्रोफाइल एक-दूसरे से अलग नहीं रह जातीं। सब वही मुद्राएँ, वही फिल्टर, वही परिचय। लगता है कि \"मुझे घूमना, कॉफी और दौड़ना पसंद है\" आपने लाखवीं बार पढ़ लिया। यह चपटा हो जाना बर्नआउट का गंभीर संकेत है।" },
    { type: "h2", text: "ऐसा क्यों होता है" },
    { type: "p", text: "दिमाग अभ्यस्त हो जाता है। लगातार पर्याप्त मात्रा में लगभग एक जैसे संकेत मिलने पर व्यक्तिगत अंतर देख पाने की क्षमता घट जाती है — अंतर तब भी मौजूद रहते हैं, बस आप उन्हें दर्ज करना बंद कर देते हैं। स्वाइप पर टिकी ऐप्स हर प्रोफाइल को एक ही मानक ढाँचे में पेश करती हैं, जिससे इंसान की ज़्यादातर असली झलक मिट जाती है। सब एक जैसे लगने लगते हैं क्योंकि अब आप उन्हें अलग नहीं कर पाते।" },
    { type: "h2", text: "क्या करें" },
    { type: "p", text: "ऐसे मंचों पर जाइए जहाँ व्यक्तित्व पहले आता है। Qulo में हर सदस्य अपने सवाल खुद लिखता है — दो से दस तक, हर सवाल में चार विकल्प — और ये सवाल किसी भी तस्वीर से कहीं बेहतर उस इंसान का परिचय देते हैं। कोई क्या पूछना चुनता है, और तीन गलत जवाब कैसे गढ़ता है, इससे उसके हास्य, उसके ध्यान और उसके मूल्यों का पता चलता है। दो लोगों का एक जैसा सेट लिखना बहुत मुश्किल है।" },

    { type: "h2", text: "संकेत 5: असल ज़िंदगी में मिलने की चाह" },
    { type: "h2", text: "कैसे पहचानें" },
    { type: "p", text: "आप खुद को यह सोचते पाते हैं: \"काश किसी से सामान्य तरीके से मुलाकात हो जाती।\" डेटिंग ऐप्स आपको लगातार बनावटी लगती हैं। एल्गोरिद्म के परिचय के बजाय किसी से यूँ ही टकरा जाने का संयोग याद आता है। यह भावना पूरी तरह सामान्य है और एक स्वस्थ प्रवृत्ति दिखाती है।" },
    { type: "h2", text: "ऐसा क्यों होता है" },
    { type: "p", text: "इंसानी दिमाग आमने-सामने के संपर्क के लिए विकसित हुआ है। आवाज़ का लहजा, शरीर की भाषा और आँखों का मिलना — पहले कुछ मिनटों में किसी के बारे में जो आप जानते हैं, उसका बड़ा हिस्सा यही ले जाते हैं; डेटिंग ऐप्स यह सब हटा देती हैं और किसी को जानने को टेक्स्ट और तस्वीरों के आकलन तक सिकोड़ देती हैं। नतीजा एक ऐसी प्रक्रिया है जो काम तो करती है, पर स्वाभाविक कम ही लगती है।" },
    { type: "h2", text: "क्या करें" },
    { type: "p", text: "असल ज़िंदगी में मिलने और ऑनलाइन मिलने को विकल्प नहीं, एक-दूसरे का पूरक मानिए। शौक के समूहों से जुड़िए, आयोजनों में जाइए। डिजिटल तरफ ऐसे मंच चुनिए जहाँ बातचीत खुद कम मशीनी लगे। Qulo पर किसी के सवाल हल करना ताश की गड्डी छाँटने से ज़्यादा कैफे की बातचीत जैसा है — और इससे ऑनलाइन मुलाकात में भी असली मुलाकात की थोड़ी बनावट आ जाती है।" },

    { type: "h2", accent: "green", text: "Qulo बनावट से ही बर्नआउट का सामना कैसे करता है" },
    { type: "p", text: "Qulo उसी बात के इर्द-गिर्द बना है जो सचमुच डेटिंग ऐप बर्नआउट पैदा करती है। हर सदस्य अपने दो से दस सवाल लिखता है, हर सवाल में चार विकल्प होते हैं, और सबके सही जवाब देने पर ही मैच होता है। यह अकेली व्यवस्था स्वाइप के चक्र की ज़्यादातर गड़बड़ियाँ दूर कर देती है:" },
    { type: "ul", items: [
      "**अंतहीन स्क्रॉल नहीं:** हर बातचीत सोची-समझी और सीमित है",
      "**ऑटोपायलट नहीं:** सवाल हल करने के लिए सचमुच सोचना पड़ता है",
      "**अर्थ रखने वाले मैच:** जिसने आपसे मैच किया, उसने आपका लिखा पढ़ा और सही जवाब दिया",
      "**स्वाभाविक शुरुआत:** बात करने के लिए ठोस विषय पहले से मौजूद है",
      "**अलग-अलग प्रोफाइल:** किसी के लिखे सवाल उसे दूसरों से गड्डमड्ड करना मुश्किल बना देते हैं",
    ] },

    { type: "h2", text: "डिजिटल डिटॉक्स के सुझाव" },
    { type: "p", text: "अगर बर्नआउट आ ही चुका है, तो थोड़े समय का डिजिटल डिटॉक्स आज़माने लायक है:" },
    { type: "ul", items: [
      "एक हफ्ते के लिए सारी डेटिंग ऐप्स से दूरी बनाइए",
      "यह समय खुद पर लगाइए: कसरत, शौक, दोस्त",
      "लौटने से पहले एक सवाल का ईमानदारी से जवाब दीजिए: मैं असल में ढूँढ क्या रहा हूँ?",
      "इस्तेमाल की जाने वाली ऐप्स की संख्या एक या दो रखिए",
      "गुणवत्ता की शर्त के साथ लौटिए: कम प्रोफाइल, ज़्यादा ध्यान",
    ] },

    { type: "quote", text: "\"बर्नआउट गलत लोगों को ढूँढने से नहीं आता — गलत तरीके से ढूँढने से आता है। तरीका बदलिए, ढूँढना फिर से सुखद हो जाएगा।\"" },

    { type: "h2", accent: "green", text: "निष्कर्ष" },
    { type: "p", text: "डेटिंग ऐप बर्नआउट असली है, व्यापक है और गंभीरता से लेने लायक है — और इसका मतलब यह नहीं कि आपको ऑनलाइन लोगों से मिलना छोड़ देना चाहिए। संकेत पहचानना पहला कदम है, अपना तरीका बदलना दूसरा। सवालों पर टिकी व्यवस्था अनुभव को सतह से गहराई की ओर ले जाती है और बर्नआउट को किसी फीचर के रूप में नहीं, एक साइड-इफेक्ट के रूप में घटाती है। Qulo पर आप फिर से जान सकते हैं कि किसी के बारे में सचमुच जिज्ञासु होना कैसा लगता है।" },
  ],
};
