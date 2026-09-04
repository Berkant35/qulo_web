import type { LocalizedArticle } from "@/components/blog/ArticleBlocks";

/**
 * "Quiz Dating for Introverts" — migrated from inline per-locale JSX.
 * Canonical source: `en`; every one of the 16 locales is a full translation, so
 * no locale falls back to English any more (the legacy component shipped only
 * `tr` and `en`, serving the English body under 14 locales whose `hreflang`
 * promised otherwise). `**bold**` renders as <strong>.
 *
 * Statistics policy: the legacy post opened with "introversion is a personality
 * trait that affects approximately 30-50% of the population" — no study, no
 * publisher, not checkable — and that range is gone; the sentence now says only
 * that introversion is common, which is all the argument ever needed. The other
 * number it carried, "Dr. John Gottman's 40+ years of relationship research",
 * is likewise gone: the substance (what his work points to) is kept, the
 * unverifiable count is not. Named non-numeric attributions survive because
 * they are checkable claims about who said what, not statistics — Carl Jung on
 * introversion, Susan Cain's "Quiet", and Marti Olsen Laney's acetylcholine /
 * dopamine account, which is now framed as the account she popularised rather
 * than as settled neuroscience.
 *
 * The one figure in the post comes from an approved primary source: **Huang,
 * Yeomans, Brooks, Minson & Gino**, "It Doesn't Hurt to Ask: Question-Asking
 * Increases Liking", Journal of Personality and Social Psychology, September
 * 2017 (see `HUANG_JPSP_2017` in `src/lib/constants/stats.ts`) — 1,961
 * second-date decisions from 110 speed daters, attributed inline in all 16
 * locales. Thousand separators follow local convention (1,961 / 1.961 / 1 961 /
 * 1961), matching `psychology-of-the-first-message.ts`; the value never
 * changes. Do not reintroduce a number here without a named primary source.
 *
 * Product-claim policy: the legacy "Question Types" section illustrated Qulo
 * with open-ended prompts ("What do you value most in life?"), which is not the
 * mechanic. The section now describes what actually exists: you write 2–4
 * multiple-choice questions on the free plan (up to 10 on a paid plan), four
 * options each, marking the answer that is true of you, and someone matches
 * only by getting every one right. The optional
 * powers (hint, halve the options, skip) are named as costing in-app diamonds
 * and as never being required to match. Nothing else is claimed.
 *
 * Brand rule: Qulo is the only dating app nameable on this site. Everything
 * else is described generically as "dating apps" / "swipe-based apps".
 *
 * Note: the block model has no h3, so the original h3 sub-headings ("1.
 * Overstimulation", "Thinking Time", …) are authored as purple h2. The two
 * headings the original markup rendered in `text-qulo-green` — "Why Quiz Dating
 * Is Ideal for Introverts" and the closing "Conclusion" — keep `accent:
 * "green"` at the same positions (block indices 11 and 32); every other heading
 * is purple. That is the complete green count: 2. (The legacy blockquote
 * carried `border-qulo-purple`; `ArticleBlocks` renders every quote with a
 * green border, which is the shared house style and not an accent.)
 */
