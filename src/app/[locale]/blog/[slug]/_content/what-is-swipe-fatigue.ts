import type { LocalizedArticle } from "@/components/blog/ArticleBlocks";

/**
 * "What is Swipe Fatigue" — migrated from inline per-locale JSX.
 * Canonical source: `en`; every one of the 16 locales is a full translation, so
 * no locale falls back to English any more (the legacy component served the
 * English body under 14 locales whose `hreflang` promised otherwise).
 * `**bold**` renders as <strong>.
 *
 * Statistics policy: the only figures kept are the 78% burnout number —
 * attributed inline to its primary source (Forbes Health / OnePoll, 2024 survey
 * of 1,000 US dating-app users) — and the participant counts of the Huang,
 * Yeomans, Brooks, Minson & Gino study (Journal of Personality and Social
 * Psychology, 2017), also attributed inline. The figures previously carried by
 * this post — "2-5% of matches become a date", "54% feel lonelier", "50% of men
 * get almost no matches", "ghosting rates exceed 80%", "a profile is reviewed
 * for 0.5-2 seconds", "30-40 minutes a day", "over 100 profiles", "115 swipes
 * per match" and "35,000 decisions per day" — had no traceable source and were
 * removed: where the qualitative point survives on its own it stays, otherwise
 * the claim goes with the number. Do not reintroduce a number here without a
 * named primary source.
 *
 * Brand rule: Qulo is the only dating app nameable on this site. Everything else
 * is described generically as "swipe-based apps".
 *
 * Note: the block model has no h3, so the original h3 sub-headings ("1. Decision
 * Fatigue", "How Does It Work?", …) are authored as purple h2. The two headings
 * the original markup rendered in `text-qulo-green` — "Qulo's Solution" and the
 * closing "Conclusion" — keep `accent: "green"`; every other heading is purple.
 */
export const whatIsSwipeFatigue: LocalizedArticle = {
  en: [
    { type: "h2", text: "What Is Swipe Fatigue?" },
    { type: "p", text: "Swipe fatigue is the mental and emotional exhaustion caused by endlessly swiping through profiles on dating apps. The term became popular in the early 2020s, but it names a problem people had been feeling for years. The swipe mechanic shared by most mainstream dating apps looks like a game at first, and eventually traps the people playing it in a cycle that takes more than it gives back." },
    { type: "p", text: "Anyone who has spent a season on these apps knows the pattern. You open the app out of habit, work through a queue of strangers, close it without a single conversation worth continuing, and repeat the whole thing the next evening. Sustained long enough, that produces overstimulation and a steady decline in the quality of the decisions you are making." },

    { type: "h2", text: "Why Does Swipe Fatigue Happen?" },

    { type: "h2", text: "1. Decision Fatigue" },
    { type: "p", text: "Every swipe is a decision, and the human brain does not have an unlimited budget for those. Constantly saying \"yes\" or \"no\" to strangers depletes the same decision-making capacity you need for the rest of your day. Psychologist Barry Schwartz's **paradox of choice** describes what comes next: when people are given too many options, they end up less satisfied with what they choose and slower to choose at all. On dating apps this shows up as the nagging thought that the next profile might be better." },

    { type: "h2", text: "2. The Dopamine Loop and Addiction" },
    { type: "p", text: "The swipe mechanic works like a slot machine. Every swipe carries the uncertainty of \"will this person like me back?\", and unpredictable rewards are exactly the pattern that keeps a brain pulling the lever. This variable reward system holds your attention while draining it. A match produces a short burst of happiness, it fades quickly, and the loop starts over." },

    { type: "h2", text: "3. Superficiality and Lack of Depth" },
    { type: "p", text: "On swipe-based apps the decision is made almost instantly, and mostly on physical appearance. In that fraction of a second there is no way to assess someone's personality, values, sense of humour or view of the world — the mechanic leaves no room for it. As a result the matches stay superficial and genuine connection rarely forms." },

    { type: "h2", text: "4. Ghosting and Communication Breakdowns" },
    { type: "p", text: "Swipe culture trains people to treat each other as disposable. Conversations often end after a handful of messages, and ghosting — cutting off contact with no explanation — has stopped being an exception and become an ordinary part of the experience. For the person on the receiving end, it feeds rejection sensitivity and a general distrust of the whole format." },

    { type: "h2", text: "What the Evidence Actually Shows" },
    { type: "p", text: "Dramatic statistics circulate about dating apps, and most of them cannot be traced back to any real study. One figure can: in a 2024 **Forbes Health** survey conducted with **OnePoll** among **1,000** dating-app users in the United States, **78%** said they had experienced emotional burnout from app-based dating. Burnout is not a niche complaint from a handful of unlucky users — it is the majority experience." },
    { type: "ul", items: [
      "**Effort in, nothing out:** long sessions of evaluating strangers that end without a single conversation worth having",
      "**Attention is the product:** the loop is built to keep you scrolling, not to graduate you out of the app",
      "**Diminishing returns:** the more profiles you see, the less any individual one registers",
    ] },

    { type: "h2", accent: "green", text: "Qulo's Solution: Question-Based Matching" },
    { type: "p", text: "Qulo was built to change the mechanic rather than decorate it. Instead of swiping, matching runs on questions and answers, which takes the split-second appearance judgement out of the front of the process and puts something you can actually be known for in its place." },

    { type: "h2", text: "How Does It Work?" },
    { type: "p", text: "On Qulo you write between 2 and 4 questions — up to 10 on a paid plan. They reflect your personality, your interests and the things you care about. Other people try to solve them, and you match with whoever answers all of them correctly. Because a match costs thought rather than a thumb movement, the person on the other side has demonstrably paid attention to you before the conversation even starts." },

    { type: "h2", text: "Why Is It Better?" },
    { type: "ul", items: [
      "**Fewer but better matches:** not everyone matches, but the people who do have already understood something about you",
      "**Personality first:** your thinking and your values are the matching criteria, not your photos",
      "**An enjoyable process:** solving someone's questions is far more engaging than an endless queue of faces",
      "**Less ghosting:** people who put effort into a match are more willing to keep the conversation alive",
    ] },

    { type: "quote", text: "The questions you ask to get to know someone are worth more than hundreds of swipes." },

    { type: "h2", text: "How Is Quiz Dating Different?" },
    { type: "p", text: "Quiz dating departs from the standard model at the root. Swipe-based apps are built around seeing; quiz dating is built around understanding. Asking someone questions is the oldest and most natural way humans get to know each other, and Qulo simply moves that process into an app." },
    { type: "p", text: "On a swipe-based app the matching criteria are effectively appearance, age and distance. On Qulo, matching depends on whether the other person actually got your answers right. That means the person you match with has understood your mindset, your interests or your values — not just approved of a photograph." },
    { type: "p", text: "There is research behind the idea. In a 2017 study published in the **Journal of Personality and Social Psychology**, Huang, Yeomans, Brooks, Minson and Gino analysed **1,961** second-date decisions made by **110** speed daters and found that the people who asked more follow-up questions were more likely to be asked back. Curiosity turns out to be attractive in a measurable way — and a question-based app makes curiosity the entry requirement." },

    { type: "h2", text: "How to Overcome Swipe Fatigue" },
    { type: "p", text: "If you recognise yourself in the description, a few things help:" },
    { type: "ul", items: [
      "Put a limit on how long you spend in dating apps each day",
      "Look at profiles properly instead of swiping on autopilot",
      "Take the time to read what people wrote about themselves",
      "Make a real attempt to talk to the matches you already have",
      "Try a different matching method — **a question-based app like Qulo** breaks the swipe loop instead of dressing it up",
    ] },

    { type: "h2", accent: "green", text: "Conclusion" },
    { type: "p", text: "Swipe fatigue is one of the defining problems of modern dating culture: an endless stream of profiles, decisions that cost more than they return, and matches too thin to survive a week of messaging. The answer is not to give up on meeting people through an app. It is to change what the app asks of you. Qulo's bet is a simple one — meeting through questions is more meaningful, more fun and far more sustainable than another evening of swiping." },
  ],

  tr: [
    { type: "h2", text: "Swipe Yorgunluğu Nedir?" },
    { type: "p", text: "Swipe yorgunluğu, flört uygulamalarında durmadan profillere bakıp sola ya da sağa kaydırmanın yarattığı zihinsel ve duygusal tükenmişlik hâlidir. Terim 2020'li yılların başında yaygınlaştı ama aslında insanların yıllardır hissettiği bir sorunu adlandırıyor. Çoğu popüler flört uygulamasının ortak paydası olan bu mekanik başta bir oyun gibi görünür; zamanla kullanıcıyı verdiğinden fazlasını alan bir döngünün içine sokar." },
    { type: "p", text: "Bu uygulamalarda bir dönem geçirmiş herkes tabloyu bilir. Alışkanlıktan uygulamayı açarsınız, yabancılardan oluşan sırayı elden geçirirsiniz, devam etmeye değer tek bir sohbet çıkmadan kapatırsınız ve ertesi akşam aynısını tekrarlarsınız. Yeterince uzun sürdüğünde bu, aşırı uyarılmaya ve verdiğiniz kararların kalitesinde istikrarlı bir düşüşe yol açar." },

    { type: "h2", text: "Swipe Yorgunluğu Neden Oluşur?" },

    { type: "h2", text: "1. Karar Yorgunluğu" },
    { type: "p", text: "Her kaydırma bir karardır ve insan beyninin karar bütçesi sınırsız değildir. Yabancılara sürekli \"evet\" ya da \"hayır\" demek, günün geri kalanında ihtiyaç duyduğunuz karar verme kapasitesini tüketir. Psikolog Barry Schwartz'ın **seçim paradoksu** kavramı devamını anlatır: insanlara çok fazla seçenek sunulduğunda seçtiklerinden daha az tatmin olur, seçmekte de zorlanırlar. Flört uygulamalarında bu, \"bir sonraki daha iyi olabilir\" düşüncesi olarak kendini gösterir." },

    { type: "h2", text: "2. Dopamin Döngüsü ve Bağımlılık" },
    { type: "p", text: "Swipe mekaniği bir kumar makinesi gibi çalışır. Her kaydırmada \"acaba bu kişi de beni beğenecek mi?\" belirsizliği vardır ve beyni kolu çevirmeye devam ettiren tam da bu öngörülemeyen ödül düzenidir. Değişken ödül sistemi dikkatinizi tutarken bir yandan da tüketir. Eşleşme geldiğinde kısa süreli bir mutluluk yaşanır, hızla söner ve döngü baştan başlar." },

    { type: "h2", text: "3. Yüzeysellik ve Derinlik Eksikliği" },
    { type: "p", text: "Swipe tabanlı uygulamalarda karar neredeyse anında ve büyük ölçüde fiziksel görünüme bakılarak verilir. O saniyenin içinde bir insanın kişiliğini, değerlerini, mizah anlayışını ya da dünyaya bakışını değerlendirmenin imkânı yoktur; mekanik buna yer bırakmaz. Sonuçta eşleşmeler yüzeysel kalır ve gerçek bir bağ nadiren kurulur." },

    { type: "h2", text: "4. Ghosting ve İletişim Kopuklukları" },
    { type: "p", text: "Swipe kültürü insanlara birbirlerini tek kullanımlıkmış gibi görmeyi öğretir. Sohbetler çoğu zaman birkaç mesaj sonra biter; ghosting, yani hiçbir açıklama yapmadan iletişimi kesmek, istisna olmaktan çıkıp deneyimin sıradan bir parçası hâline gelmiştir. Karşı tarafta bu, reddedilme hassasiyetini ve bütün bu formata karşı bir güvensizliği besler." },

    { type: "h2", text: "Veriler Aslında Ne Söylüyor?" },
    { type: "p", text: "Flört uygulamaları hakkında çarpıcı istatistikler dolaşır ve çoğunun izi gerçek bir araştırmaya kadar sürülemez. Bir tanesinin sürülebilir: **Forbes Health**'in 2024'te **OnePoll** ile birlikte ABD'de **1.000** flört uygulaması kullanıcısıyla yaptığı ankette katılımcıların **%78**'i uygulama üzerinden flörtün kendilerinde duygusal tükenmişlik yarattığını söyledi. Tükenmişlik, şanssız birkaç kullanıcının yakınması değil; çoğunluğun deneyimi." },
    { type: "ul", items: [
      "**Emek girer, karşılığı çıkmaz:** yabancıları değerlendirmekle geçen uzun seanslar, konuşmaya değer tek bir sohbet bile bırakmadan biter",
      "**Ürün, sizin dikkatiniz:** döngü sizi uygulamadan mezun etmek için değil, kaydırmaya devam ettirmek için kurulmuştur",
      "**Azalan verim:** ne kadar çok profil görürseniz, tek bir profil o kadar az iz bırakır",
    ] },

    { type: "h2", accent: "green", text: "Qulo'nun Çözümü: Soru Tabanlı Eşleşme" },
    { type: "p", text: "Qulo, mekaniği süslemek yerine değiştirmek için kuruldu. Kaydırma yerine eşleşme soru ve cevaplar üzerinden yürür; böylece sürecin en başındaki saniyelik görünüm yargısı devreden çıkar ve yerine gerçekten tanınabileceğiniz bir şey gelir." },

    { type: "h2", text: "Nasıl Çalışır?" },
    { type: "p", text: "Qulo'da 2 ile 4 arasında soru yazarsınız; ücretli planda bu sayı 10'a kadar çıkar. Bu sorular kişiliğinizi, ilgi alanlarınızı ve önemsediğiniz şeyleri yansıtır. Diğer kullanıcılar bu soruları çözmeye çalışır; hepsini doğru cevaplayan kişiyle eşleşirsiniz. Eşleşmenin bedeli bir parmak hareketi değil düşünmek olduğu için, karşı taraf sohbet daha başlamadan size gerçekten dikkat kesilmiş olur." },

    { type: "h2", text: "Neden Daha İyi?" },
    { type: "ul", items: [
      "**Daha az ama daha iyi eşleşme:** herkesle eşleşmezsiniz, ama eşleştikleriniz sizinle ilgili bir şeyi çoktan anlamıştır",
      "**Önce kişilik:** eşleşme ölçütünüz fotoğraflarınız değil, düşünce biçiminiz ve değerlerinizdir",
      "**Keyifli bir süreç:** birinin sorularını çözmek, bitmeyen yüz sırasından çok daha sürükleyicidir",
      "**Daha az ghosting:** bir eşleşme için emek veren insanlar sohbeti sürdürmeye daha isteklidir",
    ] },

    { type: "quote", text: "Bir insanı tanımak için sorduğunuz sorular, yüzlerce kaydırmadan daha değerlidir." },

    { type: "h2", text: "Quiz Dating Nasıl Farklı?" },
    { type: "p", text: "Quiz dating, alışılmış modelden kökten ayrılır. Swipe tabanlı uygulamalar görmek üzerine kuruludur; quiz dating anlamak üzerine. Birine soru sormak, insanların birbirini tanımasının en eski ve en doğal yoludur; Qulo bu süreci olduğu gibi uygulamaya taşır." },
    { type: "p", text: "Swipe tabanlı bir uygulamada eşleşme ölçütleri pratikte görünüm, yaş ve mesafedir. Qulo'da ise eşleşme, karşı tarafın cevaplarınızı gerçekten bilip bilmediğine bağlıdır. Yani eşleştiğiniz kişi bir fotoğrafı onaylamakla kalmamış; düşünce yapınızı, ilgi alanlarınızı ya da değerlerinizi anlamıştır." },
    { type: "p", text: "Bunun arkasında araştırma da var. **Journal of Personality and Social Psychology** dergisinde 2017'de yayımlanan bir çalışmada Huang, Yeomans, Brooks, Minson ve Gino, **110** hızlı flört katılımcısının verdiği **1.961** ikinci buluşma kararını inceledi ve daha çok takip sorusu soranların yeniden davet edilme ihtimalinin daha yüksek olduğunu buldu. Merak, ölçülebilir biçimde çekici; soru tabanlı bir uygulama da merakı giriş şartı hâline getiriyor." },

    { type: "h2", text: "Swipe Yorgunluğundan Nasıl Kurtulursunuz?" },
    { type: "p", text: "Kendinizi bu tarifte buluyorsanız birkaç şey işe yarar:" },
    { type: "ul", items: [
      "Flört uygulamalarında günde ne kadar vakit geçirdiğinize sınır koyun",
      "Otomatiğe bağlayıp kaydırmak yerine profillere gerçekten bakın",
      "İnsanların kendileri hakkında yazdıklarını okumaya zaman ayırın",
      "Hâlihazırdaki eşleşmelerinizle konuşmak için gerçek bir çaba gösterin",
      "Farklı bir eşleşme yöntemi deneyin — **Qulo gibi soru tabanlı bir uygulama** swipe döngüsünü süslemek yerine kırar",
    ] },

    { type: "h2", accent: "green", text: "Sonuç" },
    { type: "p", text: "Swipe yorgunluğu modern flört kültürünün en belirgin sorunlarından biri: bitmeyen profil akışı, değdiğinden fazlasına mal olan kararlar ve bir haftalık mesajlaşmayı bile taşıyamayacak kadar ince eşleşmeler. Çözüm, uygulama üzerinden insan tanımaktan vazgeçmek değil; uygulamanın sizden ne istediğini değiştirmek. Qulo'nun iddiası basit: sorularla tanışmak, bir akşam daha kaydırmaktan çok daha anlamlı, çok daha eğlenceli ve çok daha sürdürülebilir." },
  ],

  de: [
    { type: "h2", text: "Was ist Swipe-Müdigkeit?" },
    { type: "p", text: "Swipe-Müdigkeit ist die geistige und emotionale Erschöpfung, die entsteht, wenn man sich in Dating-Apps endlos durch Profile wischt. Der Begriff wurde Anfang der 2020er populär, benennt aber ein Problem, das die Leute schon jahrelang gespürt hatten. Die Wischmechanik, die sich die meisten großen Dating-Apps teilen, wirkt anfangs wie ein Spiel und sperrt die Spielenden am Ende in einen Kreislauf, der mehr nimmt, als er zurückgibt." },
    { type: "p", text: "Wer eine Weile in diesen Apps unterwegs war, kennt das Muster. Man öffnet die App aus Gewohnheit, arbeitet eine Warteschlange von Fremden ab, schließt sie ohne ein einziges Gespräch, das der Fortsetzung wert wäre, und wiederholt das Ganze am nächsten Abend. Lange genug betrieben, führt das zu Reizüberflutung und zu einem stetigen Qualitätsverlust der Entscheidungen, die man trifft." },

    { type: "h2", text: "Warum entsteht Swipe-Müdigkeit?" },

    { type: "h2", text: "1. Entscheidungsmüdigkeit" },
    { type: "p", text: "Jeder Wisch ist eine Entscheidung, und das menschliche Gehirn hat dafür kein unbegrenztes Budget. Ständig \"ja\" oder \"nein\" zu Fremden zu sagen, verbraucht genau die Entscheidungskraft, die man für den Rest des Tages braucht. Der Psychologe Barry Schwartz beschreibt mit dem **Paradox der Wahl**, was danach passiert: Wer zu viele Optionen bekommt, ist mit der getroffenen Wahl weniger zufrieden und entscheidet langsamer. In Dating-Apps zeigt sich das als der nagende Gedanke, das nächste Profil könnte besser sein." },

    { type: "h2", text: "2. Die Dopaminschleife und die Abhängigkeit" },
    { type: "p", text: "Die Wischmechanik funktioniert wie ein Spielautomat. Bei jedem Wisch steht die Ungewissheit im Raum: \"Wird diese Person mich auch mögen?\" Unvorhersehbare Belohnungen sind genau das Muster, das ein Gehirn weiter am Hebel ziehen lässt. Dieses variable Belohnungssystem hält die Aufmerksamkeit und zehrt sie gleichzeitig auf. Ein Match erzeugt einen kurzen Glücksschub, der schnell verfliegt — und die Schleife beginnt von vorn." },

    { type: "h2", text: "3. Oberflächlichkeit und fehlende Tiefe" },
    { type: "p", text: "In Swipe-basierten Apps fällt die Entscheidung fast augenblicklich und überwiegend nach dem Aussehen. In diesem Sekundenbruchteil lassen sich weder Persönlichkeit noch Werte, Humor oder Weltsicht beurteilen — die Mechanik lässt dafür keinen Raum. Entsprechend bleiben die Matches oberflächlich, und echte Verbindung entsteht selten." },

    { type: "h2", text: "4. Ghosting und Kommunikationsabbrüche" },
    { type: "p", text: "Die Wischkultur bringt Menschen bei, einander als Wegwerfware zu behandeln. Gespräche enden oft nach einer Handvoll Nachrichten, und Ghosting — der Kontaktabbruch ohne jede Erklärung — ist von der Ausnahme zum normalen Bestandteil der Erfahrung geworden. Bei der Person, die es trifft, nährt das die Angst vor Zurückweisung und ein grundsätzliches Misstrauen gegenüber dem ganzen Format." },

    { type: "h2", text: "Was die Belege tatsächlich zeigen" },
    { type: "p", text: "Über Dating-Apps kursieren dramatische Statistiken, und die meisten lassen sich auf keine echte Studie zurückführen. Eine Zahl schon: In einer Umfrage von **Forbes Health**, die 2024 gemeinsam mit **OnePoll** unter **1.000** Dating-App-Nutzerinnen und -Nutzern in den USA durchgeführt wurde, gaben **78 %** an, durch das Daten per App emotional ausgebrannt zu sein. Burnout ist keine Nischenklage einiger Pechvögel, sondern die Erfahrung der Mehrheit." },
    { type: "ul", items: [
      "**Aufwand rein, nichts raus:** lange Sitzungen voller Bewertung von Fremden, an deren Ende kein einziges Gespräch steht, das sich lohnt",
      "**Das Produkt ist Ihre Aufmerksamkeit:** Die Schleife ist darauf gebaut, Sie am Scrollen zu halten, nicht darauf, Sie aus der App zu entlassen",
      "**Abnehmender Ertrag:** Je mehr Profile Sie sehen, desto weniger bleibt von einem einzelnen hängen",
    ] },

    { type: "h2", accent: "green", text: "Qulos Lösung: Matching über Fragen" },
    { type: "p", text: "Qulo wurde gebaut, um die Mechanik zu ändern statt sie zu dekorieren. Statt zu wischen, läuft das Matching über Fragen und Antworten. Damit fällt das Sekundenurteil über das Aussehen vom Anfang des Prozesses weg, und an seine Stelle tritt etwas, wofür man tatsächlich gekannt werden kann." },

    { type: "h2", text: "Wie funktioniert das?" },
    { type: "p", text: "Bei Qulo schreiben Sie zwischen 2 und 4 Fragen — bis zu 10 im kostenpflichtigen Tarif. Sie spiegeln Ihre Persönlichkeit, Ihre Interessen und das, was Ihnen wichtig ist. Andere versuchen, sie zu lösen, und Sie matchen mit der Person, die alle richtig beantwortet. Weil ein Match Nachdenken kostet und nicht bloß eine Daumenbewegung, hat die Person auf der anderen Seite Ihnen nachweislich Aufmerksamkeit geschenkt, bevor das Gespräch überhaupt beginnt." },

    { type: "h2", text: "Warum ist das besser?" },
    { type: "ul", items: [
      "**Weniger, aber bessere Matches:** Nicht alle matchen, aber wer es tut, hat bereits etwas an Ihnen verstanden",
      "**Persönlichkeit zuerst:** Ihre Denkweise und Ihre Werte sind das Matching-Kriterium, nicht Ihre Fotos",
      "**Ein angenehmer Prozess:** Die Fragen eines Menschen zu lösen, ist weit fesselnder als eine endlose Warteschlange von Gesichtern",
      "**Weniger Ghosting:** Wer Mühe in ein Match steckt, hält das Gespräch eher am Leben",
    ] },

    { type: "quote", text: "Die Fragen, die Sie stellen, um jemanden kennenzulernen, sind mehr wert als Hunderte von Wischbewegungen." },

    { type: "h2", text: "Was macht Quiz-Dating anders?" },
    { type: "p", text: "Quiz-Dating weicht an der Wurzel vom Standardmodell ab. Swipe-basierte Apps sind ums Sehen herum gebaut, Quiz-Dating ums Verstehen. Jemandem Fragen zu stellen, ist die älteste und natürlichste Art, wie Menschen einander kennenlernen — Qulo verlegt diesen Vorgang schlicht in eine App." },
    { type: "p", text: "In einer Swipe-basierten App sind die Matching-Kriterien faktisch Aussehen, Alter und Entfernung. Bei Qulo hängt das Match davon ab, ob die andere Person Ihre Antworten wirklich getroffen hat. Das heißt: Wer mit Ihnen matcht, hat Ihre Denkweise, Ihre Interessen oder Ihre Werte verstanden — und nicht nur ein Foto abgenickt." },
    { type: "p", text: "Dahinter steht auch Forschung. In einer 2017 im **Journal of Personality and Social Psychology** veröffentlichten Studie werteten Huang, Yeomans, Brooks, Minson und Gino **1.961** Entscheidungen über ein zweites Date von **110** Speed-Datern aus und fanden: Wer mehr Nachfragen stellte, wurde eher erneut eingeladen. Neugier ist messbar attraktiv — und eine fragenbasierte App macht Neugier zur Eintrittsbedingung." },

    { type: "h2", text: "Wie Sie aus der Swipe-Müdigkeit herauskommen" },
    { type: "p", text: "Wenn Sie sich in der Beschreibung wiedererkennen, hilft Folgendes:" },
    { type: "ul", items: [
      "Begrenzen Sie, wie viel Zeit Sie täglich in Dating-Apps verbringen",
      "Schauen Sie sich Profile richtig an, statt im Autopiloten zu wischen",
      "Nehmen Sie sich die Zeit zu lesen, was Menschen über sich geschrieben haben",
      "Unternehmen Sie einen ernsthaften Versuch, mit Ihren bestehenden Matches zu sprechen",
      "Probieren Sie eine andere Matching-Methode — **eine fragenbasierte App wie Qulo** durchbricht die Wischschleife, statt sie hübsch zu verpacken",
    ] },

    { type: "h2", accent: "green", text: "Fazit" },
    { type: "p", text: "Swipe-Müdigkeit ist eines der prägenden Probleme der modernen Dating-Kultur: ein endloser Strom von Profilen, Entscheidungen, die mehr kosten als sie einbringen, und Matches, die zu dünn sind, um eine Woche Chatten zu überstehen. Die Antwort ist nicht, das Kennenlernen per App aufzugeben. Die Antwort ist, zu ändern, was die App von Ihnen verlangt. Qulos Wette ist einfach: Sich über Fragen kennenzulernen, ist bedeutsamer, macht mehr Spaß und ist weit nachhaltiger als ein weiterer Abend voller Wischbewegungen." },
  ],

  fr: [
    { type: "h2", text: "Qu'est-ce que la fatigue du swipe ?" },
    { type: "p", text: "La fatigue du swipe, c'est l'épuisement mental et émotionnel provoqué par le fait de faire défiler sans fin des profils sur les applis de rencontre. Le terme s'est répandu au début des années 2020, mais il nomme un problème que les gens ressentaient depuis des années. La mécanique du swipe, commune à la plupart des grandes applis, ressemble d'abord à un jeu, puis enferme ceux qui y jouent dans une boucle qui prend plus qu'elle ne rend." },
    { type: "p", text: "Quiconque a passé une saison sur ces applis connaît le schéma. On ouvre l'appli par habitude, on écoule une file d'inconnus, on referme sans une seule conversation qui mérite d'être poursuivie, et on recommence le lendemain soir. Tenu assez longtemps, cela produit une surstimulation et une dégradation constante de la qualité des décisions que l'on prend." },

    { type: "h2", text: "Pourquoi la fatigue du swipe apparaît-elle ?" },

    { type: "h2", text: "1. La fatigue décisionnelle" },
    { type: "p", text: "Chaque swipe est une décision, et le cerveau humain ne dispose pas d'un budget illimité pour cela. Dire sans cesse \"oui\" ou \"non\" à des inconnus épuise la capacité de décision dont vous avez besoin pour le reste de la journée. Le psychologue Barry Schwartz décrit la suite avec son **paradoxe du choix** : trop d'options rendent les gens moins satisfaits de ce qu'ils choisissent et plus lents à choisir. Sur les applis de rencontre, cela prend la forme d'une pensée lancinante : le prochain profil sera peut-être meilleur." },

    { type: "h2", text: "2. La boucle dopaminergique et l'addiction" },
    { type: "p", text: "La mécanique du swipe fonctionne comme une machine à sous. Chaque swipe porte l'incertitude du \"est-ce que cette personne va m'aimer en retour ?\", et les récompenses imprévisibles sont précisément le schéma qui pousse un cerveau à tirer le levier encore une fois. Ce système de récompense variable retient l'attention tout en la vidant. Un match provoque une brève poussée de bonheur, qui s'évapore vite, et la boucle repart." },

    { type: "h2", text: "3. Superficialité et manque de profondeur" },
    { type: "p", text: "Sur les applis fondées sur le swipe, la décision se prend presque instantanément et surtout sur l'apparence physique. En une fraction de seconde, impossible d'évaluer la personnalité, les valeurs, l'humour ou la vision du monde de quelqu'un : la mécanique n'y laisse aucune place. Les matchs restent donc superficiels et une vraie connexion se forme rarement." },

    { type: "h2", text: "4. Ghosting et ruptures de communication" },
    { type: "p", text: "La culture du swipe apprend aux gens à se traiter comme des objets jetables. Les conversations s'arrêtent souvent après quelques messages, et le ghosting — couper le contact sans la moindre explication — a cessé d'être une exception pour devenir une composante ordinaire de l'expérience. Chez celui ou celle qui le subit, cela nourrit la peur du rejet et une méfiance générale envers tout le format." },

    { type: "h2", text: "Ce que montrent réellement les données" },
    { type: "p", text: "Des statistiques spectaculaires circulent sur les applis de rencontre, et la plupart ne remontent à aucune étude sérieuse. Un chiffre, si : dans une enquête **Forbes Health** menée en 2024 avec **OnePoll** auprès de **1 000** utilisateurs d'applis de rencontre aux États-Unis, **78 %** déclaraient avoir connu un épuisement émotionnel lié aux rencontres par appli. Le burnout n'est pas la plainte marginale de quelques malchanceux : c'est l'expérience de la majorité." },
    { type: "ul", items: [
      "**De l'effort en entrée, rien en sortie :** de longues sessions à évaluer des inconnus qui se terminent sans une seule conversation qui vaille",
      "**Le produit, c'est votre attention :** la boucle est conçue pour vous faire scroller, pas pour vous faire sortir de l'appli",
      "**Rendements décroissants :** plus vous voyez de profils, moins chacun d'eux vous marque",
    ] },

    { type: "h2", accent: "green", text: "La solution de Qulo : le matching par questions" },
    { type: "p", text: "Qulo a été conçu pour changer la mécanique plutôt que la décorer. Au lieu du swipe, le matching repose sur des questions et des réponses : le jugement en une fraction de seconde sur l'apparence disparaît du début du parcours, remplacé par quelque chose pour quoi on peut réellement être reconnu." },

    { type: "h2", text: "Comment ça marche ?" },
    { type: "p", text: "Sur Qulo, vous écrivez entre 2 et 4 questions — jusqu'à 10 avec un abonnement payant. Elles reflètent votre personnalité, vos centres d'intérêt et ce qui compte pour vous. Les autres essaient d'y répondre, et vous matchez avec la personne qui répond correctement à toutes. Comme un match coûte de la réflexion et non un mouvement de pouce, la personne en face vous a manifestement prêté attention avant même le début de la conversation." },

    { type: "h2", text: "Pourquoi est-ce mieux ?" },
    { type: "ul", items: [
      "**Moins de matchs, mais meilleurs :** tout le monde ne matche pas, mais ceux qui y parviennent ont déjà compris quelque chose de vous",
      "**La personnalité d'abord :** votre façon de penser et vos valeurs sont le critère de matching, pas vos photos",
      "**Un processus agréable :** résoudre les questions de quelqu'un est bien plus captivant qu'une file infinie de visages",
      "**Moins de ghosting :** ceux qui investissent des efforts dans un match sont plus enclins à faire vivre la conversation",
    ] },

    { type: "quote", text: "Les questions que vous posez pour connaître quelqu'un valent plus que des centaines de swipes." },

    { type: "h2", text: "En quoi le quiz dating est-il différent ?" },
    { type: "p", text: "Le quiz dating s'écarte du modèle standard à la racine. Les applis à swipe sont construites autour du fait de voir ; le quiz dating, autour du fait de comprendre. Poser des questions est la manière la plus ancienne et la plus naturelle dont les humains apprennent à se connaître, et Qulo ne fait que déplacer ce processus dans une appli." },
    { type: "p", text: "Sur une appli à swipe, les critères de matching se réduisent en pratique à l'apparence, l'âge et la distance. Sur Qulo, le match dépend de savoir si l'autre a vraiment trouvé vos réponses. Autrement dit, la personne avec qui vous matchez a compris votre façon de penser, vos centres d'intérêt ou vos valeurs — elle n'a pas seulement approuvé une photo." },
    { type: "p", text: "L'idée est étayée par la recherche. Dans une étude publiée en 2017 dans le **Journal of Personality and Social Psychology**, Huang, Yeomans, Brooks, Minson et Gino ont analysé **1 961** décisions de second rendez-vous prises par **110** participants à des speed datings : celles et ceux qui posaient davantage de questions de relance étaient plus souvent réinvités. La curiosité est attirante de façon mesurable — et une appli fondée sur les questions en fait la condition d'entrée." },

    { type: "h2", text: "Comment sortir de la fatigue du swipe" },
    { type: "p", text: "Si vous vous reconnaissez dans cette description, quelques réflexes aident :" },
    { type: "ul", items: [
      "Fixez une limite au temps passé chaque jour sur les applis de rencontre",
      "Regardez vraiment les profils au lieu de swiper en pilote automatique",
      "Prenez le temps de lire ce que les gens ont écrit sur eux-mêmes",
      "Faites un véritable effort pour parler aux matchs que vous avez déjà",
      "Essayez une autre méthode de matching — **une appli fondée sur les questions comme Qulo** casse la boucle du swipe au lieu de l'enjoliver",
    ] },

    { type: "h2", accent: "green", text: "Conclusion" },
    { type: "p", text: "La fatigue du swipe est l'un des problèmes qui définissent la culture des rencontres d'aujourd'hui : un flux infini de profils, des décisions qui coûtent plus qu'elles ne rapportent et des matchs trop minces pour survivre à une semaine de messages. La réponse n'est pas de renoncer à rencontrer des gens via une appli. Elle est de changer ce que l'appli exige de vous. Le pari de Qulo est simple : se rencontrer par des questions est plus signifiant, plus amusant et bien plus durable qu'une soirée de swipe de plus." },
  ],

  es: [
    { type: "h2", text: "¿Qué es el cansancio del swipe?" },
    { type: "p", text: "El cansancio del swipe es el agotamiento mental y emocional que produce deslizar perfiles sin parar en las apps de citas. El término se popularizó a principios de la década de 2020, pero pone nombre a algo que la gente llevaba años sintiendo. La mecánica del deslizamiento, común a la mayoría de las apps grandes, parece un juego al principio y acaba encerrando a quien juega en un bucle que quita más de lo que devuelve." },
    { type: "p", text: "Cualquiera que haya pasado una temporada en estas apps conoce el patrón. Abres la app por costumbre, despachas una cola de desconocidos, la cierras sin una sola conversación que merezca continuar y repites todo la noche siguiente. Sostenido el tiempo suficiente, eso produce sobreestimulación y un deterioro constante en la calidad de las decisiones que tomas." },

    { type: "h2", text: "¿Por qué aparece el cansancio del swipe?" },

    { type: "h2", text: "1. Fatiga de decisión" },
    { type: "p", text: "Cada deslizamiento es una decisión, y el cerebro humano no tiene un presupuesto ilimitado para ellas. Decir sin descanso \"sí\" o \"no\" a desconocidos agota la misma capacidad de decidir que necesitas para el resto del día. El psicólogo Barry Schwartz describe lo que viene después con su **paradoja de la elección**: cuando se ofrecen demasiadas opciones, la gente queda menos satisfecha con lo que elige y tarda más en elegir. En las apps de citas eso aparece como el pensamiento insistente de que el siguiente perfil podría ser mejor." },

    { type: "h2", text: "2. El bucle de dopamina y la adicción" },
    { type: "p", text: "La mecánica del swipe funciona como una máquina tragaperras. Cada deslizamiento lleva dentro la incertidumbre de \"¿le gustaré yo también?\", y las recompensas impredecibles son justo el patrón que hace que un cerebro siga tirando de la palanca. Ese sistema de recompensa variable retiene tu atención mientras la vacía. Un match da una descarga breve de felicidad, se apaga rápido y el bucle vuelve a empezar." },

    { type: "h2", text: "3. Superficialidad y falta de profundidad" },
    { type: "p", text: "En las apps basadas en el swipe la decisión se toma casi al instante y sobre todo por el aspecto físico. En esa fracción de segundo no hay forma de valorar la personalidad, los valores, el humor o la mirada sobre el mundo de nadie: la mecánica no deja espacio para ello. El resultado es que los matches se quedan en la superficie y la conexión real rara vez llega." },

    { type: "h2", text: "4. Ghosting y rupturas de comunicación" },
    { type: "p", text: "La cultura del swipe enseña a tratar a las personas como algo desechable. Las conversaciones suelen morir tras un puñado de mensajes, y el ghosting —cortar el contacto sin explicación alguna— ha dejado de ser la excepción para volverse una parte corriente de la experiencia. En quien lo recibe alimenta la sensibilidad al rechazo y una desconfianza general hacia todo el formato." },

    { type: "h2", text: "Qué muestran realmente los datos" },
    { type: "p", text: "Sobre las apps de citas circulan estadísticas llamativas y la mayoría no se puede rastrear hasta ningún estudio real. Una cifra sí: en una encuesta de **Forbes Health** realizada en 2024 con **OnePoll** entre **1.000** usuarios de apps de citas en Estados Unidos, el **78 %** dijo haber sufrido agotamiento emocional por las citas a través de apps. El burnout no es la queja de unos pocos con mala suerte: es la experiencia de la mayoría." },
    { type: "ul", items: [
      "**Entra esfuerzo, no sale nada:** sesiones largas evaluando desconocidos que terminan sin una sola conversación que valga la pena",
      "**El producto es tu atención:** el bucle está construido para que sigas deslizando, no para que salgas de la app",
      "**Rendimientos decrecientes:** cuantos más perfiles ves, menos te marca cada uno",
    ] },

    { type: "h2", accent: "green", text: "La solución de Qulo: emparejamiento por preguntas" },
    { type: "p", text: "Qulo se construyó para cambiar la mecánica en lugar de decorarla. En vez de deslizar, el emparejamiento funciona con preguntas y respuestas: el juicio instantáneo sobre el aspecto sale del principio del proceso y en su lugar queda algo por lo que de verdad te pueden conocer." },

    { type: "h2", text: "¿Cómo funciona?" },
    { type: "p", text: "En Qulo escribes entre 2 y 4 preguntas — hasta 10 con un plan de pago. Reflejan tu personalidad, tus intereses y lo que te importa. Los demás intentan resolverlas y haces match con quien acierta todas. Como un match cuesta pensar y no un gesto del pulgar, la persona del otro lado te ha prestado atención de forma demostrable antes incluso de que empiece la conversación." },

    { type: "h2", text: "¿Por qué es mejor?" },
    { type: "ul", items: [
      "**Menos matches, pero mejores:** no todo el mundo hace match, pero quien lo hace ya ha entendido algo de ti",
      "**La personalidad primero:** tu forma de pensar y tus valores son el criterio de emparejamiento, no tus fotos",
      "**Un proceso disfrutable:** resolver las preguntas de alguien engancha mucho más que una cola infinita de caras",
      "**Menos ghosting:** quien invierte esfuerzo en un match está más dispuesto a mantener viva la conversación",
    ] },

    { type: "quote", text: "Las preguntas que haces para conocer a alguien valen más que cientos de deslizamientos." },

    { type: "h2", text: "¿En qué se diferencia el quiz dating?" },
    { type: "p", text: "El quiz dating se aparta del modelo habitual desde la raíz. Las apps de swipe están construidas alrededor de ver; el quiz dating, alrededor de entender. Hacer preguntas es la manera más antigua y natural en que las personas se conocen, y Qulo simplemente traslada ese proceso a una app." },
    { type: "p", text: "En una app de swipe los criterios de emparejamiento son en la práctica el aspecto, la edad y la distancia. En Qulo el match depende de si la otra persona acertó de verdad tus respuestas. Es decir: quien hace match contigo ha entendido tu manera de pensar, tus intereses o tus valores, no solo ha aprobado una foto." },
    { type: "p", text: "La idea tiene respaldo en la investigación. En un estudio publicado en 2017 en el **Journal of Personality and Social Psychology**, Huang, Yeomans, Brooks, Minson y Gino analizaron **1.961** decisiones sobre una segunda cita tomadas por **110** participantes en citas rápidas y hallaron que quienes hacían más preguntas de seguimiento tenían más probabilidades de ser invitados de nuevo. La curiosidad resulta atractiva de forma medible, y una app basada en preguntas convierte la curiosidad en el requisito de entrada." },

    { type: "h2", text: "Cómo salir del cansancio del swipe" },
    { type: "p", text: "Si te reconoces en la descripción, hay algunas cosas que ayudan:" },
    { type: "ul", items: [
      "Pon un límite al tiempo diario que pasas en apps de citas",
      "Mira los perfiles de verdad en lugar de deslizar en piloto automático",
      "Dedica tiempo a leer lo que la gente ha escrito sobre sí misma",
      "Haz un intento real de hablar con los matches que ya tienes",
      "Prueba otro método de emparejamiento: **una app basada en preguntas como Qulo** rompe el bucle del swipe en lugar de maquillarlo",
    ] },

    { type: "h2", accent: "green", text: "Conclusión" },
    { type: "p", text: "El cansancio del swipe es uno de los problemas que definen la cultura de citas actual: un flujo infinito de perfiles, decisiones que cuestan más de lo que devuelven y matches demasiado finos para sobrevivir a una semana de mensajes. La respuesta no es renunciar a conocer gente a través de una app, sino cambiar lo que la app te pide. La apuesta de Qulo es sencilla: conocerse a través de preguntas es más significativo, más divertido y mucho más sostenible que otra noche deslizando." },
  ],

  ar: [
    { type: "h2", text: "ما هو إرهاق التمرير؟" },
    { type: "p", text: "إرهاق التمرير هو الإنهاك الذهني والعاطفي الناتج عن تصفّح الملفات الشخصية بلا نهاية في تطبيقات المواعدة. انتشر المصطلح في مطلع العشرينيات، لكنه يسمّي مشكلة كان الناس يشعرون بها منذ سنوات. آلية التمرير التي تتشاركها معظم تطبيقات المواعدة الكبرى تبدو في البداية أشبه بلعبة، ثم تحبس اللاعبين في دورة تأخذ أكثر ممّا تعطي." },
    { type: "p", text: "من قضى فترة في هذه التطبيقات يعرف النمط جيدًا: تفتح التطبيق بحكم العادة، تمرّ على طابور من الغرباء، تغلقه دون محادثة واحدة تستحقّ المتابعة، ثم تكرّر الأمر نفسه في الليلة التالية. وإذا استمرّ ذلك طويلًا فإنه يؤدي إلى فرط تحفيز ذهني وإلى تراجع مطّرد في جودة القرارات التي تتّخذها." },

    { type: "h2", text: "لماذا يحدث إرهاق التمرير؟" },

    { type: "h2", text: "1. إرهاق اتخاذ القرار" },
    { type: "p", text: "كل تمريرة قرار، وميزانية الدماغ البشري لاتخاذ القرارات ليست بلا حدود. قول \"نعم\" أو \"لا\" للغرباء بلا توقّف يستهلك القدرة نفسها التي تحتاجها لبقية يومك. يصف عالم النفس باري شوارتز ما يحدث بعد ذلك بمفهوم **مفارقة الاختيار**: حين تُعرض على الناس خيارات أكثر من اللازم، يقلّ رضاهم عمّا يختارونه ويصبح الاختيار نفسه أبطأ. وفي تطبيقات المواعدة يظهر ذلك على شكل فكرة ملحّة: ربما يكون الملف التالي أفضل." },

    { type: "h2", text: "2. حلقة الدوبامين والإدمان" },
    { type: "p", text: "تعمل آلية التمرير مثل ماكينة القمار. كل تمريرة تحمل سؤالًا معلّقًا: \"هل سيعجب بي هذا الشخص أيضًا؟\"، والمكافآت غير المتوقّعة هي بالضبط النمط الذي يبقي الدماغ ممسكًا بالذراع. هذا النظام ذو المكافأة المتغيّرة يمسك انتباهك ويستنزفه في الوقت نفسه. يأتي التطابق فتشعر بدفقة سعادة قصيرة سرعان ما تخبو، ثم تبدأ الحلقة من جديد." },

    { type: "h2", text: "3. السطحية وغياب العمق" },
    { type: "p", text: "في التطبيقات القائمة على التمرير يُتّخذ القرار في لحظة تقريبًا، وعلى أساس المظهر الخارجي في الأغلب. في ذلك الجزء من الثانية لا سبيل لتقييم شخصية أحد أو قيمه أو حسّه الفكاهي أو نظرته إلى العالم؛ الآلية نفسها لا تترك مجالًا لذلك. والنتيجة أن التطابقات تبقى سطحية ونادرًا ما ينشأ ارتباط حقيقي." },

    { type: "h2", text: "4. الغوستينغ وانقطاع التواصل" },
    { type: "p", text: "تدرّب ثقافة التمرير الناس على معاملة بعضهم كأشياء يمكن الاستغناء عنها. تنتهي المحادثات غالبًا بعد حفنة رسائل، وصار الغوستينغ — أي قطع التواصل دون أي تفسير — جزءًا عاديًا من التجربة بدل أن يكون استثناءً. أمّا من يقع عليه ذلك فتتغذّى لديه الحساسية تجاه الرفض وعدم الثقة بالصيغة كلها." },

    { type: "h2", text: "ماذا تُظهر الأدلة فعلًا؟" },
    { type: "p", text: "تنتشر عن تطبيقات المواعدة إحصاءات مثيرة لا يمكن ردّ معظمها إلى أي دراسة حقيقية. رقم واحد يمكن ردّه: في استطلاع أجرته **Forbes Health** عام 2024 بالتعاون مع **OnePoll** وشمل **1,000** مستخدم لتطبيقات المواعدة في الولايات المتحدة، قال **78%** إنهم عانوا إنهاكًا عاطفيًا بسبب المواعدة عبر التطبيقات. الإنهاك ليس شكوى فئة صغيرة سيئة الحظ، بل تجربة الأغلبية." },
    { type: "ul", items: [
      "**جهد يدخل ولا شيء يخرج:** جلسات طويلة في تقييم الغرباء تنتهي دون محادثة واحدة تستحقّ",
      "**المنتج هو انتباهك:** الحلقة مبنيّة لإبقائك تمرّر، لا لإخراجك من التطبيق",
      "**عائد متناقص:** كلما رأيت ملفات أكثر، قلّ الأثر الذي يتركه كل ملف على حدة",
    ] },

    { type: "h2", accent: "green", text: "حلّ Qulo: التطابق القائم على الأسئلة" },
    { type: "p", text: "بُني Qulo لتغيير الآلية لا لتزيينها. فبدل التمرير، يقوم التطابق على الأسئلة والأجوبة، وبذلك يخرج حكم اللحظة على المظهر من بداية المسار ليحلّ محلّه شيء يمكن أن تُعرَف به فعلًا." },

    { type: "h2", text: "كيف يعمل؟" },
    { type: "p", text: "في Qulo تكتب ما بين 2 و4 أسئلة تعكس شخصيتك واهتماماتك وما يهمّك، وحتى 10 أسئلة في الخطة المدفوعة. يحاول الآخرون حلّها، وتتطابق مع من يجيب عنها كلها إجابة صحيحة. ولأن التطابق يكلّف تفكيرًا لا حركة إبهام، فإن الطرف الآخر يكون قد انتبه إليك فعليًا قبل أن تبدأ المحادثة أصلًا." },

    { type: "h2", text: "لماذا هو أفضل؟" },
    { type: "ul", items: [
      "**تطابقات أقل لكن أفضل:** لا يتطابق الجميع، لكن من يتطابق يكون قد فهم شيئًا عنك بالفعل",
      "**الشخصية أولًا:** معيار التطابق هو طريقة تفكيرك وقيمك، لا صورك",
      "**تجربة ممتعة:** حلّ أسئلة شخص ما أكثر تشويقًا بكثير من طابور لا ينتهي من الوجوه",
      "**غوستينغ أقل:** من يبذل جهدًا في تطابق يكون أكثر استعدادًا لإبقاء المحادثة حيّة",
    ] },

    { type: "quote", text: "الأسئلة التي تطرحها لتتعرّف إلى إنسان أثمن من مئات التمريرات." },

    { type: "h2", text: "بماذا تختلف المواعدة القائمة على الأسئلة؟" },
    { type: "p", text: "تختلف المواعدة القائمة على الأسئلة عن النموذج المعتاد من الجذر. التطبيقات القائمة على التمرير مبنيّة حول الرؤية، أمّا هذه فمبنيّة حول الفهم. طرح الأسئلة هو أقدم طرق البشر وأكثرها طبيعية للتعرّف إلى بعضهم، وQulo ينقل هذه العملية إلى التطبيق كما هي." },
    { type: "p", text: "في تطبيق قائم على التمرير تنحصر معايير التطابق عمليًا في المظهر والعمر والمسافة. أمّا في Qulo فيتوقّف التطابق على ما إذا كان الطرف الآخر قد أصاب إجاباتك حقًا. أي أن من يتطابق معك يكون قد فهم طريقة تفكيرك أو اهتماماتك أو قيمك، لا أنه وافق على صورة فحسب." },
    { type: "p", text: "وللفكرة سند بحثي. في دراسة نُشرت عام 2017 في دورية **Journal of Personality and Social Psychology**، حلّل هوانغ ويومانز وبروكس ومينسون وجينو **1,961** قرارًا بشأن موعد ثانٍ اتّخذها **110** مشاركين في مواعدات سريعة، ووجدوا أن من طرحوا أسئلة متابعة أكثر كانوا أرجح دعوةً إلى لقاء ثانٍ. الفضول جذّاب بصورة قابلة للقياس، والتطبيق القائم على الأسئلة يجعل الفضول شرط الدخول." },

    { type: "h2", text: "كيف تتخلّص من إرهاق التمرير" },
    { type: "p", text: "إن وجدت نفسك في هذا الوصف، فهذه أمور تساعد:" },
    { type: "ul", items: [
      "ضع حدًّا للوقت الذي تقضيه يوميًا في تطبيقات المواعدة",
      "انظر إلى الملفات الشخصية بجدّية بدل التمرير على الطيّار الآلي",
      "خصّص وقتًا لقراءة ما كتبه الناس عن أنفسهم",
      "ابذل محاولة حقيقية للحديث مع من تطابقت معهم بالفعل",
      "جرّب طريقة تطابق مختلفة — **تطبيق قائم على الأسئلة مثل Qulo** يكسر حلقة التمرير بدل تجميلها",
    ] },

    { type: "h2", accent: "green", text: "الخلاصة" },
    { type: "p", text: "إرهاق التمرير من أبرز مشكلات ثقافة المواعدة الحديثة: سيل لا ينتهي من الملفات، وقرارات تكلّف أكثر ممّا تعيد، وتطابقات أرقّ من أن تصمد أسبوعًا من الرسائل. الحلّ ليس التخلّي عن التعرّف إلى الناس عبر التطبيقات، بل تغيير ما يطلبه التطبيق منك. رهان Qulo بسيط: التعارف عبر الأسئلة أعمق معنًى وأكثر متعة وأطول عمرًا من أمسية أخرى من التمرير." },
  ],

  ru: [
    { type: "h2", text: "Что такое усталость от свайпов?" },
    { type: "p", text: "Усталость от свайпов — это умственное и эмоциональное истощение от бесконечного перелистывания анкет в приложениях для знакомств. Термин стал популярен в начале 2020-х, но он лишь дал имя тому, что люди чувствовали годами. Механика свайпа, общая почти для всех крупных приложений, поначалу похожа на игру, а в итоге запирает игрока в цикле, который забирает больше, чем отдаёт." },
    { type: "p", text: "Любой, кто провёл в таких приложениях хотя бы сезон, знает этот сценарий. Вы открываете приложение по привычке, прокручиваете очередь незнакомцев, закрываете его без единого разговора, который стоило бы продолжить, и повторяете всё это следующим вечером. Если так продолжается долго, возникает перевозбуждение и неуклонно падает качество решений, которые вы принимаете." },

    { type: "h2", text: "Почему возникает усталость от свайпов?" },

    { type: "h2", text: "1. Усталость от решений" },
    { type: "p", text: "Каждый свайп — это решение, а бюджет мозга на решения не безграничен. Постоянные «да» и «нет» незнакомым людям расходуют ту же способность выбирать, которая нужна вам на весь оставшийся день. Психолог Барри Шварц описал продолжение в концепции **парадокса выбора**: когда вариантов слишком много, человек меньше доволен сделанным выбором и дольше не может его сделать. В приложениях для знакомств это превращается в навязчивую мысль, что следующая анкета может оказаться лучше." },

    { type: "h2", text: "2. Дофаминовая петля и зависимость" },
    { type: "p", text: "Механика свайпа работает как игровой автомат. В каждом свайпе есть неопределённость: «а понравлюсь ли я в ответ?» — и именно непредсказуемое вознаграждение заставляет мозг снова дёргать рычаг. Такая система переменного подкрепления удерживает внимание и одновременно его выжигает. Мэтч даёт короткую вспышку радости, она быстро гаснет, и петля начинается заново." },

    { type: "h2", text: "3. Поверхностность и нехватка глубины" },
    { type: "p", text: "В приложениях со свайпами решение принимается почти мгновенно и в основном по внешности. За эту долю секунды невозможно оценить ни характер, ни ценности, ни чувство юмора, ни взгляд человека на мир — механика просто не оставляет для этого места. В результате мэтчи остаются поверхностными, а настоящая связь возникает редко." },

    { type: "h2", text: "4. Гостинг и обрыв общения" },
    { type: "p", text: "Культура свайпа приучает относиться к людям как к одноразовым. Переписка часто заканчивается после нескольких сообщений, а гостинг — исчезновение без объяснений — перестал быть исключением и стал обычной частью опыта. У того, кто с этим сталкивается, это подпитывает страх отвержения и общее недоверие к самому формату." },

    { type: "h2", text: "Что на самом деле показывают данные" },
    { type: "p", text: "Про приложения для знакомств ходят эффектные цифры, и большинство из них невозможно возвести к реальному исследованию. Одну — можно: в опросе **Forbes Health**, проведённом в 2024 году совместно с **OnePoll** среди **1000** пользователей приложений для знакомств в США, **78%** сказали, что испытывали эмоциональное выгорание от знакомств через приложения. Выгорание — не жалоба горстки невезучих, а опыт большинства." },
    { type: "ul", items: [
      "**Усилия внутрь, ничего наружу:** долгие сессии оценки незнакомцев, которые заканчиваются без единого стоящего разговора",
      "**Продукт — это ваше внимание:** петля устроена так, чтобы вы продолжали листать, а не чтобы вы наконец вышли из приложения",
      "**Убывающая отдача:** чем больше анкет вы видите, тем меньше запоминается каждая отдельная",
    ] },

    { type: "h2", accent: "green", text: "Решение Qulo: подбор через вопросы" },
    { type: "p", text: "Qulo сделан для того, чтобы поменять саму механику, а не украсить её. Вместо свайпов подбор строится на вопросах и ответах: мгновенная оценка внешности уходит с начала пути, а на её место встаёт то, за что вас действительно можно узнать." },

    { type: "h2", text: "Как это работает?" },
    { type: "p", text: "В Qulo вы пишете от 2 до 4 вопросов — до 10 на платном тарифе. Они отражают ваш характер, интересы и то, что для вас важно. Другие пытаются их решить, и мэтч случается с тем, кто ответил на все правильно. Поскольку мэтч стоит размышления, а не движения большого пальца, человек на другой стороне заведомо уделил вам внимание ещё до начала разговора." },

    { type: "h2", text: "Почему это лучше?" },
    { type: "ul", items: [
      "**Меньше мэтчей, но лучше:** совпадают не все, но те, кто совпал, уже что-то про вас поняли",
      "**Сначала личность:** критерий подбора — ваш способ мыслить и ваши ценности, а не фотографии",
      "**Приятный процесс:** разгадывать чужие вопросы куда увлекательнее, чем листать бесконечную очередь лиц",
      "**Меньше гостинга:** тот, кто вложил усилие в мэтч, охотнее поддерживает разговор",
    ] },

    { type: "quote", text: "Вопросы, которые вы задаёте, чтобы узнать человека, стоят больше сотен свайпов." },

    { type: "h2", text: "Чем отличаются знакомства через вопросы?" },
    { type: "p", text: "Знакомства через вопросы расходятся со стандартной моделью в самом корне. Приложения со свайпами построены вокруг «смотреть», а знакомства через вопросы — вокруг «понимать». Задавать вопросы — древнейший и самый естественный способ узнать другого человека, и Qulo просто переносит этот способ в приложение." },
    { type: "p", text: "В приложении со свайпами критерии подбора сводятся к внешности, возрасту и расстоянию. В Qulo мэтч зависит от того, действительно ли собеседник угадал ваши ответы. То есть человек, с которым вы совпали, понял ваш образ мыслей, ваши интересы или ценности, а не просто одобрил фотографию." },
    { type: "p", text: "За этой идеей стоит и исследование. В работе, опубликованной в 2017 году в журнале **Journal of Personality and Social Psychology**, Хуанг, Йоманс, Брукс, Минсон и Джино разобрали **1961** решение о втором свидании, принятое **110** участниками быстрых свиданий, и обнаружили: те, кто задавал больше уточняющих вопросов, чаще получали приглашение снова. Любопытство привлекательно измеримым образом — а приложение на вопросах делает любопытство условием входа." },

    { type: "h2", text: "Как выбраться из усталости от свайпов" },
    { type: "p", text: "Если вы узнали себя в описании, помогает следующее:" },
    { type: "ul", items: [
      "Ограничьте время, которое вы каждый день проводите в приложениях для знакомств",
      "Смотрите анкеты внимательно, а не свайпайте на автопилоте",
      "Находите время читать то, что люди написали о себе",
      "Сделайте настоящую попытку заговорить с теми, с кем уже совпали",
      "Попробуйте другой способ подбора — **приложение на вопросах вроде Qulo** ломает петлю свайпов, а не приукрашивает её",
    ] },

    { type: "h2", accent: "green", text: "Заключение" },
    { type: "p", text: "Усталость от свайпов — одна из определяющих проблем современной культуры знакомств: бесконечный поток анкет, решения, которые обходятся дороже своей отдачи, и мэтчи, слишком тонкие, чтобы пережить неделю переписки. Ответ не в том, чтобы отказаться от знакомств через приложение, а в том, чтобы изменить то, чего приложение от вас требует. Ставка Qulo проста: знакомиться через вопросы осмысленнее, интереснее и намного устойчивее, чем провести ещё один вечер за свайпами." },
  ],

  pt: [
    { type: "h2", text: "O que é a fadiga do swipe?" },
    { type: "p", text: "A fadiga do swipe é o esgotamento mental e emocional causado por deslizar perfis sem parar nos aplicativos de relacionamento. O termo se popularizou no início dos anos 2020, mas dá nome a algo que as pessoas já sentiam havia anos. A mecânica do swipe, comum à maioria dos aplicativos grandes, parece um jogo no começo e acaba prendendo quem joga num ciclo que tira mais do que devolve." },
    { type: "p", text: "Quem passou uma temporada nesses aplicativos conhece o padrão. Você abre o app por hábito, percorre uma fila de desconhecidos, fecha sem uma única conversa que valha a pena continuar e repete tudo na noite seguinte. Mantido por tempo suficiente, isso produz superestimulação e uma queda constante na qualidade das decisões que você toma." },

    { type: "h2", text: "Por que a fadiga do swipe acontece?" },

    { type: "h2", text: "1. Fadiga de decisão" },
    { type: "p", text: "Cada swipe é uma decisão, e o cérebro humano não tem orçamento ilimitado para isso. Dizer \"sim\" ou \"não\" a desconhecidos o tempo todo consome a mesma capacidade de decidir de que você precisa para o resto do dia. O psicólogo Barry Schwartz descreve o que vem depois com o **paradoxo da escolha**: diante de opções demais, as pessoas ficam menos satisfeitas com o que escolhem e demoram mais para escolher. Nos aplicativos de relacionamento isso aparece como aquele pensamento insistente de que o próximo perfil pode ser melhor." },

    { type: "h2", text: "2. O ciclo da dopamina e o vício" },
    { type: "p", text: "A mecânica do swipe funciona como uma máquina caça-níqueis. Cada deslizada carrega a incerteza do \"será que essa pessoa vai gostar de mim também?\", e recompensas imprevisíveis são exatamente o padrão que mantém um cérebro puxando a alavanca. Esse sistema de recompensa variável segura a sua atenção enquanto a esvazia. Um match dá uma explosão curta de alegria, que passa rápido, e o ciclo recomeça." },

    { type: "h2", text: "3. Superficialidade e falta de profundidade" },
    { type: "p", text: "Nos aplicativos baseados em swipe a decisão é tomada quase instantaneamente e sobretudo pela aparência física. Nessa fração de segundo não há como avaliar a personalidade, os valores, o humor ou a visão de mundo de alguém — a mecânica não deixa espaço para isso. O resultado é que os matches ficam na superfície e a conexão de verdade raramente aparece." },

    { type: "h2", text: "4. Ghosting e rupturas de comunicação" },
    { type: "p", text: "A cultura do swipe ensina as pessoas a se tratarem como descartáveis. As conversas costumam morrer depois de algumas mensagens, e o ghosting — cortar o contato sem nenhuma explicação — deixou de ser exceção para virar parte comum da experiência. Em quem recebe, isso alimenta a sensibilidade à rejeição e uma desconfiança geral em relação ao formato inteiro." },

    { type: "h2", text: "O que as evidências realmente mostram" },
    { type: "p", text: "Circulam estatísticas dramáticas sobre aplicativos de relacionamento, e a maioria não pode ser rastreada até nenhum estudo real. Um número pode: numa pesquisa da **Forbes Health** feita em 2024 com a **OnePoll** entre **1.000** usuários de aplicativos de relacionamento nos Estados Unidos, **78%** disseram ter sofrido esgotamento emocional por causa dos relacionamentos por aplicativo. O burnout não é a queixa de alguns azarados: é a experiência da maioria." },
    { type: "ul", items: [
      "**Entra esforço, não sai nada:** sessões longas avaliando desconhecidos que terminam sem uma única conversa que preste",
      "**O produto é a sua atenção:** o ciclo foi construído para manter você deslizando, não para liberar você do aplicativo",
      "**Retornos decrescentes:** quanto mais perfis você vê, menos cada um deles marca",
    ] },

    { type: "h2", accent: "green", text: "A solução da Qulo: match por perguntas" },
    { type: "p", text: "A Qulo foi construída para mudar a mecânica em vez de decorá-la. No lugar do swipe, o match funciona por perguntas e respostas: o julgamento instantâneo sobre a aparência sai do início do processo e entra algo pelo qual você pode de fato ser conhecido." },

    { type: "h2", text: "Como funciona?" },
    { type: "p", text: "No Qulo você escreve entre 2 e 4 perguntas — até 10 num plano pago. Elas refletem a sua personalidade, os seus interesses e o que importa para você. As outras pessoas tentam resolvê-las, e você dá match com quem acerta todas. Como um match custa pensamento e não um movimento de polegar, a pessoa do outro lado comprovadamente prestou atenção em você antes mesmo de a conversa começar." },

    { type: "h2", text: "Por que é melhor?" },
    { type: "ul", items: [
      "**Menos matches, porém melhores:** nem todo mundo dá match, mas quem dá já entendeu alguma coisa sobre você",
      "**Personalidade primeiro:** o critério de match é o seu jeito de pensar e os seus valores, não as suas fotos",
      "**Um processo divertido:** resolver as perguntas de alguém é muito mais envolvente do que uma fila infinita de rostos",
      "**Menos ghosting:** quem investe esforço num match fica mais disposto a manter a conversa viva",
    ] },

    { type: "quote", text: "As perguntas que você faz para conhecer alguém valem mais do que centenas de swipes." },

    { type: "h2", text: "O que torna o quiz dating diferente?" },
    { type: "p", text: "O quiz dating se afasta do modelo padrão pela raiz. Aplicativos de swipe são construídos em torno de ver; o quiz dating, em torno de entender. Fazer perguntas é o jeito mais antigo e mais natural de as pessoas se conhecerem, e o Qulo apenas leva esse processo para dentro de um aplicativo." },
    { type: "p", text: "Num aplicativo de swipe os critérios de match são, na prática, aparência, idade e distância. No Qulo o match depende de a outra pessoa ter realmente acertado as suas respostas. Ou seja, quem dá match com você entendeu o seu jeito de pensar, os seus interesses ou os seus valores — não apenas aprovou uma foto." },
    { type: "p", text: "A ideia tem respaldo em pesquisa. Num estudo publicado em 2017 no **Journal of Personality and Social Psychology**, Huang, Yeomans, Brooks, Minson e Gino analisaram **1.961** decisões sobre um segundo encontro tomadas por **110** participantes de encontros rápidos e descobriram que quem fazia mais perguntas de acompanhamento tinha mais chance de ser convidado de novo. A curiosidade é atraente de um jeito mensurável — e um aplicativo baseado em perguntas transforma a curiosidade em requisito de entrada." },

    { type: "h2", text: "Como sair da fadiga do swipe" },
    { type: "p", text: "Se você se reconhece na descrição, algumas coisas ajudam:" },
    { type: "ul", items: [
      "Estabeleça um limite para o tempo diário que você passa em aplicativos de relacionamento",
      "Olhe os perfis de verdade em vez de deslizar no piloto automático",
      "Reserve tempo para ler o que as pessoas escreveram sobre si mesmas",
      "Faça uma tentativa real de conversar com os matches que você já tem",
      "Experimente outro método de match — **um aplicativo baseado em perguntas como o Qulo** quebra o ciclo do swipe em vez de enfeitá-lo",
    ] },

    { type: "h2", accent: "green", text: "Conclusão" },
    { type: "p", text: "A fadiga do swipe é um dos problemas que definem a cultura de relacionamentos de hoje: um fluxo infinito de perfis, decisões que custam mais do que rendem e matches finos demais para sobreviver a uma semana de mensagens. A resposta não é desistir de conhecer gente por aplicativo, e sim mudar o que o aplicativo pede de você. A aposta do Qulo é simples: conhecer alguém por perguntas é mais significativo, mais divertido e muito mais sustentável do que mais uma noite deslizando." },
  ],

  it: [
    { type: "h2", text: "Che cos'è la swipe fatigue?" },
    { type: "p", text: "La swipe fatigue è l'esaurimento mentale ed emotivo provocato dallo scorrere all'infinito i profili nelle app di incontri. Il termine si è diffuso all'inizio degli anni Venti, ma dà un nome a un problema che le persone sentivano da anni. La meccanica dello swipe, comune alla maggior parte delle grandi app, all'inizio sembra un gioco e finisce per chiudere chi gioca in un ciclo che toglie più di quanto restituisca." },
    { type: "p", text: "Chiunque abbia passato una stagione su queste app conosce lo schema. Apri l'app per abitudine, smaltisci una fila di sconosciuti, la chiudi senza una sola conversazione che valga la pena continuare e ripeti tutto la sera dopo. Portato avanti abbastanza a lungo, questo produce sovrastimolazione e un calo costante nella qualità delle decisioni che prendi." },

    { type: "h2", text: "Perché nasce la swipe fatigue?" },

    { type: "h2", text: "1. Affaticamento decisionale" },
    { type: "p", text: "Ogni swipe è una decisione, e il cervello umano non ha un budget illimitato per queste cose. Dire in continuazione \"sì\" o \"no\" a degli sconosciuti consuma la stessa capacità decisionale che ti serve per il resto della giornata. Lo psicologo Barry Schwartz descrive il seguito con il **paradosso della scelta**: davanti a troppe opzioni le persone sono meno soddisfatte di ciò che scelgono e più lente a scegliere. Nelle app di incontri questo diventa il pensiero fisso che il prossimo profilo potrebbe essere migliore." },

    { type: "h2", text: "2. Il ciclo della dopamina e la dipendenza" },
    { type: "p", text: "La meccanica dello swipe funziona come una slot machine. Ogni scorrimento porta con sé l'incertezza del \"e se piacessi anche io?\", e le ricompense imprevedibili sono esattamente lo schema che tiene un cervello attaccato alla leva. Questo sistema a ricompensa variabile trattiene l'attenzione e insieme la prosciuga. Un match dà una scarica breve di felicità, che svanisce in fretta, e il ciclo riparte." },

    { type: "h2", text: "3. Superficialità e mancanza di profondità" },
    { type: "p", text: "Nelle app basate sullo swipe la decisione arriva quasi all'istante, e soprattutto sull'aspetto fisico. In quella frazione di secondo non c'è modo di valutare la personalità, i valori, il senso dell'umorismo o lo sguardo sul mondo di qualcuno: la meccanica non lascia spazio. Il risultato è che i match restano in superficie e un legame vero si forma di rado." },

    { type: "h2", text: "4. Ghosting e comunicazione che si interrompe" },
    { type: "p", text: "La cultura dello swipe insegna a trattare le persone come usa e getta. Le conversazioni spesso muoiono dopo una manciata di messaggi, e il ghosting — sparire senza alcuna spiegazione — ha smesso di essere un'eccezione ed è diventato una parte ordinaria dell'esperienza. In chi lo subisce alimenta la sensibilità al rifiuto e una sfiducia generale verso l'intero formato." },

    { type: "h2", text: "Che cosa mostrano davvero i dati" },
    { type: "p", text: "Sulle app di incontri circolano statistiche clamorose, e la maggior parte non è riconducibile a nessuno studio reale. Un dato lo è: in un sondaggio di **Forbes Health** condotto nel 2024 insieme a **OnePoll** su **1.000** utenti di app di incontri negli Stati Uniti, il **78%** ha dichiarato di aver sperimentato un esaurimento emotivo legato agli incontri via app. Il burnout non è la lamentela di pochi sfortunati: è l'esperienza della maggioranza." },
    { type: "ul", items: [
      "**Entra fatica, non esce nulla:** sessioni lunghe passate a valutare sconosciuti che finiscono senza una sola conversazione che valga",
      "**Il prodotto è la tua attenzione:** il ciclo è costruito per tenerti a scorrere, non per farti uscire dall'app",
      "**Rendimenti decrescenti:** più profili vedi, meno ognuno di loro lascia il segno",
    ] },

    { type: "h2", accent: "green", text: "La soluzione di Qulo: match basato sulle domande" },
    { type: "p", text: "Qulo è nato per cambiare la meccanica invece di decorarla. Al posto dello swipe il match passa da domande e risposte: il giudizio istantaneo sull'aspetto esce dall'inizio del percorso e al suo posto entra qualcosa per cui puoi davvero essere conosciuto." },

    { type: "h2", text: "Come funziona?" },
    { type: "p", text: "Su Qulo scrivi da 2 a 4 domande — fino a 10 con un piano a pagamento. Riflettono la tua personalità, i tuoi interessi e le cose a cui tieni. Gli altri provano a risolverle e il match arriva con chi risponde correttamente a tutte. Poiché un match costa pensiero e non un movimento del pollice, la persona dall'altra parte ti ha dimostrabilmente prestato attenzione prima ancora che la conversazione cominci." },

    { type: "h2", text: "Perché è meglio?" },
    { type: "ul", items: [
      "**Meno match, ma migliori:** non tutti fanno match, ma chi lo fa ha già capito qualcosa di te",
      "**Prima la personalità:** il criterio di match è il tuo modo di pensare e i tuoi valori, non le tue foto",
      "**Un processo piacevole:** risolvere le domande di qualcuno è molto più coinvolgente di una fila infinita di volti",
      "**Meno ghosting:** chi investe impegno in un match è più disposto a tenere viva la conversazione",
    ] },

    { type: "quote", text: "Le domande che fai per conoscere qualcuno valgono più di centinaia di swipe." },

    { type: "h2", text: "In che cosa il quiz dating è diverso?" },
    { type: "p", text: "Il quiz dating si stacca dal modello standard alla radice. Le app basate sullo swipe sono costruite attorno al vedere; il quiz dating attorno al capire. Fare domande è il modo più antico e più naturale in cui gli esseri umani si conoscono, e Qulo non fa che spostare quel processo dentro un'app." },
    { type: "p", text: "In un'app a swipe i criteri di match sono di fatto aspetto, età e distanza. Su Qulo il match dipende dal fatto che l'altra persona abbia davvero indovinato le tue risposte. Vuol dire che chi fa match con te ha capito il tuo modo di pensare, i tuoi interessi o i tuoi valori, e non ha solo approvato una fotografia." },
    { type: "p", text: "Dietro all'idea c'è anche della ricerca. In uno studio pubblicato nel 2017 sul **Journal of Personality and Social Psychology**, Huang, Yeomans, Brooks, Minson e Gino hanno analizzato **1.961** decisioni su un secondo appuntamento prese da **110** partecipanti a speed date e hanno scoperto che chi faceva più domande di approfondimento veniva richiamato più spesso. La curiosità è attraente in modo misurabile, e un'app basata sulle domande fa della curiosità il requisito d'ingresso." },

    { type: "h2", text: "Come uscire dalla swipe fatigue" },
    { type: "p", text: "Se ti riconosci nella descrizione, qualcosa aiuta:" },
    { type: "ul", items: [
      "Metti un limite al tempo che passi ogni giorno nelle app di incontri",
      "Guarda i profili sul serio invece di scorrere con il pilota automatico",
      "Prenditi il tempo di leggere quello che le persone hanno scritto di sé",
      "Fai un tentativo vero di parlare con i match che hai già",
      "Prova un metodo di match diverso — **un'app basata sulle domande come Qulo** rompe il ciclo dello swipe invece di abbellirlo",
    ] },

    { type: "h2", accent: "green", text: "Conclusione" },
    { type: "p", text: "La swipe fatigue è uno dei problemi che definiscono la cultura degli incontri di oggi: un flusso infinito di profili, decisioni che costano più di quanto rendano e match troppo sottili per sopravvivere a una settimana di messaggi. La risposta non è rinunciare a conoscere persone tramite un'app, ma cambiare ciò che l'app ti chiede. La scommessa di Qulo è semplice: conoscersi attraverso le domande è più significativo, più divertente e molto più sostenibile di un'altra serata passata a scorrere." },
  ],

  ja: [
    { type: "h2", text: "スワイプ疲れとは何か" },
    { type: "p", text: "スワイプ疲れとは、マッチングアプリでプロフィールを延々とめくり続けることで生じる精神的・感情的な消耗のことです。この言葉が広まったのは2020年代の初めですが、指しているのは人々が何年も前から感じていた問題です。主要なマッチングアプリの多くが共有するスワイプという仕組みは、最初はゲームのように見え、やがて遊んでいる側を、返ってくるものより奪うもののほうが多い循環に閉じ込めます。" },
    { type: "p", text: "この種のアプリをひと通り使った人なら、流れは見当がつくはずです。習慣でアプリを開き、見知らぬ人の行列を片づけ、続ける価値のある会話がひとつも生まれないまま閉じ、翌日の夜も同じことを繰り返す。これが長く続くと過剰な刺激にさらされ、自分が下す判断の質が着実に落ちていきます。" },

    { type: "h2", text: "なぜスワイプ疲れは起きるのか" },

    { type: "h2", text: "1. 決断疲れ" },
    { type: "p", text: "スワイプは一回ごとが決断であり、人間の脳の決断予算は無限ではありません。見知らぬ相手に「はい」か「いいえ」を言い続けることは、その日の残りに必要な判断力をそのまま削っていきます。心理学者バリー・シュワルツの**選択のパラドックス**が、その先を説明しています。選択肢が多すぎると人は選んだものへの満足度が下がり、そもそも選ぶこと自体が遅くなる。マッチングアプリでは、これが「次の人のほうが良いかもしれない」という執拗な考えとして現れます。" },

    { type: "h2", text: "2. ドーパミンのループと依存" },
    { type: "p", text: "スワイプの仕組みはスロットマシンとよく似ています。一回ごとに「この人も自分を気に入ってくれるだろうか」という不確かさが伴い、予測できない報酬こそが脳にレバーを引かせ続けるパターンです。この変動報酬の仕組みは注意を引きつけながら、同時にそれをすり減らします。マッチが成立すると短い高揚が訪れますが、すぐに冷めてループが最初から始まります。" },

    { type: "h2", text: "3. 表面性と深さの欠如" },
    { type: "p", text: "スワイプ型のアプリでは、判断はほぼ一瞬で、しかも大部分が外見によって下されます。そのわずかな時間で相手の性格や価値観、ユーモア、世界の見方を評価する方法はありません。仕組みがその余地を残していないのです。結果としてマッチは表面的なままで、本当のつながりはめったに生まれません。" },

    { type: "h2", text: "4. ゴースティングと会話の断絶" },
    { type: "p", text: "スワイプ文化は、人を使い捨てのように扱うことを学習させます。会話はメッセージ数通で途切れることが多く、ゴースティング——説明もなく連絡を絶つこと——は例外ではなく体験のありふれた一部になりました。受け取る側では、それが拒絶への過敏さと、この形式そのものへの不信を育てます。" },

    { type: "h2", text: "データが実際に示していること" },
    { type: "p", text: "マッチングアプリについては派手な統計が出回りますが、その多くは実際の調査にたどり着けません。ひとつだけたどれる数字があります。**Forbes Health** が2024年に **OnePoll** と共同で米国のマッチングアプリ利用者 **1,000** 人を対象に行った調査では、**78%** がアプリでの出会いによる感情的な燃え尽きを経験したと答えました。燃え尽きは運の悪い一部の人の不満ではなく、多数派の体験です。" },
    { type: "ul", items: [
      "**労力は入るのに何も出てこない:** 見知らぬ人を評価するだけの長い時間が、価値ある会話をひとつも残さずに終わる",
      "**商品はあなたの注意:** ループはあなたをスクロールさせ続けるために作られていて、アプリから卒業させるためではない",
      "**逓減する見返り:** 見るプロフィールが増えるほど、一つひとつの印象は薄くなる",
    ] },

    { type: "h2", accent: "green", text: "Qulo の答え——質問によるマッチング" },
    { type: "p", text: "Qulo は、仕組みを飾るのではなく作り替えるために作られました。スワイプの代わりに、マッチングは質問と回答の上で動きます。これにより一瞬の外見判断が入口から外れ、代わりに本当に知られうる自分が置かれます。" },

    { type: "h2", text: "どう動くのか" },
    { type: "p", text: "Qulo では2問から4問の質問を書きます（有料プランなら最大10問）。質問はあなたの性格、関心、大事にしていることを映します。ほかの人がそれを解こうとし、すべてに正解した相手とマッチします。マッチの代価が親指の動きではなく思考であるため、会話が始まる前の時点で、相手はすでにあなたに注意を払ったことが証明されています。" },

    { type: "h2", text: "なぜそのほうが良いのか" },
    { type: "ul", items: [
      "**数は少なくても質は高い:** 全員とマッチするわけではないが、マッチした相手はすでにあなたの何かを理解している",
      "**まず人柄:** マッチの基準は写真ではなく、考え方と価値観",
      "**楽しい体験:** 誰かの質問を解くことは、終わりのない顔の行列よりずっと引き込まれる",
      "**ゴースティングが少ない:** マッチに手間をかけた人ほど、会話を続けようとする",
    ] },

    { type: "quote", text: "誰かを知るために投げかける質問は、何百回ものスワイプより価値がある。" },

    { type: "h2", text: "クイズ型の出会いは何が違うのか" },
    { type: "p", text: "クイズ型の出会いは、標準的なモデルと根本から異なります。スワイプ型のアプリが「見ること」を軸に作られているのに対し、クイズ型は「理解すること」を軸にしています。質問を投げかけるのは、人間が互いを知るための最も古く、最も自然な方法です。Qulo はその営みをそのままアプリに移しただけです。" },
    { type: "p", text: "スワイプ型のアプリでは、マッチの基準は実質的に外見・年齢・距離です。Qulo では、相手が本当にあなたの答えを言い当てたかどうかでマッチが決まります。つまりマッチした相手は、写真を承認しただけでなく、あなたの考え方や関心、価値観を理解しているということです。" },
    { type: "p", text: "この考えには研究の裏づけもあります。2017年に **Journal of Personality and Social Psychology** に発表された研究で、ホアン、ヨーマンズ、ブルックス、ミンソン、ジーノの各氏は、スピードデート参加者 **110** 人による **1,961** 件の二度目のデートに関する判断を分析し、フォローアップの質問を多くした人ほど再び誘われやすいことを見いだしました。好奇心は測定できるかたちで魅力的であり、質問を軸にしたアプリはその好奇心を入場条件にします。" },

    { type: "h2", text: "スワイプ疲れから抜け出すには" },
    { type: "p", text: "この説明に自分を見つけたなら、次のことが助けになります。" },
    { type: "ul", items: [
      "マッチングアプリに一日で使う時間に上限を決める",
      "自動操縦でめくらず、プロフィールをきちんと見る",
      "相手が自分について書いた文章を読む時間を取る",
      "すでにいるマッチと話すことに本気で取り組む",
      "別のマッチング方法を試す——**Qulo のような質問ベースのアプリ**は、スワイプのループを飾るのではなく断ち切る",
    ] },

    { type: "h2", accent: "green", text: "まとめ" },
    { type: "p", text: "スワイプ疲れは、現代の出会い文化を象徴する問題のひとつです。終わりのないプロフィールの流れ、見返りより高くつく判断、一週間のやり取りにも耐えられない薄いマッチ。答えはアプリで人と出会うことをやめることではなく、アプリがあなたに何を求めるかを変えることです。Qulo の賭けは単純です。質問を通じて出会うほうが、もう一晩スワイプに費やすよりも意味があり、楽しく、はるかに長続きします。" },
  ],

  ko: [
    { type: "h2", text: "스와이프 피로란 무엇인가" },
    { type: "p", text: "스와이프 피로는 데이팅 앱에서 프로필을 끝없이 넘기며 생기는 정신적·정서적 소진을 말합니다. 이 표현은 2020년대 초에 퍼졌지만, 사람들이 이미 몇 년째 느껴온 문제를 뒤늦게 부른 이름입니다. 주요 데이팅 앱 대부분이 공유하는 스와이프 방식은 처음에는 게임처럼 보이지만, 결국 사용자를 돌려주는 것보다 가져가는 것이 더 많은 순환에 가둡니다." },
    { type: "p", text: "이런 앱에서 한 계절을 보낸 사람이라면 흐름을 압니다. 습관처럼 앱을 열고, 낯선 사람들의 줄을 처리하고, 이어갈 만한 대화 하나 없이 앱을 닫고, 다음 날 저녁에 같은 일을 반복합니다. 충분히 오래 지속되면 과잉 자극이 쌓이고, 내리는 판단의 질이 꾸준히 떨어집니다." },

    { type: "h2", text: "스와이프 피로는 왜 생기는가" },

    { type: "h2", text: "1. 결정 피로" },
    { type: "p", text: "스와이프는 한 번마다 하나의 결정이고, 인간의 뇌가 결정에 쓸 수 있는 예산은 무한하지 않습니다. 낯선 사람에게 쉬지 않고 “예” 또는 “아니오”를 말하는 일은 하루의 나머지를 위해 필요한 판단력을 그대로 깎아냅니다. 심리학자 배리 슈워츠의 **선택의 역설**이 그다음을 설명합니다. 선택지가 너무 많으면 사람은 자기가 고른 것에 덜 만족하고, 고르는 일 자체도 느려집니다. 데이팅 앱에서는 이것이 “다음 사람이 더 나을지도 모른다”는 집요한 생각으로 나타납니다." },

    { type: "h2", text: "2. 도파민 루프와 중독" },
    { type: "p", text: "스와이프 방식은 슬롯머신처럼 작동합니다. 넘길 때마다 “이 사람도 나를 좋아할까?”라는 불확실성이 따라오고, 예측할 수 없는 보상이야말로 뇌가 레버를 계속 당기게 만드는 패턴입니다. 이 가변 보상 체계는 주의를 붙잡아 두는 동시에 소진시킵니다. 매치가 뜨면 짧은 행복감이 오지만 금세 식고, 루프는 처음부터 다시 시작됩니다." },

    { type: "h2", text: "3. 피상성과 깊이의 부재" },
    { type: "p", text: "스와이프 기반 앱에서는 판단이 거의 즉시, 그것도 대부분 외모로 내려집니다. 그 찰나에 누군가의 성격이나 가치관, 유머 감각, 세계관을 평가할 방법은 없습니다. 방식 자체가 그럴 여지를 남기지 않기 때문입니다. 그래서 매치는 표면에 머물고 진짜 연결은 좀처럼 생기지 않습니다." },

    { type: "h2", text: "4. 잠수와 대화의 단절" },
    { type: "p", text: "스와이프 문화는 사람을 일회용처럼 대하도록 길들입니다. 대화는 메시지 몇 개 만에 끊기는 일이 잦고, 아무 설명 없이 연락을 끊는 잠수는 예외가 아니라 경험의 평범한 일부가 되었습니다. 그것을 겪는 쪽에서는 거절에 대한 민감함과 이 형식 전체에 대한 불신이 자랍니다." },

    { type: "h2", text: "데이터가 실제로 말해주는 것" },
    { type: "p", text: "데이팅 앱에 관해 자극적인 통계가 돌아다니지만, 대부분은 실제 연구까지 거슬러 올라가지 않습니다. 하나는 올라갑니다. **Forbes Health**가 2024년 **OnePoll**과 함께 미국의 데이팅 앱 사용자 **1,000**명을 대상으로 진행한 조사에서 **78%**가 앱을 통한 만남으로 정서적 번아웃을 겪었다고 답했습니다. 번아웃은 운 나쁜 소수의 불평이 아니라 다수의 경험입니다." },
    { type: "ul", items: [
      "**노력은 들어가는데 나오는 것이 없다:** 낯선 사람을 평가하는 긴 시간이 이어갈 만한 대화 하나 없이 끝난다",
      "**상품은 당신의 주의력이다:** 루프는 당신을 계속 넘기게 하려고 설계되었지, 앱에서 졸업시키려고 만들어지지 않았다",
      "**수확 체감:** 프로필을 많이 볼수록 하나하나가 남기는 인상은 옅어진다",
    ] },

    { type: "h2", accent: "green", text: "Qulo의 해법: 질문 기반 매칭" },
    { type: "p", text: "Qulo는 방식을 꾸미는 대신 바꾸려고 만들어졌습니다. 스와이프 대신 매칭이 질문과 답으로 굴러가고, 그 결과 순간적인 외모 판단이 과정의 맨 앞에서 빠지고 그 자리에 실제로 당신을 알아볼 수 있는 무언가가 들어섭니다." },

    { type: "h2", text: "어떻게 작동하나요?" },
    { type: "p", text: "Qulo에서는 2개에서 4개 사이의 질문을 씁니다 — 유료 플랜에서는 최대 10개입니다. 질문은 당신의 성격과 관심사, 중요하게 여기는 것을 담습니다. 다른 사람들이 그 질문을 풀고, 전부 맞힌 사람과 매치됩니다. 매치의 대가가 엄지 움직임이 아니라 생각이기 때문에, 대화가 시작되기도 전에 상대가 당신에게 주의를 기울였다는 사실이 증명됩니다." },

    { type: "h2", text: "왜 더 나은가요?" },
    { type: "ul", items: [
      "**적지만 더 나은 매치:** 모두와 매치되지는 않지만, 매치된 사람은 이미 당신에 대해 무언가를 이해했다",
      "**성격이 먼저:** 매칭 기준은 사진이 아니라 생각하는 방식과 가치관이다",
      "**즐거운 과정:** 누군가의 질문을 푸는 일은 끝없는 얼굴의 줄보다 훨씬 몰입된다",
      "**잠수가 적다:** 매치에 공을 들인 사람일수록 대화를 이어가려 한다",
    ] },

    { type: "quote", text: "누군가를 알기 위해 던지는 질문은 수백 번의 스와이프보다 값지다." },

    { type: "h2", text: "퀴즈 데이팅은 무엇이 다른가" },
    { type: "p", text: "퀴즈 데이팅은 표준 모델과 뿌리부터 갈라집니다. 스와이프 기반 앱이 보는 것을 중심에 두었다면, 퀴즈 데이팅은 이해하는 것을 중심에 둡니다. 질문을 던지는 일은 사람이 서로를 알아가는 가장 오래되고 가장 자연스러운 방법이고, Qulo는 그 과정을 그대로 앱으로 옮겼을 뿐입니다." },
    { type: "p", text: "스와이프 기반 앱에서 매칭 기준은 사실상 외모와 나이, 거리입니다. Qulo에서는 상대가 당신의 답을 실제로 맞혔는지에 따라 매치가 결정됩니다. 즉 당신과 매치된 사람은 사진을 승인한 것이 아니라 당신의 사고방식이나 관심사, 가치관을 이해한 것입니다." },
    { type: "p", text: "이 발상에는 연구의 뒷받침도 있습니다. 2017년 **Journal of Personality and Social Psychology**에 실린 연구에서 황, 요먼스, 브룩스, 민슨, 지노는 스피드 데이팅 참가자 **110**명이 내린 **1,961**건의 두 번째 데이트 결정을 분석해, 후속 질문을 더 많이 한 사람이 다시 초대받을 가능성이 높다는 사실을 확인했습니다. 호기심은 측정 가능한 방식으로 매력적이며, 질문 기반 앱은 그 호기심을 입장 조건으로 삼습니다." },

    { type: "h2", text: "스와이프 피로에서 벗어나는 법" },
    { type: "p", text: "이 설명에서 자신을 발견했다면 다음이 도움이 됩니다." },
    { type: "ul", items: [
      "데이팅 앱에 하루에 쓰는 시간에 상한을 두세요",
      "자동으로 넘기는 대신 프로필을 제대로 보세요",
      "사람들이 자기에 대해 써 둔 글을 읽는 시간을 가지세요",
      "이미 매치된 사람들과 이야기해 보려고 진짜로 시도하세요",
      "다른 매칭 방식을 시도해 보세요 — **Qulo 같은 질문 기반 앱**은 스와이프 루프를 포장하는 대신 끊어냅니다",
    ] },

    { type: "h2", accent: "green", text: "결론" },
    { type: "p", text: "스와이프 피로는 오늘날 연애 문화를 규정하는 문제 중 하나입니다. 끝없는 프로필의 흐름, 얻는 것보다 비싼 결정, 일주일의 메시지도 버티지 못할 만큼 얇은 매치. 답은 앱으로 사람을 만나는 일을 그만두는 것이 아니라, 앱이 당신에게 무엇을 요구하는지를 바꾸는 것입니다. Qulo의 베팅은 단순합니다. 질문을 통해 만나는 편이 하룻밤 더 스와이프하는 것보다 더 의미 있고, 더 즐겁고, 훨씬 오래갑니다." },
  ],

  zh: [
    { type: "h2", text: "什么是滑动疲劳？" },
    { type: "p", text: "滑动疲劳，指的是在交友软件里不停地划过一张张资料所带来的精神和情绪耗竭。这个说法在 2020 年代初流行起来，但它描述的问题人们早已感受了很多年。多数主流交友软件共用的滑动机制，一开始像游戏，最后却把玩的人困在一个索取多于给予的循环里。" },
    { type: "p", text: "在这类软件上待过一阵子的人都熟悉那套流程：出于习惯打开软件，处理掉一队陌生人，关掉时没有一段值得继续的对话，第二天晚上再重复一遍。持续得够久，就会带来过度刺激，你所做判断的质量也会稳步下滑。" },

    { type: "h2", text: "滑动疲劳为什么会出现？" },

    { type: "h2", text: "1. 决策疲劳" },
    { type: "p", text: "每一次滑动都是一次决定，而人脑用于决策的预算并非无限。不停地对陌生人说“是”或“不是”，消耗的正是你一天剩下的时间里所需要的判断力。心理学家巴里·施瓦茨提出的**选择的悖论**说明了接下来会发生什么：当可选项太多时，人对自己的选择更不满意，也更难做出选择。在交友软件里，这表现为一个挥之不去的念头——下一个也许更好。" },

    { type: "h2", text: "2. 多巴胺循环与成瘾" },
    { type: "p", text: "滑动机制的运作方式很像老虎机。每一次滑动都带着“这个人会不会也喜欢我”的不确定，而不可预测的奖励恰恰是让大脑不断去拉杆的那种模式。这套可变奖励系统一边抓住你的注意力，一边把它耗干。配对出现时会有短暂的兴奋，很快消退，循环从头开始。" },

    { type: "h2", text: "3. 表面化与缺乏深度" },
    { type: "p", text: "在以滑动为核心的软件里，判断几乎是瞬间做出的，而且主要基于外表。在那一瞬间，没有办法评估一个人的性格、价值观、幽默感或者看待世界的方式——机制本身没有为此留出空间。结果就是配对停留在表面，真正的连接很少发生。" },

    { type: "h2", text: "4. 突然失联与沟通断裂" },
    { type: "p", text: "滑动文化训练人们把彼此当成一次性的。对话常常在几条消息之后就断了，而不作任何解释地消失，已经从例外变成了这种体验里再平常不过的一部分。对被这样对待的人来说，它滋养的是对被拒绝的敏感，以及对整套形式的不信任。" },

    { type: "h2", text: "证据究竟说明了什么" },
    { type: "p", text: "关于交友软件的耸动数据到处流传，其中大多数追溯不到任何真实研究。有一个数字可以：在 **Forbes Health** 于 2024 年联合 **OnePoll** 面向美国 **1,000** 名交友软件用户所做的调查中，**78%** 的受访者表示自己曾因通过软件约会而感到情绪耗竭。倦怠不是少数倒霉用户的抱怨，而是多数人的经历。" },
    { type: "ul", items: [
      "**投入很多，产出为零：** 花很长时间评估陌生人，结束时却没有一段值得的对话",
      "**产品其实是你的注意力：** 这个循环的设计目的是让你继续滑，而不是让你从软件里毕业",
      "**边际递减：** 看的资料越多，每一份留下的印象就越淡",
    ] },

    { type: "h2", accent: "green", text: "Qulo 的解法：以问题匹配" },
    { type: "p", text: "Qulo 的出发点是改造机制，而不是给它加装饰。匹配不再依赖滑动，而是依赖提问与作答；于是那种一瞬间对外表的判断被移出了流程的开头，取而代之的是你真正能被认识的那一面。" },

    { type: "h2", text: "它是怎么运作的？" },
    { type: "p", text: "在 Qulo 上，你写下 2 到 4 个问题；付费方案最多 10 道。这些问题反映你的性格、兴趣和在意的事。别人尝试解答，全部答对的人才会和你配对。因为一次配对的代价是思考而不是拇指的动作，所以在对话开始之前，对方就已经明确地把注意力放在了你身上。" },

    { type: "h2", text: "为什么它更好？" },
    { type: "ul", items: [
      "**更少但更好的配对：** 不是所有人都能配上，但配上的人已经理解了你的某一面",
      "**性格优先：** 匹配标准是你的思维方式和价值观，而不是你的照片",
      "**过程本身有趣：** 解开一个人的问题，比刷过没有尽头的面孔要投入得多",
      "**更少的失联：** 为一次配对付出过力气的人，更愿意让对话继续下去",
    ] },

    { type: "quote", text: "为了认识一个人而提出的问题，比几百次滑动都更有价值。" },

    { type: "h2", text: "问答式约会有何不同？" },
    { type: "p", text: "问答式约会与标准模式的分歧发生在根部。以滑动为核心的软件围绕“看”来构建，问答式约会围绕“懂”来构建。向对方提问，是人类相互认识最古老也最自然的方式，Qulo 只是把这个过程搬进了一个应用里。" },
    { type: "p", text: "在滑动式软件里，匹配标准实际上只有外表、年龄和距离。在 Qulo 上，配对取决于对方是否真的答对了你的问题。也就是说，和你配对的人理解了你的思路、兴趣或价值观，而不只是认可了一张照片。" },
    { type: "p", text: "这个想法也有研究支撑。在 2017 年发表于 **Journal of Personality and Social Psychology** 的一项研究中，Huang、Yeomans、Brooks、Minson 与 Gino 分析了 **110** 位快速约会参与者做出的 **1,961** 次是否再见一面的决定，发现追问更多的人更容易被再次邀约。好奇心以一种可测量的方式显得有吸引力——而以问题为核心的应用，正是把好奇心变成了入场条件。" },

    { type: "h2", text: "如何走出滑动疲劳" },
    { type: "p", text: "如果你在上面的描述里认出了自己，下面几件事会有帮助：" },
    { type: "ul", items: [
      "给自己每天花在交友软件上的时间设一个上限",
      "认真看资料，别在自动驾驶状态下一直滑",
      "花点时间读读别人写下的自我介绍",
      "对已经配对的人，认真尝试聊起来",
      "试试别的匹配方式——**像 Qulo 这样以问题为核心的应用**是打断滑动循环，而不是把它包装得更好看",
    ] },

    { type: "h2", accent: "green", text: "结语" },
    { type: "p", text: "滑动疲劳是当代约会文化最典型的问题之一：无尽的资料流、代价高于回报的判断，以及薄到撑不过一周聊天的配对。答案不是放弃通过应用认识人，而是改变应用对你的要求。Qulo 的赌注很简单：通过问题相识，比再刷一晚上更有意义、更有意思，也更长久。" },
  ],

  nl: [
    { type: "h2", text: "Wat is swipemoeheid?" },
    { type: "p", text: "Swipemoeheid is de mentale en emotionele uitputting die ontstaat door eindeloos door profielen te vegen in datingapps. De term werd populair aan het begin van de jaren twintig, maar hij benoemt een probleem dat mensen al jaren voelden. De swipemechaniek die de meeste grote datingapps delen lijkt eerst een spel, en sluit de spelers uiteindelijk op in een cyclus die meer wegneemt dan teruggeeft." },
    { type: "p", text: "Wie een tijd op deze apps heeft doorgebracht kent het patroon. Je opent de app uit gewoonte, werkt een rij vreemden af, sluit hem zonder één gesprek dat het voortzetten waard is, en herhaalt het geheel de volgende avond. Lang genoeg volgehouden levert dat overprikkeling op en een gestage daling in de kwaliteit van de beslissingen die je neemt." },

    { type: "h2", text: "Waarom ontstaat swipemoeheid?" },

    { type: "h2", text: "1. Beslissingsmoeheid" },
    { type: "p", text: "Elke swipe is een beslissing, en het menselijk brein heeft daarvoor geen onbeperkt budget. Voortdurend \"ja\" of \"nee\" zeggen tegen vreemden put precies het beslisvermogen uit dat je voor de rest van je dag nodig hebt. Psycholoog Barry Schwartz beschrijft met de **paradox van de keuze** wat er daarna gebeurt: bij te veel opties zijn mensen minder tevreden met wat ze kiezen en kiezen ze trager. In datingapps wordt dat de knagende gedachte dat het volgende profiel beter zou kunnen zijn." },

    { type: "h2", text: "2. De dopamineloop en verslaving" },
    { type: "p", text: "De swipemechaniek werkt als een gokautomaat. Bij elke veeg hangt de onzekerheid in de lucht: \"vindt deze persoon mij ook leuk?\" Onvoorspelbare beloningen zijn precies het patroon dat een brein aan de hendel houdt. Dit systeem van wisselende beloning houdt je aandacht vast en put haar tegelijk uit. Een match geeft een korte flits van geluk, die snel wegebt, en de lus begint opnieuw." },

    { type: "h2", text: "3. Oppervlakkigheid en gebrek aan diepgang" },
    { type: "p", text: "In swipe-apps valt de beslissing vrijwel onmiddellijk, en vooral op uiterlijk. In die fractie van een seconde is er geen manier om iemands persoonlijkheid, waarden, humor of kijk op de wereld te beoordelen — de mechaniek laat er simpelweg geen ruimte voor. Het gevolg is dat matches oppervlakkig blijven en echte verbinding zelden ontstaat." },

    { type: "h2", text: "4. Ghosting en haperende communicatie" },
    { type: "p", text: "De swipecultuur leert mensen elkaar als wegwerpartikelen te behandelen. Gesprekken stranden vaak na een handvol berichten, en ghosting — het contact verbreken zonder enige uitleg — is van uitzondering een gewoon onderdeel van de ervaring geworden. Bij degene die het overkomt voedt het gevoeligheid voor afwijzing en wantrouwen tegenover het hele format." },

    { type: "h2", text: "Wat het bewijs werkelijk laat zien" },
    { type: "p", text: "Er circuleren spectaculaire statistieken over datingapps, en de meeste zijn tot geen enkel echt onderzoek te herleiden. Eén cijfer wel: in een onderzoek van **Forbes Health** dat in 2024 samen met **OnePoll** werd uitgevoerd onder **1.000** gebruikers van datingapps in de Verenigde Staten zei **78%** emotionele burn-out te hebben ervaren van daten via apps. Burn-out is geen klacht van een handvol pechvogels, maar de ervaring van de meerderheid." },
    { type: "ul", items: [
      "**Moeite erin, niets eruit:** lange sessies waarin je vreemden beoordeelt en die eindigen zonder één gesprek dat de moeite waard is",
      "**Het product is jouw aandacht:** de lus is gebouwd om je te laten scrollen, niet om je uit de app te laten afstuderen",
      "**Afnemende opbrengst:** hoe meer profielen je ziet, hoe minder er van elk afzonderlijk blijft hangen",
    ] },

    { type: "h2", accent: "green", text: "De oplossing van Qulo: matchen op vragen" },
    { type: "p", text: "Qulo is gebouwd om de mechaniek te veranderen in plaats van te versieren. In plaats van swipen draait het matchen op vragen en antwoorden: het bliksemsnelle oordeel over uiterlijk verdwijnt van de voorkant van het proces en er komt iets voor in de plaats waarom je werkelijk gekend kunt worden." },

    { type: "h2", text: "Hoe werkt het?" },
    { type: "p", text: "Op Qulo schrijf je tussen de 2 en 4 vragen — tot 10 met een betaald abonnement. Ze weerspiegelen je persoonlijkheid, je interesses en wat je belangrijk vindt. Anderen proberen ze op te lossen, en je matcht met degene die ze allemaal goed beantwoordt. Omdat een match denkwerk kost en geen duimbeweging, heeft de persoon aan de andere kant aantoonbaar aandacht aan je besteed nog voordat het gesprek begint." },

    { type: "h2", text: "Waarom is dit beter?" },
    { type: "ul", items: [
      "**Minder maar betere matches:** niet iedereen matcht, maar wie het doet heeft al iets van je begrepen",
      "**Persoonlijkheid eerst:** je manier van denken en je waarden zijn het matchcriterium, niet je foto's",
      "**Een leuk proces:** iemands vragen oplossen is veel boeiender dan een eindeloze rij gezichten",
      "**Minder ghosting:** wie moeite in een match steekt, houdt het gesprek eerder levend",
    ] },

    { type: "quote", text: "De vragen die je stelt om iemand te leren kennen zijn meer waard dan honderden swipes." },

    { type: "h2", text: "Wat maakt quizdating anders?" },
    { type: "p", text: "Quizdating wijkt bij de wortel af van het standaardmodel. Swipe-apps zijn gebouwd rond zien; quizdating rond begrijpen. Iemand vragen stellen is de oudste en meest natuurlijke manier waarop mensen elkaar leren kennen, en Qulo verplaatst dat proces simpelweg naar een app." },
    { type: "p", text: "In een swipe-app zijn de matchcriteria in de praktijk uiterlijk, leeftijd en afstand. Op Qulo hangt de match ervan af of de ander je antwoorden echt goed had. Dat betekent dat degene met wie je matcht je denkwijze, je interesses of je waarden heeft begrepen — en niet alleen een foto heeft goedgekeurd." },
    { type: "p", text: "Er zit ook onderzoek achter het idee. In een studie die in 2017 verscheen in het **Journal of Personality and Social Psychology** analyseerden Huang, Yeomans, Brooks, Minson en Gino **1.961** beslissingen over een tweede date van **110** deelnemers aan speeddates, en zij vonden dat wie meer vervolgvragen stelde vaker opnieuw werd gevraagd. Nieuwsgierigheid blijkt op meetbare wijze aantrekkelijk — en een app die op vragen draait maakt nieuwsgierigheid tot toegangseis." },

    { type: "h2", text: "Hoe kom je uit de swipemoeheid?" },
    { type: "p", text: "Herken je jezelf in de beschrijving, dan helpt het volgende:" },
    { type: "ul", items: [
      "Stel een limiet aan de tijd die je dagelijks in datingapps doorbrengt",
      "Bekijk profielen echt in plaats van op de automatische piloot te swipen",
      "Neem de tijd om te lezen wat mensen over zichzelf hebben geschreven",
      "Doe een serieuze poging om te praten met de matches die je al hebt",
      "Probeer een andere manier van matchen — **een app op basis van vragen zoals Qulo** doorbreekt de swipelus in plaats van hem op te leuken",
    ] },

    { type: "h2", accent: "green", text: "Conclusie" },
    { type: "p", text: "Swipemoeheid is een van de bepalende problemen van de moderne datingcultuur: een eindeloze stroom profielen, beslissingen die meer kosten dan ze opleveren en matches die te dun zijn om een week appen te overleven. Het antwoord is niet om het leren kennen van mensen via een app op te geven. Het antwoord is om te veranderen wat de app van je vraagt. De inzet van Qulo is eenvoudig: elkaar leren kennen via vragen is betekenisvoller, leuker en veel duurzamer dan nog een avond swipen." },
  ],

  pl: [
    { type: "h2", text: "Czym jest zmęczenie swipe'owaniem?" },
    { type: "p", text: "Zmęczenie swipe'owaniem to psychiczne i emocjonalne wyczerpanie wywołane bezustannym przewijaniem profili w aplikacjach randkowych. Termin spopularyzował się na początku lat dwudziestych, ale nazywa problem, który ludzie odczuwali od lat. Mechanika przesuwania, wspólna dla większości dużych aplikacji, na początku wygląda jak gra, a ostatecznie zamyka grających w pętli, która zabiera więcej, niż oddaje." },
    { type: "p", text: "Każdy, kto spędził w takich aplikacjach jakiś czas, zna ten schemat. Otwierasz aplikację z przyzwyczajenia, przerabiasz kolejkę nieznajomych, zamykasz ją bez ani jednej rozmowy wartej kontynuowania i powtarzasz to wszystko następnego wieczoru. Utrzymywane dostatecznie długo, daje to przebodźcowanie i stały spadek jakości podejmowanych decyzji." },

    { type: "h2", text: "Skąd bierze się zmęczenie swipe'owaniem?" },

    { type: "h2", text: "1. Zmęczenie decyzyjne" },
    { type: "p", text: "Każde przesunięcie to decyzja, a ludzki mózg nie ma na nie nieograniczonego budżetu. Nieustanne mówienie nieznajomym \"tak\" albo \"nie\" zużywa dokładnie tę zdolność decydowania, której potrzebujesz na resztę dnia. Psycholog Barry Schwartz opisuje dalszy ciąg **paradoksem wyboru**: gdy opcji jest zbyt wiele, ludzie są mniej zadowoleni z tego, co wybrali, i wolniej podejmują decyzję. W aplikacjach randkowych przybiera to postać natrętnej myśli, że następny profil może być lepszy." },

    { type: "h2", text: "2. Pętla dopaminowa i uzależnienie" },
    { type: "p", text: "Mechanika przesuwania działa jak automat do gry. Przy każdym ruchu wisi w powietrzu niepewność: \"czy ta osoba też mnie polubi?\", a nieprzewidywalne nagrody to dokładnie ten schemat, który każe mózgowi ciągnąć za dźwignię. Ten system zmiennej nagrody przytrzymuje uwagę i jednocześnie ją wyjaławia. Dopasowanie daje krótki zastrzyk radości, który szybko gaśnie, i pętla rusza od nowa." },

    { type: "h2", text: "3. Powierzchowność i brak głębi" },
    { type: "p", text: "W aplikacjach opartych na przesuwaniu decyzja zapada niemal natychmiast i przede wszystkim na podstawie wyglądu. W tym ułamku sekundy nie sposób ocenić czyjejś osobowości, wartości, poczucia humoru ani spojrzenia na świat — mechanika po prostu nie zostawia na to miejsca. W efekcie dopasowania pozostają powierzchowne, a prawdziwa więź powstaje rzadko." },

    { type: "h2", text: "4. Ghosting i urwana komunikacja" },
    { type: "p", text: "Kultura przesuwania uczy traktowania ludzi jak rzeczy jednorazowych. Rozmowy często umierają po kilku wiadomościach, a ghosting — zerwanie kontaktu bez żadnego wyjaśnienia — przestał być wyjątkiem i stał się zwyczajną częścią doświadczenia. U osoby, która tego doświadcza, karmi to wrażliwość na odrzucenie i ogólną nieufność wobec całego formatu." },

    { type: "h2", text: "Co naprawdę pokazują dane" },
    { type: "p", text: "O aplikacjach randkowych krążą efektowne statystyki, a większości z nich nie da się doprowadzić do żadnego prawdziwego badania. Jedną liczbę da się: w sondażu **Forbes Health** przeprowadzonym w 2024 roku wspólnie z **OnePoll** wśród **1000** użytkowników aplikacji randkowych w Stanach Zjednoczonych **78%** stwierdziło, że doświadczyło emocjonalnego wypalenia przez randkowanie w aplikacjach. Wypalenie nie jest skargą garstki pechowców, tylko doświadczeniem większości." },
    { type: "ul", items: [
      "**Wysiłek wchodzi, nic nie wychodzi:** długie sesje oceniania nieznajomych, które kończą się bez ani jednej wartościowej rozmowy",
      "**Produktem jest twoja uwaga:** pętla została zbudowana po to, żebyś przewijał dalej, a nie po to, żebyś opuścił aplikację",
      "**Malejące zyski:** im więcej profili widzisz, tym mniej zostaje z każdego z osobna",
    ] },

    { type: "h2", accent: "green", text: "Rozwiązanie Qulo: dopasowanie przez pytania" },
    { type: "p", text: "Qulo powstało po to, żeby zmienić mechanikę, a nie ją ozdobić. Zamiast przesuwania dopasowanie opiera się na pytaniach i odpowiedziach: błyskawiczny osąd wyglądu znika z początku procesu, a jego miejsce zajmuje coś, z czego naprawdę można cię poznać." },

    { type: "h2", text: "Jak to działa?" },
    { type: "p", text: "W Qulo piszesz od 2 do 4 pytań — do 10 w planie płatnym. Odzwierciedlają twoją osobowość, zainteresowania i to, na czym ci zależy. Inni próbują je rozwiązać, a dopasowanie następuje z tym, kto odpowie poprawnie na wszystkie. Ponieważ dopasowanie kosztuje myślenie, a nie ruch kciukiem, osoba po drugiej stronie w wymierny sposób poświęciła ci uwagę, zanim rozmowa w ogóle się zaczęła." },

    { type: "h2", text: "Dlaczego to lepsze?" },
    { type: "ul", items: [
      "**Mniej, ale lepszych dopasowań:** nie każdy się dopasuje, ale kto to zrobi, już coś o tobie zrozumiał",
      "**Najpierw osobowość:** kryterium dopasowania jest twój sposób myślenia i twoje wartości, a nie zdjęcia",
      "**Przyjemny proces:** rozwiązywanie czyichś pytań wciąga o wiele bardziej niż nieskończona kolejka twarzy",
      "**Mniej ghostingu:** kto włożył wysiłek w dopasowanie, chętniej podtrzymuje rozmowę",
    ] },

    { type: "quote", text: "Pytania, które zadajesz, żeby kogoś poznać, są warte więcej niż setki przesunięć." },

    { type: "h2", text: "Czym różni się randkowanie przez pytania?" },
    { type: "p", text: "Randkowanie przez pytania rozchodzi się ze standardowym modelem u samego korzenia. Aplikacje oparte na przesuwaniu zbudowano wokół patrzenia, randkowanie przez pytania — wokół rozumienia. Zadawanie pytań to najstarszy i najbardziej naturalny sposób, w jaki ludzie się poznają, a Qulo po prostu przenosi ten proces do aplikacji." },
    { type: "p", text: "W aplikacji opartej na przesuwaniu kryteriami dopasowania są w praktyce wygląd, wiek i odległość. W Qulo dopasowanie zależy od tego, czy druga osoba naprawdę trafiła w twoje odpowiedzi. To znaczy, że ktoś, kto się z tobą dopasował, zrozumiał twój sposób myślenia, zainteresowania albo wartości, a nie tylko zaakceptował zdjęcie." },
    { type: "p", text: "Za tym pomysłem stoi też badanie. W pracy opublikowanej w 2017 roku w **Journal of Personality and Social Psychology** Huang, Yeomans, Brooks, Minson i Gino przeanalizowali **1961** decyzji o drugiej randce podjętych przez **110** uczestników szybkich randek i stwierdzili, że osoby zadające więcej pytań pogłębiających częściej były zapraszane ponownie. Ciekawość okazuje się atrakcyjna w mierzalny sposób — a aplikacja oparta na pytaniach czyni z ciekawości warunek wstępu." },

    { type: "h2", text: "Jak wyjść ze zmęczenia swipe'owaniem" },
    { type: "p", text: "Jeśli rozpoznajesz się w tym opisie, pomaga kilka rzeczy:" },
    { type: "ul", items: [
      "Ustal limit czasu, jaki dziennie spędzasz w aplikacjach randkowych",
      "Oglądaj profile naprawdę, zamiast przesuwać na autopilocie",
      "Znajdź czas, żeby przeczytać, co ludzie napisali o sobie",
      "Podejmij prawdziwą próbę rozmowy z dopasowaniami, które już masz",
      "Spróbuj innej metody dopasowania — **aplikacja oparta na pytaniach, taka jak Qulo**, przerywa pętlę przesuwania, zamiast ją upiększać",
    ] },

    { type: "h2", accent: "green", text: "Podsumowanie" },
    { type: "p", text: "Zmęczenie swipe'owaniem to jeden z problemów definiujących współczesną kulturę randkowania: nieskończony strumień profili, decyzje kosztujące więcej, niż dają, i dopasowania zbyt cienkie, by przetrwać tydzień pisania. Odpowiedzią nie jest rezygnacja z poznawania ludzi przez aplikację, tylko zmiana tego, czego aplikacja od ciebie wymaga. Zakład Qulo jest prosty: poznawanie się przez pytania ma więcej sensu, daje więcej frajdy i jest o wiele trwalsze niż kolejny wieczór przesuwania." },
  ],

  sv: [
    { type: "h2", text: "Vad är swipe-trötthet?" },
    { type: "p", text: "Swipe-trötthet är den mentala och känslomässiga utmattning som uppstår av att svepa genom profiler i det oändliga i dejtingappar. Begreppet blev populärt i början av 2020-talet, men det sätter namn på ett problem som människor känt av i åratal. Swipe-mekaniken, som de flesta stora dejtingappar delar, ser först ut som ett spel och låser till slut in den som spelar i en slinga som tar mer än den ger tillbaka." },
    { type: "p", text: "Den som tillbringat en säsong i de här apparna känner igen mönstret. Du öppnar appen av vana, betar av en kö av främlingar, stänger den utan ett enda samtal värt att fortsätta och upprepar alltihop nästa kväll. Hålls det på tillräckligt länge ger det överstimulering och en stadig försämring av kvaliteten på de beslut du fattar." },

    { type: "h2", text: "Varför uppstår swipe-trötthet?" },

    { type: "h2", text: "1. Beslutströtthet" },
    { type: "p", text: "Varje svep är ett beslut, och den mänskliga hjärnan har ingen obegränsad budget för sådana. Att oavbrutet säga \"ja\" eller \"nej\" till främlingar tär på precis den beslutsförmåga du behöver för resten av dagen. Psykologen Barry Schwartz beskriver fortsättningen med **valets paradox**: när människor får för många alternativ blir de mindre nöjda med det de väljer och långsammare på att välja alls. I dejtingappar visar det sig som den gnagande tanken att nästa profil kanske är bättre." },

    { type: "h2", text: "2. Dopaminslingan och beroendet" },
    { type: "p", text: "Swipe-mekaniken fungerar som en enarmad bandit. Varje svep bär på osäkerheten \"kommer den här personen att gilla mig tillbaka?\", och oförutsägbara belöningar är precis det mönster som får en hjärna att dra i spaken igen. Det här systemet med rörlig belöning håller kvar uppmärksamheten samtidigt som det tömmer den. En matchning ger en kort lyckokick som snabbt klingar av, och slingan börjar om." },

    { type: "h2", text: "3. Ytlighet och brist på djup" },
    { type: "p", text: "I swipe-baserade appar fattas beslutet nästan omedelbart, och mest utifrån utseende. På den bråkdelen av en sekund går det inte att bedöma någons personlighet, värderingar, humor eller syn på världen — mekaniken lämnar helt enkelt inget utrymme för det. Följden är att matchningarna förblir ytliga och att äkta kontakt sällan uppstår." },

    { type: "h2", text: "4. Ghosting och avbruten kommunikation" },
    { type: "p", text: "Swipe-kulturen lär människor att behandla varandra som engångsartiklar. Samtal dör ofta efter en handfull meddelanden, och ghosting — att bryta kontakten utan någon förklaring — har slutat vara ett undantag och blivit en vanlig del av upplevelsen. Hos den som drabbas göder det känsligheten för avvisning och en allmän misstro mot hela formatet." },

    { type: "h2", text: "Vad underlaget faktiskt visar" },
    { type: "p", text: "Det cirkulerar dramatiska siffror om dejtingappar, och de flesta går inte att spåra till någon verklig studie. En siffra går: i en undersökning från **Forbes Health** som 2024 genomfördes tillsammans med **OnePoll** bland **1 000** användare av dejtingappar i USA uppgav **78 %** att de upplevt känslomässig utbrändhet av att dejta via app. Utbrändhet är inte ett gnäll från några få otursförföljda, utan majoritetens erfarenhet." },
    { type: "ul", items: [
      "**Möda in, ingenting ut:** långa pass av att bedöma främlingar som slutar utan ett enda samtal värt namnet",
      "**Produkten är din uppmärksamhet:** slingan är byggd för att hålla dig kvar i flödet, inte för att låta dig ta examen från appen",
      "**Avtagande avkastning:** ju fler profiler du ser, desto mindre fastnar var och en av dem",
    ] },

    { type: "h2", accent: "green", text: "Qulos lösning: matchning genom frågor" },
    { type: "p", text: "Qulo byggdes för att ändra mekaniken snarare än att dekorera den. I stället för svep vilar matchningen på frågor och svar: det blixtsnabba omdömet om utseendet försvinner från början av processen och ersätts av något du faktiskt kan bli känd för." },

    { type: "h2", text: "Hur fungerar det?" },
    { type: "p", text: "På Qulo skriver du mellan 2 och 4 frågor — upp till 10 med ett betalt abonnemang. De speglar din personlighet, dina intressen och det du bryr dig om. Andra försöker lösa dem, och du matchar med den som svarar rätt på alla. Eftersom en matchning kostar tankearbete och inte en tumrörelse har personen på andra sidan bevisligen ägnat dig uppmärksamhet redan innan samtalet börjar." },

    { type: "h2", text: "Varför är det bättre?" },
    { type: "ul", items: [
      "**Färre men bättre matchningar:** alla matchar inte, men de som gör det har redan förstått något om dig",
      "**Personligheten först:** ditt sätt att tänka och dina värderingar är matchningskriteriet, inte dina bilder",
      "**En rolig process:** att lösa någons frågor är långt mer engagerande än en oändlig kö av ansikten",
      "**Mindre ghosting:** den som lagt möda på en matchning är mer villig att hålla samtalet vid liv",
    ] },

    { type: "quote", text: "Frågorna du ställer för att lära känna någon är värda mer än hundratals svep." },

    { type: "h2", text: "Vad gör frågebaserad dejting annorlunda?" },
    { type: "p", text: "Frågebaserad dejting skiljer sig från standardmodellen ända vid roten. Swipe-baserade appar är byggda kring att se; frågebaserad dejting kring att förstå. Att ställa frågor är det äldsta och mest naturliga sättet människor lär känna varandra på, och Qulo flyttar helt enkelt in den processen i en app." },
    { type: "p", text: "I en swipe-baserad app är matchningskriterierna i praktiken utseende, ålder och avstånd. På Qulo hänger matchningen på om den andra personen verkligen träffade rätt på dina svar. Det betyder att den du matchar med har förstått ditt sätt att tänka, dina intressen eller dina värderingar — och inte bara godkänt ett fotografi." },
    { type: "p", text: "Det finns forskning bakom idén. I en studie som publicerades 2017 i **Journal of Personality and Social Psychology** analyserade Huang, Yeomans, Brooks, Minson och Gino **1 961** beslut om en andra dejt fattade av **110** deltagare i snabbdejtning, och fann att de som ställde fler följdfrågor oftare blev tillfrågade igen. Nyfikenhet visar sig vara attraktiv på ett mätbart sätt — och en frågebaserad app gör nyfikenheten till inträdeskrav." },

    { type: "h2", text: "Så tar du dig ur swipe-tröttheten" },
    { type: "p", text: "Känner du igen dig i beskrivningen finns det några saker som hjälper:" },
    { type: "ul", items: [
      "Sätt en gräns för hur lång tid du dagligen lägger i dejtingappar",
      "Titta ordentligt på profilerna i stället för att svepa på autopilot",
      "Ta dig tid att läsa vad människor har skrivit om sig själva",
      "Gör ett verkligt försök att prata med de matchningar du redan har",
      "Prova en annan matchningsmetod — **en frågebaserad app som Qulo** bryter swipe-slingan i stället för att snygga till den",
    ] },

    { type: "h2", accent: "green", text: "Slutsats" },
    { type: "p", text: "Swipe-trötthet är ett av de problem som definierar dagens dejtingkultur: ett oändligt flöde av profiler, beslut som kostar mer än de ger och matchningar som är för tunna för att överleva en vecka av meddelanden. Svaret är inte att sluta träffa människor via app. Svaret är att ändra vad appen kräver av dig. Qulos vad är enkelt: att lära känna varandra genom frågor är mer meningsfullt, roligare och långt mer hållbart än ännu en kväll med svep." },
  ],

  hi: [
    { type: "h2", text: "स्वाइप थकान क्या है?" },
    { type: "p", text: "स्वाइप थकान वह मानसिक और भावनात्मक थकावट है जो डेटिंग ऐप्स पर लगातार प्रोफ़ाइलें पलटते रहने से पैदा होती है। यह शब्द 2020 के दशक की शुरुआत में चलन में आया, मगर जिस दिक़्क़त को यह नाम देता है, उसे लोग बरसों से महसूस कर रहे थे। ज़्यादातर बड़ी डेटिंग ऐप्स में मौजूद स्वाइप की बनावट शुरू में खेल जैसी लगती है, और आख़िर में खेलने वाले को ऐसे चक्र में बंद कर देती है जो लौटाने से ज़्यादा ले लेता है।" },
    { type: "p", text: "जिसने भी इन ऐप्स पर कुछ महीने बिताए हैं, वह यह ढर्रा पहचानता है। आप आदतन ऐप खोलते हैं, अजनबियों की क़तार निपटाते हैं, बिना एक भी ऐसी बातचीत के बंद कर देते हैं जिसे आगे बढ़ाया जाए, और अगली शाम वही सब दोहराते हैं। यह काफ़ी दिन चलता रहे तो दिमाग़ पर ज़रूरत से ज़्यादा बोझ पड़ता है और आपके फ़ैसलों की गुणवत्ता लगातार गिरती जाती है।" },

    { type: "h2", text: "स्वाइप थकान क्यों होती है?" },

    { type: "h2", text: "1. फ़ैसलों की थकान" },
    { type: "p", text: "हर स्वाइप एक फ़ैसला है, और इंसानी दिमाग़ के पास फ़ैसलों का बजट असीमित नहीं होता। अजनबियों को लगातार \"हाँ\" या \"ना\" कहना उसी क्षमता को चुकाता है जो आपको बाक़ी दिन के लिए चाहिए। मनोवैज्ञानिक बैरी श्वार्ट्ज़ **चुनाव के विरोधाभास** से आगे की कहानी बताते हैं: जब विकल्प ज़रूरत से ज़्यादा हों तो लोग अपने चुनाव से कम संतुष्ट होते हैं और चुनने में भी देर लगाते हैं। डेटिंग ऐप्स पर यह इस ज़िद्दी ख़याल की शक्ल लेता है कि अगली प्रोफ़ाइल शायद बेहतर हो।" },

    { type: "h2", text: "2. डोपामिन का चक्र और लत" },
    { type: "p", text: "स्वाइप की बनावट स्लॉट मशीन की तरह काम करती है। हर स्वाइप के साथ यह अनिश्चितता जुड़ी रहती है कि \"क्या यह इंसान भी मुझे पसंद करेगा?\", और अप्रत्याशित इनाम ठीक वही ढर्रा है जो दिमाग़ को बार-बार लीवर खींचने पर लगाए रखता है। बदलते इनाम की यह व्यवस्था ध्यान को थामे रखती है और साथ ही उसे निचोड़ती भी है। मैच होने पर ख़ुशी की छोटी-सी लहर आती है, जल्दी उतर जाती है, और चक्र फिर शुरू हो जाता है।" },

    { type: "h2", text: "3. सतहीपन और गहराई की कमी" },
    { type: "p", text: "स्वाइप पर टिकी ऐप्स में फ़ैसला लगभग तुरंत होता है, और ज़्यादातर शक्ल-सूरत के आधार पर। सेकंड के उस हिस्से में किसी के स्वभाव, मूल्यों, हास्यबोध या दुनिया को देखने के नज़रिए को आँकना मुमकिन ही नहीं — बनावट इसके लिए जगह ही नहीं छोड़ती। नतीजा यह कि मैच सतह पर ही रह जाते हैं और असली जुड़ाव कम ही बनता है।" },

    { type: "h2", text: "4. घोस्टिंग और टूटता संवाद" },
    { type: "p", text: "स्वाइप की संस्कृति लोगों को एक-दूसरे के साथ इस्तेमाल-और-फेंक जैसा बर्ताव करना सिखाती है। बातचीत अक्सर चंद संदेशों के बाद ख़त्म हो जाती है, और घोस्टिंग — यानी बिना कोई सफ़ाई दिए संपर्क तोड़ देना — अपवाद रहने के बजाय अनुभव का आम हिस्सा बन चुका है। जिसके साथ ऐसा होता है, उसमें यह अस्वीकृति के प्रति संवेदनशीलता और पूरे ढाँचे पर अविश्वास पालता है।" },

    { type: "h2", text: "आँकड़े असल में क्या दिखाते हैं" },
    { type: "p", text: "डेटिंग ऐप्स के बारे में चौंकाने वाले आँकड़े ख़ूब घूमते हैं, और उनमें से ज़्यादातर किसी असली अध्ययन तक नहीं पहुँचते। एक आँकड़ा पहुँचता है: **Forbes Health** ने 2024 में **OnePoll** के साथ मिलकर अमेरिका के **1,000** डेटिंग ऐप उपयोगकर्ताओं पर जो सर्वेक्षण किया, उसमें **78%** ने कहा कि ऐप के ज़रिए डेटिंग से उन्हें भावनात्मक थकावट हुई है। यह थकावट चंद बदक़िस्मत लोगों की शिकायत नहीं, बहुसंख्या का अनुभव है।" },
    { type: "ul", items: [
      "**मेहनत जाती है, कुछ लौटता नहीं:** अजनबियों को परखने में बीते लंबे सत्र, और अंत में एक भी ऐसी बातचीत नहीं जो काम की हो",
      "**उत्पाद आपका ध्यान है:** यह चक्र आपको स्क्रॉल कराते रहने के लिए बना है, ऐप से विदा कराने के लिए नहीं",
      "**घटता प्रतिफल:** जितनी ज़्यादा प्रोफ़ाइलें देखेंगे, हर एक का असर उतना ही कम रह जाएगा",
    ] },

    { type: "h2", accent: "green", text: "Qulo का हल: सवालों पर टिकी मैचिंग" },
    { type: "p", text: "Qulo बनावट को सजाने के लिए नहीं, बदलने के लिए बना है। स्वाइप की जगह मैचिंग सवालों और जवाबों पर चलती है, जिससे पल भर में होने वाला शक्ल का फ़ैसला शुरुआत से हट जाता है और उसकी जगह वह चीज़ आती है जिसके लिए आपको सचमुच जाना जा सके।" },

    { type: "h2", text: "यह काम कैसे करता है?" },
    { type: "p", text: "Qulo पर आप 2 से 4 सवाल लिखते हैं — भुगतान वाली योजना में 10 तक। ये सवाल आपके स्वभाव, दिलचस्पियों और आपके लिए अहम चीज़ों को दिखाते हैं। दूसरे लोग उन्हें हल करने की कोशिश करते हैं, और मैच उसी से होता है जो सभी जवाब सही देता है। चूँकि मैच की क़ीमत अंगूठे की हरकत नहीं बल्कि सोच है, इसलिए बातचीत शुरू होने से पहले ही यह साबित हो जाता है कि सामने वाले ने आप पर ध्यान दिया है।" },

    { type: "h2", text: "यह बेहतर क्यों है?" },
    { type: "ul", items: [
      "**कम मगर बेहतर मैच:** सबसे मैच नहीं होता, मगर जिससे होता है वह आपके बारे में कुछ समझ चुका होता है",
      "**पहले व्यक्तित्व:** मैच की कसौटी आपकी तस्वीरें नहीं, आपकी सोच और मूल्य हैं",
      "**मज़ेदार प्रक्रिया:** किसी के सवाल हल करना चेहरों की बेअंत क़तार से कहीं ज़्यादा बाँधता है",
      "**घोस्टिंग कम:** जो मैच के लिए मेहनत करता है, वह बातचीत जारी रखने को ज़्यादा तैयार रहता है",
    ] },

    { type: "quote", text: "किसी को जानने के लिए आप जो सवाल पूछते हैं, वे सैकड़ों स्वाइप से ज़्यादा क़ीमती हैं।" },

    { type: "h2", text: "सवालों पर टिकी डेटिंग अलग कैसे है?" },
    { type: "p", text: "सवालों पर टिकी डेटिंग आम मॉडल से जड़ से अलग होती है। स्वाइप वाली ऐप्स देखने के इर्द-गिर्द बनी हैं; सवालों वाली डेटिंग समझने के इर्द-गिर्द। सवाल पूछना इंसानों के एक-दूसरे को जानने का सबसे पुराना और सबसे स्वाभाविक तरीक़ा है, और Qulo बस उसी तरीक़े को ऐप के भीतर ले आता है।" },
    { type: "p", text: "स्वाइप वाली ऐप में मैच की कसौटी असल में शक्ल, उम्र और दूरी होती है। Qulo पर मैच इस बात पर टिका है कि सामने वाले ने सचमुच आपके जवाब सही पहचाने या नहीं। यानी जिससे आपका मैच होता है, उसने सिर्फ़ एक तस्वीर को मंज़ूरी नहीं दी — उसने आपकी सोच, दिलचस्पियाँ या मूल्य समझे हैं।" },
    { type: "p", text: "इस विचार के पीछे शोध भी है। 2017 में **Journal of Personality and Social Psychology** में छपे एक अध्ययन में हुआंग, योमन्स, ब्रुक्स, मिन्सन और जीनो ने स्पीड डेटिंग के **110** प्रतिभागियों द्वारा लिए गए **1,961** फ़ैसलों का विश्लेषण किया कि दूसरी मुलाक़ात हो या नहीं, और पाया कि जो लोग ज़्यादा आगे के सवाल पूछते थे, उन्हें दोबारा बुलाए जाने की संभावना ज़्यादा थी। जिज्ञासा नापे जा सकने वाले ढंग से आकर्षक है — और सवालों पर टिकी ऐप जिज्ञासा को ही दाख़िले की शर्त बना देती है।" },

    { type: "h2", text: "स्वाइप थकान से बाहर कैसे निकलें" },
    { type: "p", text: "अगर इस वर्णन में आपको अपनी झलक दिखी, तो ये बातें मदद करती हैं:" },
    { type: "ul", items: [
      "डेटिंग ऐप्स पर रोज़ बिताए जाने वाले समय की एक हद तय करें",
      "ऑटोपायलट पर स्वाइप करने के बजाय प्रोफ़ाइलें ठीक से देखें",
      "लोगों ने अपने बारे में जो लिखा है, उसे पढ़ने के लिए वक़्त निकालें",
      "जो मैच पहले से हैं, उनसे बात करने की सच्ची कोशिश करें",
      "मैचिंग का कोई और तरीक़ा आज़माएँ — **Qulo जैसी सवालों पर टिकी ऐप** स्वाइप के चक्र को सजाती नहीं, तोड़ती है",
    ] },

    { type: "h2", accent: "green", text: "निष्कर्ष" },
    { type: "p", text: "स्वाइप थकान आज की डेटिंग संस्कृति की सबसे बड़ी दिक़्क़तों में से एक है: प्रोफ़ाइलों का न ख़त्म होने वाला बहाव, ऐसे फ़ैसले जो देने से ज़्यादा लेते हैं, और इतने पतले मैच कि हफ़्ते भर की बातचीत भी न झेल पाएँ। जवाब ऐप के ज़रिए लोगों से मिलना छोड़ देना नहीं है, बल्कि यह बदलना है कि ऐप आपसे क्या माँगती है। Qulo का दाँव सीधा है: सवालों के ज़रिए मिलना, एक और शाम स्वाइप करने से कहीं ज़्यादा अर्थपूर्ण, ज़्यादा मज़ेदार और कहीं ज़्यादा टिकाऊ है।" },
  ],
};