export const quizDatingForIntroverts: LocalizedArticle = {
  en: [
    { type: "h2", text: "Introversion and Dating Apps: Why Is It So Hard?" },
    { type: "p", text: "Introversion is a common personality trait. Defined by Carl Jung, it describes people who draw their energy from their inner world and who prefer deep thinking and meaningful relationships. Introverts are not shy, socially anxious, or people who dislike others — they simply recharge differently." },
    { type: "p", text: "Traditional dating apps are largely designed around extroverted communication patterns: quick decisions, superficial first impressions, constant pressure to interact. That makes for a particularly exhausting and unsatisfying experience if you are an introvert. Is there a better way? Quiz dating — matching by answering someone's questions instead of judging their photos — answers exactly that." },

    { type: "h2", text: "3 Major Problems Introverts Face on Dating Apps" },

    { type: "h2", text: "1. Overstimulation" },
    { type: "p", text: "Introverts are often described as more sensitive to outside stimulation than extroverts. In \"The Introvert Advantage\", Marti Olsen Laney popularised the account that introverted and extroverted brains lean on different neurotransmitter pathways — acetylcholine, associated with deep thinking and introspection, against dopamine, associated with novelty and excitement. Whatever the underlying biology turns out to be, the experience is familiar to anyone who has felt wrung out after an hour of scrolling." },
    { type: "p", text: "Swipe-based dating apps deliver a constant stream of new stimuli: photos, profiles, notifications. For a brain that is easily overloaded, that means fatigue, decision paralysis, and eventually avoiding the app altogether." },

    { type: "h2", text: "2. Social Depletion" },
    { type: "p", text: "Introverts need time alone after social interaction to recharge. The constant messaging pressure of dating apps gets in the way of that recovery. Keeping several conversations going at once is particularly draining: every new thread draws on the same reserve, and in time the \"social battery\" runs flat." },

    { type: "h2", text: "3. The Superficiality Problem" },
    { type: "p", text: "Introverts tend to dislike small talk and prefer conversations with something in them. Yet the typical opening message on a dating app — \"Hey, how are you?\", \"Nice photos\" — is exactly the kind of empty exchange they avoid. The result is that introverts never quite feel at home on these apps and stop starting conversations at all." },

    { type: "h2", accent: "green", text: "Why Quiz Dating Is Ideal for Introverts" },

    { type: "h2", text: "Thinking Time" },
    { type: "p", text: "The swipe mechanic demands instant judgement, which is not where introverts are strongest. Answering someone's questions gives you time to read, think and decide. Reading a question carefully, considering the person who wrote it, and choosing your answer deliberately is not a workaround for introversion — it is the introvert's natural communication style, turned into the mechanic itself." },

    { type: "h2", text: "Written Expression Power" },
    { type: "p", text: "Susan Cain, in \"Quiet: The Power of Introverts in a World That Can't Stop Talking\", argues that introverts are often at their most articulate in writing, where they can think before answering instead of performing on the spot. There is also direct evidence that the thing introverts do naturally — ask, then listen — is what draws people in. In the paper \"It Doesn't Hurt to Ask: Question-Asking Increases Liking\", published by **Huang, Yeomans, Brooks, Minson and Gino** in the Journal of Personality and Social Psychology in September 2017, an analysis of **1,961** second-date decisions from **110** speed daters found that people who asked more follow-up questions were more likely to be asked back. Quiz dating builds that behaviour into the format: you ask, and the other person answers." },

    { type: "h2", text: "Depth Priority" },
    { type: "p", text: "Introverts tend to build fewer but deeper relationships. A model that produces fewer, better-considered matches fits that instinct. Because a match only happens after someone has worked through your questions, every match already carries a level of attention that a swipe never asks for." },

    { type: "h2", text: "Introvert Strategies on Qulo" },

    { type: "h2", text: "Question Types" },
    { type: "p", text: "On Qulo you write between **2 and 4** multiple-choice questions, or up to 10 on a paid plan. Each has four options, and you mark the one that is true of you. Someone matches with you only by getting every single question right — there is no partial credit. The question types that work best for introverts:" },
    { type: "ul", items: [
      "**Value-based questions:** \"What do I value most?\" — with four options you would genuinely weigh against each other, this reaches real compatibility instead of guesswork",
      "**Scenario questions:** \"What is my ideal rainy Sunday?\" — the four options say more about your life than a bio does",
      "**Culture and taste questions:** \"Which of these did I read last?\" — a quick read on whether your worlds overlap",
      "**Philosophical questions:** \"What does success mean to me?\" — the option someone picks tells you how they think",
    ] },

    { type: "h2", text: "Pace Control" },
    { type: "p", text: "On Qulo you move at your own speed. How many questions you answer in a day, and how many conversations you keep open, is entirely up to you. Solving questions is asynchronous, so there is no pressure to hold several live conversations at once. If you get stuck, the optional powers — a hint, halving the options, skipping a question — cost in-app diamonds, and none of them is required to match." },

    { type: "h2", text: "The Introvert-Extrovert Compatibility Myth" },
    { type: "p", text: "Popular culture insists that introverts and extroverts form a \"perfect balance\". The research picture is more nuanced. Decades of relationship research by the psychologist John Gottman point to shared values, communication that works, and mutual respect as what holds couples together — not the pairing of personality types." },
    { type: "p", text: "Question-based matching reflects that. Questions measure agreement about values and ways of thinking, independent of personality type. An introvert can match perfectly with another introvert or with an extrovert; what matters is whether the answers line up, not which type is on either side." },

    { type: "h2", text: "Insights from Susan Cain's \"Quiet\"" },
    { type: "p", text: "Cain's book sets out the strengths that a culture built around talking tends to overlook. According to her, introverts:" },
    { type: "ul", items: [
      "Listen more deeply and read people more closely",
      "Make more careful, more considered decisions",
      "Build loyal, committed relationships",
      "Do their best thinking on creative and difficult problems",
    ] },
    { type: "p", text: "Those strengths are exactly what a question-based format rewards. Working through someone's questions calls for careful reading, patient thinking and attention to what another person actually meant — the things introverts are good at." },

    { type: "quote", text: "Introverts are not powerful because they are quiet. They are powerful because they listen. Quiz dating is built on listening." },

    { type: "h2", accent: "green", text: "Conclusion" },
    { type: "p", text: "Dating apps can be hard work for introverts — but the problem is not introversion, it is the design. Swipe-based models are built around extroverted habits and quietly ignore what introverts are good at. Question-based matching puts that right: time to think, room to write, and depth ahead of volume. On Qulo you meet people at your own pace, through your own questions, in your own style. Because the best connections are rarely made by whoever talks loudest — they are made by whoever listens best." },
  ],

  tr: [
    { type: "h2", text: "İçe Dönüklük ve Dating Uygulamaları: Neden Bu Kadar Zor?" },
    { type: "p", text: "İçe dönüklük yaygın bir kişilik özelliğidir. Carl Jung tarafından tanımlanan bu kavram, enerjisini iç dünyasından alan, derin düşünmeyi ve anlamlı ilişkileri tercih eden insanları anlatır. İçe dönükler utangaç, sosyal kaygı yaşayan ya da insanlardan hoşlanmayan kişiler değildir — yalnızca enerjilerini farklı bir yerden toplarlar." },
    { type: "p", text: "Geleneksel dating uygulamaları büyük ölçüde dışa dönük iletişim kalıplarına göre tasarlanmıştır: hızlı kararlar, yüzeysel ilk izlenimler, sürekli etkileşim baskısı. İçe dönük biriyseniz bu, özellikle yorucu ve tatmin etmeyen bir deneyim yaratır. Peki daha iyi bir yol var mı? Quiz dating — birinin fotoğraflarına bakarak değil, sorularını cevaplayarak eşleşmek — tam olarak bu soruya cevap veriyor." },

    { type: "h2", text: "İçe Dönüklerin Dating Uygulamalarındaki 3 Büyük Sorunu" },

    { type: "h2", text: "1. Aşırı Uyarılma" },
    { type: "p", text: "İçe dönükler çoğu zaman dış uyaranlara dışa dönüklerden daha duyarlı olarak tanımlanır. Marti Olsen Laney, \"The Introvert Advantage\" kitabında, içe dönük ve dışa dönük beyinlerin farklı nörotransmitter yollarına yaslandığı anlatısını yaygınlaştırdı: derin düşünme ve iç gözlemle ilişkilendirilen asetilkolin ile yenilik ve heyecan arayışıyla ilişkilendirilen dopamin. Altta yatan biyoloji ne çıkarsa çıksın, bir saatlik kaydırmanın ardından kendini tükenmiş hisseden herkes bu deneyimi tanır." },
    { type: "p", text: "Swipe tabanlı dating uygulamaları kesintisiz bir yeni uyaran akışı sunar: fotoğraflar, profiller, bildirimler. Kolayca yüklenen bir beyin için bunun anlamı yorgunluk, karar verememe ve sonunda uygulamadan büsbütün uzaklaşmaktır." },

    { type: "h2", text: "2. Sosyal Tükenme" },
    { type: "p", text: "İçe dönüklerin sosyal etkileşimin ardından toparlanmak için yalnız zamana ihtiyacı vardır. Dating uygulamalarının sürekli mesajlaşma baskısı bu toparlanmanın önüne geçer. Aynı anda birkaç sohbeti birden yürütmek özellikle tüketicidir: her yeni sohbet aynı rezervden çeker ve zamanla \"sosyal batarya\" tamamen boşalır." },

    { type: "h2", text: "3. Yüzeysellik Sorunu" },
    { type: "p", text: "İçe dönükler genellikle havadan sudan sohbetten hoşlanmaz, içi dolu konuşmaları tercih eder. Oysa dating uygulamalarındaki tipik açılış mesajı — \"Merhaba, nasılsın?\", \"Fotoğrafların güzel\" — tam da kaçındıkları o boş alışverişin kendisidir. Sonuç: içe dönükler bu uygulamalarda hiçbir zaman kendini evinde hissetmez ve bir süre sonra sohbet başlatmayı bütünüyle bırakır." },

    { type: "h2", accent: "green", text: "Quiz Dating Neden İçe Dönükler İçin İdeal?" },

    { type: "h2", text: "Düşünme Süresi" },
    { type: "p", text: "Swipe mekaniği anlık yargı ister; içe dönüklerin en güçlü olduğu yer burası değildir. Birinin sorularını cevaplamak ise okumak, düşünmek ve karar vermek için zaman tanır. Bir soruyu dikkatle okumak, onu yazan kişiyi düşünmek ve cevabını bilinçli seçmek, içe dönüklüğün etrafından dolaşmanın bir yolu değildir — içe dönüğün doğal iletişim tarzının doğrudan mekaniğe dönüşmüş halidir." },

    { type: "h2", text: "Yazılı İfade Gücü" },
    { type: "p", text: "Susan Cain, \"Quiet: The Power of Introverts in a World That Can't Stop Talking\" kitabında, içe dönüklerin çoğu zaman en iyi yazarken ifade edebildiğini savunur: orada anında sahneye çıkmak yerine cevaplamadan önce düşünebilirler. Üstelik içe dönüklerin doğal olarak yaptığı şeyin — önce sorup sonra dinlemenin — insanları kendine çektiğine dair doğrudan kanıt da var. **Huang, Yeomans, Brooks, Minson ve Gino**'nun Eylül 2017'de Journal of Personality and Social Psychology'de yayımladığı \"It Doesn't Hurt to Ask: Question-Asking Increases Liking\" başlıklı çalışmada, **110** hızlı tanışma katılımcısından gelen **1.961** ikinci buluşma kararı incelendi ve daha çok takip sorusu soranların tekrar davet edilme olasılığının daha yüksek olduğu görüldü. Quiz dating bu davranışı formatın içine yerleştirir: siz sorarsınız, karşı taraf cevaplar." },

    { type: "h2", text: "Derinlik Önceliği" },
    { type: "p", text: "İçe dönükler az sayıda ama daha derin ilişki kurma eğilimindedir. Daha az ama daha iyi düşünülmüş eşleşme üreten bir model bu içgüdüye uyar. Eşleşme ancak biri sorularınızın hepsini çözdükten sonra gerçekleştiği için, her eşleşme swipe'ın hiçbir zaman istemediği bir dikkat düzeyini baştan taşır." },

    { type: "h2", text: "Qulo'da İçe Dönük Stratejileri" },

    { type: "h2", text: "Soru Tipleri" },
    { type: "p", text: "Qulo'da **2 ile 4** arasında çoktan seçmeli soru yazarsınız; ücretli planda bu sayı 10'a kadar çıkar. Her sorunun dört seçeneği vardır ve doğru olanı, yani sizin için geçerli olanı işaretlersiniz. Karşı taraf ancak soruların tamamını doğru bilirse sizinle eşleşir — kısmi puan yoktur. İçe dönükler için en iyi işleyen soru tipleri:" },
    { type: "ul", items: [
      "**Değer soruları:** \"En çok neye değer veririm?\" — gerçekten birbiriyle tartacağınız dört seçenekle, tahmin yerine gerçek uyuma ulaşır",
      "**Senaryo soruları:** \"İdeal yağmurlu pazarım nasıldır?\" — dört seçenek, hayatınız hakkında bir biyografiden fazlasını söyler",
      "**Kültür ve zevk soruları:** \"Bunlardan hangisini en son okudum?\" — dünyalarınızın kesişip kesişmediğine dair hızlı bir okuma",
      "**Felsefi sorular:** \"Başarı benim için ne demek?\" — karşı tarafın seçtiği şık, nasıl düşündüğünü gösterir",
    ] },

    { type: "h2", text: "Tempo Kontrolü" },
    { type: "p", text: "Qulo'da kendi hızınızda ilerlersiniz. Günde kaç soru cevaplayacağınız ve kaç sohbeti açık tutacağınız tamamen size kalmış. Soru çözme süreci asenkron olduğu için aynı anda birkaç canlı sohbeti sürdürme baskısı yoktur. Takılırsanız isteğe bağlı güçler — ipucu, seçenekleri yarıya indirme, soruyu atlama — uygulama içi elmasa mal olur ve hiçbiri eşleşmek için zorunlu değildir." },

    { type: "h2", text: "İçe Dönük-Dışa Dönük Uyumluluk Miti" },
    { type: "p", text: "Popüler kültür, içe dönüklerle dışa dönüklerin \"mükemmel bir denge\" oluşturduğunda ısrar eder. Araştırmaların tablosu daha nüanslıdır. Psikolog John Gottman'ın onlarca yıla yayılan ilişki araştırmaları, çiftleri bir arada tutan şeyin paylaşılan değerler, işleyen bir iletişim ve karşılıklı saygı olduğuna işaret eder — kişilik tiplerinin eşleştirilmesine değil." },
    { type: "p", text: "Soru temelli eşleşme bunu yansıtır. Sorular, kişilik tipinden bağımsız olarak değerlerdeki ve düşünme biçimindeki uyumu ölçer. Bir içe dönük, başka bir içe dönükle de bir dışa dönükle de kusursuz eşleşebilir; önemli olan cevapların örtüşmesidir, iki taraftaki tip değil." },

    { type: "h2", text: "Susan Cain'in \"Quiet\" Kitabından Çıkarımlar" },
    { type: "p", text: "Cain'in kitabı, konuşmak üzerine kurulu bir kültürün gözden kaçırma eğiliminde olduğu güçleri ortaya serer. Ona göre içe dönükler:" },
    { type: "ul", items: [
      "Daha derin dinler ve insanları daha yakından okur",
      "Daha dikkatli, daha düşünülmüş kararlar verir",
      "Sadık ve bağlılık taşıyan ilişkiler kurar",
      "Yaratıcı ve zor problemler üzerinde en iyi düşünmeyi yapar",
    ] },
    { type: "p", text: "Bu güçler tam olarak soru temelli bir formatın ödüllendirdiği şeylerdir. Birinin sorularını çözmek dikkatli okuma, sabırlı düşünme ve karşıdakinin gerçekte ne demek istediğine yönelik bir ilgi ister — yani içe dönüklerin iyi olduğu şeyleri." },

    { type: "quote", text: "İçe dönükler sessiz oldukları için güçlü değildir. Dinledikleri için güçlüdür. Quiz dating dinlemenin üzerine kuruludur." },

    { type: "h2", accent: "green", text: "Sonuç" },
    { type: "p", text: "Dating uygulamaları içe dönükler için yorucu bir iş olabilir — ama sorun içe dönüklükte değil, tasarımda. Swipe tabanlı modeller dışa dönük alışkanlıklar üzerine kurulmuştur ve içe dönüklerin iyi olduğu şeyleri sessizce görmezden gelir. Soru temelli eşleşme bunu düzeltir: düşünmek için zaman, yazmak için alan ve nicelikten önce derinlik. Qulo'da insanlarla kendi hızınızda, kendi sorularınızla ve kendi tarzınızda tanışırsınız. Çünkü en iyi bağlantılar nadiren en yüksek sesle konuşanlar tarafından kurulur — en iyi dinleyenler tarafından kurulur." },
  ],

  de: [
    { type: "h2", text: "Introversion und Dating-Apps: Warum ist es so schwer?" },
    { type: "p", text: "Introversion ist eine weit verbreitete Persönlichkeitseigenschaft. Der von Carl Jung geprägte Begriff beschreibt Menschen, die ihre Energie aus ihrer inneren Welt schöpfen und tiefes Nachdenken sowie bedeutungsvolle Beziehungen bevorzugen. Introvertierte sind nicht schüchtern, sozial ängstlich oder menschenscheu — sie laden ihre Batterien nur anders auf." },
    { type: "p", text: "Klassische Dating-Apps sind weitgehend um extrovertierte Kommunikationsmuster herum gebaut: schnelle Entscheidungen, oberflächliche erste Eindrücke, ständiger Druck zur Interaktion. Für introvertierte Menschen ergibt das eine besonders anstrengende und wenig befriedigende Erfahrung. Gibt es einen besseren Weg? Quiz-Dating — man matcht, indem man die Fragen einer Person beantwortet, statt ihre Fotos zu beurteilen — beantwortet genau das." },

    { type: "h2", text: "3 große Probleme, die Introvertierte auf Dating-Apps haben" },

    { type: "h2", text: "1. Reizüberflutung" },
    { type: "p", text: "Introvertierte gelten als empfindlicher gegenüber äußeren Reizen als Extrovertierte. In „The Introvert Advantage“ hat Marti Olsen Laney die Deutung populär gemacht, dass introvertierte und extrovertierte Gehirne unterschiedliche Neurotransmitter-Bahnen nutzen — Acetylcholin, verbunden mit tiefem Nachdenken und Innenschau, gegenüber Dopamin, verbunden mit Neuem und Aufregung. Was die zugrunde liegende Biologie am Ende auch ergibt: Das Erleben kennt jede und jeder, der nach einer Stunde Scrollen ausgelaugt war." },
    { type: "p", text: "Swipe-basierte Dating-Apps liefern einen ununterbrochenen Strom neuer Reize: Fotos, Profile, Benachrichtigungen. Für ein Gehirn, das schnell überlastet ist, bedeutet das Erschöpfung, Entscheidungsblockaden und irgendwann das Meiden der App." },

    { type: "h2", text: "2. Soziale Erschöpfung" },
    { type: "p", text: "Introvertierte brauchen nach sozialem Kontakt Zeit für sich, um sich zu erholen. Der ständige Nachrichtendruck von Dating-Apps stört genau diese Erholung. Mehrere Gespräche gleichzeitig zu führen zehrt besonders: Jeder neue Chat greift auf dieselbe Reserve zu, und irgendwann ist die „soziale Batterie“ leer." },

    { type: "h2", text: "3. Das Oberflächlichkeitsproblem" },
    { type: "p", text: "Introvertierte mögen Small Talk meist nicht und bevorzugen Gespräche mit Substanz. Die typische Eröffnungsnachricht auf einer Dating-App — „Hey, wie geht's?“, „Schöne Fotos“ — ist aber genau der leere Austausch, den sie vermeiden. Das Ergebnis: Introvertierte fühlen sich in solchen Apps nie richtig zu Hause und hören ganz auf, Gespräche zu beginnen." },

    { type: "h2", accent: "green", text: "Warum Quiz-Dating ideal für Introvertierte ist" },

    { type: "h2", text: "Zeit zum Nachdenken" },
    { type: "p", text: "Die Swipe-Mechanik verlangt ein sofortiges Urteil, und darin sind Introvertierte nicht am stärksten. Die Fragen einer anderen Person zu beantworten gibt dagegen Zeit zum Lesen, Nachdenken und Entscheiden. Eine Frage sorgfältig zu lesen, über die Person nachzudenken, die sie geschrieben hat, und die Antwort bewusst zu wählen ist kein Umweg um die Introversion herum — es ist der natürliche Kommunikationsstil introvertierter Menschen, direkt zur Mechanik gemacht." },

    { type: "h2", text: "Die Kraft des geschriebenen Ausdrucks" },
    { type: "p", text: "Susan Cain argumentiert in „Quiet: The Power of Introverts in a World That Can't Stop Talking“, dass Introvertierte sich schriftlich oft am klarsten ausdrücken: Dort können sie nachdenken, bevor sie antworten, statt aus dem Stand zu performen. Es gibt außerdem direkte Belege dafür, dass genau das, was Introvertierte von Natur aus tun — fragen und dann zuhören —, andere Menschen anzieht. In der Studie „It Doesn't Hurt to Ask: Question-Asking Increases Liking“, die **Huang, Yeomans, Brooks, Minson und Gino** im September 2017 im Journal of Personality and Social Psychology veröffentlichten, wurden **1.961** Zweitdate-Entscheidungen von **110** Speed-Dating-Teilnehmenden ausgewertet: Wer mehr Anschlussfragen stellte, wurde häufiger ein zweites Mal gefragt. Quiz-Dating baut dieses Verhalten in das Format ein: Sie fragen, die andere Person antwortet." },

    { type: "h2", text: "Tiefe vor Menge" },
    { type: "p", text: "Introvertierte bauen tendenziell weniger, dafür tiefere Beziehungen auf. Ein Modell, das weniger, aber besser durchdachte Matches hervorbringt, passt zu diesem Instinkt. Weil ein Match erst zustande kommt, nachdem jemand sich durch Ihre Fragen gearbeitet hat, trägt jedes Match von Anfang an eine Aufmerksamkeit in sich, die ein Swipe nie verlangt." },

    { type: "h2", text: "Strategien für Introvertierte auf Qulo" },

    { type: "h2", text: "Fragetypen" },
    { type: "p", text: "Auf Qulo schreiben Sie zwischen **2 und 4** Multiple-Choice-Fragen, im kostenpflichtigen Tarif bis zu 10. Jede hat vier Optionen, und Sie markieren die, die auf Sie zutrifft. Jemand matcht nur mit Ihnen, wenn wirklich alle Fragen richtig beantwortet sind — Teilpunkte gibt es nicht. Die Fragetypen, die für Introvertierte am besten funktionieren:" },
    { type: "ul", items: [
      "**Wertefragen:** „Was ist mir am wichtigsten?“ — mit vier Optionen, die Sie tatsächlich gegeneinander abwägen würden, erreicht das echte Passung statt Raten",
      "**Szenariofragen:** „Wie sieht mein idealer verregneter Sonntag aus?“ — die vier Optionen sagen mehr über Ihr Leben als jede Bio",
      "**Kultur- und Geschmacksfragen:** „Welches davon habe ich zuletzt gelesen?“ — ein schneller Hinweis darauf, ob sich Ihre Welten überschneiden",
      "**Philosophische Fragen:** „Was bedeutet Erfolg für mich?“ — die gewählte Option verrät, wie jemand denkt",
    ] },

    { type: "h2", text: "Tempokontrolle" },
    { type: "p", text: "Auf Qulo bestimmen Sie das Tempo selbst. Wie viele Fragen Sie am Tag beantworten und wie viele Gespräche Sie offen halten, liegt ganz bei Ihnen. Das Lösen der Fragen läuft asynchron, es gibt also keinen Druck, mehrere Live-Gespräche gleichzeitig zu führen. Wenn Sie nicht weiterkommen, kosten die optionalen Hilfen — ein Hinweis, das Halbieren der Optionen, das Überspringen einer Frage — In-App-Diamanten, und keine davon ist für ein Match erforderlich." },

    { type: "h2", text: "Der Mythos von der Introvertiert-Extrovertiert-Passung" },
    { type: "p", text: "Die Populärkultur besteht darauf, dass Introvertierte und Extrovertierte eine „perfekte Balance“ bilden. Die Forschungslage ist vielschichtiger. Jahrzehnte an Beziehungsforschung des Psychologen John Gottman deuten darauf hin, dass gemeinsame Werte, funktionierende Kommunikation und gegenseitiger Respekt Paare zusammenhalten — nicht die Kombination von Persönlichkeitstypen." },
    { type: "p", text: "Fragebasiertes Matching bildet genau das ab. Fragen messen Übereinstimmung bei Werten und Denkweisen, unabhängig vom Persönlichkeitstyp. Eine introvertierte Person kann perfekt zu einer anderen introvertierten Person passen oder zu einer extrovertierten; entscheidend ist, ob die Antworten zusammenpassen, nicht welcher Typ auf welcher Seite steht." },

    { type: "h2", text: "Erkenntnisse aus Susan Cains „Quiet“" },
    { type: "p", text: "Cains Buch legt die Stärken offen, die eine auf Reden gebaute Kultur gern übersieht. Ihr zufolge gilt für Introvertierte:" },
    { type: "ul", items: [
      "Sie hören tiefer zu und lesen Menschen genauer",
      "Sie treffen sorgfältigere, durchdachtere Entscheidungen",
      "Sie bauen loyale, verbindliche Beziehungen auf",
      "Sie denken bei kreativen und schwierigen Problemen am besten",
    ] },
    { type: "p", text: "Genau diese Stärken belohnt ein fragebasiertes Format. Sich durch die Fragen einer anderen Person zu arbeiten verlangt sorgfältiges Lesen, geduldiges Nachdenken und Aufmerksamkeit dafür, was gemeint war — also das, worin Introvertierte gut sind." },

    { type: "quote", text: "Introvertierte sind nicht stark, weil sie still sind. Sie sind stark, weil sie zuhören. Quiz-Dating ist auf Zuhören gebaut." },

    { type: "h2", accent: "green", text: "Fazit" },
    { type: "p", text: "Dating-Apps können für Introvertierte anstrengend sein — aber das Problem ist nicht die Introversion, sondern das Design. Swipe-basierte Modelle sind um extrovertierte Gewohnheiten gebaut und übergehen still, worin Introvertierte gut sind. Fragebasiertes Matching rückt das zurecht: Zeit zum Nachdenken, Raum zum Schreiben und Tiefe vor Menge. Auf Qulo lernen Sie Menschen im eigenen Tempo kennen, über eigene Fragen und im eigenen Stil. Denn die besten Verbindungen entstehen selten durch die, die am lautesten reden — sondern durch die, die am besten zuhören." },
  ],

  fr: [
    { type: "h2", text: "Introversion et applis de rencontre : pourquoi est-ce si difficile ?" },
    { type: "p", text: "L'introversion est un trait de personnalité très répandu. Défini par Carl Jung, il décrit les personnes qui puisent leur énergie dans leur monde intérieur et qui préfèrent la réflexion profonde et les relations qui ont du sens. Les introvertis ne sont ni timides, ni anxieux socialement, ni misanthropes — ils se rechargent simplement autrement." },
    { type: "p", text: "Les applis de rencontre classiques sont largement conçues autour de schémas de communication extravertis : décisions rapides, premières impressions superficielles, pression permanente à l'interaction. Pour une personne introvertie, cela donne une expérience particulièrement épuisante et peu satisfaisante. Existe-t-il une meilleure voie ? Le quiz dating — matcher en répondant aux questions de quelqu'un plutôt qu'en jugeant ses photos — répond exactement à cette question." },

    { type: "h2", text: "Les 3 grands problèmes des introvertis sur les applis de rencontre" },

    { type: "h2", text: "1. La surstimulation" },
    { type: "p", text: "On décrit souvent les introvertis comme plus sensibles aux stimulations extérieures que les extravertis. Dans « The Introvert Advantage », Marti Olsen Laney a popularisé l'idée que les cerveaux introvertis et extravertis s'appuient sur des voies de neurotransmetteurs différentes — l'acétylcholine, associée à la réflexion profonde et à l'introspection, face à la dopamine, associée à la nouveauté et à l'excitation. Quelle que soit la biologie sous-jacente, l'expérience parle à quiconque s'est senti vidé après une heure de défilement." },
    { type: "p", text: "Les applis basées sur le swipe délivrent un flux ininterrompu de stimuli nouveaux : photos, profils, notifications. Pour un cerveau qui sature vite, cela signifie fatigue, paralysie décisionnelle et, à terme, évitement pur et simple de l'appli." },

    { type: "h2", text: "2. L'épuisement social" },
    { type: "p", text: "Les introvertis ont besoin de temps seuls après une interaction sociale pour se recharger. La pression permanente de la messagerie sur les applis de rencontre empêche précisément cette récupération. Mener plusieurs conversations de front est particulièrement coûteux : chaque nouveau fil puise dans la même réserve, et avec le temps la « batterie sociale » se vide complètement." },

    { type: "h2", text: "3. Le problème de la superficialité" },
    { type: "p", text: "Les introvertis apprécient rarement le bavardage et préfèrent les conversations qui ont du contenu. Or le message d'ouverture typique sur une appli de rencontre — « Salut, ça va ? », « Jolies photos » — est exactement l'échange vide qu'ils évitent. Résultat : les introvertis ne se sentent jamais vraiment chez eux sur ces applis et finissent par ne plus engager de conversation du tout." },

    { type: "h2", accent: "green", text: "Pourquoi le quiz dating est idéal pour les introvertis" },

    { type: "h2", text: "Le temps de réfléchir" },
    { type: "p", text: "La mécanique du swipe exige un jugement instantané, et ce n'est pas là que les introvertis sont les plus forts. Répondre aux questions de quelqu'un laisse au contraire le temps de lire, de réfléchir et de décider. Lire une question attentivement, penser à la personne qui l'a écrite et choisir sa réponse délibérément n'est pas un contournement de l'introversion — c'est le style de communication naturel des introvertis, transformé en mécanique." },

    { type: "h2", text: "La force de l'expression écrite" },
    { type: "p", text: "Dans « Quiet: The Power of Introverts in a World That Can't Stop Talking », Susan Cain soutient que les introvertis sont souvent les plus éloquents à l'écrit : ils peuvent y réfléchir avant de répondre au lieu de devoir performer sur-le-champ. Il existe par ailleurs des preuves directes que ce que les introvertis font naturellement — demander, puis écouter — est précisément ce qui attire les autres. Dans l'étude « It Doesn't Hurt to Ask: Question-Asking Increases Liking », publiée par **Huang, Yeomans, Brooks, Minson et Gino** dans le Journal of Personality and Social Psychology en septembre 2017, l'analyse de **1 961** décisions de second rendez-vous prises par **110** participants au speed dating a montré que celles et ceux qui posaient le plus de questions de relance étaient plus souvent recontactés. Le quiz dating inscrit ce comportement dans le format : vous posez les questions, l'autre répond." },

    { type: "h2", text: "La priorité à la profondeur" },
    { type: "p", text: "Les introvertis construisent en général moins de relations, mais plus profondes. Un modèle qui produit des matchs moins nombreux et mieux pesés colle à cet instinct. Comme un match n'a lieu qu'après que quelqu'un a travaillé toutes vos questions, chaque match porte d'emblée une attention qu'un swipe ne demande jamais." },

    { type: "h2", text: "Stratégies pour les introvertis sur Qulo" },

    { type: "h2", text: "Types de questions" },
    { type: "p", text: "Sur Qulo, vous rédigez entre **2 et 4** questions à choix multiple, et jusqu'à 10 avec un abonnement payant. Chacune comporte quatre options, et vous cochez celle qui est vraie pour vous. Quelqu'un ne matche avec vous qu'en trouvant absolument toutes les bonnes réponses — il n'y a pas de demi-point. Les types de questions qui fonctionnent le mieux pour les introvertis :" },
    { type: "ul", items: [
      "**Questions de valeurs :** « À quoi est-ce que j'accorde le plus d'importance ? » — avec quatre options que vous mettriez réellement en balance, on atteint une compatibilité réelle plutôt qu'un pari",
      "**Questions de scénario :** « À quoi ressemble mon dimanche pluvieux idéal ? » — les quatre options en disent plus sur votre vie qu'une bio",
      "**Questions de culture et de goûts :** « Lequel de ces livres ai-je lu en dernier ? » — un aperçu rapide du recoupement de vos univers",
      "**Questions philosophiques :** « Que signifie la réussite pour moi ? » — l'option choisie révèle la façon de penser de l'autre",
    ] },

    { type: "h2", text: "Le contrôle du rythme" },
    { type: "p", text: "Sur Qulo, vous avancez à votre rythme. Le nombre de questions que vous résolvez par jour et le nombre de conversations que vous gardez ouvertes ne dépendent que de vous. La résolution des questions est asynchrone : aucune pression à tenir plusieurs conversations en direct en même temps. Si vous bloquez, les pouvoirs facultatifs — un indice, la réduction des options de moitié, le fait de passer une question — coûtent des diamants dans l'appli, et aucun n'est nécessaire pour matcher." },

    { type: "h2", text: "Le mythe de la compatibilité introverti-extraverti" },
    { type: "p", text: "La culture populaire affirme que les introvertis et les extravertis forment un « équilibre parfait ». La recherche donne un tableau plus nuancé. Des décennies de travaux sur le couple menés par le psychologue John Gottman pointent vers les valeurs partagées, une communication qui fonctionne et le respect mutuel comme ce qui tient un couple ensemble — pas l'appariement des types de personnalité." },
    { type: "p", text: "Le matching par questions reflète cela. Les questions mesurent l'accord sur les valeurs et les façons de penser, indépendamment du type de personnalité. Un introverti peut parfaitement matcher avec un autre introverti comme avec un extraverti ; ce qui compte, c'est que les réponses concordent, pas le type de chaque côté." },

    { type: "h2", text: "Ce que l'on retient de « Quiet » de Susan Cain" },
    { type: "p", text: "Le livre de Cain met au jour les forces qu'une culture bâtie sur la parole a tendance à négliger. Selon elle, les introvertis :" },
    { type: "ul", items: [
      "Écoutent plus profondément et lisent les autres de plus près",
      "Prennent des décisions plus prudentes et plus réfléchies",
      "Construisent des relations loyales et engagées",
      "Réfléchissent le mieux aux problèmes créatifs et difficiles",
    ] },
    { type: "p", text: "Ce sont exactement les forces que récompense un format fondé sur les questions. Travailler les questions de quelqu'un demande une lecture attentive, une réflexion patiente et de l'attention à ce que l'autre voulait vraiment dire — précisément ce en quoi les introvertis excellent." },

    { type: "quote", text: "Les introvertis ne sont pas forts parce qu'ils sont silencieux. Ils sont forts parce qu'ils écoutent. Le quiz dating est bâti sur l'écoute." },

    { type: "h2", accent: "green", text: "Conclusion" },
    { type: "p", text: "Les applis de rencontre peuvent être éprouvantes pour les introvertis — mais le problème n'est pas l'introversion, c'est la conception. Les modèles fondés sur le swipe sont bâtis autour d'habitudes extraverties et ignorent discrètement ce que les introvertis font de mieux. Le matching par questions rétablit l'équilibre : du temps pour réfléchir, de la place pour écrire, et la profondeur avant le volume. Sur Qulo, vous rencontrez des gens à votre rythme, à travers vos propres questions et dans votre propre style. Parce que les meilleures connexions se nouent rarement grâce à celui qui parle le plus fort — mais grâce à celui qui écoute le mieux." },
  ],

  es: [
    { type: "h2", text: "Introversión y apps de citas: ¿por qué resulta tan difícil?" },
    { type: "p", text: "La introversión es un rasgo de personalidad muy extendido. Definido por Carl Jung, describe a las personas que obtienen su energía de su mundo interior y que prefieren el pensamiento profundo y las relaciones con sentido. Los introvertidos no son tímidos, ni socialmente ansiosos, ni gente a la que no le gusten los demás: simplemente se recargan de otra manera." },
    { type: "p", text: "Las apps de citas tradicionales están diseñadas en gran medida en torno a patrones de comunicación extrovertidos: decisiones rápidas, primeras impresiones superficiales, presión constante por interactuar. Para una persona introvertida eso se traduce en una experiencia especialmente agotadora y poco satisfactoria. ¿Hay una forma mejor? El quiz dating —hacer match respondiendo a las preguntas de alguien en lugar de juzgar sus fotos— responde exactamente a eso." },

    { type: "h2", text: "Los 3 grandes problemas de los introvertidos en las apps de citas" },

    { type: "h2", text: "1. Sobreestimulación" },
    { type: "p", text: "A los introvertidos se los describe a menudo como más sensibles a los estímulos externos que los extrovertidos. En \"The Introvert Advantage\", Marti Olsen Laney popularizó la idea de que los cerebros introvertidos y extrovertidos se apoyan en vías de neurotransmisores distintas: la acetilcolina, asociada al pensamiento profundo y la introspección, frente a la dopamina, asociada a la novedad y la excitación. Sea cual sea la biología de fondo, la experiencia le resulta familiar a cualquiera que se haya sentido exprimido tras una hora de scroll." },
    { type: "p", text: "Las apps basadas en el swipe entregan un flujo continuo de estímulos nuevos: fotos, perfiles, notificaciones. Para un cerebro que se satura rápido, eso significa fatiga, parálisis a la hora de decidir y, con el tiempo, evitar la app por completo." },

    { type: "h2", text: "2. Agotamiento social" },
    { type: "p", text: "Los introvertidos necesitan tiempo a solas después de la interacción social para recuperarse. La presión constante de la mensajería en las apps de citas interfiere justo con esa recuperación. Mantener varias conversaciones a la vez desgasta especialmente: cada hilo nuevo tira de la misma reserva y, con el tiempo, la \"batería social\" se queda a cero." },

    { type: "h2", text: "3. El problema de la superficialidad" },
    { type: "p", text: "A los introvertidos no suele gustarles la charla trivial y prefieren conversaciones con sustancia. Sin embargo, el mensaje de apertura típico en una app de citas —\"Hola, ¿qué tal?\", \"Bonitas fotos\"— es exactamente ese intercambio vacío que evitan. El resultado es que los introvertidos nunca terminan de sentirse cómodos en estas apps y dejan de iniciar conversaciones." },

    { type: "h2", accent: "green", text: "Por qué el quiz dating es ideal para introvertidos" },

    { type: "h2", text: "Tiempo para pensar" },
    { type: "p", text: "La mecánica del swipe exige un juicio instantáneo, y ahí no está la fuerza de los introvertidos. Responder a las preguntas de otra persona, en cambio, da tiempo para leer, pensar y decidir. Leer una pregunta con atención, pensar en quien la escribió y elegir la respuesta de forma deliberada no es un rodeo para esquivar la introversión: es el estilo de comunicación natural del introvertido convertido en la propia mecánica." },

    { type: "h2", text: "La fuerza de la expresión escrita" },
    { type: "p", text: "Susan Cain, en \"Quiet: The Power of Introverts in a World That Can't Stop Talking\", sostiene que los introvertidos suelen expresarse mejor por escrito, donde pueden pensar antes de responder en lugar de actuar sobre la marcha. Además, hay evidencia directa de que lo que los introvertidos hacen de forma natural —preguntar y luego escuchar— es justo lo que atrae a los demás. En el estudio \"It Doesn't Hurt to Ask: Question-Asking Increases Liking\", publicado por **Huang, Yeomans, Brooks, Minson y Gino** en el Journal of Personality and Social Psychology en septiembre de 2017, se analizaron **1.961** decisiones de segunda cita tomadas por **110** participantes de speed dating: quienes hacían más preguntas de seguimiento tenían más probabilidades de ser invitados de nuevo. El quiz dating integra ese comportamiento en el formato: tú preguntas y la otra persona responde." },

    { type: "h2", text: "Prioridad a la profundidad" },
    { type: "p", text: "Los introvertidos tienden a construir menos relaciones, pero más profundas. Un modelo que produce menos matches y mejor pensados encaja con ese instinto. Como el match solo ocurre después de que alguien haya resuelto todas tus preguntas, cada match ya trae consigo un nivel de atención que un swipe nunca pide." },

    { type: "h2", text: "Estrategias para introvertidos en Qulo" },

    { type: "h2", text: "Tipos de preguntas" },
    { type: "p", text: "En Qulo escribes entre **2 y 4** preguntas de opción múltiple, y hasta 10 con un plan de pago. Cada una tiene cuatro opciones y marcas la que es cierta para ti. Alguien hace match contigo solo si acierta absolutamente todas: no hay puntuación parcial. Los tipos de pregunta que mejor funcionan para los introvertidos:" },
    { type: "ul", items: [
      "**Preguntas de valores:** \"¿Qué es lo que más valoro?\" — con cuatro opciones que de verdad sopesarías entre sí, se llega a una compatibilidad real y no a una apuesta",
      "**Preguntas de escenario:** \"¿Cómo es mi domingo lluvioso ideal?\" — las cuatro opciones dicen más de tu vida que una bio",
      "**Preguntas de cultura y gustos:** \"¿Cuál de estos leí por última vez?\" — una lectura rápida de si vuestros mundos se cruzan",
      "**Preguntas filosóficas:** \"¿Qué significa el éxito para mí?\" — la opción que alguien elige revela cómo piensa",
    ] },

    { type: "h2", text: "Control del ritmo" },
    { type: "p", text: "En Qulo avanzas a tu propio ritmo. Cuántas preguntas respondes al día y cuántas conversaciones mantienes abiertas depende solo de ti. Resolver preguntas es asíncrono, así que no hay presión por sostener varias conversaciones en vivo a la vez. Si te atascas, los poderes opcionales —una pista, reducir las opciones a la mitad, saltarte una pregunta— cuestan diamantes dentro de la app, y ninguno es necesario para hacer match." },

    { type: "h2", text: "El mito de la compatibilidad introvertido-extrovertido" },
    { type: "p", text: "La cultura popular insiste en que introvertidos y extrovertidos forman un \"equilibrio perfecto\". El panorama de la investigación es más matizado. Décadas de investigación sobre pareja del psicólogo John Gottman apuntan a los valores compartidos, a una comunicación que funciona y al respeto mutuo como lo que mantiene unida a una pareja, y no al emparejamiento de tipos de personalidad." },
    { type: "p", text: "El emparejamiento por preguntas refleja eso. Las preguntas miden la coincidencia en valores y formas de pensar, con independencia del tipo de personalidad. Un introvertido puede encajar perfectamente con otro introvertido o con un extrovertido; lo que importa es que las respuestas coincidan, no qué tipo hay a cada lado." },

    { type: "h2", text: "Ideas de \"Quiet\", de Susan Cain" },
    { type: "p", text: "El libro de Cain expone las fortalezas que una cultura construida sobre hablar tiende a pasar por alto. Según ella, los introvertidos:" },
    { type: "ul", items: [
      "Escuchan con más profundidad y leen mejor a las personas",
      "Toman decisiones más cuidadosas y más meditadas",
      "Construyen relaciones leales y comprometidas",
      "Piensan mejor ante problemas creativos y difíciles",
    ] },
    { type: "p", text: "Esas fortalezas son exactamente lo que premia un formato basado en preguntas. Resolver las preguntas de otra persona exige lectura atenta, pensamiento paciente y atención a lo que realmente quiso decir: justo aquello en lo que los introvertidos son buenos." },

    { type: "quote", text: "Los introvertidos no son fuertes porque callen. Son fuertes porque escuchan. El quiz dating está construido sobre la escucha." },

    { type: "h2", accent: "green", text: "Conclusión" },
    { type: "p", text: "Las apps de citas pueden ser duras para los introvertidos, pero el problema no es la introversión, sino el diseño. Los modelos basados en el swipe se construyen en torno a hábitos extrovertidos e ignoran en silencio aquello en lo que los introvertidos son buenos. El emparejamiento por preguntas corrige eso: tiempo para pensar, espacio para escribir y profundidad antes que volumen. En Qulo conoces a gente a tu ritmo, con tus propias preguntas y a tu manera. Porque las mejores conexiones rara vez las crea quien habla más alto: las crea quien mejor escucha." },
  ],

  ar: [
    { type: "h2", text: "الانطواء وتطبيقات المواعدة: لماذا الأمر صعب إلى هذا الحد؟" },
    { type: "p", text: "الانطواء سمة شخصية واسعة الانتشار. عرّفه كارل يونغ ليصف الأشخاص الذين يستمدون طاقتهم من عالمهم الداخلي ويفضّلون التفكير العميق والعلاقات ذات المعنى. المنطوون ليسوا خجولين ولا يعانون من قلق اجتماعي ولا يكرهون الناس — هم فقط يستعيدون طاقتهم بطريقة مختلفة." },
    { type: "p", text: "تطبيقات المواعدة التقليدية مصمَّمة إلى حد بعيد حول أنماط تواصل منفتحة: قرارات سريعة، انطباعات أولى سطحية، وضغط دائم للتفاعل. وبالنسبة لشخص منطوٍ فإن ذلك يصنع تجربة مرهقة وغير مُرضية بشكل خاص. فهل هناك طريق أفضل؟ المواعدة القائمة على الأسئلة — أن تتطابق مع شخص عبر الإجابة عن أسئلته بدل الحكم على صوره — تجيب عن هذا السؤال بالضبط." },

    { type: "h2", text: "ثلاث مشكلات كبرى يواجهها المنطوون في تطبيقات المواعدة" },

    { type: "h2", text: "1. فرط التحفيز" },
    { type: "p", text: "كثيرًا ما يوصف المنطوون بأنهم أكثر حساسية للمثيرات الخارجية من المنفتحين. في كتاب \"The Introvert Advantage\"، نشرت Marti Olsen Laney الطرح القائل إن أدمغة المنطوين والمنفتحين تعتمد على مسارات ناقلات عصبية مختلفة: الأسِيتيل كولين المرتبط بالتفكير العميق والتأمل الداخلي، مقابل الدوبامين المرتبط بالجِدّة والإثارة. ومهما تكن البيولوجيا الكامنة، فالتجربة مألوفة لكل من شعر بالإنهاك بعد ساعة من التمرير." },
    { type: "p", text: "تقدّم التطبيقات القائمة على السحب تدفقًا متواصلًا من المثيرات الجديدة: صور وملفات شخصية وإشعارات. وبالنسبة لدماغ يمتلئ بسرعة، فإن ذلك يعني الإرهاق وشلل القرار ثم تجنّب التطبيق تمامًا في النهاية." },

    { type: "h2", text: "2. الاستنزاف الاجتماعي" },
    { type: "p", text: "يحتاج المنطوون إلى وقت بمفردهم بعد التفاعل الاجتماعي كي يستعيدوا طاقتهم. وضغط الرسائل المستمر في تطبيقات المواعدة يقطع هذا التعافي بالذات. أما إبقاء عدة محادثات مفتوحة في الوقت نفسه فمستنزف بصفة خاصة: كل محادثة جديدة تسحب من الرصيد ذاته، ومع الوقت تفرغ \"البطارية الاجتماعية\" تمامًا." },

    { type: "h2", text: "3. مشكلة السطحية" },
    { type: "p", text: "لا يميل المنطوون إلى الحديث العابر ويفضّلون محادثات لها مضمون. لكن رسالة الافتتاح المعتادة في تطبيقات المواعدة — \"مرحبًا، كيف حالك؟\"، \"صورك جميلة\" — هي تحديدًا ذلك التبادل الفارغ الذي يتجنبونه. والنتيجة أن المنطوين لا يشعرون أبدًا بالارتياح في هذه التطبيقات ويتوقفون عن بدء المحادثات أصلًا." },

    { type: "h2", accent: "green", text: "لماذا تُعدّ المواعدة بالأسئلة مثالية للمنطوين؟" },

    { type: "h2", text: "وقت للتفكير" },
    { type: "p", text: "تتطلب آلية السحب حكمًا لحظيًا، وهذا ليس موطن قوة المنطوين. أما الإجابة عن أسئلة شخص آخر فتمنحك وقتًا للقراءة والتفكير والاختيار. أن تقرأ سؤالًا بعناية، وتفكر في من كتبه، وتختار إجابتك عن قصد — ليس التفافًا على الانطواء، بل هو أسلوب التواصل الطبيعي للمنطوي وقد تحوّل إلى الآلية نفسها." },

    { type: "h2", text: "قوة التعبير الكتابي" },
    { type: "p", text: "ترى Susan Cain في كتابها \"Quiet: The Power of Introverts in a World That Can't Stop Talking\" أن المنطوين يكونون في أوضح حالاتهم في الكتابة، حيث يستطيعون التفكير قبل الإجابة بدل الأداء الفوري. وهناك أيضًا دليل مباشر على أن ما يفعله المنطوون بطبيعتهم — أن يسألوا ثم يستمعوا — هو ما يجذب الناس. ففي دراسة \"It Doesn't Hurt to Ask: Question-Asking Increases Liking\" التي نشرها **Huang وYeomans وBrooks وMinson وGino** في مجلة Journal of Personality and Social Psychology في سبتمبر 2017، جرى تحليل **1,961** قرار موعد ثانٍ صادرًا عن **110** مشاركين في التعارف السريع، وتبيّن أن من طرحوا أسئلة متابعة أكثر كانوا أوفر حظًا في تلقّي دعوة ثانية. والمواعدة بالأسئلة تضع هذا السلوك في صميم الصيغة: أنت تسأل، والطرف الآخر يجيب." },

    { type: "h2", text: "أولوية العمق" },
    { type: "p", text: "يميل المنطوون إلى بناء علاقات أقل عددًا وأعمق أثرًا. والنموذج الذي ينتج تطابقات أقل وأكثر تمعّنًا ينسجم مع هذا الميل. ولأن التطابق لا يحدث إلا بعد أن يجتاز شخص ما أسئلتك كلها، فإن كل تطابق يحمل منذ البداية قدرًا من الانتباه لا تطلبه حركة سحب أبدًا." },

    { type: "h2", text: "استراتيجيات المنطوين في Qulo" },

    { type: "h2", text: "أنواع الأسئلة" },
    { type: "p", text: "في Qulo تكتب ما بين **2 و4** أسئلة اختيار من متعدد، وحتى 10 أسئلة في الخطة المدفوعة. لكل سؤال أربعة خيارات، وأنت تحدد الخيار الصحيح بشأنك. ولا يتطابق معك أحد إلا إذا أجاب عن الأسئلة كلها إجابة صحيحة — لا توجد درجة جزئية. وهذه أنواع الأسئلة الأفضل للمنطوين:" },
    { type: "ul", items: [
      "**أسئلة القيم:** \"ما الذي أقدّره أكثر من غيره؟\" — بأربعة خيارات توازن بينها فعلًا، تصل إلى توافق حقيقي بدل التخمين",
      "**أسئلة السيناريو:** \"كيف يبدو يوم الأحد الممطر المثالي عندي؟\" — الخيارات الأربعة تقول عن حياتك أكثر مما تقوله نبذة تعريفية",
      "**أسئلة الثقافة والذوق:** \"أيّ من هذه قرأته آخر مرة؟\" — قراءة سريعة لمدى تقاطع عالميكما",
      "**الأسئلة الفلسفية:** \"ماذا يعني النجاح بالنسبة لي؟\" — الخيار الذي ينتقيه الطرف الآخر يكشف طريقة تفكيره",
    ] },

    { type: "h2", text: "التحكم في الإيقاع" },
    { type: "p", text: "في Qulo تتقدّم بالسرعة التي تناسبك. كم سؤالًا تجيب عنه في اليوم، وكم محادثة تبقيها مفتوحة — الأمر متروك لك تمامًا. وحلّ الأسئلة غير متزامن، فلا ضغط لإدارة عدة محادثات حيّة في الوقت نفسه. وإذا تعثّرت، فالقدرات الاختيارية — تلميح، تقليص الخيارات إلى النصف، تخطي سؤال — تكلّف ألماسًا داخل التطبيق، ولا واحدة منها لازمة للتطابق." },

    { type: "h2", text: "أسطورة التوافق بين المنطوي والمنفتح" },
    { type: "p", text: "تصرّ الثقافة الشائعة على أن المنطوين والمنفتحين يشكّلون \"توازنًا مثاليًا\". غير أن صورة البحث العلمي أكثر تركيبًا. فعقود من أبحاث العلاقات لدى عالم النفس John Gottman تشير إلى القيم المشتركة والتواصل الناجح والاحترام المتبادل بوصفها ما يبقي الشريكين معًا — لا إلى مزاوجة أنماط الشخصية." },
    { type: "p", text: "والمطابقة القائمة على الأسئلة تعكس ذلك. فالأسئلة تقيس التوافق في القيم وطرائق التفكير بمعزل عن نمط الشخصية. ويمكن لمنطوٍ أن يتطابق تمامًا مع منطوٍ آخر أو مع منفتح؛ المهم هو تطابق الإجابات، لا النمط الواقف على كل جانب." },

    { type: "h2", text: "خلاصات من كتاب \"Quiet\" لسوزان كاين" },
    { type: "p", text: "يكشف كتاب كاين عن نقاط القوة التي تميل ثقافة قائمة على الكلام إلى إغفالها. فبحسبها، المنطوون:" },
    { type: "ul", items: [
      "يستمعون بعمق أكبر ويقرأون الناس عن قرب",
      "يتخذون قرارات أكثر تأنيًا وأكثر تمعّنًا",
      "يبنون علاقات وفيّة وملتزمة",
      "يفكرون على أفضل نحو في المسائل الإبداعية والصعبة",
    ] },
    { type: "p", text: "وهذه القوى هي بالضبط ما تكافئه صيغة قائمة على الأسئلة. فالعمل على أسئلة شخص آخر يتطلب قراءة متأنية وتفكيرًا صبورًا وانتباهًا لما قصده فعلًا — أي ما يجيده المنطوون." },

    { type: "quote", text: "المنطوون ليسوا أقوياء لأنهم صامتون، بل لأنهم يستمعون. والمواعدة بالأسئلة مبنية على الإصغاء." },

    { type: "h2", accent: "green", text: "الخلاصة" },
    { type: "p", text: "قد تكون تطبيقات المواعدة مرهقة للمنطوين — لكن المشكلة ليست في الانطواء بل في التصميم. فالنماذج القائمة على السحب مبنية حول عادات منفتحة وتتجاهل بهدوء ما يجيده المنطوون. أما المطابقة بالأسئلة فتعيد التوازن: وقت للتفكير، ومساحة للكتابة، وعمق قبل الكمية. في Qulo تلتقي بالناس بالسرعة التي تناسبك، عبر أسئلتك أنت وبأسلوبك أنت. لأن أفضل الروابط نادرًا ما يصنعها من يرفع صوته أكثر — بل من يُحسن الإصغاء أكثر." },
  ],

  ru: [
    { type: "h2", text: "Интроверсия и приложения для знакомств: почему это так тяжело?" },
    { type: "p", text: "Интроверсия — распространённая черта характера. Понятие, введённое Карлом Юнгом, описывает людей, которые черпают энергию из своего внутреннего мира и предпочитают глубокое размышление и осмысленные отношения. Интроверты не застенчивы, не тревожны в общении и не сторонятся людей — они просто восстанавливаются иначе." },
    { type: "p", text: "Традиционные приложения для знакомств во многом построены вокруг экстравертных моделей общения: быстрые решения, поверхностное первое впечатление, постоянное давление быть на связи. Для интроверта это оборачивается особенно изматывающим и неудовлетворительным опытом. Есть ли путь лучше? Квиз-дейтинг — совпадение через ответы на чужие вопросы, а не через оценку фотографий — отвечает именно на это." },

    { type: "h2", text: "3 главные проблемы интровертов в приложениях для знакомств" },

    { type: "h2", text: "1. Перевозбуждение" },
    { type: "p", text: "Интровертов часто описывают как более чувствительных к внешним раздражителям, чем экстраверты. В книге \"The Introvert Advantage\" Марти Олсен Лейни популяризировала объяснение, согласно которому мозг интроверта и экстраверта опирается на разные нейромедиаторные пути: ацетилхолин, связанный с глубоким размышлением и самонаблюдением, против дофамина, связанного с новизной и возбуждением. Какой бы ни оказалась биология в основе, само переживание знакомо каждому, кто чувствовал себя выжатым после часа пролистывания." },
    { type: "p", text: "Приложения, построенные на свайпе, выдают непрерывный поток новых стимулов: фотографии, анкеты, уведомления. Для мозга, который быстро перегружается, это означает усталость, паралич решения и в итоге отказ от приложения вовсе." },

    { type: "h2", text: "2. Социальное истощение" },
    { type: "p", text: "После общения интровертам нужно время наедине с собой, чтобы восстановиться. Постоянное давление переписки в приложениях мешает именно этому восстановлению. Вести несколько разговоров одновременно особенно затратно: каждая новая переписка черпает из того же запаса, и со временем «социальная батарейка» садится полностью." },

    { type: "h2", text: "3. Проблема поверхностности" },
    { type: "p", text: "Интроверты обычно не любят светскую болтовню и предпочитают разговоры по существу. Но типичное первое сообщение в приложении для знакомств — «Привет, как дела?», «Красивые фото» — это ровно тот пустой обмен, которого они избегают. В результате интроверты никогда не чувствуют себя здесь своими и вовсе перестают начинать разговор." },

    { type: "h2", accent: "green", text: "Почему квиз-дейтинг идеален для интровертов" },

    { type: "h2", text: "Время подумать" },
    { type: "p", text: "Механика свайпа требует мгновенного суждения — а это не сильная сторона интровертов. Ответы на чужие вопросы, наоборот, дают время прочитать, подумать и решить. Внимательно прочитать вопрос, подумать о человеке, который его написал, и осознанно выбрать ответ — это не обходной путь вокруг интроверсии, а естественный стиль общения интроверта, превращённый в саму механику." },

    { type: "h2", text: "Сила письменного выражения" },
    { type: "p", text: "Сьюзан Кейн в книге \"Quiet: The Power of Introverts in a World That Can't Stop Talking\" утверждает, что интроверты чаще всего наиболее точны именно на письме: там можно подумать перед ответом, а не выступать с ходу. Есть и прямые данные о том, что то, что интроверты делают естественно — сначала спросить, потом слушать, — как раз и притягивает людей. В работе \"It Doesn't Hurt to Ask: Question-Asking Increases Liking\", опубликованной **Huang, Yeomans, Brooks, Minson и Gino** в Journal of Personality and Social Psychology в сентябре 2017 года, был проанализирован **1 961** решение о втором свидании, принятое **110** участниками спид-дейтинга: те, кто задавал больше уточняющих вопросов, чаще получали приглашение снова. Квиз-дейтинг встраивает это поведение в сам формат: вы спрашиваете, а другой человек отвечает." },

    { type: "h2", text: "Приоритет глубины" },
    { type: "p", text: "Интроверты обычно строят меньше отношений, но более глубоких. Модель, дающая меньше совпадений, но более обдуманных, отвечает этому чутью. Поскольку совпадение возникает только после того, как человек разобрался со всеми вашими вопросами, каждое совпадение уже несёт в себе то внимание, которого свайп никогда не требует." },

    { type: "h2", text: "Стратегии интроверта в Qulo" },

    { type: "h2", text: "Типы вопросов" },
    { type: "p", text: "В Qulo вы составляете от **2 до 4** вопросов с вариантами ответа, а на платном тарифе — до 10. У каждого четыре варианта, и вы отмечаете тот, который верен для вас. Совпадение произойдёт, только если человек ответит правильно абсолютно на все — частичного зачёта нет. Типы вопросов, которые лучше всего работают для интровертов:" },
    { type: "ul", items: [
      "**Вопросы о ценностях:** «Что для меня важнее всего?» — с четырьмя вариантами, которые вы действительно взвешивали бы друг против друга, это выводит на настоящую совместимость, а не на угадывание",
      "**Вопросы-сценарии:** «Каким будет мой идеальный дождливый выходной?» — четыре варианта скажут о вашей жизни больше, чем описание профиля",
      "**Вопросы о культуре и вкусах:** «Что из этого я прочитал последним?» — быстрый способ понять, пересекаются ли ваши миры",
      "**Философские вопросы:** «Что для меня значит успех?» — выбранный вариант показывает, как человек мыслит",
    ] },

    { type: "h2", text: "Контроль темпа" },
    { type: "p", text: "В Qulo вы движетесь в своём темпе. Сколько вопросов решать за день и сколько переписок держать открытыми — решаете только вы. Решение вопросов асинхронно, поэтому нет давления вести несколько живых бесед сразу. Если застряли, необязательные способности — подсказка, сокращение вариантов вдвое, пропуск вопроса — стоят внутриигровых алмазов, и ни одна из них не требуется для совпадения." },

    { type: "h2", text: "Миф о совместимости интроверта и экстраверта" },
    { type: "p", text: "Массовая культура настаивает, что интроверт и экстраверт образуют «идеальный баланс». Картина исследований сложнее. Десятилетия исследований отношений психолога Джона Готтмана указывают на общие ценности, работающее общение и взаимное уважение как на то, что удерживает пару вместе, а вовсе не на сочетание типов личности." },
    { type: "p", text: "Подбор через вопросы отражает это. Вопросы измеряют совпадение ценностей и способов мышления независимо от типа личности. Интроверт может идеально совпасть и с другим интровертом, и с экстравертом; важно, сходятся ли ответы, а не какой тип с каждой стороны." },

    { type: "h2", text: "Выводы из книги Сьюзан Кейн \"Quiet\"" },
    { type: "p", text: "Книга Кейн показывает сильные стороны, которые культура, построенная на говорении, склонна не замечать. По её словам, интроверты:" },
    { type: "ul", items: [
      "Слушают глубже и внимательнее считывают людей",
      "Принимают более осторожные и продуманные решения",
      "Строят верные, преданные отношения",
      "Лучше всего думают над творческими и трудными задачами",
    ] },
    { type: "p", text: "Именно эти качества и вознаграждает формат, построенный на вопросах. Разбор чужих вопросов требует внимательного чтения, терпеливого размышления и внимания к тому, что человек на самом деле имел в виду, — то есть того, в чём интроверты сильны." },

    { type: "quote", text: "Интроверты сильны не потому, что молчат. Они сильны потому, что слушают. Квиз-дейтинг построен на умении слушать." },

    { type: "h2", accent: "green", text: "Заключение" },
    { type: "p", text: "Приложения для знакомств могут быть тяжёлой работой для интровертов, но проблема не в интроверсии, а в дизайне. Модели на основе свайпа выстроены вокруг экстравертных привычек и тихо игнорируют то, в чём интроверты хороши. Подбор через вопросы это исправляет: время подумать, место, чтобы написать, и глубина вместо объёма. В Qulo вы знакомитесь в своём темпе, своими вопросами и в своём стиле. Потому что лучшие связи редко создаёт тот, кто говорит громче всех, — их создаёт тот, кто лучше всех слушает." },
  ],

  pt: [
    { type: "h2", text: "Introversão e apps de namoro: por que é tão difícil?" },
    { type: "p", text: "A introversão é um traço de personalidade bastante comum. Definido por Carl Jung, descreve pessoas que retiram sua energia do mundo interior e que preferem o pensamento profundo e as relações com sentido. Introvertidos não são tímidos, nem ansiosos socialmente, nem pessoas que não gostam dos outros — apenas se recarregam de outra forma." },
    { type: "p", text: "Os apps de namoro tradicionais são desenhados em grande medida em torno de padrões extrovertidos de comunicação: decisões rápidas, primeiras impressões superficiais, pressão constante para interagir. Para quem é introvertido, isso resulta numa experiência especialmente exaustiva e pouco satisfatória. Existe um caminho melhor? O quiz dating — dar match respondendo às perguntas de alguém em vez de julgar as fotos — responde exatamente a isso." },

    { type: "h2", text: "Os 3 grandes problemas dos introvertidos nos apps de namoro" },

    { type: "h2", text: "1. Superestimulação" },
    { type: "p", text: "Introvertidos costumam ser descritos como mais sensíveis a estímulos externos do que extrovertidos. Em \"The Introvert Advantage\", Marti Olsen Laney popularizou a leitura de que cérebros introvertidos e extrovertidos se apoiam em vias de neurotransmissores diferentes: a acetilcolina, associada ao pensamento profundo e à introspecção, contra a dopamina, associada à novidade e à excitação. Seja qual for a biologia por trás, a experiência é familiar a qualquer pessoa que já se sentiu esgotada após uma hora de rolagem." },
    { type: "p", text: "Os apps baseados em swipe entregam um fluxo contínuo de estímulos novos: fotos, perfis, notificações. Para um cérebro que satura rápido, isso significa cansaço, paralisia de decisão e, com o tempo, o abandono do app." },

    { type: "h2", text: "2. Esgotamento social" },
    { type: "p", text: "Introvertidos precisam de tempo sozinhos depois da interação social para se recuperar. A pressão constante das mensagens nos apps de namoro atrapalha justamente essa recuperação. Manter várias conversas ao mesmo tempo desgasta em especial: cada nova conversa puxa da mesma reserva e, com o tempo, a \"bateria social\" zera." },

    { type: "h2", text: "3. O problema da superficialidade" },
    { type: "p", text: "Introvertidos tendem a não gostar de conversa fiada e preferem trocas com conteúdo. Só que a mensagem de abertura típica num app de namoro — \"Oi, tudo bem?\", \"Fotos bonitas\" — é exatamente a troca vazia que eles evitam. O resultado é que introvertidos nunca se sentem à vontade nesses apps e param de iniciar conversas." },

    { type: "h2", accent: "green", text: "Por que o quiz dating é ideal para introvertidos" },

    { type: "h2", text: "Tempo para pensar" },
    { type: "p", text: "A mecânica do swipe exige julgamento instantâneo, e não é aí que os introvertidos são mais fortes. Responder às perguntas de alguém, ao contrário, dá tempo para ler, pensar e decidir. Ler uma pergunta com atenção, pensar em quem a escreveu e escolher a resposta de propósito não é um desvio para contornar a introversão: é o estilo natural de comunicação do introvertido transformado na própria mecânica." },

    { type: "h2", text: "A força da expressão escrita" },
    { type: "p", text: "Susan Cain, em \"Quiet: The Power of Introverts in a World That Can't Stop Talking\", defende que introvertidos costumam se expressar melhor por escrito, onde podem pensar antes de responder em vez de atuar na hora. Há também evidência direta de que aquilo que os introvertidos fazem naturalmente — perguntar e depois escutar — é justamente o que atrai as pessoas. No estudo \"It Doesn't Hurt to Ask: Question-Asking Increases Liking\", publicado por **Huang, Yeomans, Brooks, Minson e Gino** no Journal of Personality and Social Psychology em setembro de 2017, foram analisadas **1.961** decisões de segundo encontro tomadas por **110** participantes de speed dating: quem fazia mais perguntas de acompanhamento tinha mais chance de ser convidado de novo. O quiz dating coloca esse comportamento dentro do formato: você pergunta e a outra pessoa responde." },

    { type: "h2", text: "Prioridade à profundidade" },
    { type: "p", text: "Introvertidos tendem a construir menos relações, porém mais profundas. Um modelo que produz menos matches, e mais bem pensados, combina com esse instinto. Como o match só acontece depois que alguém resolveu todas as suas perguntas, cada match já carrega um nível de atenção que um swipe nunca pede." },

    { type: "h2", text: "Estratégias para introvertidos no Qulo" },

    { type: "h2", text: "Tipos de pergunta" },
    { type: "p", text: "No Qulo você escreve entre **2 e 4** perguntas de múltipla escolha, e até 10 num plano pago. Cada uma tem quatro opções, e você marca a que é verdadeira sobre você. Alguém só dá match com você acertando absolutamente todas — não há pontuação parcial. Os tipos de pergunta que funcionam melhor para introvertidos:" },
    { type: "ul", items: [
      "**Perguntas de valores:** \"O que eu mais valorizo?\" — com quatro opções que você realmente pesaria entre si, chega-se a compatibilidade real em vez de chute",
      "**Perguntas de cenário:** \"Como é meu domingo chuvoso ideal?\" — as quatro opções dizem mais sobre sua vida do que uma bio",
      "**Perguntas de cultura e gosto:** \"Qual destes eu li por último?\" — uma leitura rápida de quanto seus mundos se cruzam",
      "**Perguntas filosóficas:** \"O que sucesso significa para mim?\" — a opção escolhida mostra como a pessoa pensa",
    ] },

    { type: "h2", text: "Controle de ritmo" },
    { type: "p", text: "No Qulo você avança no seu ritmo. Quantas perguntas responde por dia e quantas conversas mantém abertas depende só de você. Resolver perguntas é assíncrono, então não há pressão para sustentar várias conversas ao vivo ao mesmo tempo. Se travar, os poderes opcionais — uma dica, cortar as opções pela metade, pular uma pergunta — custam diamantes dentro do app, e nenhum deles é necessário para dar match." },

    { type: "h2", text: "O mito da compatibilidade introvertido-extrovertido" },
    { type: "p", text: "A cultura popular insiste que introvertidos e extrovertidos formam um \"equilíbrio perfeito\". O quadro das pesquisas é mais nuançado. Décadas de pesquisa sobre relacionamentos do psicólogo John Gottman apontam para valores compartilhados, comunicação que funciona e respeito mútuo como o que mantém um casal junto — não para o encaixe de tipos de personalidade." },
    { type: "p", text: "O match por perguntas reflete isso. As perguntas medem a concordância sobre valores e modos de pensar, independentemente do tipo de personalidade. Um introvertido pode combinar perfeitamente com outro introvertido ou com um extrovertido; o que importa é se as respostas se encaixam, não qual tipo está de cada lado." },

    { type: "h2", text: "Lições de \"Quiet\", de Susan Cain" },
    { type: "p", text: "O livro de Cain expõe as forças que uma cultura construída sobre falar costuma ignorar. Segundo ela, os introvertidos:" },
    { type: "ul", items: [
      "Escutam com mais profundidade e leem melhor as pessoas",
      "Tomam decisões mais cuidadosas e mais ponderadas",
      "Constroem relações leais e comprometidas",
      "Pensam melhor diante de problemas criativos e difíceis",
    ] },
    { type: "p", text: "Essas forças são exatamente o que um formato baseado em perguntas recompensa. Resolver as perguntas de alguém exige leitura atenta, pensamento paciente e atenção ao que a outra pessoa realmente quis dizer — ou seja, aquilo em que introvertidos são bons." },

    { type: "quote", text: "Introvertidos não são fortes por serem calados. São fortes porque escutam. O quiz dating é construído sobre a escuta." },

    { type: "h2", accent: "green", text: "Conclusão" },
    { type: "p", text: "Apps de namoro podem ser trabalhosos para introvertidos — mas o problema não é a introversão, e sim o desenho. Modelos baseados em swipe são construídos em torno de hábitos extrovertidos e ignoram em silêncio aquilo em que introvertidos são bons. O match por perguntas corrige isso: tempo para pensar, espaço para escrever e profundidade antes de volume. No Qulo você conhece pessoas no seu ritmo, com suas próprias perguntas e do seu jeito. Porque as melhores conexões raramente vêm de quem fala mais alto — vêm de quem escuta melhor." },
  ],

  it: [
    { type: "h2", text: "Introversione e app di incontri: perché è così difficile?" },
    { type: "p", text: "L'introversione è un tratto di personalità molto diffuso. Definito da Carl Jung, descrive le persone che traggono energia dal proprio mondo interiore e che preferiscono il pensiero profondo e le relazioni che hanno un senso. Gli introversi non sono timidi, non soffrono di ansia sociale e non detestano gli altri: semplicemente si ricaricano in un altro modo." },
    { type: "p", text: "Le app di incontri tradizionali sono costruite in gran parte attorno a schemi di comunicazione estroversi: decisioni rapide, prime impressioni superficiali, pressione costante a interagire. Per una persona introversa il risultato è un'esperienza particolarmente sfiancante e poco appagante. Esiste una strada migliore? Il quiz dating — trovare un match rispondendo alle domande di qualcuno invece di giudicarne le foto — risponde esattamente a questo." },

    { type: "h2", text: "I 3 grandi problemi degli introversi sulle app di incontri" },

    { type: "h2", text: "1. Sovrastimolazione" },
    { type: "p", text: "Gli introversi vengono spesso descritti come più sensibili agli stimoli esterni rispetto agli estroversi. In \"The Introvert Advantage\", Marti Olsen Laney ha reso popolare la lettura secondo cui i cervelli introversi ed estroversi si appoggiano a vie neurotrasmettitoriali diverse: l'acetilcolina, associata al pensiero profondo e all'introspezione, contro la dopamina, associata alla novità e all'eccitazione. Qualunque sia la biologia sottostante, l'esperienza è familiare a chiunque si sia sentito prosciugato dopo un'ora di scorrimento." },
    { type: "p", text: "Le app basate sullo swipe erogano un flusso ininterrotto di stimoli nuovi: foto, profili, notifiche. Per un cervello che si satura in fretta questo significa stanchezza, paralisi decisionale e, alla lunga, l'abbandono dell'app." },

    { type: "h2", text: "2. Esaurimento sociale" },
    { type: "p", text: "Dopo l'interazione sociale gli introversi hanno bisogno di tempo da soli per ricaricarsi. La pressione costante dei messaggi sulle app di incontri interferisce proprio con quel recupero. Tenere aperte più conversazioni insieme è particolarmente logorante: ogni nuovo scambio attinge alla stessa riserva e col tempo la \"batteria sociale\" si scarica del tutto." },

    { type: "h2", text: "3. Il problema della superficialità" },
    { type: "p", text: "Gli introversi tendono a non amare le chiacchiere di circostanza e preferiscono conversazioni con qualcosa dentro. Ma il tipico messaggio di apertura su un'app di incontri — \"Ciao, come va?\", \"Belle foto\" — è esattamente lo scambio vuoto che evitano. Il risultato è che gli introversi non si sentono mai davvero a proprio agio su queste app e smettono del tutto di iniziare conversazioni." },

    { type: "h2", accent: "green", text: "Perché il quiz dating è ideale per gli introversi" },

    { type: "h2", text: "Tempo per pensare" },
    { type: "p", text: "La meccanica dello swipe richiede un giudizio istantaneo, e non è lì che gli introversi danno il meglio. Rispondere alle domande di qualcuno, invece, lascia il tempo di leggere, riflettere e decidere. Leggere una domanda con attenzione, pensare a chi l'ha scritta e scegliere la risposta con intenzione non è un modo per aggirare l'introversione: è lo stile comunicativo naturale dell'introverso trasformato nella meccanica stessa." },

    { type: "h2", text: "La forza dell'espressione scritta" },
    { type: "p", text: "Susan Cain, in \"Quiet: The Power of Introverts in a World That Can't Stop Talking\", sostiene che gli introversi si esprimono spesso al meglio per iscritto, dove possono pensare prima di rispondere anziché esibirsi sul momento. C'è inoltre una prova diretta che ciò che gli introversi fanno naturalmente — chiedere e poi ascoltare — è proprio ciò che attira le persone. Nello studio \"It Doesn't Hurt to Ask: Question-Asking Increases Liking\", pubblicato da **Huang, Yeomans, Brooks, Minson e Gino** sul Journal of Personality and Social Psychology nel settembre 2017, sono state analizzate **1.961** decisioni sul secondo appuntamento prese da **110** partecipanti allo speed dating: chi faceva più domande di approfondimento aveva più probabilità di essere richiamato. Il quiz dating incorpora questo comportamento nel formato: tu chiedi e l'altra persona risponde." },

    { type: "h2", text: "Priorità alla profondità" },
    { type: "p", text: "Gli introversi tendono a costruire relazioni meno numerose ma più profonde. Un modello che produce match meno frequenti e più ponderati si accorda con questo istinto. Poiché il match avviene solo dopo che qualcuno ha lavorato su tutte le tue domande, ogni match porta già con sé un'attenzione che uno swipe non chiede mai." },

    { type: "h2", text: "Strategie per introversi su Qulo" },

    { type: "h2", text: "Tipi di domanda" },
    { type: "p", text: "Su Qulo scrivi da **2 a 4** domande a scelta multipla, e fino a 10 con un piano a pagamento. Ognuna ha quattro opzioni e tu indichi quella vera per te. Qualcuno entra in match con te solo indovinandole proprio tutte: non esiste punteggio parziale. I tipi di domanda che funzionano meglio per gli introversi:" },
    { type: "ul", items: [
      "**Domande sui valori:** \"A cosa tengo di più?\" — con quattro opzioni che soppeseresti davvero, si arriva a una compatibilità reale invece che a un tiro a indovinare",
      "**Domande di scenario:** \"Com'è la mia domenica di pioggia ideale?\" — le quattro opzioni dicono della tua vita più di una bio",
      "**Domande di cultura e gusti:** \"Quale di questi ho letto per ultimo?\" — una lettura rapida di quanto i vostri mondi si sovrappongano",
      "**Domande filosofiche:** \"Che cosa significa per me il successo?\" — l'opzione scelta rivela come ragiona l'altra persona",
    ] },

    { type: "h2", text: "Controllo del ritmo" },
    { type: "p", text: "Su Qulo procedi al tuo ritmo. Quante domande risolvere in un giorno e quante conversazioni tenere aperte dipende solo da te. La risoluzione delle domande è asincrona, quindi non c'è la pressione di reggere più conversazioni dal vivo contemporaneamente. Se ti blocchi, i poteri facoltativi — un indizio, il dimezzamento delle opzioni, il salto di una domanda — costano diamanti nell'app, e nessuno di essi è necessario per fare match." },

    { type: "h2", text: "Il mito della compatibilità introverso-estroverso" },
    { type: "p", text: "La cultura popolare insiste sul fatto che introversi ed estroversi formino un \"equilibrio perfetto\". Il quadro della ricerca è più sfumato. Decenni di ricerca sulle relazioni dello psicologo John Gottman indicano nei valori condivisi, in una comunicazione che funziona e nel rispetto reciproco ciò che tiene insieme una coppia, non nell'abbinamento dei tipi di personalità." },
    { type: "p", text: "L'abbinamento per domande riflette proprio questo. Le domande misurano l'accordo su valori e modi di pensare, indipendentemente dal tipo di personalità. Un introverso può trovare un match perfetto con un altro introverso o con un estroverso; ciò che conta è che le risposte coincidano, non quale tipo stia da ciascun lato." },

    { type: "h2", text: "Spunti da \"Quiet\" di Susan Cain" },
    { type: "p", text: "Il libro di Cain mette in luce le qualità che una cultura costruita sul parlare tende a trascurare. Secondo lei, gli introversi:" },
    { type: "ul", items: [
      "Ascoltano più a fondo e leggono le persone più da vicino",
      "Prendono decisioni più attente e più meditate",
      "Costruiscono relazioni leali e impegnate",
      "Pensano meglio davanti a problemi creativi e difficili",
    ] },
    { type: "p", text: "Sono esattamente le qualità che un formato basato sulle domande premia. Lavorare sulle domande di un'altra persona richiede lettura attenta, pensiero paziente e attenzione a ciò che l'altro intendeva davvero: cioè le cose in cui gli introversi sono bravi." },

    { type: "quote", text: "Gli introversi non sono forti perché stanno zitti. Sono forti perché ascoltano. Il quiz dating è costruito sull'ascolto." },

    { type: "h2", accent: "green", text: "Conclusione" },
    { type: "p", text: "Le app di incontri possono essere faticose per gli introversi, ma il problema non è l'introversione: è il design. I modelli basati sullo swipe sono costruiti attorno ad abitudini estroverse e ignorano in silenzio ciò in cui gli introversi sono bravi. L'abbinamento per domande rimette le cose a posto: tempo per pensare, spazio per scrivere e profondità prima della quantità. Su Qulo conosci le persone al tuo ritmo, con le tue domande e nel tuo stile. Perché i legami migliori li crea di rado chi parla più forte: li crea chi ascolta meglio." },
  ],

  ja: [
    { type: "h2", text: "内向性とデーティングアプリ──なぜこんなに大変なのか" },
    { type: "p", text: "内向性は広く見られるパーソナリティ特性です。カール・ユングが定義したこの概念は、自分の内側からエネルギーを得て、深く考えることと意味のある関係を好む人たちを指します。内向的な人は、内気なわけでも、社交不安を抱えているわけでも、人が嫌いなわけでもありません。ただ、回復のしかたが違うだけです。" },
    { type: "p", text: "従来のデーティングアプリは、その多くが外向的なコミュニケーションの型を前提に設計されています。素早い判断、表面的な第一印象、絶え間ないやり取りの圧力。内向的な人にとって、それはとりわけ消耗し、満たされにくい体験になります。もっと良いやり方はないのでしょうか。クイズ・デーティング──写真を品定めするのではなく、相手の質問に答えることでマッチする方式──は、まさにその問いへの答えです。" },

    { type: "h2", text: "内向的な人がデーティングアプリで直面する3つの大きな問題" },

    { type: "h2", text: "1. 過剰な刺激" },
    { type: "p", text: "内向的な人は、外向的な人より外からの刺激に敏感だとしばしば説明されます。Marti Olsen Laneyは著書「The Introvert Advantage」で、内向型と外向型の脳が異なる神経伝達物質の経路に依存しているという見方を広めました。深い思考や内省と結びついたアセチルコリンと、新奇さや興奮と結びついたドーパミンです。根底にある生物学がどうであれ、1時間スクロールしたあとに絞り出されたような疲れを感じたことのある人には、この体験はおなじみでしょう。" },
    { type: "p", text: "スワイプ型のデーティングアプリは、新しい刺激を絶え間なく送り込んできます。写真、プロフィール、通知。すぐに容量がいっぱいになる脳にとって、それは疲労と決断の麻痺を意味し、やがてアプリそのものを避けることにつながります。" },

    { type: "h2", text: "2. 社会的な消耗" },
    { type: "p", text: "内向的な人は、人と関わったあとに回復するためのひとりの時間を必要とします。デーティングアプリの絶え間ないメッセージの圧力は、まさにその回復を妨げます。複数の会話を同時に抱えることはとりわけ消耗します。新しいやり取りはどれも同じ蓄えから引き出され、やがて「社会的バッテリー」は完全に空になります。" },

    { type: "h2", text: "3. 浅さの問題" },
    { type: "p", text: "内向的な人は世間話を好まず、中身のある会話を好む傾向があります。ところがデーティングアプリの典型的な最初のメッセージ──「こんにちは、元気ですか？」「写真、素敵ですね」──は、まさに彼らが避けたい中身のないやり取りそのものです。その結果、内向的な人はこうしたアプリでいつまでも居心地の悪さを感じ、やがて自分から会話を始めなくなります。" },

    { type: "h2", accent: "green", text: "クイズ・デーティングが内向的な人に向いている理由" },

    { type: "h2", text: "考える時間" },
    { type: "p", text: "スワイプの仕組みは瞬時の判断を求めますが、そこは内向的な人の得意分野ではありません。一方、相手の質問に答える形式なら、読み、考え、決めるための時間があります。質問をていねいに読み、それを書いた人について考え、意識して答えを選ぶ──これは内向性を迂回するための工夫ではなく、内向的な人の自然なコミュニケーションの型がそのまま仕組みになったものです。" },

    { type: "h2", text: "書いて伝える力" },
    { type: "p", text: "Susan Cainは「Quiet: The Power of Introverts in a World That Can't Stop Talking」で、内向的な人はしばしば書くときにこそ最もよく言葉にできると論じています。その場で演じる代わりに、答える前に考えられるからです。さらに、内向的な人が自然に行っていること──まず尋ね、そして聴くこと──こそが人を引きつけるという直接的な証拠もあります。**Huang、Yeomans、Brooks、Minson、Gino**が2017年9月にJournal of Personality and Social Psychologyで発表した論文「It Doesn't Hurt to Ask: Question-Asking Increases Liking」では、**110**人のスピードデート参加者による**1,961**件の「もう一度会うか」の判断が分析され、フォローアップの質問を多くした人ほど再び誘われる確率が高いことが示されました。クイズ・デーティングは、その振る舞いを形式そのものに組み込んでいます。あなたが尋ね、相手が答えるのです。" },

    { type: "h2", text: "深さを優先する" },
    { type: "p", text: "内向的な人は、数は少なくとも深い関係を築く傾向があります。マッチの数が少なく、そのぶんよく考えられている仕組みは、その感覚に合います。マッチは相手があなたの質問をすべて解いたあとにしか成立しないため、どのマッチも、スワイプがけっして求めないだけの注意をはじめから伴っています。" },

    { type: "h2", text: "Quloでの内向型の戦略" },

    { type: "h2", text: "質問のタイプ" },
    { type: "p", text: "Quloでは**2〜4問**（有料プランなら最大10問）の多肢選択式の質問をつくります。それぞれに4つの選択肢があり、自分にとって正しいものに印をつけます。相手はすべての質問に正解して初めてあなたとマッチします。部分点はありません。内向的な人に最も向いている質問のタイプはこちらです。" },
    { type: "ul", items: [
      "**価値観の質問:**「自分が最も大切にしているものは？」──本当に迷うような4択にすると、当てずっぽうではなく本物の相性に届きます",
      "**シチュエーションの質問:**「理想の雨の日曜日は？」──4つの選択肢は、自己紹介文より雄弁にあなたの生活を語ります",
      "**文化と趣味の質問:**「最後に読んだのはどれ？」──互いの世界が重なっているかを手早く測れます",
      "**哲学的な質問:**「自分にとって成功とは？」──相手が選ぶ選択肢に、その人の考え方が表れます",
    ] },

    { type: "h2", text: "ペースの主導権" },
    { type: "p", text: "Quloでは自分のペースで進められます。1日に何問答えるか、いくつの会話を開いておくかは、まったくあなた次第です。質問を解くプロセスは非同期なので、複数のリアルタイムの会話を同時に抱える圧力はありません。行き詰まったときの任意のパワー──ヒント、選択肢を半分に減らす、質問を飛ばす──はアプリ内のダイヤを消費しますが、マッチするために必要なものはひとつもありません。" },

    { type: "h2", text: "内向型と外向型は相性が良いという神話" },
    { type: "p", text: "大衆文化は、内向型と外向型が「完璧なバランス」をつくると言い張ります。しかし研究が描く像はもっと入り組んでいます。心理学者John Gottmanによる数十年にわたる関係研究が指し示すのは、共有された価値観、機能するコミュニケーション、そして相互の敬意であって、パーソナリティ類型の組み合わせではありません。" },
    { type: "p", text: "質問によるマッチングはそれを反映します。質問が測るのは、パーソナリティ類型とは無関係に、価値観と考え方の一致です。内向的な人は、別の内向的な人とも、外向的な人とも完璧にマッチしえます。大切なのは答えが噛み合うかどうかであって、どちらにどの類型がいるかではありません。" },

    { type: "h2", text: "Susan Cain「Quiet」からの示唆" },
    { type: "p", text: "Cainの本は、話すことを中心に組み立てられた文化が見落としがちな強みを描き出しています。彼女によれば、内向的な人は──" },
    { type: "ul", items: [
      "より深く聴き、人をより細やかに読み取る",
      "より慎重で、よく考えられた決断をする",
      "誠実で、長く続く関係を築く",
      "創造的で難しい問題について最もよく考える",
    ] },
    { type: "p", text: "これらの強みは、質問を軸にした形式がまさに報いるものです。相手の質問に取り組むには、ていねいな読み、辛抱強い思考、そして相手が本当に言いたかったことへの注意が要ります。つまり内向的な人が得意なことです。" },

    { type: "quote", text: "内向的な人が強いのは、静かだからではありません。聴くからです。クイズ・デーティングは聴くことの上に成り立っています。" },

    { type: "h2", accent: "green", text: "まとめ" },
    { type: "p", text: "デーティングアプリは内向的な人にとって重労働になりがちですが、問題は内向性ではなく設計にあります。スワイプ型のモデルは外向的な習慣を前提に組み立てられ、内向的な人の得意なことを静かに無視してきました。質問によるマッチングはそれを正します。考える時間、書くための余白、そして量より深さ。Quloでは、自分のペースで、自分の質問で、自分のスタイルで人と出会えます。最良のつながりは、いちばん大きな声で話す人が生むことはめったにありません。いちばんよく聴く人が生むのです。" },
  ],

  ko: [
    { type: "h2", text: "내향성과 데이팅 앱: 왜 이렇게 힘들까?" },
    { type: "p", text: "내향성은 아주 흔한 성격 특성입니다. 칼 융이 정의한 이 개념은 자신의 내면 세계에서 에너지를 얻고, 깊이 생각하는 것과 의미 있는 관계를 선호하는 사람들을 가리킵니다. 내향적인 사람은 수줍음이 많은 것도, 사회 불안을 겪는 것도, 사람을 싫어하는 것도 아닙니다. 그저 회복하는 방식이 다를 뿐입니다." },
    { type: "p", text: "전통적인 데이팅 앱은 대체로 외향적인 소통 방식을 전제로 설계되어 있습니다. 빠른 결정, 피상적인 첫인상, 끊임없는 상호작용 압박. 내향적인 사람에게 그것은 특히 지치고 만족스럽지 않은 경험이 됩니다. 더 나은 길은 없을까요? 사진을 품평하는 대신 상대의 질문에 답해 매칭되는 퀴즈 데이팅이 바로 그 질문에 대한 답입니다." },

    { type: "h2", text: "내향적인 사람이 데이팅 앱에서 겪는 3가지 큰 문제" },

    { type: "h2", text: "1. 과도한 자극" },
    { type: "p", text: "내향적인 사람은 외향적인 사람보다 외부 자극에 더 민감하다고 자주 설명됩니다. Marti Olsen Laney는 저서 \"The Introvert Advantage\"에서 내향형과 외향형의 뇌가 서로 다른 신경전달물질 경로에 기댄다는 설명을 널리 퍼뜨렸습니다. 깊은 사고와 성찰에 연결된 아세틸콜린, 그리고 새로움과 흥분에 연결된 도파민입니다. 그 아래의 생물학이 결국 무엇으로 밝혀지든, 한 시간 스크롤한 뒤 기운이 다 빠져본 사람이라면 그 감각을 압니다." },
    { type: "p", text: "스와이프 기반 데이팅 앱은 새로운 자극을 끊임없이 밀어 넣습니다. 사진, 프로필, 알림. 쉽게 포화되는 뇌에게 그것은 피로와 결정 마비를 뜻하고, 결국 앱 자체를 피하게 만듭니다." },

    { type: "h2", text: "2. 사회적 소진" },
    { type: "p", text: "내향적인 사람은 사람들과 어울린 뒤 회복할 혼자만의 시간이 필요합니다. 데이팅 앱의 끝없는 메시지 압박은 바로 그 회복을 방해합니다. 여러 대화를 동시에 끌고 가는 일은 특히 소모적입니다. 새로 시작된 대화는 모두 같은 저장고에서 끌어다 쓰고, 시간이 지나면 \"사회적 배터리\"는 완전히 바닥납니다." },

    { type: "h2", text: "3. 피상성의 문제" },
    { type: "p", text: "내향적인 사람은 대체로 가벼운 잡담을 좋아하지 않고 내용이 있는 대화를 선호합니다. 그런데 데이팅 앱의 전형적인 첫 메시지 — \"안녕하세요, 잘 지내세요?\", \"사진 좋네요\" — 는 정확히 그들이 피하고 싶은 빈 대화입니다. 그 결과 내향적인 사람은 이런 앱에서 끝내 편안해지지 못하고, 아예 먼저 말을 걸지 않게 됩니다." },

    { type: "h2", accent: "green", text: "퀴즈 데이팅이 내향적인 사람에게 이상적인 이유" },

    { type: "h2", text: "생각할 시간" },
    { type: "p", text: "스와이프 방식은 즉각적인 판단을 요구하는데, 그것은 내향적인 사람이 가장 강한 지점이 아닙니다. 반면 상대의 질문에 답하는 방식은 읽고, 생각하고, 결정할 시간을 줍니다. 질문을 꼼꼼히 읽고, 그것을 쓴 사람을 떠올리고, 답을 의식적으로 고르는 일은 내향성을 우회하는 요령이 아닙니다. 내향적인 사람의 자연스러운 소통 방식이 그대로 메커니즘이 된 것입니다." },

    { type: "h2", text: "글로 표현하는 힘" },
    { type: "p", text: "Susan Cain은 \"Quiet: The Power of Introverts in a World That Can't Stop Talking\"에서 내향적인 사람은 글에서 가장 또렷하게 자신을 표현하는 경우가 많다고 말합니다. 즉석에서 연기하는 대신 답하기 전에 생각할 수 있기 때문입니다. 게다가 내향적인 사람이 자연스럽게 하는 일 — 먼저 묻고 그다음 듣는 것 — 이야말로 사람을 끌어당긴다는 직접적인 증거도 있습니다. **Huang, Yeomans, Brooks, Minson, Gino**가 2017년 9월 Journal of Personality and Social Psychology에 발표한 논문 \"It Doesn't Hurt to Ask: Question-Asking Increases Liking\"에서는 스피드 데이팅 참가자 **110**명이 내린 두 번째 데이트 결정 **1,961**건이 분석되었고, 후속 질문을 더 많이 한 사람일수록 다시 초대받을 가능성이 높았습니다. 퀴즈 데이팅은 그 행동을 형식 안에 그대로 심어 둡니다. 당신이 묻고, 상대가 답합니다." },

    { type: "h2", text: "깊이 우선" },
    { type: "p", text: "내향적인 사람은 관계의 수는 적어도 더 깊게 맺는 경향이 있습니다. 매칭이 적게, 대신 더 숙고되어 일어나는 모델은 그 감각과 잘 맞습니다. 매칭은 누군가가 당신의 질문을 모두 풀어낸 뒤에야 이루어지므로, 모든 매칭은 스와이프가 결코 요구하지 않는 수준의 주의를 처음부터 담고 있습니다." },

    { type: "h2", text: "Qulo에서의 내향형 전략" },

    { type: "h2", text: "질문 유형" },
    { type: "p", text: "Qulo에서는 객관식 질문을 **2개에서 4개** 사이로 만들며, 유료 플랜에서는 최대 10개까지 만들 수 있습니다. 각 질문에는 네 개의 선택지가 있고, 당신에게 해당하는 답을 표시합니다. 상대는 모든 질문을 다 맞혀야만 당신과 매칭됩니다. 부분 점수는 없습니다. 내향적인 사람에게 가장 잘 맞는 질문 유형은 이렇습니다." },
    { type: "ul", items: [
      "**가치 질문:** \"내가 가장 소중히 여기는 것은?\" — 실제로 저울질하게 되는 네 개의 선택지를 두면, 찍기가 아니라 진짜 궁합에 닿습니다",
      "**상황 질문:** \"비 오는 일요일에 나의 이상적인 하루는?\" — 네 개의 선택지가 자기소개보다 당신의 삶을 더 많이 말해 줍니다",
      "**문화와 취향 질문:** \"이 중에서 내가 가장 최근에 읽은 것은?\" — 두 사람의 세계가 겹치는지 빠르게 가늠할 수 있습니다",
      "**철학적 질문:** \"나에게 성공이란 무엇일까?\" — 상대가 고른 선택지가 그 사람의 사고방식을 보여 줍니다",
    ] },

    { type: "h2", text: "속도 조절" },
    { type: "p", text: "Qulo에서는 자기 속도로 나아갑니다. 하루에 몇 개의 질문에 답할지, 몇 개의 대화를 열어 둘지는 전적으로 당신에게 달려 있습니다. 질문 풀이는 비동기로 진행되므로 여러 실시간 대화를 동시에 감당해야 할 압박이 없습니다. 막혔을 때 쓸 수 있는 선택적 능력 — 힌트, 선택지 절반 줄이기, 질문 건너뛰기 — 은 앱 내 다이아몬드를 소모하며, 매칭에 반드시 필요한 것은 하나도 없습니다." },

    { type: "h2", text: "내향형-외향형 궁합이라는 신화" },
    { type: "p", text: "대중문화는 내향형과 외향형이 \"완벽한 균형\"을 이룬다고 주장합니다. 연구가 보여 주는 그림은 더 복잡합니다. 심리학자 John Gottman의 수십 년에 걸친 관계 연구는, 두 사람을 붙들어 두는 것이 공유된 가치와 작동하는 소통, 그리고 서로에 대한 존중이라고 가리킵니다. 성격 유형의 조합이 아니라요." },
    { type: "p", text: "질문 기반 매칭은 바로 그것을 반영합니다. 질문은 성격 유형과 무관하게 가치와 사고방식의 일치를 측정합니다. 내향적인 사람은 또 다른 내향적인 사람과도, 외향적인 사람과도 완벽하게 매칭될 수 있습니다. 중요한 것은 답이 맞아떨어지느냐이지, 양쪽에 어떤 유형이 있느냐가 아닙니다." },

    { type: "h2", text: "Susan Cain의 \"Quiet\"에서 얻는 통찰" },
    { type: "p", text: "Cain의 책은 말하기를 중심으로 세워진 문화가 놓치기 쉬운 강점들을 드러냅니다. 그에 따르면 내향적인 사람은:" },
    { type: "ul", items: [
      "더 깊이 듣고 사람을 더 가까이서 읽어 냅니다",
      "더 신중하고 더 숙고된 결정을 내립니다",
      "충실하고 오래가는 관계를 만듭니다",
      "창의적이고 어려운 문제 앞에서 가장 잘 생각합니다",
    ] },
    { type: "p", text: "이 강점들은 질문 기반 형식이 정확히 보상하는 것들입니다. 상대의 질문을 풀어 가려면 꼼꼼한 읽기, 인내심 있는 사고, 그리고 상대가 실제로 무엇을 말하려 했는지에 대한 주의가 필요합니다. 바로 내향적인 사람이 잘하는 일들입니다." },

    { type: "quote", text: "내향적인 사람이 강한 것은 조용해서가 아닙니다. 듣기 때문입니다. 퀴즈 데이팅은 듣기 위에 세워져 있습니다." },

    { type: "h2", accent: "green", text: "결론" },
    { type: "p", text: "데이팅 앱은 내향적인 사람에게 고된 일이 될 수 있습니다. 하지만 문제는 내향성이 아니라 설계입니다. 스와이프 기반 모델은 외향적인 습관을 중심으로 만들어졌고, 내향적인 사람이 잘하는 것을 조용히 지나칩니다. 질문 기반 매칭은 그것을 바로잡습니다. 생각할 시간, 쓸 수 있는 여백, 그리고 양보다 깊이. Qulo에서는 자기 속도로, 자기 질문으로, 자기 방식대로 사람을 만납니다. 가장 좋은 인연은 가장 크게 말하는 사람이 만드는 경우가 드무니까요. 가장 잘 듣는 사람이 만듭니다." },
  ],

  zh: [
    { type: "h2", text: "内向与约会应用：为什么这么难？" },
    { type: "p", text: "内向是一种相当常见的人格特质。这个由荣格提出的概念，描述的是那些从内心世界汲取能量、偏好深度思考与有意义关系的人。内向者并不是害羞、社交焦虑或讨厌别人的人——他们只是以不同的方式恢复能量。" },
    { type: "p", text: "传统约会应用在很大程度上是围绕外向者的沟通模式设计的：快速判断、浮于表面的第一印象、持续不断的互动压力。对内向的人来说，这带来的是一种格外耗神又难以满足的体验。有没有更好的路？答题式约会——通过回答对方的问题来配对，而不是评判对方的照片——回答的正是这个问题。" },

    { type: "h2", text: "内向者在约会应用上遇到的三大问题" },

    { type: "h2", text: "1. 过度刺激" },
    { type: "p", text: "人们常说，内向者比外向者对外界刺激更敏感。Marti Olsen Laney 在《The Introvert Advantage》中让一种解释广为人知：内向与外向的大脑依赖不同的神经递质通路——与深度思考和内省相关的乙酰胆碱，以及与新奇和兴奋相关的多巴胺。无论底层生物学最终是什么样子，凡是刷了一小时后感到被掏空的人，都熟悉这种体验。" },
    { type: "p", text: "基于滑动的约会应用会持续不断地送来新刺激：照片、资料、通知。对一个容易饱和的大脑来说，这意味着疲惫、决策瘫痪，最后干脆躲开这个应用。" },

    { type: "h2", text: "2. 社交耗竭" },
    { type: "p", text: "内向者在社交之后需要独处的时间来恢复。约会应用里持续不断的消息压力，恰恰打断了这种恢复。同时维持好几段对话尤其消耗：每一段新的聊天都从同一个储备里支取，久而久之，「社交电量」就彻底见底了。" },

    { type: "h2", text: "3. 浅层交流的问题" },
    { type: "p", text: "内向者往往不喜欢寒暄，更偏好有内容的对话。但约会应用上典型的开场白——「嗨，你好吗？」「照片很好看」——恰恰就是他们想避开的空洞交流。结果是，内向者在这类应用里始终感觉不自在，最后干脆不再主动开口。" },

    { type: "h2", accent: "green", text: "为什么答题式约会最适合内向者" },

    { type: "h2", text: "思考的时间" },
    { type: "p", text: "滑动这个机制要求瞬间判断，而这并不是内向者最擅长的地方。回答对方的问题则相反，它留出了阅读、思考和决定的时间。仔细读一道题、想一想写下它的人、有意识地选出答案——这不是绕开内向的技巧，而是把内向者天然的沟通方式直接变成了机制本身。" },

    { type: "h2", text: "书面表达的力量" },
    { type: "p", text: "Susan Cain 在《Quiet: The Power of Introverts in a World That Can't Stop Talking》中提出，内向者往往在书写时表达得最清晰：在那里，他们可以先想好再回答，而不必当场表演。此外还有直接证据表明，内向者天然会做的事——先提问，再倾听——正是吸引他人的关键。**Huang、Yeomans、Brooks、Minson 与 Gino** 于 2017 年 9 月发表在 Journal of Personality and Social Psychology 的论文《It Doesn't Hurt to Ask: Question-Asking Increases Liking》分析了 **110** 位快速约会参与者做出的 **1,961** 项第二次约会决定，结果发现：提出更多追问的人，更有可能被再次邀约。答题式约会把这种行为直接写进了形式里：你提问，对方作答。" },

    { type: "h2", text: "深度优先" },
    { type: "p", text: "内向者通常会建立更少但更深的关系。一个产生更少、也更经过斟酌的配对的模式，正合这种直觉。因为配对只有在对方把你的题目全部做完之后才会发生，所以每一次配对从一开始就带着滑动从不要求的那份专注。" },

    { type: "h2", text: "在 Qulo 上的内向者策略" },

    { type: "h2", text: "题目类型" },
    { type: "p", text: "在 Qulo 上，你会写 **2 到 4** 道选择题，付费方案最多 10 道。每题有四个选项，你标出符合自己的那一个。对方必须全部答对才能与你配对——没有部分得分。最适合内向者的题目类型是：" },
    { type: "ul", items: [
      "**价值观题：**「我最看重什么？」——当四个选项是你真的会互相权衡的，它触及的是真实的契合，而不是瞎猜",
      "**情景题：**「我理想中的雨天周日是什么样？」——四个选项比一段个人简介更能说明你的生活",
      "**文化与品味题：**「这几本里我最近读的是哪一本？」——快速判断你们的世界是否有交集",
      "**哲思题：**「成功对我意味着什么？」——对方选的那一项，会告诉你他怎么思考",
    ] },

    { type: "h2", text: "节奏由你掌握" },
    { type: "p", text: "在 Qulo 上，你按自己的节奏推进。一天答多少题、同时开着几段对话，完全由你决定。答题过程是异步的，所以不存在同时应付好几场实时对话的压力。如果卡住了，可选的能力——提示、把选项砍掉一半、跳过一题——需要消耗应用内的钻石，而它们没有一个是配对的必要条件。" },

    { type: "h2", text: "内向与外向互补的迷思" },
    { type: "p", text: "流行文化坚持认为内向者和外向者能构成「完美的平衡」。研究给出的图景要复杂得多。心理学家 John Gottman 数十年的亲密关系研究指向的是共同的价值观、行得通的沟通以及彼此的尊重，而不是人格类型的搭配。" },
    { type: "p", text: "基于问题的配对正反映了这一点。题目衡量的是价值观与思维方式上的一致，与人格类型无关。一个内向者可以和另一个内向者完美配对，也可以和一个外向者完美配对；重要的是答案是否对得上，而不是两边各自是什么类型。" },

    { type: "h2", text: "来自 Susan Cain《Quiet》的启发" },
    { type: "p", text: "Cain 的书揭示了一种以说话为中心的文化容易忽略的长处。在她看来，内向者：" },
    { type: "ul", items: [
      "听得更深，也更细致地读懂别人",
      "做出更谨慎、更经过考虑的决定",
      "建立忠诚而有承诺的关系",
      "在创造性和棘手的问题上思考得最好",
    ] },
    { type: "p", text: "而这些长处，恰恰是基于问题的形式所奖励的。做完别人的题目，需要仔细的阅读、有耐心的思考，以及对对方真正想表达什么的留意——也就是内向者擅长的那些事。" },

    { type: "quote", text: "内向者的力量不在于沉默，而在于倾听。答题式约会正是建立在倾听之上的。" },

    { type: "h2", accent: "green", text: "结语" },
    { type: "p", text: "约会应用对内向者来说可能很累人——但问题不在内向，而在设计。基于滑动的模式围绕外向者的习惯搭建，悄悄忽略了内向者所擅长的事。基于问题的配对把这一点纠正过来：思考的时间、书写的余地，以及深度优先于数量。在 Qulo 上，你按自己的节奏、用自己的问题、以自己的方式认识别人。因为最好的联结很少由嗓门最大的人促成——而是由最会倾听的人促成。" },
  ],

  nl: [
    { type: "h2", text: "Introversie en datingapps: waarom is het zo zwaar?" },
    { type: "p", text: "Introversie is een veelvoorkomende persoonlijkheidstrek. Het door Carl Jung gedefinieerde begrip beschrijft mensen die hun energie uit hun binnenwereld halen en die diep nadenken en betekenisvolle relaties verkiezen. Introverten zijn niet verlegen, niet sociaal angstig en houden niet minder van mensen — ze laden alleen anders op." },
    { type: "p", text: "Traditionele datingapps zijn grotendeels gebouwd rond extraverte communicatiepatronen: snelle beslissingen, oppervlakkige eerste indrukken, constante druk om te reageren. Voor wie introvert is levert dat een bijzonder uitputtende en weinig bevredigende ervaring op. Is er een betere weg? Quizdating — matchen door iemands vragen te beantwoorden in plaats van diens foto's te beoordelen — beantwoordt precies die vraag." },

    { type: "h2", text: "De 3 grote problemen van introverten op datingapps" },

    { type: "h2", text: "1. Overprikkeling" },
    { type: "p", text: "Introverten worden vaak omschreven als gevoeliger voor prikkels van buitenaf dan extraverten. In \"The Introvert Advantage\" maakte Marti Olsen Laney de lezing populair dat introverte en extraverte hersenen op verschillende neurotransmitterbanen leunen: acetylcholine, verbonden met diep nadenken en introspectie, tegenover dopamine, verbonden met nieuwheid en opwinding. Wat de onderliggende biologie uiteindelijk ook blijkt te zijn, de ervaring is herkenbaar voor iedereen die zich na een uur scrollen leeggezogen voelde." },
    { type: "p", text: "Swipe-gebaseerde apps leveren een onafgebroken stroom nieuwe prikkels: foto's, profielen, meldingen. Voor een brein dat snel vol zit betekent dat vermoeidheid, besluiteloosheid en uiteindelijk de app helemaal mijden." },

    { type: "h2", text: "2. Sociale uitputting" },
    { type: "p", text: "Introverten hebben na sociaal contact tijd alleen nodig om bij te komen. De constante berichtendruk van datingapps staat precies dat herstel in de weg. Meerdere gesprekken tegelijk voeren kost extra veel: elk nieuw gesprek put uit dezelfde reserve, en na verloop van tijd is de \"sociale batterij\" helemaal leeg." },

    { type: "h2", text: "3. Het oppervlakkigheidsprobleem" },
    { type: "p", text: "Introverten houden doorgaans niet van small talk en verkiezen gesprekken met inhoud. Maar het typische openingsbericht op een datingapp — \"Hoi, hoe gaat het?\", \"Mooie foto's\" — is precies de lege uitwisseling die ze vermijden. Het gevolg: introverten voelen zich in deze apps nooit echt thuis en beginnen op den duur helemaal geen gesprekken meer." },

    { type: "h2", accent: "green", text: "Waarom quizdating ideaal is voor introverten" },

    { type: "h2", text: "Tijd om na te denken" },
    { type: "p", text: "De swipe-mechaniek vraagt om een onmiddellijk oordeel, en daar liggen de sterke punten van introverten niet. Iemands vragen beantwoorden geeft juist tijd om te lezen, te denken en te beslissen. Een vraag aandachtig lezen, denken aan de persoon die hem schreef en je antwoord bewust kiezen is geen omweg om introversie heen — het is de natuurlijke communicatiestijl van introverten, rechtstreeks tot mechaniek gemaakt." },

    { type: "h2", text: "De kracht van schriftelijke expressie" },
    { type: "p", text: "Susan Cain betoogt in \"Quiet: The Power of Introverts in a World That Can't Stop Talking\" dat introverten zich vaak het scherpst uitdrukken op papier: daar kunnen ze nadenken vóór ze antwoorden in plaats van ter plekke te presteren. Er is bovendien direct bewijs dat juist wat introverten van nature doen — eerst vragen, dan luisteren — mensen aantrekt. In de studie \"It Doesn't Hurt to Ask: Question-Asking Increases Liking\", die **Huang, Yeomans, Brooks, Minson en Gino** in september 2017 publiceerden in het Journal of Personality and Social Psychology, werden **1.961** beslissingen over een tweede date van **110** speeddaters geanalyseerd: wie meer vervolgvragen stelde, werd vaker opnieuw gevraagd. Quizdating bouwt dat gedrag in het format in: jij vraagt, de ander antwoordt." },

    { type: "h2", text: "Diepte boven aantal" },
    { type: "p", text: "Introverten bouwen doorgaans minder maar diepere relaties op. Een model dat minder en beter doordachte matches oplevert, sluit aan bij dat instinct. Omdat een match pas ontstaat nadat iemand al je vragen heeft doorgewerkt, draagt elke match van meet af aan een aandacht in zich die een swipe nooit vraagt." },

    { type: "h2", text: "Strategieën voor introverten op Qulo" },

    { type: "h2", text: "Soorten vragen" },
    { type: "p", text: "Op Qulo schrijf je tussen de **2 en 4** meerkeuzevragen, en tot 10 met een betaald abonnement. Elke vraag heeft vier opties, en jij markeert het antwoord dat op jou van toepassing is. Iemand matcht alleen met je door ze werkelijk allemaal goed te hebben — deelpunten bestaan niet. De vraagsoorten die voor introverten het beste werken:" },
    { type: "ul", items: [
      "**Waardenvragen:** \"Wat vind ik het belangrijkst?\" — met vier opties die je echt tegen elkaar zou afwegen bereik je echte compatibiliteit in plaats van gokwerk",
      "**Scenariovragen:** \"Hoe ziet mijn ideale regenachtige zondag eruit?\" — de vier opties zeggen meer over je leven dan een bio",
      "**Cultuur- en smaakvragen:** \"Welke hiervan heb ik als laatste gelezen?\" — een snelle peiling of jullie werelden elkaar overlappen",
      "**Filosofische vragen:** \"Wat betekent succes voor mij?\" — de gekozen optie verraadt hoe iemand denkt",
    ] },

    { type: "h2", text: "Tempo in eigen hand" },
    { type: "p", text: "Op Qulo ga je in je eigen tempo. Hoeveel vragen je op een dag beantwoordt en hoeveel gesprekken je openhoudt, bepaal jij helemaal zelf. Vragen oplossen gaat asynchroon, dus er is geen druk om meerdere live gesprekken tegelijk te voeren. Loop je vast, dan kosten de optionele krachten — een hint, de opties halveren, een vraag overslaan — diamanten in de app, en geen ervan is nodig om te matchen." },

    { type: "h2", text: "De mythe van de introvert-extravert-match" },
    { type: "p", text: "De populaire cultuur houdt vol dat introverten en extraverten een \"perfecte balans\" vormen. Het onderzoeksbeeld is genuanceerder. Decennia aan relatieonderzoek van psycholoog John Gottman wijzen op gedeelde waarden, communicatie die werkt en wederzijds respect als wat een stel bij elkaar houdt — niet op de combinatie van persoonlijkheidstypen." },
    { type: "p", text: "Matchen op basis van vragen weerspiegelt dat. Vragen meten overeenstemming over waarden en manieren van denken, los van het persoonlijkheidstype. Een introvert kan perfect matchen met een andere introvert of met een extravert; wat telt is of de antwoorden kloppen, niet welk type aan welke kant staat." },

    { type: "h2", text: "Inzichten uit \"Quiet\" van Susan Cain" },
    { type: "p", text: "Cains boek legt de sterke punten bloot die een cultuur die om praten draait geneigd is over het hoofd te zien. Volgens haar doen introverten het volgende:" },
    { type: "ul", items: [
      "Ze luisteren dieper en lezen mensen nauwkeuriger",
      "Ze nemen zorgvuldiger en beter doordachte beslissingen",
      "Ze bouwen loyale, toegewijde relaties op",
      "Ze denken het scherpst over creatieve en lastige problemen",
    ] },
    { type: "p", text: "Precies die sterke punten worden beloond door een format dat op vragen draait. Je door iemands vragen heen werken vraagt om aandachtig lezen, geduldig denken en oog voor wat de ander werkelijk bedoelde — de dingen waar introverten goed in zijn." },

    { type: "quote", text: "Introverten zijn niet krachtig omdat ze stil zijn. Ze zijn krachtig omdat ze luisteren. Quizdating is gebouwd op luisteren." },

    { type: "h2", accent: "green", text: "Conclusie" },
    { type: "p", text: "Datingapps kunnen zwaar werk zijn voor introverten — maar het probleem is niet de introversie, het is het ontwerp. Swipe-gebaseerde modellen zijn gebouwd rond extraverte gewoonten en gaan stilzwijgend voorbij aan waar introverten goed in zijn. Matchen op vragen zet dat recht: tijd om na te denken, ruimte om te schrijven, en diepte boven volume. Op Qulo ontmoet je mensen in je eigen tempo, met je eigen vragen en in je eigen stijl. Want de beste verbindingen komen zelden van wie het hardst praat — ze komen van wie het beste luistert." },
  ],

  pl: [
    { type: "h2", text: "Introwersja i aplikacje randkowe: dlaczego to takie trudne?" },
    { type: "p", text: "Introwersja to bardzo powszechna cecha osobowości. Pojęcie zdefiniowane przez Carla Junga opisuje osoby, które czerpią energię ze swojego wewnętrznego świata i przedkładają głębokie myślenie oraz sensowne relacje nad resztę. Introwertycy nie są nieśmiali, nie cierpią na lęk społeczny i nie mają dosyć ludzi — po prostu regenerują się inaczej." },
    { type: "p", text: "Tradycyjne aplikacje randkowe są w dużej mierze zaprojektowane wokół ekstrawertycznych wzorców komunikacji: szybkie decyzje, powierzchowne pierwsze wrażenie, nieustanna presja interakcji. Dla osoby introwertycznej daje to doświadczenie wyjątkowo męczące i mało satysfakcjonujące. Czy istnieje lepsza droga? Randkowanie przez pytania — dopasowanie przez odpowiadanie na czyjeś pytania zamiast oceniania zdjęć — odpowiada dokładnie na to." },

    { type: "h2", text: "3 największe problemy introwertyków w aplikacjach randkowych" },

    { type: "h2", text: "1. Przebodźcowanie" },
    { type: "p", text: "Introwertyków opisuje się często jako bardziej wrażliwych na bodźce z zewnątrz niż ekstrawertyków. W książce \"The Introvert Advantage\" Marti Olsen Laney spopularyzowała wykładnię, według której mózgi introwertyczne i ekstrawertyczne opierają się na innych szlakach neuroprzekaźników: acetylocholinie, kojarzonej z głębokim myśleniem i introspekcją, oraz dopaminie, kojarzonej z nowością i pobudzeniem. Jakkolwiek ostatecznie wygląda biologia u podstaw, samo doświadczenie zna każdy, kto po godzinie przewijania czuł się wyżęty." },
    { type: "p", text: "Aplikacje oparte na przesuwaniu dostarczają nieprzerwany strumień nowych bodźców: zdjęcia, profile, powiadomienia. Dla mózgu, który szybko się przepełnia, oznacza to zmęczenie, paraliż decyzyjny, a w końcu omijanie aplikacji szerokim łukiem." },

    { type: "h2", text: "2. Wyczerpanie społeczne" },
    { type: "p", text: "Po kontaktach z ludźmi introwertycy potrzebują czasu sam na sam ze sobą, żeby się zregenerować. Nieustanna presja pisania w aplikacjach randkowych przeszkadza właśnie w tej regeneracji. Prowadzenie kilku rozmów naraz kosztuje szczególnie dużo: każda nowa czerpie z tego samego zapasu, aż z czasem \"bateria społeczna\" wysiada zupełnie." },

    { type: "h2", text: "3. Problem powierzchowności" },
    { type: "p", text: "Introwertycy zwykle nie przepadają za rozmową o niczym i wolą wymianę zdań z treścią. Tymczasem typowa pierwsza wiadomość w aplikacji randkowej — \"Cześć, co słychać?\", \"Ładne zdjęcia\" — to dokładnie ta pusta wymiana, której unikają. W efekcie introwertycy nigdy nie czują się w takich aplikacjach u siebie i przestają w ogóle zaczynać rozmowy." },

    { type: "h2", accent: "green", text: "Dlaczego randkowanie przez pytania jest idealne dla introwertyków" },

    { type: "h2", text: "Czas do namysłu" },
    { type: "p", text: "Mechanika przesuwania wymaga natychmiastowego osądu, a to nie jest najmocniejsza strona introwertyków. Odpowiadanie na czyjeś pytania daje za to czas, by przeczytać, przemyśleć i zdecydować. Uważne przeczytanie pytania, pomyślenie o osobie, która je napisała, i świadomy wybór odpowiedzi to nie obejście introwersji — to naturalny styl komunikacji introwertyka zamieniony wprost w mechanikę." },

    { type: "h2", text: "Siła wyrazu na piśmie" },
    { type: "p", text: "Susan Cain w książce \"Quiet: The Power of Introverts in a World That Can't Stop Talking\" przekonuje, że introwertycy najcelniej wyrażają się na piśmie: mogą tam pomyśleć przed odpowiedzią, zamiast występować na żywo. Istnieje też bezpośredni dowód na to, że właśnie to, co introwertycy robią naturalnie — najpierw pytają, potem słuchają — przyciąga ludzi. W badaniu \"It Doesn't Hurt to Ask: Question-Asking Increases Liking\", opublikowanym przez **Huang, Yeomansa, Brooks, Minson i Gino** we wrześniu 2017 roku w Journal of Personality and Social Psychology, przeanalizowano **1961** decyzji o drugiej randce podjętych przez **110** uczestników speed datingu: ci, którzy zadawali więcej pytań pogłębiających, częściej byli zapraszani ponownie. Randkowanie przez pytania wbudowuje to zachowanie w sam format: ty pytasz, druga osoba odpowiada." },

    { type: "h2", text: "Głębia przed ilością" },
    { type: "p", text: "Introwertycy budują zwykle mniej relacji, ale głębszych. Model, który daje mniej i lepiej przemyślanych dopasowań, odpowiada temu instynktowi. Ponieważ dopasowanie następuje dopiero wtedy, gdy ktoś przejdzie przez wszystkie twoje pytania, każde niesie ze sobą od początku uwagę, o jaką przesunięcie palcem nigdy nie prosi." },

    { type: "h2", text: "Strategie dla introwertyków w Qulo" },

    { type: "h2", text: "Rodzaje pytań" },
    { type: "p", text: "W Qulo układasz od **2 do 4** pytań wielokrotnego wyboru, a w planie płatnym nawet do 10. Każde ma cztery opcje, a ty zaznaczasz tę prawdziwą o tobie. Ktoś dopasuje się do ciebie wyłącznie wtedy, gdy trafi absolutnie wszystkie — nie ma punktów częściowych. Rodzaje pytań, które sprawdzają się u introwertyków najlepiej:" },
    { type: "ul", items: [
      "**Pytania o wartości:** \"Co cenię najbardziej?\" — przy czterech opcjach, które naprawdę ważyłbyś między sobą, dociera się do prawdziwego dopasowania, a nie do zgadywanki",
      "**Pytania scenariuszowe:** \"Jak wygląda moja idealna deszczowa niedziela?\" — cztery opcje mówią o twoim życiu więcej niż opis profilu",
      "**Pytania o kulturę i gust:** \"Którą z tych rzeczy przeczytałem ostatnio?\" — szybkie sprawdzenie, czy wasze światy się przecinają",
      "**Pytania filozoficzne:** \"Co dla mnie znaczy sukces?\" — wybrana opcja pokazuje, jak ktoś myśli",
    ] },

    { type: "h2", text: "Kontrola tempa" },
    { type: "p", text: "W Qulo idziesz we własnym tempie. To, ile pytań rozwiążesz dziennie i ile rozmów utrzymasz otwartych, zależy wyłącznie od ciebie. Rozwiązywanie pytań jest asynchroniczne, więc nie ma presji prowadzenia kilku rozmów na żywo naraz. Jeśli utkniesz, opcjonalne moce — podpowiedź, zmniejszenie liczby opcji o połowę, pominięcie pytania — kosztują diamenty w aplikacji i żadna z nich nie jest potrzebna do dopasowania." },

    { type: "h2", text: "Mit dopasowania introwertyk-ekstrawertyk" },
    { type: "p", text: "Kultura popularna upiera się, że introwertycy i ekstrawertycy tworzą \"idealną równowagę\". Obraz z badań jest bardziej złożony. Dziesięciolecia badań nad związkami prowadzonych przez psychologa Johna Gottmana wskazują na wspólne wartości, działającą komunikację i wzajemny szacunek jako to, co trzyma parę razem — a nie na zestawienie typów osobowości." },
    { type: "p", text: "Dopasowanie przez pytania właśnie to odzwierciedla. Pytania mierzą zgodność wartości i sposobów myślenia niezależnie od typu osobowości. Introwertyk może idealnie dopasować się i do innego introwertyka, i do ekstrawertyka; liczy się to, czy odpowiedzi się schodzą, a nie jaki typ stoi po której stronie." },

    { type: "h2", text: "Wnioski z \"Quiet\" Susan Cain" },
    { type: "p", text: "Książka Cain pokazuje mocne strony, które kultura zbudowana wokół mówienia zwykle przeocza. Jej zdaniem introwertycy:" },
    { type: "ul", items: [
      "Słuchają głębiej i uważniej czytają ludzi",
      "Podejmują ostrożniejsze, lepiej przemyślane decyzje",
      "Budują lojalne, zaangażowane relacje",
      "Najlepiej myślą nad problemami twórczymi i trudnymi",
    ] },
    { type: "p", text: "Dokładnie te mocne strony nagradza format oparty na pytaniach. Przejście przez czyjeś pytania wymaga uważnego czytania, cierpliwego myślenia i wyczucia, co druga osoba naprawdę miała na myśli — czyli tego, w czym introwertycy są dobrzy." },

    { type: "quote", text: "Introwertycy nie są silni dlatego, że milczą. Są silni dlatego, że słuchają. Randkowanie przez pytania jest zbudowane na słuchaniu." },

    { type: "h2", accent: "green", text: "Podsumowanie" },
    { type: "p", text: "Aplikacje randkowe potrafią być dla introwertyków ciężką pracą — ale problemem nie jest introwersja, tylko projekt. Modele oparte na przesuwaniu zbudowano wokół ekstrawertycznych nawyków i po cichu pomijają to, w czym introwertycy są dobrzy. Dopasowanie przez pytania to prostuje: czas do namysłu, miejsce na pisanie i głębia przed ilością. W Qulo poznajesz ludzi we własnym tempie, przez własne pytania i we własnym stylu. Bo najlepsze więzi rzadko tworzy ten, kto mówi najgłośniej — tworzy je ten, kto najlepiej słucha." },
  ],

  sv: [
    { type: "h2", text: "Introversion och dejtingappar: varför är det så svårt?" },
    { type: "p", text: "Introversion är ett mycket vanligt personlighetsdrag. Begreppet, som definierades av Carl Jung, beskriver människor som hämtar sin energi ur sin inre värld och som föredrar djupt tänkande och meningsfulla relationer. Introverta är varken blyga, socialt ängsliga eller människotrötta — de laddar bara om på ett annat sätt." },
    { type: "p", text: "Traditionella dejtingappar är till stor del byggda kring extroverta kommunikationsmönster: snabba beslut, ytliga första intryck, ständig press att interagera. För den som är introvert blir det en särskilt utmattande och otillfredsställande upplevelse. Finns det en bättre väg? Quizdejting — att matcha genom att svara på någons frågor i stället för att bedöma personens bilder — svarar på precis det." },

    { type: "h2", text: "3 stora problem introverta möter på dejtingappar" },

    { type: "h2", text: "1. Överstimulering" },
    { type: "p", text: "Introverta beskrivs ofta som känsligare för yttre intryck än extroverta. I \"The Introvert Advantage\" gjorde Marti Olsen Laney tolkningen populär att introverta och extroverta hjärnor lutar sig mot olika signalsubstansbanor: acetylkolin, förknippat med djupt tänkande och självreflektion, mot dopamin, förknippat med nyhet och spänning. Vad den underliggande biologin än visar sig vara känner var och en som känt sig urvriden efter en timmes scrollande igen upplevelsen." },
    { type: "p", text: "Swipebaserade appar levererar en oavbruten ström av nya intryck: bilder, profiler, notiser. För en hjärna som snabbt blir mättad betyder det trötthet, beslutsförlamning och till slut att man undviker appen helt." },

    { type: "h2", text: "2. Social utmattning" },
    { type: "p", text: "Introverta behöver tid för sig själva efter socialt umgänge för att återhämta sig. Den ständiga meddelandepressen i dejtingappar stör just den återhämtningen. Att hålla flera samtal igång samtidigt tär extra mycket: varje ny tråd tar ur samma förråd, och med tiden är det \"sociala batteriet\" helt tomt." },

    { type: "h2", text: "3. Ytlighetsproblemet" },
    { type: "p", text: "Introverta brukar ogilla kallprat och föredra samtal med innehåll. Men det typiska öppningsmeddelandet i en dejtingapp — \"Hej, hur mår du?\", \"Fina bilder\" — är precis det tomma utbyte de undviker. Följden blir att introverta aldrig riktigt känner sig hemma i sådana appar och till slut slutar inleda samtal över huvud taget." },

    { type: "h2", accent: "green", text: "Varför quizdejting är idealiskt för introverta" },

    { type: "h2", text: "Tid att tänka" },
    { type: "p", text: "Swipemekaniken kräver ett omedelbart omdöme, och där ligger inte de introvertas styrka. Att svara på någons frågor ger i stället tid att läsa, tänka och bestämma sig. Att läsa en fråga noga, tänka på personen som skrev den och välja sitt svar medvetet är ingen omväg runt introversionen — det är den introvertas naturliga kommunikationsstil, förvandlad till själva mekaniken." },

    { type: "h2", text: "Kraften i det skrivna" },
    { type: "p", text: "Susan Cain menar i \"Quiet: The Power of Introverts in a World That Can't Stop Talking\" att introverta ofta uttrycker sig som tydligast i skrift: där hinner de tänka innan de svarar i stället för att prestera på stående fot. Det finns dessutom direkta belägg för att just det introverta gör naturligt — frågar först och lyssnar sedan — är det som drar människor till sig. I studien \"It Doesn't Hurt to Ask: Question-Asking Increases Liking\", publicerad av **Huang, Yeomans, Brooks, Minson och Gino** i Journal of Personality and Social Psychology i september 2017, analyserades **1 961** beslut om en andra dejt fattade av **110** snabbdejtare: de som ställde fler följdfrågor blev oftare tillfrågade igen. Quizdejting bygger in det beteendet i själva formatet: du frågar, den andra svarar." },

    { type: "h2", text: "Djup före mängd" },
    { type: "p", text: "Introverta bygger oftast färre men djupare relationer. En modell som ger färre och mer genomtänkta matchningar ligger nära det instinkten säger. Eftersom en matchning uppstår först när någon tagit sig igenom alla dina frågor bär varje matchning från början en uppmärksamhet som en swipe aldrig ber om." },

    { type: "h2", text: "Strategier för introverta på Qulo" },

    { type: "h2", text: "Frågetyper" },
    { type: "p", text: "På Qulo skriver du mellan **2 och 4** flervalsfrågor, och upp till 10 med ett betalt abonnemang. Varje fråga har fyra alternativ, och du markerar det som stämmer på dig. Någon matchar med dig bara genom att ha rätt på precis alla — det finns inga delpoäng. De frågetyper som fungerar bäst för introverta:" },
    { type: "ul", items: [
      "**Värderingsfrågor:** \"Vad värdesätter jag mest?\" — med fyra alternativ du faktiskt skulle väga mot varandra når du verklig samstämmighet i stället för gissningar",
      "**Scenariofrågor:** \"Hur ser min ideala regniga söndag ut?\" — de fyra alternativen säger mer om ditt liv än en presentationstext",
      "**Kultur- och smakfrågor:** \"Vilken av de här läste jag senast?\" — en snabb avläsning av om era världar överlappar",
      "**Filosofiska frågor:** \"Vad betyder framgång för mig?\" — alternativet någon väljer visar hur den personen tänker",
    ] },

    { type: "h2", text: "Kontroll över tempot" },
    { type: "p", text: "På Qulo går du fram i din egen takt. Hur många frågor du svarar på om dagen och hur många samtal du håller öppna avgör bara du. Att lösa frågor sker asynkront, så det finns ingen press att hålla flera samtal levande samtidigt. Om du kör fast kostar de valfria krafterna — en ledtråd, att halvera alternativen, att hoppa över en fråga — diamanter i appen, och ingen av dem behövs för att matcha." },

    { type: "h2", text: "Myten om att introvert och extrovert passar ihop" },
    { type: "p", text: "Populärkulturen håller fast vid att introverta och extroverta bildar en \"perfekt balans\". Forskningsbilden är mer nyanserad. Decennier av relationsforskning från psykologen John Gottman pekar på gemensamma värderingar, kommunikation som fungerar och ömsesidig respekt som det som håller ihop ett par — inte på kombinationen av personlighetstyper." },
    { type: "p", text: "Matchning genom frågor speglar just det. Frågor mäter samstämmighet i värderingar och sätt att tänka, oberoende av personlighetstyp. En introvert kan matcha perfekt med en annan introvert eller med en extrovert; det som avgör är om svaren går ihop, inte vilken typ som står på vardera sidan." },

    { type: "h2", text: "Insikter från Susan Cains \"Quiet\"" },
    { type: "p", text: "Cains bok lyfter fram de styrkor som en kultur byggd kring prat tenderar att förbise. Enligt henne gör introverta följande:" },
    { type: "ul", items: [
      "De lyssnar djupare och läser människor närmare",
      "De fattar mer omsorgsfulla och genomtänkta beslut",
      "De bygger lojala och hängivna relationer",
      "De tänker som bäst kring kreativa och svåra problem",
    ] },
    { type: "p", text: "Det är precis de styrkorna som ett frågebaserat format belönar. Att arbeta sig igenom någons frågor kräver noggrann läsning, tålmodigt tänkande och uppmärksamhet på vad den andra faktiskt menade — alltså det introverta är bra på." },

    { type: "quote", text: "Introverta är inte starka för att de är tysta. De är starka för att de lyssnar. Quizdejting är byggd på lyssnandet." },

    { type: "h2", accent: "green", text: "Slutsats" },
    { type: "p", text: "Dejtingappar kan vara hårt arbete för introverta — men problemet är inte introversionen, utan designen. Swipebaserade modeller är byggda kring extroverta vanor och förbigår tyst det introverta är bra på. Frågebaserad matchning rättar till det: tid att tänka, plats att skriva och djup före volym. På Qulo möter du människor i din egen takt, genom dina egna frågor och i din egen stil. För de bästa kontakterna skapas sällan av den som talar högst — de skapas av den som lyssnar bäst." },
  ],

  hi: [
    { type: "h2", text: "अंतर्मुखता और डेटिंग ऐप्स: यह इतना मुश्किल क्यों लगता है?" },
    { type: "p", text: "अंतर्मुखता एक बेहद आम व्यक्तित्व विशेषता है। कार्ल युंग द्वारा परिभाषित यह अवधारणा उन लोगों का वर्णन करती है जो अपनी ऊर्जा अपनी भीतरी दुनिया से लेते हैं और गहरे सोच-विचार तथा अर्थपूर्ण रिश्तों को तरजीह देते हैं। अंतर्मुखी लोग न शर्मीले होते हैं, न सामाजिक चिंता से जूझते हैं, न ही उन्हें लोगों से चिढ़ होती है — वे बस अलग तरीके से ऊर्जा वापस पाते हैं।" },
    { type: "p", text: "पारंपरिक डेटिंग ऐप्स काफी हद तक बहिर्मुखी संवाद के ढाँचे पर बने हैं: तेज़ फैसले, सतही पहली छाप, और लगातार जुड़े रहने का दबाव। अंतर्मुखी व्यक्ति के लिए यह खासतौर पर थका देने वाला और असंतोषजनक अनुभव बन जाता है। तो क्या कोई बेहतर रास्ता है? क्विज़ डेटिंग — किसी की तस्वीरों पर राय बनाने के बजाय उसके सवालों के जवाब देकर मैच होना — ठीक इसी सवाल का जवाब है।" },

    { type: "h2", text: "डेटिंग ऐप्स पर अंतर्मुखी लोगों की 3 बड़ी दिक्कतें" },

    { type: "h2", text: "1. अत्यधिक उत्तेजना" },
    { type: "p", text: "अंतर्मुखी लोगों को अक्सर बहिर्मुखी लोगों की तुलना में बाहरी उद्दीपन के प्रति ज़्यादा संवेदनशील बताया जाता है। Marti Olsen Laney ने अपनी किताब \"The Introvert Advantage\" में यह व्याख्या लोकप्रिय की कि अंतर्मुखी और बहिर्मुखी दिमाग अलग-अलग न्यूरोट्रांसमीटर रास्तों पर टिके होते हैं: गहरी सोच और आत्मचिंतन से जुड़ा एसिटाइलकोलीन, और नएपन तथा उत्तेजना से जुड़ा डोपामीन। भीतर की जीवविज्ञान आखिरकार जो भी निकले, यह अनुभव उस हर व्यक्ति को जाना-पहचाना लगेगा जिसने एक घंटे स्क्रॉल करने के बाद खुद को निचुड़ा हुआ महसूस किया हो।" },
    { type: "p", text: "स्वाइप पर टिके डेटिंग ऐप्स लगातार नए उद्दीपन भेजते रहते हैं: तस्वीरें, प्रोफाइल, नोटिफिकेशन। जो दिमाग जल्दी भर जाता है, उसके लिए इसका मतलब है थकान, फैसला न ले पाना, और आखिरकार ऐप से ही दूरी बना लेना।" },

    { type: "h2", text: "2. सामाजिक थकावट" },
    { type: "p", text: "मेलजोल के बाद अंतर्मुखी लोगों को उबरने के लिए अकेले वक्त की ज़रूरत होती है। डेटिंग ऐप्स का लगातार मैसेज करने का दबाव ठीक इसी उबरने में अड़चन डालता है। एक साथ कई बातचीत चलाना खास तौर पर खर्चीला है: हर नई बातचीत उसी जमा पूँजी से खींचती है, और समय के साथ \"सामाजिक बैटरी\" पूरी तरह खाली हो जाती है।" },

    { type: "h2", text: "3. सतहीपन की समस्या" },
    { type: "p", text: "अंतर्मुखी लोगों को आम तौर पर हल्की-फुल्की बातचीत पसंद नहीं आती; वे ऐसी बातचीत चाहते हैं जिसमें कुछ हो। लेकिन डेटिंग ऐप पर सामान्य शुरुआती संदेश — \"हाय, कैसे हो?\", \"तस्वीरें अच्छी हैं\" — ठीक वही खोखला आदान-प्रदान है जिससे वे बचते हैं। नतीजा यह कि अंतर्मुखी लोग इन ऐप्स में कभी सहज महसूस नहीं करते और बातचीत शुरू करना ही छोड़ देते हैं।" },

    { type: "h2", accent: "green", text: "क्विज़ डेटिंग अंतर्मुखी लोगों के लिए आदर्श क्यों है" },

    { type: "h2", text: "सोचने का समय" },
    { type: "p", text: "स्वाइप की बनावट तत्काल फैसला माँगती है, और यही अंतर्मुखी लोगों की सबसे मजबूत जगह नहीं है। इसके उलट, किसी के सवालों का जवाब देने में पढ़ने, सोचने और तय करने का समय मिलता है। सवाल को ध्यान से पढ़ना, उसे लिखने वाले के बारे में सोचना और सोच-समझकर जवाब चुनना अंतर्मुखता से बचने का कोई रास्ता नहीं है — यह अंतर्मुखी व्यक्ति की स्वाभाविक संवाद शैली है, जिसे सीधे तंत्र में बदल दिया गया है।" },

    { type: "h2", text: "लिखकर कहने की ताकत" },
    { type: "p", text: "Susan Cain अपनी किताब \"Quiet: The Power of Introverts in a World That Can't Stop Talking\" में तर्क देती हैं कि अंतर्मुखी लोग अक्सर लिखते हुए ही सबसे साफ़ ढंग से खुद को व्यक्त कर पाते हैं: वहाँ वे मौके पर प्रदर्शन करने के बजाय जवाब देने से पहले सोच सकते हैं। इसके अलावा इस बात के सीधे प्रमाण भी हैं कि अंतर्मुखी लोग स्वाभाविक रूप से जो करते हैं — पहले पूछना, फिर सुनना — वही लोगों को अपनी ओर खींचता है। **Huang, Yeomans, Brooks, Minson और Gino** द्वारा सितंबर 2017 में Journal of Personality and Social Psychology में प्रकाशित अध्ययन \"It Doesn't Hurt to Ask: Question-Asking Increases Liking\" में **110** स्पीड-डेटिंग प्रतिभागियों के लिए गए **1,961** दूसरी डेट संबंधी फैसलों का विश्लेषण हुआ: जिन लोगों ने ज़्यादा आगे बढ़ाने वाले सवाल पूछे, उन्हें दोबारा बुलाए जाने की संभावना ज़्यादा थी। क्विज़ डेटिंग इसी व्यवहार को प्रारूप के भीतर बिठा देती है: आप पूछते हैं, सामने वाला जवाब देता है।" },

    { type: "h2", text: "गहराई को प्राथमिकता" },
    { type: "p", text: "अंतर्मुखी लोग आम तौर पर कम, पर ज़्यादा गहरे रिश्ते बनाते हैं। ऐसा तंत्र जो कम लेकिन ज़्यादा सोचे-समझे मैच देता है, इसी प्रवृत्ति से मेल खाता है। चूँकि मैच तभी होता है जब कोई आपके सारे सवाल हल कर ले, इसलिए हर मैच शुरुआत से ही वह ध्यान साथ लाता है जो एक स्वाइप कभी नहीं माँगता।" },

    { type: "h2", text: "Qulo पर अंतर्मुखी रणनीतियाँ" },

    { type: "h2", text: "सवालों के प्रकार" },
    { type: "p", text: "Qulo पर आप **2 से 4** बहुविकल्पीय सवाल लिखते हैं — भुगतान वाली योजना में 10 तक। हर सवाल में चार विकल्प होते हैं, और आप वही चिह्नित करते हैं जो आप पर सच बैठता है। कोई आपसे तभी मैच होता है जब वह हर एक सवाल सही करे — आंशिक अंक जैसा कुछ नहीं है। अंतर्मुखी लोगों के लिए सबसे कारगर सवालों के प्रकार:" },
    { type: "ul", items: [
      "**मूल्यों के सवाल:** \"मैं सबसे ज़्यादा किसे अहमियत देता हूँ?\" — ऐसे चार विकल्प जिन्हें आप सचमुच आपस में तौलेंगे, अटकल के बजाय असली मेल तक पहुँचाते हैं",
      "**परिस्थिति के सवाल:** \"मेरा आदर्श बरसाती रविवार कैसा होता है?\" — चार विकल्प आपकी ज़िंदगी के बारे में किसी परिचय से ज़्यादा कहते हैं",
      "**संस्कृति और रुचि के सवाल:** \"इनमें से आखिरी बार मैंने क्या पढ़ा?\" — इससे झट पता चलता है कि आपकी दुनियाएँ कहीं मिलती हैं या नहीं",
      "**दार्शनिक सवाल:** \"मेरे लिए सफलता का क्या मतलब है?\" — सामने वाला जो विकल्प चुनता है, वह उसकी सोच बता देता है",
    ] },

    { type: "h2", text: "रफ़्तार आपके हाथ में" },
    { type: "p", text: "Qulo पर आप अपनी रफ़्तार से चलते हैं। दिन में कितने सवाल हल करने हैं और कितनी बातचीत खुली रखनी हैं, यह पूरी तरह आप पर है। सवाल हल करना असिंक्रोनस है, इसलिए एक साथ कई लाइव बातचीत सँभालने का दबाव नहीं रहता। अगर आप अटक जाएँ, तो वैकल्पिक शक्तियाँ — संकेत, विकल्पों को आधा कर देना, सवाल छोड़ देना — ऐप के भीतर हीरे खर्च कराती हैं, और मैच होने के लिए इनमें से कोई भी ज़रूरी नहीं है।" },

    { type: "h2", text: "अंतर्मुखी-बहिर्मुखी अनुकूलता का मिथक" },
    { type: "p", text: "लोकप्रिय संस्कृति ज़ोर देती है कि अंतर्मुखी और बहिर्मुखी मिलकर एक \"आदर्श संतुलन\" बनाते हैं। शोध की तस्वीर कहीं ज़्यादा बारीक है। मनोवैज्ञानिक John Gottman के दशकों लंबे रिश्तों संबंधी शोध साझा मूल्यों, कारगर संवाद और परस्पर सम्मान की ओर इशारा करते हैं — न कि व्यक्तित्व के प्रकारों की जोड़ी की ओर।" },
    { type: "p", text: "सवालों पर आधारित मैचिंग यही दर्शाती है। सवाल व्यक्तित्व के प्रकार से स्वतंत्र होकर मूल्यों और सोचने के तरीकों की सहमति नापते हैं। एक अंतर्मुखी व्यक्ति दूसरे अंतर्मुखी के साथ भी पूरी तरह मैच हो सकता है और बहिर्मुखी के साथ भी; मायने यह रखता है कि जवाब मिलते हैं या नहीं, यह नहीं कि किस तरफ कौन-सा प्रकार है।" },

    { type: "h2", text: "Susan Cain की \"Quiet\" से मिली सीख" },
    { type: "p", text: "कैन की किताब उन ताकतों को सामने लाती है जिन्हें बोलने के इर्द-गिर्द बनी संस्कृति अनदेखा कर देती है। उनके मुताबिक अंतर्मुखी लोग:" },
    { type: "ul", items: [
      "ज़्यादा गहराई से सुनते हैं और लोगों को बारीकी से पढ़ते हैं",
      "ज़्यादा सावधान और सोचे-समझे फैसले लेते हैं",
      "वफ़ादार और प्रतिबद्ध रिश्ते बनाते हैं",
      "रचनात्मक और कठिन समस्याओं पर सबसे अच्छा सोचते हैं",
    ] },
    { type: "p", text: "सवालों पर टिका प्रारूप ठीक इन्हीं ताकतों को पुरस्कृत करता है। किसी के सवालों से गुज़रने के लिए ध्यान से पढ़ना, धैर्य से सोचना और यह समझना ज़रूरी है कि सामने वाला असल में क्या कहना चाहता था — यानी वही सब जिसमें अंतर्मुखी लोग अच्छे होते हैं।" },

    { type: "quote", text: "अंतर्मुखी लोग इसलिए मजबूत नहीं हैं कि वे चुप रहते हैं। वे इसलिए मजबूत हैं कि वे सुनते हैं। क्विज़ डेटिंग सुनने की नींव पर खड़ी है।" },

    { type: "h2", accent: "green", text: "निष्कर्ष" },
    { type: "p", text: "डेटिंग ऐप्स अंतर्मुखी लोगों के लिए मेहनत भरा काम हो सकते हैं — पर दिक्कत अंतर्मुखता में नहीं, बनावट में है। स्वाइप पर टिके ढाँचे बहिर्मुखी आदतों के इर्द-गिर्द बने हैं और चुपचाप उसी को नज़रअंदाज़ करते हैं जिसमें अंतर्मुखी लोग अच्छे हैं। सवालों पर आधारित मैचिंग इसे ठीक करती है: सोचने का समय, लिखने की जगह, और मात्रा से पहले गहराई। Qulo पर आप अपनी रफ़्तार से, अपने सवालों के साथ और अपने अंदाज़ में लोगों से मिलते हैं। क्योंकि सबसे अच्छे रिश्ते शायद ही सबसे ऊँची आवाज़ वाले बनाते हैं — उन्हें वही बनाते हैं जो सबसे अच्छा सुनते हैं।" },
  ],
};
