import type { LocalizedArticle } from "@/components/blog/ArticleBlocks";

/**
 * "Quiz Dating: The Future of Matching" — migrated from inline per-locale JSX.
 * Canonical source: `en`; every one of the 16 locales is a full translation, so
 * no locale falls back to English any more (the legacy component shipped only
 * `tr` and `en`, serving the English body under 14 locales whose `hreflang`
 * promised otherwise). `**bold**` renders as <strong>.
 *
 * Statistics policy: the only figures kept are the 78% burnout number —
 * attributed inline to its primary source (Forbes Health / OnePoll, 2024 survey
 * of 1,000 US dating-app users) — and the participant counts of the Huang,
 * Yeomans, Brooks, Minson & Gino study (Journal of Personality and Social
 * Psychology, 2017), also attributed inline. The figures the legacy post
 * carried — "only 2-5% of matches result in an actual date", "the top 10% of
 * users receive almost all the attention", "successful relationships are built
 * on five key factors" and the precise "2012" origin date of the swipe mechanic
 * — had no traceable source and were removed: the qualitative point survives
 * where it can stand on its own ("a small fraction", "a small minority"),
 * otherwise the claim goes with the number. The unsourced "Arthur Aron proved
 * …/36 Questions" passage was likewise replaced by the Huang et al. citation,
 * which supports the same argument from a checkable source. Qulo's own product
 * facts (2 to 4 questions on the free plan, up to 10 on a paid plan) are not
 * statistics and stay. Do not reintroduce a number here without a named
 * primary source, and never write a range ending at 10 without naming the paid
 * plan in the same sentence.
 *
 * Product-claim policy: the legacy closing of "The Future of Quiz Dating" said
 * the experience gets better "combined with AI — Qulo's smart question
 * suggestions, for instance", which implied a model running inside the product.
 * No AI runs at request time anywhere in Qulo: matching and discovery are a
 * hand-weighted formula, and the question suggestions are rows read from a
 * question bank written in advance. The paragraph now says exactly that — a
 * ready-made library you can browse, not a model composing questions live —
 * and it does not claim the library covers every locale, because it does not.
 *
 * Brand rule: Qulo is the only dating app nameable on this site. Everything else
 * is described generically as "swipe-based apps" / "mainstream dating apps".
 *
 * Note: the block model has no h3, so the original h3 sub-headings ("1. Cognitive
 * Compatibility", "2. Active Participation", …) are authored as purple h2. The
 * two headings the original markup rendered in `text-qulo-green` — "Personality
 * Tests and the Science of Compatibility" and the closing "Conclusion" — keep
 * `accent: "green"` at the same positions (block indices 15 and 25); every other
 * heading is purple.
 */
export const quizDatingFutureOfMatching: LocalizedArticle = {
  en: [
    { type: "h2", text: "The Limitations of Traditional Dating Apps" },
    { type: "p", text: "Over the past decade, dating apps have fundamentally changed how millions of people meet. The swipe mechanic that spread through the industry in the early 2010s came to dominate it, and nearly every mainstream dating app adopted the same model. That model has serious problems, and the people using it say so: in a 2024 **Forbes Health** survey conducted with **OnePoll** among **1,000** dating-app users in the United States, **78%** reported emotional burnout from dating through apps. Only a small fraction of the matches these apps produce ever turns into a real date." },
    { type: "p", text: "The fundamental problem with the swipe mechanic is that it forces us to evaluate people based on a photo and a few lines of bio. This approach presents people like a \"product catalog\", preventing the formation of deep connections. Users eventually experience \"swipe fatigue\" and either abandon the app or keep using it in an emotionally disconnected way." },

    { type: "h2", text: "The Quiz Dating Concept: A New Paradigm" },
    { type: "p", text: "Quiz dating is an approach that completely redefines the matching process. The core idea is simple: if you want to know someone, look at their thoughts, not their photos. In quiz dating, users create their own questions and wait for potential matches to solve them. Correct answers indicate compatibility." },
    { type: "p", text: "The idea that questions build connection is more than intuition. In a 2017 study published in the **Journal of Personality and Social Psychology**, Huang, Yeomans, Brooks, Minson and Gino analysed **1,961** second-date decisions made by **110** speed daters and found that the people who asked more follow-up questions were more likely to be asked back. Curiosity is attractive in a measurable way, and a question-based app puts that curiosity right at the start of the process." },

    { type: "h2", text: "Why Do Questions Create Better Matches?" },

    { type: "h2", text: "1. Cognitive Compatibility" },
    { type: "p", text: "Questions reveal how compatible two people's thought processes are. Two people who give the same answer to the same question likely share similar worldviews, values and life preferences. This is a genuine indicator of compatibility that goes beyond superficial attraction." },

    { type: "h2", text: "2. Active Participation" },
    { type: "p", text: "Swiping is a passive action — you are merely reacting to photos. Answering questions requires active participation. That engagement leads to greater mental investment and makes matched people feel more connected to each other. In psychology this is called the **investment effect**." },

    { type: "h2", text: "3. Meaningful Conversation Starters" },
    { type: "p", text: "One of the biggest problems with swipe-based apps is the \"I don't know what to write\" moment. In quiz dating, the questions provide a natural conversation starter. An opening like \"Your answer to that question was really interesting — why do you think that way?\" is far more effective than a plain \"hi\"." },

    { type: "h2", text: "4. Personality-First Filtering" },
    { type: "p", text: "Questions measure personality compatibility regardless of appearance, which makes the system fairer for everyone. On swipe-based apps a small minority of profiles absorbs almost all of the attention; in quiz dating everyone starts with the same chance, because what matters is your answers." },

    { type: "h2", accent: "green", text: "Personality Tests and the Science of Compatibility" },
    { type: "p", text: "What holds a relationship together is not much of a mystery: shared values, communication styles that fit, the ability to work through conflict, life goals pointing in the same direction, and emotional intelligence on both sides. Swipe-based apps measure none of it. Question-and-answer systems get at several of these indirectly, because the answers a person gives reveal how they think." },
    { type: "p", text: "Take a question like \"What would you do if your weekend plans changed unexpectedly?\" A single answer says something about a person's flexibility, their approach to conflict and the way they like to live. Questions like these surface in seconds what small talk would take a whole evening to reach." },

    { type: "h2", text: "Guide to Creating Questions on Qulo" },
    { type: "p", text: "Writing effective questions is the key to quality matches. Here is what to keep in mind when crafting yours on Qulo:" },
    { type: "ul", items: [
      "**Ask about various topics:** music, travel, life philosophy, humour — questions from different areas paint a more complete compatibility picture",
      "**Avoid questions that are too easy or too hard:** something everyone can guess filters nobody, and something nobody can answer kills your matching odds",
      "**Add personal touches:** a question like \"What's my favourite city?\" measures how well the answerer actually knows you",
      "**Update them regularly:** refresh your questions so they reflect your interests as those change",
      "**2 to 4 questions is the sweet spot:** too few will not filter enough, too many will shrink your matching probability — a paid plan raises the ceiling to 10",
    ] },

    { type: "quote", text: "Asking the right question means finding the right person. On Qulo, matching is not a coincidence — it is a conscious discovery." },

    { type: "h2", text: "The Future of Quiz Dating" },
    { type: "p", text: "The dating industry is at a turning point. People want more than superficial matches, and quiz dating is an approach built for that demand. The hard part is writing good questions, so Qulo keeps a library of ready-made ones you can browse when inspiration runs out — a bank drafted in advance with the help of AI, not a model writing questions for you on the spot. The question someone matches on is still your own." },
    { type: "p", text: "Question-based and interaction-based matching is likely to keep spreading, because the alternative has already shown its limits. Qulo intends to be the app that sets the standard for it rather than the one that copies it late." },

    { type: "h2", accent: "green", text: "Conclusion: The Future of Matching Is in Questions" },
    { type: "p", text: "The swipe-based model brought a real innovation to dating, but its limits are now plain to see. Quiz dating is the path to deeper, more meaningful and more sustainable connections. Write your first question on Qulo and see what matching feels like when it starts with curiosity." },
  ],

  tr: [
    { type: "h2", text: "Geleneksel Flört Uygulamalarının Sınırlılıkları" },
    { type: "p", text: "Son on yılda flört uygulamaları milyonlarca insanın tanışma biçimini kökten değiştirdi. 2010'ların başında sektöre yayılan kaydırma mekaniği kısa sürede baskın model hâline geldi ve neredeyse bütün yaygın flört uygulamaları aynı düzeni benimsedi. Bu modelin ciddi sorunları var ve bunu en çok kullananlar söylüyor: **Forbes Health**'in 2024'te **OnePoll** ile birlikte ABD'de **1.000** flört uygulaması kullanıcısıyla yaptığı ankette katılımcıların **%78**'i uygulama üzerinden flörtün kendilerinde duygusal tükenmişlik yarattığını belirtti. Bu uygulamalarda kurulan eşleşmelerin yalnızca küçük bir bölümü gerçek bir buluşmaya dönüşüyor." },
    { type: "p", text: "Kaydırma mekaniğinin temel sorunu, insanları bir fotoğraf ve birkaç satır biyografiyle değerlendirmeye zorlamasıdır. Bu yaklaşım insanları \"ürün kataloğu\" gibi sunarak derinlikli bağların kurulmasını engeller. Kullanıcılar zamanla \"swipe yorgunluğu\" yaşar ve ya uygulamayı bırakır ya da duygusal olarak kopuk bir biçimde kullanmayı sürdürür." },

    { type: "h2", text: "Quiz Dating Konsepti: Yeni Bir Paradigma" },
    { type: "p", text: "Quiz dating, eşleşme sürecini baştan tanımlayan bir yaklaşımdır. Temel fikir basittir: bir insanı tanımak istiyorsanız fotoğraflarına değil, düşüncelerine bakın. Quiz dating'de kullanıcılar kendi sorularını oluşturur ve olası eşleşmelerin bu soruları çözmesini bekler. Doğru cevaplar uyumun göstergesidir." },
    { type: "p", text: "Soruların bağ kurduğu fikri yalnızca bir sezgi değil. **Journal of Personality and Social Psychology** dergisinde 2017'de yayımlanan bir çalışmada Huang, Yeomans, Brooks, Minson ve Gino, **110** hızlı flört katılımcısının verdiği **1.961** ikinci buluşma kararını inceledi ve daha çok takip sorusu soranların yeniden davet edilme ihtimalinin daha yüksek olduğunu buldu. Merak ölçülebilir biçimde çekici; soru tabanlı bir uygulama da bu merakı sürecin en başına koyar." },

    { type: "h2", text: "Neden Sorular Daha İyi Eşleşme Sağlar?" },

    { type: "h2", text: "1. Bilişsel Uyum" },
    { type: "p", text: "Sorular, iki insanın düşünce yapısının ne kadar örtüştüğünü ortaya koyar. Aynı soruya aynı cevabı veren iki kişi büyük olasılıkla benzer bir dünya görüşüne, benzer değerlere ve benzer yaşam tercihlerine sahiptir. Bu, yüzeysel çekiciliğin ötesinde gerçek bir uyum göstergesidir." },

    { type: "h2", text: "2. Aktif Katılım" },
    { type: "p", text: "Kaydırmak pasif bir eylemdir; yalnızca fotoğraflara tepki verirsiniz. Soru çözmek ise aktif katılım ister. Bu katılım daha fazla zihinsel yatırım getirir ve eşleşen kişilerin birbirine daha bağlı hissetmesini sağlar. Psikolojide buna **yatırım etkisi** denir." },

    { type: "h2", text: "3. Anlamlı Sohbet Başlangıçları" },
    { type: "p", text: "Kaydırma tabanlı uygulamaların en büyük sorunlarından biri \"ne yazacağımı bilmiyorum\" anıdır. Quiz dating'de sorular doğal bir sohbet başlangıcı sunar. \"Şu soruya verdiğin cevap çok ilginçti, neden öyle düşünüyorsun?\" gibi bir açılış, düz bir \"merhaba\"dan çok daha etkilidir." },

    { type: "h2", text: "4. Kişilik Öncelikli Filtreleme" },
    { type: "p", text: "Sorular, görünüşten bağımsız olarak kişilik uyumunu ölçer; bu da sistemi herkes için daha adil kılar. Kaydırma tabanlı uygulamalarda profillerin küçük bir azınlığı ilginin neredeyse tamamını toplar; quiz dating'de ise herkes aynı şansla başlar, çünkü belirleyici olan cevaplarınızdır." },

    { type: "h2", accent: "green", text: "Kişilik Testleri ve Uyum Bilimi" },
    { type: "p", text: "Bir ilişkiyi ayakta tutan şeyler pek de gizemli değil: ortak değerler, birbirine oturan iletişim tarzları, çatışmayı çözebilme becerisi, aynı yöne bakan yaşam hedefleri ve iki tarafta da duygusal zekâ. Kaydırma tabanlı uygulamalar bunların hiçbirini ölçmez. Soru-cevap tabanlı sistemler ise birçoğunu dolaylı olarak yakalar, çünkü bir insanın verdiği cevaplar nasıl düşündüğünü ele verir." },
    { type: "p", text: "Örneğin \"Hafta sonu planların beklenmedik şekilde değişse ne yapardın?\" sorusunu düşünün. Tek bir cevap, o kişinin esnekliği, çatışmaya yaklaşımı ve nasıl bir hayat sevdiği hakkında fikir verir. Bu tür sorular, muhabbetin bir akşam boyunca ulaşamayacağı bilgiyi saniyeler içinde açığa çıkarır." },

    { type: "h2", text: "Qulo'da Soru Hazırlama Rehberi" },
    { type: "p", text: "Etkili sorular yazmak, kaliteli eşleşmelerin anahtarıdır. Qulo'da soru hazırlarken şunlara dikkat edin:" },
    { type: "ul", items: [
      "**Farklı konulardan sorun:** müzik, seyahat, yaşam felsefesi, mizah — farklı alanlardan sorular daha eksiksiz bir uyum resmi çizer",
      "**Çok kolay ya da çok zor sorulardan kaçının:** herkesin tahmin edebileceği bir soru kimseyi elemez, kimsenin bilemeyeceği bir soru da eşleşme ihtimalinizi bitirir",
      "**Kişisel dokunuşlar ekleyin:** \"En sevdiğim şehir hangisi?\" gibi bir soru, cevaplayanın sizi gerçekten ne kadar tanıdığını ölçer",
      "**Sorularınızı düzenli yenileyin:** ilgi alanlarınız değiştikçe sorularınız da onu yansıtsın",
      "**2 ile 4 soru arası ideal:** çok az soru yeterince filtrelemez, çok fazla soru eşleşme olasılığınızı daraltır — ücretli planda üst sınır 10'a çıkar",
    ] },

    { type: "quote", text: "Doğru soruyu sormak, doğru insanı bulmak demektir. Qulo'da eşleşme bir tesadüf değil — bilinçli bir keşiftir." },

    { type: "h2", text: "Quiz Dating'in Geleceği" },
    { type: "p", text: "Flört sektörü bir dönüm noktasında. İnsanlar artık yüzeysel eşleşmelerden fazlasını istiyor ve quiz dating tam da bu talep için kurulmuş bir yaklaşım. İşin zor kısmı iyi soru yazmak; bu yüzden Qulo, ilhamınız tükendiğinde göz atabileceğiniz hazır bir soru kütüphanesi tutuyor — önceden yapay zekâ yardımıyla hazırlanmış bir havuz; o anda sizin yerinize soru yazan bir model değil. Eşleşmeyi sağlayan soru yine sizin sorunuz oluyor." },
    { type: "p", text: "Soru ve etkileşim tabanlı eşleşmenin yayılmaya devam etmesi bekleniyor, çünkü alternatifi sınırlarını çoktan gösterdi. Qulo bu alanda standardı geç kopyalayan değil, belirleyen uygulama olmayı hedefliyor." },

    { type: "h2", accent: "green", text: "Sonuç: Eşleşmenin Geleceği Sorularda" },
    { type: "p", text: "Kaydırma tabanlı model flörte gerçek bir yenilik getirdi ama sınırları artık apaçık ortada. Quiz dating; daha derin, daha anlamlı ve daha sürdürülebilir bağlar kurmanın yolu. Qulo'da ilk sorunuzu yazın ve merakla başlayan bir eşleşmenin nasıl bir his olduğunu görün." },
  ],

  de: [
    { type: "h2", text: "Die Grenzen herkömmlicher Dating-Apps" },
    { type: "p", text: "In den vergangenen zehn Jahren haben Dating-Apps grundlegend verändert, wie Millionen Menschen einander begegnen. Die Wischmechanik, die sich Anfang der 2010er in der Branche ausbreitete, wurde schnell zum vorherrschenden Modell, und nahezu jede große Dating-App übernahm es. Dieses Modell hat ernsthafte Probleme, und die Nutzenden sagen das auch: In einer Umfrage von **Forbes Health**, die 2024 gemeinsam mit **OnePoll** unter **1.000** Dating-App-Nutzerinnen und -Nutzern in den USA durchgeführt wurde, berichteten **78 %** von emotionalem Ausgebranntsein durch das Daten per App. Nur ein kleiner Teil der Matches, die diese Apps erzeugen, wird jemals zu einem echten Date." },
    { type: "p", text: "Das grundlegende Problem der Wischmechanik ist, dass sie uns zwingt, Menschen anhand eines Fotos und weniger Zeilen Biografie zu beurteilen. Dieser Ansatz präsentiert Menschen wie einen \"Produktkatalog\" und verhindert, dass tiefe Verbindungen entstehen. Irgendwann erleben Nutzende \"Swipe-Müdigkeit\" und geben die App entweder auf oder benutzen sie emotional abgekoppelt weiter." },

    { type: "h2", text: "Das Konzept Quiz-Dating: ein neues Paradigma" },
    { type: "p", text: "Quiz-Dating ist ein Ansatz, der den Matching-Prozess von Grund auf neu definiert. Die Kernidee ist simpel: Wer jemanden kennenlernen will, sollte auf dessen Gedanken schauen, nicht auf dessen Fotos. Beim Quiz-Dating verfassen Nutzende eigene Fragen und warten darauf, dass mögliche Matches sie lösen. Richtige Antworten sind das Signal für Passung." },
    { type: "p", text: "Dass Fragen Nähe schaffen, ist mehr als eine Intuition. In einer 2017 im **Journal of Personality and Social Psychology** veröffentlichten Studie werteten Huang, Yeomans, Brooks, Minson und Gino **1.961** Entscheidungen über ein zweites Date von **110** Speed-Datern aus und fanden: Wer mehr Nachfragen stellte, wurde eher erneut eingeladen. Neugier ist messbar attraktiv — und eine fragenbasierte App stellt genau diese Neugier an den Anfang des Prozesses." },

    { type: "h2", text: "Warum führen Fragen zu besseren Matches?" },

    { type: "h2", text: "1. Kognitive Passung" },
    { type: "p", text: "Fragen zeigen, wie gut die Denkweisen zweier Menschen zusammenpassen. Wer auf dieselbe Frage dieselbe Antwort gibt, teilt sehr wahrscheinlich Weltbild, Werte und Lebensvorstellungen. Das ist ein echter Hinweis auf Passung, der über oberflächliche Anziehung hinausgeht." },

    { type: "h2", text: "2. Aktive Beteiligung" },
    { type: "p", text: "Wischen ist eine passive Handlung — man reagiert bloß auf Fotos. Fragen zu beantworten verlangt aktive Beteiligung. Dieses Engagement bedeutet mehr gedankliche Investition und lässt gematchte Menschen einander verbundener fühlen. In der Psychologie heißt das **Investitionseffekt**." },

    { type: "h2", text: "3. Sinnvolle Gesprächseinstiege" },
    { type: "p", text: "Eines der größten Probleme Swipe-basierter Apps ist der Moment \"Ich weiß nicht, was ich schreiben soll\". Beim Quiz-Dating liefern die Fragen von selbst einen Gesprächseinstieg. Ein Auftakt wie \"Deine Antwort auf diese Frage fand ich richtig spannend — warum siehst du das so?\" wirkt weit besser als ein bloßes \"Hi\"." },

    { type: "h2", text: "4. Filtern nach Persönlichkeit zuerst" },
    { type: "p", text: "Fragen messen die Passung der Persönlichkeit unabhängig vom Aussehen, und das macht das System für alle fairer. In Swipe-basierten Apps zieht eine kleine Minderheit der Profile fast die gesamte Aufmerksamkeit auf sich; beim Quiz-Dating startet jede und jeder mit derselben Chance, denn entscheidend sind Ihre Antworten." },

    { type: "h2", accent: "green", text: "Persönlichkeitstests und die Wissenschaft der Passung" },
    { type: "p", text: "Was eine Beziehung zusammenhält, ist kein großes Rätsel: gemeinsame Werte, zueinander passende Kommunikationsstile, die Fähigkeit, Konflikte auszutragen, Lebensziele, die in dieselbe Richtung zeigen, und emotionale Intelligenz auf beiden Seiten. Swipe-basierte Apps messen nichts davon. Frage-Antwort-Systeme erfassen mehreres davon indirekt, denn die Antworten eines Menschen verraten, wie er denkt." },
    { type: "p", text: "Nehmen Sie eine Frage wie \"Was würdest du tun, wenn deine Wochenendpläne unerwartet platzen?\" Eine einzige Antwort sagt etwas über Flexibilität, über den Umgang mit Konflikten und über die bevorzugte Art zu leben. Solche Fragen bringen in Sekunden ans Licht, wofür Small Talk einen ganzen Abend braucht." },

    { type: "h2", text: "Leitfaden: gute Fragen auf Qulo schreiben" },
    { type: "p", text: "Wirksame Fragen zu schreiben ist der Schlüssel zu guten Matches. Darauf sollten Sie auf Qulo achten:" },
    { type: "ul", items: [
      "**Fragen Sie zu verschiedenen Themen:** Musik, Reisen, Lebensphilosophie, Humor — Fragen aus unterschiedlichen Bereichen ergeben ein vollständigeres Bild der Passung",
      "**Vermeiden Sie zu leichte oder zu schwere Fragen:** Was alle erraten können, filtert niemanden, und was niemand beantworten kann, ruiniert Ihre Match-Chancen",
      "**Bauen Sie Persönliches ein:** Eine Frage wie \"Welche Stadt ist meine Lieblingsstadt?\" misst, wie gut das Gegenüber Sie wirklich kennt",
      "**Aktualisieren Sie regelmäßig:** Erneuern Sie Ihre Fragen, damit sie Ihre Interessen abbilden, wenn diese sich ändern",
      "**2 bis 4 Fragen sind der Idealbereich:** zu wenige filtern nicht genug, zu viele verkleinern Ihre Match-Wahrscheinlichkeit — im kostenpflichtigen Tarif liegt die Obergrenze bei 10",
    ] },

    { type: "quote", text: "Die richtige Frage zu stellen heißt, den richtigen Menschen zu finden. Auf Qulo ist ein Match kein Zufall — es ist eine bewusste Entdeckung." },

    { type: "h2", text: "Die Zukunft des Quiz-Datings" },
    { type: "p", text: "Die Dating-Branche steht an einem Wendepunkt. Menschen wollen mehr als oberflächliche Matches, und Quiz-Dating ist genau für diesen Bedarf gebaut. Das Schwierige daran ist, gute Fragen zu schreiben. Deshalb hält Qulo eine Sammlung fertiger Fragen bereit, in der Sie stöbern können, wenn Ihnen nichts einfällt — ein im Voraus mit Hilfe von KI verfasster Vorrat, kein Modell, das im Moment für Sie Fragen schreibt. Die Frage, über die jemand mit Ihnen matcht, bleibt Ihre eigene." },
    { type: "p", text: "Frage- und interaktionsbasiertes Matching dürfte sich weiter ausbreiten, denn die Alternative hat ihre Grenzen längst gezeigt. Qulo will dabei die App sein, die den Standard setzt, und nicht die, die ihn spät kopiert." },

    { type: "h2", accent: "green", text: "Fazit: Die Zukunft des Matchings liegt in Fragen" },
    { type: "p", text: "Das Swipe-Modell hat dem Daten eine echte Neuerung gebracht, doch seine Grenzen liegen inzwischen offen zutage. Quiz-Dating ist der Weg zu tieferen, bedeutsameren und nachhaltigeren Verbindungen. Schreiben Sie Ihre erste Frage auf Qulo und erleben Sie, wie sich Matching anfühlt, wenn es mit Neugier beginnt." },
  ],

  fr: [
    { type: "h2", text: "Les limites des applis de rencontre classiques" },
    { type: "p", text: "En dix ans, les applis de rencontre ont profondément changé la façon dont des millions de gens se rencontrent. La mécanique du swipe, apparue dans le secteur au début des années 2010, s'est imposée comme le modèle dominant et presque toutes les grandes applis l'ont adoptée. Ce modèle a de sérieux problèmes, et ceux qui l'utilisent le disent : dans une enquête **Forbes Health** menée en 2024 avec **OnePoll** auprès de **1 000** utilisateurs d'applis de rencontre aux États-Unis, **78 %** déclaraient un épuisement émotionnel lié aux rencontres par appli. Seule une petite partie des matchs produits par ces applis débouche un jour sur un vrai rendez-vous." },
    { type: "p", text: "Le problème de fond du swipe, c'est qu'il nous force à juger quelqu'un sur une photo et trois lignes de biographie. Cette approche présente les gens comme un \"catalogue de produits\" et empêche les liens profonds de se former. Les utilisateurs finissent par ressentir la \"fatigue du swipe\" et soit quittent l'appli, soit continuent à s'en servir de manière émotionnellement déconnectée." },

    { type: "h2", text: "Le concept du quiz dating : un nouveau paradigme" },
    { type: "p", text: "Le quiz dating redéfinit entièrement le processus de mise en relation. L'idée de départ est simple : si vous voulez connaître quelqu'un, regardez ses pensées, pas ses photos. En quiz dating, chacun crée ses propres questions et attend que les candidats au match les résolvent. Les bonnes réponses sont le signal de compatibilité." },
    { type: "p", text: "L'idée que les questions créent du lien n'est pas qu'une intuition. Dans une étude publiée en 2017 dans le **Journal of Personality and Social Psychology**, Huang, Yeomans, Brooks, Minson et Gino ont analysé **1 961** décisions de second rendez-vous prises par **110** participants à des speed datings et ont constaté que ceux qui posaient le plus de questions de relance étaient plus souvent rappelés. La curiosité est attirante de façon mesurable, et une appli fondée sur les questions place cette curiosité au tout début du processus." },

    { type: "h2", text: "Pourquoi les questions donnent-elles de meilleurs matchs ?" },

    { type: "h2", text: "1. La compatibilité cognitive" },
    { type: "p", text: "Les questions révèlent à quel point deux façons de penser se rejoignent. Deux personnes qui répondent la même chose à la même question partagent très probablement une vision du monde, des valeurs et des préférences de vie proches. C'est un véritable indicateur de compatibilité, bien au-delà de l'attirance de surface." },

    { type: "h2", text: "2. La participation active" },
    { type: "p", text: "Swiper est une action passive : on ne fait que réagir à des photos. Répondre à des questions demande une participation active. Cet engagement entraîne un investissement mental plus grand et fait que les personnes qui matchent se sentent davantage liées. En psychologie, on parle d'**effet d'investissement**." },

    { type: "h2", text: "3. De vraies amorces de conversation" },
    { type: "p", text: "L'un des plus gros problèmes des applis à swipe, c'est le moment \"je ne sais pas quoi écrire\". En quiz dating, les questions fournissent une amorce naturelle. Une ouverture comme \"Ta réponse à cette question m'a vraiment intriguée — pourquoi tu vois les choses comme ça ?\" est bien plus efficace qu'un simple \"salut\"." },

    { type: "h2", text: "4. Un filtrage par la personnalité d'abord" },
    { type: "p", text: "Les questions mesurent la compatibilité de personnalité indépendamment du physique, ce qui rend le système plus juste pour tout le monde. Sur les applis à swipe, une petite minorité de profils capte presque toute l'attention ; en quiz dating, chacun démarre avec la même chance, car ce qui compte, ce sont vos réponses." },

    { type: "h2", accent: "green", text: "Tests de personnalité et science de la compatibilité" },
    { type: "p", text: "Ce qui fait tenir une relation n'a rien de mystérieux : des valeurs communes, des styles de communication qui s'accordent, la capacité à traverser un conflit, des projets de vie qui pointent dans la même direction, et de l'intelligence émotionnelle des deux côtés. Les applis à swipe ne mesurent rien de tout cela. Les systèmes de questions-réponses en captent plusieurs indirectement, parce que les réponses d'une personne trahissent sa façon de penser." },
    { type: "p", text: "Prenez une question comme \"Que ferais-tu si tes plans du week-end tombaient à l'eau ?\" Une seule réponse en dit long sur la souplesse de quelqu'un, sur sa manière d'aborder un conflit et sur le rythme de vie qui lui convient. Ce genre de question fait remonter en quelques secondes ce qu'une soirée de bavardage n'atteindrait pas." },

    { type: "h2", text: "Guide pour écrire vos questions sur Qulo" },
    { type: "p", text: "Écrire de bonnes questions est la clé de matchs de qualité. Voici ce qu'il faut garder en tête sur Qulo :" },
    { type: "ul", items: [
      "**Variez les sujets :** musique, voyages, philosophie de vie, humour — des questions venues de domaines différents dressent un portrait de compatibilité plus complet",
      "**Évitez le trop facile et le trop difficile :** ce que tout le monde devine ne filtre personne, et ce que personne ne peut trouver ruine vos chances de match",
      "**Ajoutez une touche personnelle :** une question comme \"Quelle est ma ville préférée ?\" mesure à quel point l'autre vous connaît vraiment",
      "**Mettez-les à jour régulièrement :** renouvelez vos questions pour qu'elles suivent l'évolution de vos centres d'intérêt",
      "**Entre 2 et 4 questions, c'est l'idéal :** trop peu ne filtre pas assez, trop réduit votre probabilité de match — avec un abonnement payant, le plafond monte à 10",
    ] },

    { type: "quote", text: "Poser la bonne question, c'est trouver la bonne personne. Sur Qulo, un match n'est pas un hasard — c'est une découverte volontaire." },

    { type: "h2", text: "L'avenir du quiz dating" },
    { type: "p", text: "Le secteur de la rencontre est à un tournant. Les gens veulent mieux que des matchs superficiels, et le quiz dating est justement conçu pour cette attente. Le plus difficile reste d'écrire de bonnes questions : Qulo tient donc à disposition une bibliothèque de questions toutes prêtes, à parcourir quand l'inspiration manque — un fonds rédigé à l'avance avec l'aide de l'IA, et non un modèle qui écrirait vos questions sur le moment. La question sur laquelle on vous matche reste la vôtre." },
    { type: "p", text: "Le matching fondé sur les questions et l'interaction devrait continuer à se répandre, car l'autre modèle a déjà montré ses limites. Qulo entend être l'appli qui fixe la norme, pas celle qui la copie avec retard." },

    { type: "h2", accent: "green", text: "Conclusion : l'avenir de la rencontre passe par les questions" },
    { type: "p", text: "Le modèle du swipe a apporté une vraie innovation à la rencontre, mais ses limites sautent désormais aux yeux. Le quiz dating est la voie vers des liens plus profonds, plus signifiants et plus durables. Écrivez votre première question sur Qulo et voyez ce que devient un match quand il commence par de la curiosité." },
  ],

  es: [
    { type: "h2", text: "Los límites de las apps de citas tradicionales" },
    { type: "p", text: "En la última década, las apps de citas han cambiado por completo la forma en que millones de personas se conocen. La mecánica del deslizamiento, que se extendió por el sector a principios de la década de 2010, acabó dominándolo, y casi todas las apps de citas conocidas adoptaron el mismo modelo. Ese modelo tiene problemas serios, y quienes lo usan lo dicen: en una encuesta de **Forbes Health** realizada en 2024 junto a **OnePoll** entre **1.000** usuarios de apps de citas en Estados Unidos, el **78 %** declaró sentir agotamiento emocional por ligar a través de aplicaciones. Solo una pequeña parte de los matches que producen estas apps termina en una cita real." },
    { type: "p", text: "El problema de fondo del deslizamiento es que nos obliga a evaluar a alguien por una foto y cuatro líneas de biografía. Ese planteamiento presenta a las personas como un \"catálogo de productos\" e impide que se formen vínculos profundos. Con el tiempo, los usuarios sufren \"fatiga del swipe\" y o abandonan la app o siguen usándola de forma emocionalmente desconectada." },

    { type: "h2", text: "El concepto del quiz dating: un nuevo paradigma" },
    { type: "p", text: "El quiz dating redefine por completo el proceso de emparejamiento. La idea de partida es sencilla: si quieres conocer a alguien, mira sus ideas, no sus fotos. En el quiz dating cada persona crea sus propias preguntas y espera a que los posibles matches las resuelvan. Las respuestas correctas son la señal de compatibilidad." },
    { type: "p", text: "Que las preguntas construyan vínculo es algo más que una intuición. En un estudio publicado en 2017 en el **Journal of Personality and Social Psychology**, Huang, Yeomans, Brooks, Minson y Gino analizaron **1.961** decisiones sobre una segunda cita tomadas por **110** participantes en citas rápidas y observaron que quienes hacían más preguntas de seguimiento tenían más probabilidades de ser invitados de nuevo. La curiosidad resulta atractiva de forma medible, y una app basada en preguntas coloca esa curiosidad justo al principio del proceso." },

    { type: "h2", text: "¿Por qué las preguntas generan mejores matches?" },

    { type: "h2", text: "1. Compatibilidad cognitiva" },
    { type: "p", text: "Las preguntas revelan hasta qué punto encajan dos formas de pensar. Dos personas que responden lo mismo a la misma pregunta suelen compartir visión del mundo, valores y preferencias vitales. Es un indicador real de compatibilidad que va mucho más allá de la atracción superficial." },

    { type: "h2", text: "2. Participación activa" },
    { type: "p", text: "Deslizar es una acción pasiva: solo reaccionas a fotos. Responder preguntas exige participación activa. Esa implicación supone más inversión mental y hace que quienes hacen match se sientan más conectados entre sí. En psicología se lo llama **efecto de inversión**." },

    { type: "h2", text: "3. Buenos arranques de conversación" },
    { type: "p", text: "Uno de los mayores problemas de las apps de deslizamiento es el momento \"no sé qué escribir\". En el quiz dating, las preguntas dan por sí solas un arranque natural. Una apertura como \"Tu respuesta a esa pregunta me pareció fascinante, ¿por qué lo ves así?\" funciona mucho mejor que un \"hola\" a secas." },

    { type: "h2", text: "4. Filtrado por personalidad primero" },
    { type: "p", text: "Las preguntas miden la compatibilidad de personalidad al margen del aspecto, y eso hace el sistema más justo para todo el mundo. En las apps de deslizamiento una pequeña minoría de perfiles se lleva casi toda la atención; en el quiz dating todos parten con la misma oportunidad, porque lo que cuenta son tus respuestas." },

    { type: "h2", accent: "green", text: "Tests de personalidad y la ciencia de la compatibilidad" },
    { type: "p", text: "Lo que sostiene una relación no es ningún misterio: valores compartidos, estilos de comunicación que encajan, capacidad de atravesar un conflicto, metas de vida que apuntan en la misma dirección e inteligencia emocional por ambas partes. Las apps de deslizamiento no miden nada de eso. Los sistemas de preguntas y respuestas captan varios de esos aspectos de forma indirecta, porque las respuestas de una persona delatan cómo piensa." },
    { type: "p", text: "Piensa en una pregunta como \"¿Qué harías si tus planes del fin de semana se cayeran de repente?\". Una sola respuesta dice algo sobre la flexibilidad de alguien, sobre su forma de afrontar un conflicto y sobre el ritmo de vida que prefiere. Este tipo de preguntas saca en segundos lo que una noche entera de charla no alcanzaría." },

    { type: "h2", text: "Guía para crear preguntas en Qulo" },
    { type: "p", text: "Escribir buenas preguntas es la clave de unos matches de calidad. Esto es lo que conviene tener en cuenta en Qulo:" },
    { type: "ul", items: [
      "**Pregunta sobre temas variados:** música, viajes, filosofía de vida, humor — preguntas de ámbitos distintos dibujan un retrato de compatibilidad más completo",
      "**Evita lo demasiado fácil y lo demasiado difícil:** lo que cualquiera adivina no filtra a nadie, y lo que nadie puede acertar arruina tus opciones de match",
      "**Añade toques personales:** una pregunta como \"¿Cuál es mi ciudad favorita?\" mide cuánto te conoce de verdad quien responde",
      "**Actualízalas con regularidad:** renueva tus preguntas para que reflejen tus intereses según van cambiando",
      "**Entre 2 y 4 preguntas es lo ideal:** demasiado pocas no filtran lo suficiente, demasiadas reducen tu probabilidad de match; con un plan de pago el tope sube a 10",
    ] },

    { type: "quote", text: "Hacer la pregunta correcta es encontrar a la persona correcta. En Qulo, un match no es una casualidad: es un descubrimiento consciente." },

    { type: "h2", text: "El futuro del quiz dating" },
    { type: "p", text: "El sector de las citas está en un punto de inflexión. La gente quiere algo más que matches superficiales, y el quiz dating está construido justo para esa demanda. Lo difícil es escribir buenas preguntas, así que Qulo mantiene una biblioteca de preguntas ya hechas que puedes hojear cuando se te agota la inspiración: un fondo redactado de antemano con ayuda de la IA, no un modelo que escriba tus preguntas en ese instante. La pregunta con la que alguien hace match contigo sigue siendo tuya." },
    { type: "p", text: "Es previsible que el emparejamiento basado en preguntas e interacción siga extendiéndose, porque la alternativa ya ha enseñado sus límites. Qulo aspira a ser la app que marca el estándar, no la que lo copia tarde." },

    { type: "h2", accent: "green", text: "Conclusión: el futuro del emparejamiento está en las preguntas" },
    { type: "p", text: "El modelo del deslizamiento trajo una innovación real a las citas, pero sus límites ya están a la vista. El quiz dating es el camino hacia vínculos más profundos, más significativos y más sostenibles. Escribe tu primera pregunta en Qulo y comprueba cómo se siente un match que empieza por la curiosidad." },
  ],

  ar: [
    { type: "h2", text: "حدود تطبيقات المواعدة التقليدية" },
    { type: "p", text: "خلال العقد الماضي غيّرت تطبيقات المواعدة جذريًا الطريقة التي يتعارف بها ملايين الناس. آلية التمرير التي انتشرت في هذا المجال مطلع عقد 2010 صارت النموذج المهيمن، وتبنّتها تقريبًا كل التطبيقات الكبرى. لكن هذا النموذج يعاني مشكلات جدية، ومستخدموه أنفسهم يقولون ذلك: في استطلاع أجرته **Forbes Health** عام 2024 بالتعاون مع **OnePoll** شمل **1000** مستخدم لتطبيقات المواعدة في الولايات المتحدة، أفاد **78%** منهم بأنهم شعروا بإرهاق عاطفي من المواعدة عبر التطبيقات. ولا يتحول إلى موعد حقيقي سوى جزء صغير من التوافقات التي تنتجها هذه التطبيقات." },
    { type: "p", text: "المشكلة الجوهرية في آلية التمرير أنها تجبرنا على الحكم على إنسان من صورة وسطرين من التعريف. هذا الأسلوب يعرض الناس وكأنهم \"كتالوج منتجات\"، ويمنع نشوء روابط عميقة. ومع الوقت يصاب المستخدمون بـ\"إرهاق التمرير\"، فإما يهجرون التطبيق أو يواصلون استخدامه بانفصال عاطفي." },

    { type: "h2", text: "مفهوم المواعدة بالأسئلة: نموذج جديد" },
    { type: "p", text: "المواعدة بالأسئلة تعيد تعريف عملية التوافق من أساسها. الفكرة بسيطة: إن أردت أن تعرف إنسانًا فانظر إلى أفكاره لا إلى صوره. هنا يكتب كل مستخدم أسئلته الخاصة وينتظر من المرشحين للتوافق أن يحلّوها، والإجابات الصحيحة هي دليل الانسجام." },
    { type: "p", text: "فكرة أن الأسئلة تصنع الرابط ليست مجرد حدس. في دراسة نُشرت عام 2017 في مجلة **Journal of Personality and Social Psychology**، حلّل هوانغ ويومانز وبروكس ومينسون وجينو (Huang, Yeomans, Brooks, Minson, Gino) **1961** قرارًا بشأن موعد ثانٍ اتخذها **110** مشاركين في مواعدات سريعة، ووجدوا أن من يطرحون أسئلة متابعة أكثر كانوا أوفر حظًا في تلقي دعوة جديدة. الفضول جذّاب بصورة قابلة للقياس، والتطبيق القائم على الأسئلة يضع هذا الفضول في مقدمة العملية." },

    { type: "h2", text: "لماذا تصنع الأسئلة توافقًا أفضل؟" },

    { type: "h2", text: "1. الانسجام الذهني" },
    { type: "p", text: "تكشف الأسئلة مدى تقارب طريقتَي تفكير شخصين. من يعطيان الإجابة نفسها للسؤال نفسه يتشاركان على الأرجح رؤية للعالم وقيمًا وتفضيلات حياتية متقاربة. هذا مؤشر حقيقي على الانسجام يتجاوز الانجذاب السطحي." },

    { type: "h2", text: "2. المشاركة الفاعلة" },
    { type: "p", text: "التمرير فعل سلبي؛ أنت تكتفي بالتفاعل مع الصور. أما الإجابة عن الأسئلة فتتطلب مشاركة فاعلة. وهذه المشاركة تعني استثمارًا ذهنيًا أكبر، وتجعل المتوافقين يشعرون بارتباط أوثق ببعضهم. يسمّي علم النفس ذلك **أثر الاستثمار**." },

    { type: "h2", text: "3. بدايات حديث ذات معنى" },
    { type: "p", text: "من أكبر مشكلات تطبيقات التمرير لحظة \"لا أعرف ماذا أكتب\". في المواعدة بالأسئلة تمنحك الأسئلة بداية حديث طبيعية. افتتاحية مثل \"إجابتك على ذلك السؤال كانت لافتة حقًا — لماذا ترى الأمر هكذا؟\" أنجع بكثير من \"مرحبًا\" مجردة." },

    { type: "h2", text: "4. تصفية تبدأ من الشخصية" },
    { type: "p", text: "تقيس الأسئلة انسجام الشخصية بمعزل عن المظهر، وهذا يجعل النظام أعدل للجميع. في تطبيقات التمرير تستحوذ أقلية صغيرة من الملفات على معظم الاهتمام؛ أما هنا فيبدأ الجميع بالفرصة نفسها، لأن المعيار هو إجاباتك." },

    { type: "h2", accent: "green", text: "اختبارات الشخصية وعلم الانسجام" },
    { type: "p", text: "ما يُبقي العلاقة قائمة ليس لغزًا: قيم مشتركة، أساليب تواصل متوافقة، القدرة على تجاوز الخلاف، أهداف حياة تشير إلى الاتجاه نفسه، وذكاء عاطفي عند الطرفين. تطبيقات التمرير لا تقيس شيئًا من ذلك. أما أنظمة السؤال والجواب فتلتقط كثيرًا منه بصورة غير مباشرة، لأن إجابات الإنسان تفضح طريقة تفكيره." },
    { type: "p", text: "خذ سؤالًا مثل \"ماذا تفعل لو تغيّرت خطط عطلتك فجأة؟\". إجابة واحدة تقول شيئًا عن مرونة صاحبها، وعن أسلوبه في مواجهة الخلاف، وعن الإيقاع الذي يحب أن يعيش به. أسئلة كهذه تُظهر في ثوانٍ ما لا يبلغه حديث عابر طوال أمسية كاملة." },

    { type: "h2", text: "دليل كتابة الأسئلة على Qulo" },
    { type: "p", text: "كتابة أسئلة فعّالة هي مفتاح التوافقات الجيدة. إليك ما ينبغي مراعاته على Qulo:" },
    { type: "ul", items: [
      "**نوّع الموضوعات:** الموسيقى، السفر، فلسفة الحياة، الفكاهة — الأسئلة من مجالات مختلفة ترسم صورة أكمل عن الانسجام",
      "**تجنّب السهل جدًا والصعب جدًا:** ما يخمّنه الجميع لا يصفّي أحدًا، وما لا يعرفه أحد يقضي على فرص التوافق",
      "**أضف لمسات شخصية:** سؤال مثل \"ما مدينتي المفضلة؟\" يقيس كم يعرفك المجيب فعلًا",
      "**حدّثها بانتظام:** جدّد أسئلتك لتواكب اهتماماتك كلما تغيّرت",
      "**من 2 إلى 4 أسئلة هو المدى الأمثل:** القليل جدًا لا يصفّي بما يكفي، والكثير جدًا يقلّص احتمال التوافق — وفي الخطة المدفوعة يرتفع الحد الأقصى إلى 10 أسئلة",
    ] },

    { type: "quote", text: "أن تطرح السؤال الصحيح يعني أن تجد الإنسان الصحيح. على Qulo، التوافق ليس مصادفة — بل اكتشاف واعٍ." },

    { type: "h2", text: "مستقبل المواعدة بالأسئلة" },
    { type: "p", text: "يقف قطاع المواعدة عند منعطف. صار الناس يريدون أكثر من توافقات سطحية، والمواعدة بالأسئلة مبنية لهذا الطلب تحديدًا. والجزء الصعب هو كتابة أسئلة جيدة، ولهذا يوفّر Qulo مكتبة أسئلة جاهزة تتصفّحها حين ينفد الإلهام — مخزون كُتب مسبقًا بمساعدة الذكاء الاصطناعي، لا نموذجًا يكتب أسئلتك لحظتها. والسؤال الذي يتطابق عليه أحدهم يظل سؤالك أنت." },
    { type: "p", text: "من المرجّح أن يواصل التوافق القائم على الأسئلة والتفاعل انتشاره، لأن البديل أظهر حدوده منذ زمن. ويطمح Qulo إلى أن يكون التطبيق الذي يضع المعيار لا الذي ينسخه متأخرًا." },

    { type: "h2", accent: "green", text: "الخلاصة: مستقبل التوافق في الأسئلة" },
    { type: "p", text: "قدّم نموذج التمرير ابتكارًا حقيقيًا للمواعدة، لكن حدوده باتت واضحة للعيان. المواعدة بالأسئلة هي الطريق إلى روابط أعمق وأكثر معنى وأطول عمرًا. اكتب سؤالك الأول على Qulo، وانظر كيف يكون شعور التوافق حين يبدأ بالفضول." },
  ],

  ru: [
    { type: "h2", text: "Ограничения привычных приложений для знакомств" },
    { type: "p", text: "За последнее десятилетие приложения для знакомств полностью изменили то, как встречаются миллионы людей. Механика свайпа, распространившаяся в отрасли в начале 2010-х, стала доминирующей моделью, и почти каждое крупное приложение переняло её. У этой модели серьёзные проблемы, и говорят об этом сами пользователи: в опросе **Forbes Health**, проведённом в 2024 году совместно с **OnePoll** среди **1000** пользователей приложений для знакомств в США, **78%** сообщили об эмоциональном выгорании от знакомств через приложения. И лишь малая часть возникающих там совпадений когда-либо доходит до настоящего свидания." },
    { type: "p", text: "Главная проблема свайпа в том, что он заставляет оценивать человека по фотографии и паре строк описания. Такой подход выставляет людей как \"товарный каталог\" и мешает возникнуть глубокой связи. Со временем пользователи получают \"усталость от свайпа\" и либо бросают приложение, либо продолжают им пользоваться эмоционально отстранённо." },

    { type: "h2", text: "Концепция знакомств через вопросы: новая парадигма" },
    { type: "p", text: "Знакомства через вопросы полностью переопределяют процесс подбора пары. Исходная мысль проста: если хотите узнать человека, смотрите на его мысли, а не на его фотографии. Здесь каждый составляет собственные вопросы и ждёт, что потенциальные пары их решат. Правильные ответы и есть показатель совместимости." },
    { type: "p", text: "Мысль о том, что вопросы создают связь, — не только интуиция. В исследовании, опубликованном в 2017 году в журнале **Journal of Personality and Social Psychology**, Хуанг, Йоманс, Брукс, Минсон и Джино (Huang, Yeomans, Brooks, Minson, Gino) проанализировали **1961** решение о втором свидании, принятое **110** участниками быстрых свиданий, и обнаружили: те, кто задавал больше уточняющих вопросов, чаще получали приглашение снова. Любопытство привлекательно измеримым образом, а приложение на вопросах ставит это любопытство в самое начало процесса." },

    { type: "h2", text: "Почему вопросы дают лучшие совпадения?" },

    { type: "h2", text: "1. Когнитивная совместимость" },
    { type: "p", text: "Вопросы показывают, насколько совпадают способы мышления двух людей. Те, кто одинаково отвечает на один и тот же вопрос, скорее всего, разделяют похожие взгляды, ценности и жизненные предпочтения. Это настоящий признак совместимости, который выходит далеко за пределы поверхностного влечения." },

    { type: "h2", text: "2. Активное участие" },
    { type: "p", text: "Свайп — пассивное действие: вы просто реагируете на фотографии. Ответы на вопросы требуют активного участия. Такая вовлечённость означает больший умственный вклад и заставляет совпавших чувствовать себя ближе друг к другу. В психологии это называют **эффектом вложенных усилий**." },

    { type: "h2", text: "3. Осмысленное начало разговора" },
    { type: "p", text: "Одна из главных бед свайп-приложений — момент \"не знаю, что написать\". В знакомствах через вопросы сами вопросы дают естественный повод для разговора. Начало вроде \"Твой ответ на тот вопрос меня по-настоящему зацепил — почему ты так считаешь?\" работает гораздо лучше, чем сухое \"привет\"." },

    { type: "h2", text: "4. Отбор, начинающийся с личности" },
    { type: "p", text: "Вопросы измеряют совместимость характеров независимо от внешности, и это делает систему справедливее для всех. В свайп-приложениях небольшое меньшинство анкет забирает почти всё внимание; здесь же все начинают с одинаковыми шансами, потому что решают ваши ответы." },

    { type: "h2", accent: "green", text: "Тесты личности и наука о совместимости" },
    { type: "p", text: "То, что держит отношения, не такая уж загадка: общие ценности, подходящие друг другу стили общения, умение проходить через конфликт, жизненные цели, направленные в одну сторону, и эмоциональный интеллект с обеих сторон. Свайп-приложения не измеряют ничего из этого. Системы вопросов и ответов улавливают многое из перечисленного косвенно, потому что ответы человека выдают его способ мышления." },
    { type: "p", text: "Возьмите вопрос вроде \"Что бы ты сделал, если бы планы на выходные внезапно рухнули?\". Один ответ говорит и о гибкости человека, и о его отношении к конфликту, и о том, какой ритм жизни ему по душе. Такие вопросы за секунды вытаскивают то, до чего светская беседа не доберётся и за целый вечер." },

    { type: "h2", text: "Как составлять вопросы в Qulo" },
    { type: "p", text: "Хорошие вопросы — ключ к качественным совпадениям. Вот что стоит держать в голове в Qulo:" },
    { type: "ul", items: [
      "**Берите разные темы:** музыка, путешествия, жизненная философия, юмор — вопросы из разных областей дают более полную картину совместимости",
      "**Избегайте слишком простого и слишком сложного:** то, что угадает каждый, не отсеет никого, а то, чего не знает никто, убьёт ваши шансы на совпадение",
      "**Добавляйте личное:** вопрос вроде \"Какой город мой любимый?\" измеряет, насколько отвечающий действительно вас знает",
      "**Регулярно обновляйте:** освежайте вопросы, чтобы они отражали ваши интересы по мере их изменения",
      "**От 2 до 4 вопросов — оптимум:** слишком мало не отфильтрует, слишком много снизит вероятность совпадения; на платном тарифе потолок поднимается до 10",
    ] },

    { type: "quote", text: "Задать правильный вопрос — значит найти правильного человека. В Qulo совпадение не случайность, а осознанное открытие." },

    { type: "h2", text: "Будущее знакомств через вопросы" },
    { type: "p", text: "Индустрия знакомств находится на переломе. Людям нужно больше, чем поверхностные совпадения, и знакомства через вопросы созданы именно под этот запрос. Самое трудное — придумать хороший вопрос, поэтому в Qulo есть библиотека готовых вопросов: её можно пролистать, когда вдохновение закончилось. Это заранее составленный запас, подготовленный с помощью ИИ, а не модель, которая пишет вопросы за вас в эту самую минуту. Вопрос, по которому с вами совпадают, остаётся вашим." },
    { type: "p", text: "Подбор, основанный на вопросах и взаимодействии, скорее всего, будет распространяться дальше: альтернатива свои пределы уже показала. Qulo намерен быть приложением, которое задаёт стандарт, а не тем, которое запоздало его копирует." },

    { type: "h2", accent: "green", text: "Вывод: будущее совпадений — в вопросах" },
    { type: "p", text: "Свайп-модель принесла знакомствам настоящую новинку, но её пределы теперь очевидны. Знакомства через вопросы — путь к более глубоким, более осмысленным и более прочным связям. Напишите свой первый вопрос в Qulo и посмотрите, каким становится совпадение, когда начинается с любопытства." },
  ],

  pt: [
    { type: "h2", text: "Os limites dos aplicativos de namoro tradicionais" },
    { type: "p", text: "Na última década, os aplicativos de namoro mudaram completamente a forma como milhões de pessoas se conhecem. A mecânica do deslizar, que se espalhou pelo setor no início dos anos 2010, tornou-se o modelo dominante, e quase todos os aplicativos conhecidos adotaram o mesmo desenho. Esse modelo tem problemas sérios, e quem o usa diz isso: em uma pesquisa da **Forbes Health** feita em 2024 junto com a **OnePoll** entre **1.000** usuários de aplicativos de namoro nos Estados Unidos, **78%** relataram esgotamento emocional por paquerar através de aplicativos. E só uma pequena parte dos matches que esses aplicativos produzem vira um encontro de verdade." },
    { type: "p", text: "O problema de fundo do deslizar é que ele obriga a avaliar alguém por uma foto e duas linhas de biografia. Essa abordagem apresenta as pessoas como um \"catálogo de produtos\" e impede que laços profundos se formem. Com o tempo, os usuários sentem \"fadiga de swipe\" e ou abandonam o aplicativo ou seguem usando-o de forma emocionalmente desligada." },

    { type: "h2", text: "O conceito de quiz dating: um novo paradigma" },
    { type: "p", text: "O quiz dating redefine por inteiro o processo de formar pares. A ideia de partida é simples: se você quer conhecer alguém, olhe para os pensamentos da pessoa, não para as fotos. Aqui cada um cria as próprias perguntas e espera que os possíveis matches as resolvam. As respostas certas são o sinal de compatibilidade." },
    { type: "p", text: "A ideia de que perguntas criam vínculo é mais do que intuição. Em um estudo publicado em 2017 no **Journal of Personality and Social Psychology**, Huang, Yeomans, Brooks, Minson e Gino analisaram **1.961** decisões sobre um segundo encontro tomadas por **110** participantes de encontros rápidos e concluíram que quem fazia mais perguntas de acompanhamento tinha mais chance de ser convidado de novo. A curiosidade é atraente de um jeito mensurável, e um aplicativo baseado em perguntas coloca essa curiosidade logo no começo do processo." },

    { type: "h2", text: "Por que perguntas geram matches melhores?" },

    { type: "h2", text: "1. Compatibilidade cognitiva" },
    { type: "p", text: "As perguntas revelam o quanto duas formas de pensar se encontram. Duas pessoas que respondem a mesma coisa à mesma pergunta provavelmente compartilham visão de mundo, valores e preferências de vida. É um indicador real de compatibilidade, muito além da atração superficial." },

    { type: "h2", text: "2. Participação ativa" },
    { type: "p", text: "Deslizar é uma ação passiva: você apenas reage a fotos. Responder perguntas exige participação ativa. Esse envolvimento significa mais investimento mental e faz com que quem deu match se sinta mais ligado ao outro. Na psicologia isso se chama **efeito de investimento**." },

    { type: "h2", text: "3. Bons começos de conversa" },
    { type: "p", text: "Um dos maiores problemas dos aplicativos de deslizar é o momento \"não sei o que escrever\". No quiz dating, as próprias perguntas dão um começo natural. Uma abertura como \"Sua resposta àquela pergunta foi muito interessante — por que você pensa assim?\" funciona muito melhor do que um \"oi\" seco." },

    { type: "h2", text: "4. Filtragem que começa pela personalidade" },
    { type: "p", text: "As perguntas medem a compatibilidade de personalidade independentemente da aparência, o que torna o sistema mais justo para todo mundo. Nos aplicativos de deslizar, uma pequena minoria de perfis concentra quase toda a atenção; no quiz dating todos começam com a mesma chance, porque o que decide são as suas respostas." },

    { type: "h2", accent: "green", text: "Testes de personalidade e a ciência da compatibilidade" },
    { type: "p", text: "O que sustenta uma relação não é grande mistério: valores em comum, estilos de comunicação que combinam, capacidade de atravessar um conflito, planos de vida apontando para a mesma direção e inteligência emocional dos dois lados. Os aplicativos de deslizar não medem nada disso. Sistemas de pergunta e resposta captam vários desses pontos de forma indireta, porque as respostas de alguém entregam o jeito como essa pessoa pensa." },
    { type: "p", text: "Pense numa pergunta como \"O que você faria se seus planos de fim de semana mudassem de repente?\". Uma única resposta já diz algo sobre a flexibilidade da pessoa, sobre como ela encara um conflito e sobre o ritmo de vida que prefere. Perguntas assim trazem à tona em segundos o que uma noite inteira de conversa fiada não alcança." },

    { type: "h2", text: "Guia para criar perguntas no Qulo" },
    { type: "p", text: "Escrever boas perguntas é a chave para matches de qualidade. É isto que vale ter em mente no Qulo:" },
    { type: "ul", items: [
      "**Varie os assuntos:** música, viagem, filosofia de vida, humor — perguntas de áreas diferentes desenham um retrato de compatibilidade mais completo",
      "**Fuja do fácil demais e do difícil demais:** o que qualquer um adivinha não filtra ninguém, e o que ninguém acerta acaba com suas chances de match",
      "**Coloque toques pessoais:** uma pergunta como \"Qual é a minha cidade favorita?\" mede o quanto quem responde realmente conhece você",
      "**Atualize com regularidade:** renove suas perguntas para que acompanhem seus interesses conforme eles mudam",
      "**De 2 a 4 perguntas é o ideal:** poucas demais não filtram o bastante, muitas demais reduzem sua probabilidade de match — num plano pago o teto sobe para 10",
    ] },

    { type: "quote", text: "Fazer a pergunta certa é encontrar a pessoa certa. No Qulo, um match não é coincidência — é uma descoberta consciente." },

    { type: "h2", text: "O futuro do quiz dating" },
    { type: "p", text: "O setor de namoro está num ponto de virada. As pessoas querem mais do que matches superficiais, e o quiz dating foi construído exatamente para essa demanda. A parte difícil é escrever boas perguntas, então o Qulo mantém uma biblioteca de perguntas prontas para você folhear quando a inspiração acabar — um acervo redigido de antemão com ajuda de IA, e não um modelo que escreve suas perguntas na hora. A pergunta pela qual alguém dá match com você continua sendo sua." },
    { type: "p", text: "É provável que a formação de pares baseada em perguntas e interação continue a se espalhar, porque a alternativa já mostrou seus limites. O Qulo pretende ser o aplicativo que define o padrão, não o que o copia tarde." },

    { type: "h2", accent: "green", text: "Conclusão: o futuro dos matches está nas perguntas" },
    { type: "p", text: "O modelo do deslizar trouxe uma inovação real ao namoro, mas seus limites já estão à vista. O quiz dating é o caminho para laços mais profundos, mais significativos e mais duradouros. Escreva sua primeira pergunta no Qulo e veja como é um match que começa pela curiosidade." },
  ],

  it: [
    { type: "h2", text: "I limiti delle app di incontri tradizionali" },
    { type: "p", text: "Negli ultimi dieci anni le app di incontri hanno cambiato alla radice il modo in cui milioni di persone si conoscono. La meccanica dello swipe, diffusasi nel settore all'inizio degli anni 2010, è diventata il modello dominante e quasi tutte le app più note l'hanno adottata. Quel modello ha problemi seri, e a dirlo sono le persone che lo usano: in un sondaggio **Forbes Health** condotto nel 2024 insieme a **OnePoll** su **1.000** utenti di app di incontri negli Stati Uniti, il **78%** ha dichiarato di aver provato esaurimento emotivo per gli appuntamenti cercati tramite app. E solo una piccola parte dei match che queste app producono diventa un appuntamento vero." },
    { type: "p", text: "Il problema di fondo dello swipe è che costringe a valutare qualcuno da una foto e due righe di biografia. Questo approccio presenta le persone come un \"catalogo di prodotti\" e impedisce che nascano legami profondi. Col tempo gli utenti sviluppano la \"stanchezza da swipe\" e o abbandonano l'app o continuano a usarla in modo emotivamente distaccato." },

    { type: "h2", text: "Il concetto di quiz dating: un nuovo paradigma" },
    { type: "p", text: "Il quiz dating ridefinisce da capo il processo di abbinamento. L'idea di partenza è semplice: se vuoi conoscere qualcuno, guarda i suoi pensieri, non le sue foto. Qui ognuno scrive le proprie domande e aspetta che i potenziali match le risolvano. Le risposte giuste sono il segnale di compatibilità." },
    { type: "p", text: "Che le domande costruiscano legame è più di un'intuizione. In uno studio pubblicato nel 2017 sul **Journal of Personality and Social Psychology**, Huang, Yeomans, Brooks, Minson e Gino hanno analizzato **1.961** decisioni su un secondo appuntamento prese da **110** partecipanti a speed date e hanno riscontrato che chi faceva più domande di approfondimento veniva richiamato più spesso. La curiosità è attraente in modo misurabile, e un'app basata sulle domande mette quella curiosità proprio all'inizio del percorso." },

    { type: "h2", text: "Perché le domande producono match migliori?" },

    { type: "h2", text: "1. Compatibilità cognitiva" },
    { type: "p", text: "Le domande rivelano quanto due modi di pensare si incontrino. Due persone che rispondono allo stesso modo alla stessa domanda condividono con ogni probabilità visione del mondo, valori e preferenze di vita. È un indicatore reale di compatibilità, molto oltre l'attrazione di superficie." },

    { type: "h2", text: "2. Partecipazione attiva" },
    { type: "p", text: "Fare swipe è un'azione passiva: ci si limita a reagire a delle foto. Rispondere a domande richiede partecipazione attiva. Quel coinvolgimento significa più investimento mentale e fa sentire più legate le persone che si sono trovate. In psicologia si chiama **effetto investimento**." },

    { type: "h2", text: "3. Aperture di conversazione che funzionano" },
    { type: "p", text: "Uno dei problemi più grossi delle app a swipe è il momento \"non so cosa scrivere\". Nel quiz dating sono le domande stesse a offrire un aggancio naturale. Un'apertura come \"La tua risposta a quella domanda mi ha davvero incuriosito: perché la pensi così?\" funziona molto meglio di un \"ciao\" secco." },

    { type: "h2", text: "4. Un filtro che parte dalla personalità" },
    { type: "p", text: "Le domande misurano la compatibilità caratteriale a prescindere dall'aspetto, e questo rende il sistema più equo per tutti. Sulle app a swipe una piccola minoranza di profili raccoglie quasi tutta l'attenzione; nel quiz dating si parte tutti con la stessa possibilità, perché a contare sono le tue risposte." },

    { type: "h2", accent: "green", text: "Test di personalità e scienza della compatibilità" },
    { type: "p", text: "Ciò che tiene insieme una relazione non è un mistero: valori condivisi, stili comunicativi che si incastrano, la capacità di attraversare un conflitto, obiettivi di vita rivolti nella stessa direzione e intelligenza emotiva da entrambe le parti. Le app a swipe non misurano niente di tutto questo. I sistemi a domanda e risposta ne colgono diversi in modo indiretto, perché le risposte di una persona tradiscono il suo modo di ragionare." },
    { type: "p", text: "Prendete una domanda come \"Cosa faresti se i tuoi programmi del weekend saltassero all'improvviso?\". Una sola risposta dice qualcosa sulla flessibilità di chi la dà, sul suo modo di affrontare un conflitto e sul ritmo di vita che preferisce. Domande così portano a galla in pochi secondi ciò a cui una serata di chiacchiere non arriverebbe." },

    { type: "h2", text: "Guida alla scrittura delle domande su Qulo" },
    { type: "p", text: "Scrivere domande efficaci è la chiave di match di qualità. Ecco cosa tenere a mente su Qulo:" },
    { type: "ul", items: [
      "**Variate gli argomenti:** musica, viaggi, filosofia di vita, umorismo — domande da ambiti diversi restituiscono un ritratto di compatibilità più completo",
      "**Evitate il troppo facile e il troppo difficile:** ciò che indovinano tutti non filtra nessuno, ciò che non sa nessuno azzera le vostre possibilità di match",
      "**Aggiungete tocchi personali:** una domanda come \"Qual è la mia città preferita?\" misura quanto chi risponde vi conosce davvero",
      "**Aggiornatele con regolarità:** rinnovate le domande perché seguano i vostri interessi mentre cambiano",
      "**Da 2 a 4 domande è la misura giusta:** troppo poche non filtrano abbastanza, troppe riducono la probabilità di match — con un piano a pagamento il tetto sale a 10",
    ] },

    { type: "quote", text: "Fare la domanda giusta significa trovare la persona giusta. Su Qulo un match non è una coincidenza: è una scoperta consapevole." },

    { type: "h2", text: "Il futuro del quiz dating" },
    { type: "p", text: "Il settore degli incontri è a una svolta. Le persone vogliono più che match superficiali, e il quiz dating è costruito esattamente su quella domanda. La parte difficile è scrivere buone domande, perciò Qulo mette a disposizione una raccolta di domande già pronte da sfogliare quando l'ispirazione manca: un archivio redatto in anticipo con l'aiuto dell'IA, non un modello che scrive le domande al posto tuo sul momento. La domanda su cui qualcuno fa match con te resta la tua." },
    { type: "p", text: "È probabile che l'abbinamento basato su domande e interazione continui a diffondersi, perché l'alternativa ha già mostrato i propri limiti. Qulo punta a essere l'app che fissa lo standard, non quella che lo copia in ritardo." },

    { type: "h2", accent: "green", text: "Conclusione: il futuro dell'abbinamento sta nelle domande" },
    { type: "p", text: "Il modello a swipe ha portato agli incontri un'innovazione vera, ma i suoi limiti sono ormai sotto gli occhi di tutti. Il quiz dating è la strada verso legami più profondi, più significativi e più duraturi. Scrivete la vostra prima domanda su Qulo e guardate che cosa diventa un match quando comincia dalla curiosità." },
  ],

  ja: [
    { type: "h2", text: "従来のマッチングアプリの限界" },
    { type: "p", text: "この十年で、マッチングアプリは何百万人もの出会い方を根本から変えました。2010年代の初めに広まったスワイプの仕組みは業界を席巻し、主要なアプリのほとんどが同じ形を採用しています。しかしこのモデルには深刻な問題があり、それを口にしているのは使っている本人たちです。**Forbes Health** が2024年に **OnePoll** と実施した、米国のマッチングアプリ利用者 **1,000** 人を対象とした調査では、**78%** がアプリでの恋愛活動によって感情的に燃え尽きたと回答しました。そして、こうしたアプリで生まれるマッチのうち実際のデートにつながるのはごく一部にすぎません。" },
    { type: "p", text: "スワイプの根本的な問題は、写真一枚と数行の自己紹介で人を判断させてしまうことです。この作りは人を「商品カタログ」のように並べ、深いつながりが生まれるのを妨げます。やがて利用者は「スワイプ疲れ」を感じ、アプリを離れるか、感情の伴わない使い方を続けることになります。" },

    { type: "h2", text: "クイズデーティングという考え方 — 新しいパラダイム" },
    { type: "p", text: "クイズデーティングは、マッチングの流れをまるごと定義し直す方法です。出発点は単純で、誰かを知りたいなら写真ではなく考えを見よう、というものです。ここでは一人ひとりが自分の質問をつくり、マッチ候補がそれを解くのを待ちます。正解こそが相性のしるしです。" },
    { type: "p", text: "質問が関係をつくるというのは、単なる直感ではありません。**Journal of Personality and Social Psychology** に2017年に掲載された研究で、Huang、Yeomans、Brooks、Minson、Gino の各氏は、スピードデート参加者 **110** 人による **1,961** 件の「二度目に会うかどうか」の判断を分析し、掘り下げる質問を多くした人ほど再び誘われやすいことを見いだしました。好奇心は測れるかたちで魅力的であり、質問を土台にしたアプリはその好奇心を最初の一歩に置きます。" },

    { type: "h2", text: "なぜ質問はより良いマッチを生むのか" },

    { type: "h2", text: "1. 思考の相性" },
    { type: "p", text: "質問は、二人の考え方がどれだけ噛み合うかを映し出します。同じ質問に同じ答えを返す二人は、世界の見方も価値観も暮らしの好みも近い可能性が高い。これは見た目の魅力を超えた、本物の相性の手がかりです。" },

    { type: "h2", text: "2. 能動的な参加" },
    { type: "p", text: "スワイプは受け身の行為で、写真に反応しているだけです。質問に答えるには能動的な参加が要ります。その関与は思考の投資を増やし、マッチした二人がより結びつきを感じる理由になります。心理学ではこれを **投資効果** と呼びます。" },

    { type: "h2", text: "3. 意味のある会話のきっかけ" },
    { type: "p", text: "スワイプ型アプリの最大の悩みのひとつが「何を書けばいいかわからない」瞬間です。クイズデーティングでは質問そのものが自然な糸口になります。「あの質問の答え、すごく面白かった。どうしてそう思うの？」という始まり方は、ただの「はじめまして」よりはるかに効きます。" },

    { type: "h2", text: "4. 人柄から始まる絞り込み" },
    { type: "p", text: "質問は見た目とは無関係に人柄の相性を測るので、仕組み全体が誰にとっても公平になります。スワイプ型アプリではごく一部のプロフィールが注目のほとんどを集めますが、クイズデーティングでは全員が同じ地点から始まります。ものを言うのはあなたの答えだからです。" },

    { type: "h2", accent: "green", text: "性格テストと相性の科学" },
    { type: "p", text: "関係を支えるものは、それほど神秘的ではありません。共有された価値観、噛み合うコミュニケーションの癖、衝突を通り抜ける力、同じ方角を向いた人生の目標、そして双方の情緒的な知性です。スワイプ型アプリはそのどれも測りません。質問と答えの仕組みなら、その多くを間接的に捉えられます。人の答えは、その人の考え方を映すからです。" },
    { type: "p", text: "たとえば「週末の予定が急に崩れたらどうする？」という質問を考えてみてください。たった一つの答えが、その人の柔軟さ、衝突への向き合い方、好きな暮らしのテンポを語ります。こうした質問は、一晩の世間話でも届かないところに数秒でたどり着きます。" },

    { type: "h2", text: "Qulo での質問づくりガイド" },
    { type: "p", text: "良い質問を書くことが、質の高いマッチへの鍵です。Qulo で質問をつくるときは次の点を意識してください。" },
    { type: "ul", items: [
      "**分野を散らす:** 音楽、旅、人生観、ユーモア — 別々の領域からの質問ほど、相性の輪郭がはっきり描けます",
      "**簡単すぎ・難しすぎを避ける:** 誰でも当たる質問は誰も絞れず、誰にも当てられない質問はマッチの芽を摘みます",
      "**個人的な色を足す:** 「私の一番好きな街は？」のような質問は、答える人がどれだけ本当にあなたを知っているかを測ります",
      "**定期的に更新する:** 興味の変化に合わせて質問も入れ替えましょう",
      "**2〜4問がちょうどよい:** 少なすぎると絞り込めず、多すぎるとマッチの確率が下がります（有料プランなら上限は10問）",
    ] },

    { type: "quote", text: "正しい問いを立てることは、正しい人に出会うことです。Qulo のマッチングは偶然ではなく、意識的な発見です。" },

    { type: "h2", text: "クイズデーティングのこれから" },
    { type: "p", text: "恋愛アプリの業界は転換点にあります。人々は表面的なマッチ以上のものを求めており、クイズデーティングはまさにその需要のために作られた仕組みです。むずかしいのは、よい質問を書くことです。だから Qulo には、思いつかないときに眺められる既製の質問ライブラリがあります。あらかじめ AI の助けを借りて用意しておいた蓄えであって、その場であなたの代わりに質問を書くモデルではありません。マッチのきっかけになる質問は、やはりあなた自身のものです。" },
    { type: "p", text: "質問や対話に基づくマッチングは今後も広がっていくでしょう。代わりの方式はすでに限界を見せているからです。Qulo は、その基準を遅れて真似るアプリではなく、基準そのものをつくるアプリでありたいと考えています。" },

    { type: "h2", accent: "green", text: "結論 — マッチングの未来は問いの中にある" },
    { type: "p", text: "スワイプ型のモデルは恋愛アプリに本物の革新をもたらしましたが、その限界はもう誰の目にも明らかです。クイズデーティングは、より深く、より意味があり、より長続きするつながりへの道です。Qulo で最初の質問を書いて、好奇心から始まるマッチがどんな感触なのか確かめてみてください。" },
  ],

  ko: [
    { type: "h2", text: "기존 데이팅 앱의 한계" },
    { type: "p", text: "지난 10년 동안 데이팅 앱은 수백만 명이 사람을 만나는 방식을 근본적으로 바꿔 놓았습니다. 2010년대 초 업계에 퍼진 스와이프 방식은 이내 지배적인 모델이 되었고, 널리 알려진 앱 대부분이 같은 구조를 받아들였습니다. 그러나 이 모델에는 심각한 문제가 있고, 그렇게 말하는 사람은 다름 아닌 사용자들입니다. **Forbes Health**가 2024년 **OnePoll**과 함께 미국의 데이팅 앱 이용자 **1,000**명을 대상으로 진행한 설문에서 **78%**가 앱을 통한 만남으로 정서적 소진을 겪었다고 답했습니다. 그리고 이런 앱에서 생기는 매칭 가운데 실제 만남으로 이어지는 것은 아주 일부에 지나지 않습니다." },
    { type: "p", text: "스와이프의 근본적인 문제는 사진 한 장과 몇 줄의 소개만으로 사람을 판단하게 만든다는 데 있습니다. 이런 방식은 사람을 \"상품 카탈로그\"처럼 늘어놓아 깊은 관계가 생길 여지를 막습니다. 결국 사용자는 \"스와이프 피로\"를 느끼고 앱을 떠나거나, 감정적으로 무뎌진 채 계속 사용하게 됩니다." },

    { type: "h2", text: "퀴즈 데이팅이라는 개념: 새로운 패러다임" },
    { type: "p", text: "퀴즈 데이팅은 매칭 과정을 처음부터 다시 정의하는 접근입니다. 출발점은 단순합니다. 누군가를 알고 싶다면 사진이 아니라 생각을 보라는 것입니다. 여기서는 각자가 자기 질문을 만들고, 매칭 후보가 그 질문을 풀기를 기다립니다. 정답이 곧 잘 맞는다는 신호입니다." },
    { type: "p", text: "질문이 관계를 만든다는 생각은 단순한 직감이 아닙니다. 2017년 **Journal of Personality and Social Psychology**에 실린 연구에서 Huang, Yeomans, Brooks, Minson, Gino는 스피드 데이팅 참가자 **110**명이 내린 **1,961**건의 두 번째 만남 결정을 분석했고, 후속 질문을 더 많이 한 사람일수록 다시 초대받을 가능성이 높다는 사실을 확인했습니다. 호기심은 측정 가능한 방식으로 매력적이며, 질문 기반 앱은 그 호기심을 과정의 맨 앞에 놓습니다." },

    { type: "h2", text: "왜 질문이 더 나은 매칭을 만들까요?" },

    { type: "h2", text: "1. 사고방식의 궁합" },
    { type: "p", text: "질문은 두 사람의 사고방식이 얼마나 맞물리는지를 드러냅니다. 같은 질문에 같은 답을 내놓는 두 사람은 세계관도, 가치관도, 삶의 취향도 비슷할 가능성이 큽니다. 겉모습의 끌림을 훌쩍 넘어서는 진짜 궁합의 신호입니다." },

    { type: "h2", text: "2. 능동적인 참여" },
    { type: "p", text: "스와이프는 수동적인 행동입니다. 사진에 반응할 뿐이죠. 반면 질문에 답하려면 능동적으로 참여해야 합니다. 그 참여는 더 큰 정신적 투자를 뜻하고, 매칭된 두 사람이 서로에게 더 연결되어 있다고 느끼게 만듭니다. 심리학에서는 이를 **투자 효과**라고 부릅니다." },

    { type: "h2", text: "3. 의미 있는 대화의 시작" },
    { type: "p", text: "스와이프 기반 앱의 가장 큰 골칫거리 중 하나가 \"뭐라고 써야 할지 모르겠는\" 순간입니다. 퀴즈 데이팅에서는 질문 자체가 자연스러운 실마리가 됩니다. \"그 질문에 대한 답이 정말 흥미로웠어요. 왜 그렇게 생각하세요?\" 같은 첫마디는 밋밋한 \"안녕하세요\"보다 훨씬 잘 통합니다." },

    { type: "h2", text: "4. 성격부터 보는 필터링" },
    { type: "p", text: "질문은 외모와 무관하게 성격의 궁합을 재기 때문에 시스템이 모두에게 더 공정해집니다. 스와이프 기반 앱에서는 소수의 프로필이 관심을 거의 독차지하지만, 퀴즈 데이팅에서는 모두가 같은 출발선에 섭니다. 판가름하는 것은 당신의 답이기 때문입니다." },

    { type: "h2", accent: "green", text: "성격 검사와 궁합의 과학" },
    { type: "p", text: "관계를 지탱하는 것들은 그리 신비롭지 않습니다. 공유하는 가치관, 서로 맞물리는 대화 방식, 갈등을 통과하는 힘, 같은 방향을 보는 삶의 목표, 그리고 양쪽 모두의 정서 지능입니다. 스와이프 기반 앱은 그중 어느 것도 재지 않습니다. 질문과 답으로 이루어진 방식은 그 여러 가지를 간접적으로 잡아냅니다. 사람이 내놓는 답이 곧 그 사람의 사고방식을 드러내기 때문입니다." },
    { type: "p", text: "\"주말 계획이 갑자기 틀어지면 어떻게 하세요?\" 같은 질문을 떠올려 보세요. 답 하나가 그 사람의 유연함, 갈등을 대하는 태도, 좋아하는 삶의 속도를 말해 줍니다. 이런 질문은 저녁 내내 이어지는 잡담으로도 닿지 못할 지점을 몇 초 만에 드러냅니다." },

    { type: "h2", text: "Qulo에서 질문 만드는 법" },
    { type: "p", text: "좋은 질문을 쓰는 것이 좋은 매칭의 핵심입니다. Qulo에서 질문을 만들 때 이런 점을 기억하세요." },
    { type: "ul", items: [
      "**주제를 골고루 흩뿌리세요:** 음악, 여행, 삶의 태도, 유머 — 서로 다른 영역의 질문이 궁합의 그림을 더 온전히 그려 줍니다",
      "**너무 쉽거나 너무 어려운 질문은 피하세요:** 누구나 맞히는 질문은 아무도 걸러 내지 못하고, 아무도 못 맞히는 질문은 매칭 가능성을 없앱니다",
      "**개인적인 결을 넣으세요:** \"내가 가장 좋아하는 도시는?\" 같은 질문은 답하는 사람이 당신을 실제로 얼마나 아는지 재 줍니다",
      "**주기적으로 갱신하세요:** 관심사가 달라지는 만큼 질문도 새로 고쳐 주세요",
      "**2~4개가 가장 알맞습니다:** 너무 적으면 걸러 내지 못하고, 너무 많으면 매칭 확률이 줄어듭니다(유료 플랜에서는 상한이 10개)",
    ] },

    { type: "quote", text: "옳은 질문을 던진다는 것은 옳은 사람을 찾는다는 뜻입니다. Qulo에서 매칭은 우연이 아니라 의식적인 발견입니다." },

    { type: "h2", text: "퀴즈 데이팅의 미래" },
    { type: "p", text: "데이팅 업계는 전환점에 서 있습니다. 사람들은 이제 표면적인 매칭 이상을 원하고, 퀴즈 데이팅은 바로 그 수요를 겨냥해 만들어진 방식입니다. 어려운 부분은 좋은 질문을 쓰는 일입니다. 그래서 Qulo에는 아이디어가 떠오르지 않을 때 둘러볼 수 있는 기성 질문 라이브러리가 있습니다. 미리 AI의 도움을 받아 만들어 둔 보관함이지, 그 자리에서 당신 대신 질문을 써 주는 모델이 아닙니다. 매칭의 근거가 되는 질문은 여전히 당신의 것입니다." },
    { type: "p", text: "질문과 상호작용에 기반한 매칭은 앞으로도 계속 퍼져 나갈 가능성이 큽니다. 대안이 이미 한계를 드러냈기 때문입니다. Qulo는 그 기준을 뒤늦게 베끼는 앱이 아니라, 기준을 세우는 앱이 되고자 합니다." },

    { type: "h2", accent: "green", text: "결론: 매칭의 미래는 질문에 있습니다" },
    { type: "p", text: "스와이프 모델은 데이팅에 진짜 혁신을 가져왔지만, 그 한계는 이제 뚜렷하게 보입니다. 퀴즈 데이팅은 더 깊고, 더 의미 있고, 더 오래가는 관계로 가는 길입니다. Qulo에서 첫 질문을 써 보고, 호기심에서 시작하는 매칭이 어떤 느낌인지 확인해 보세요." },
  ],

  zh: [
    { type: "h2", text: "传统交友软件的局限" },
    { type: "p", text: "过去十年里，交友软件从根本上改变了数百万人相识的方式。2010年代初在行业里蔓延开来的滑动机制很快成为主导模式，几乎所有主流应用都采用了同一套设计。可这套模式问题不小，而说出这一点的正是使用它的人：**Forbes Health** 于2024年联合 **OnePoll** 对美国 **1,000** 名交友软件用户所做的调查显示，**78%** 的人表示自己因线上交友而感到情绪耗竭。而这些应用促成的配对中，真正走到线下见面的只有一小部分。" },
    { type: "p", text: "滑动机制的根本问题在于，它逼着人凭一张照片和几行自我介绍去判断另一个人。这种做法把人像“商品目录”一样陈列出来，让深层的连接难以形成。久而久之，用户产生“滑动疲劳”，要么弃用应用，要么在情感上麻木地继续刷下去。" },

    { type: "h2", text: "问答式交友：一种新范式" },
    { type: "p", text: "问答式交友把配对流程整个重新定义。出发点很简单：想认识一个人，就去看他的想法，而不是他的照片。在这里，每个人写下自己的问题，等待可能的对象来解答，答对了才是合拍的信号。" },
    { type: "p", text: "问题能建立连接，这不只是直觉。在2017年发表于 **Journal of Personality and Social Psychology** 的一项研究中，Huang、Yeomans、Brooks、Minson 与 Gino 分析了 **110** 名快速约会参与者做出的 **1,961** 次“是否再见一面”的决定，发现追问越多的人越容易被再次邀约。好奇心的吸引力是可以被测量的，而以问题为核心的应用，把这份好奇放在了整个流程的最前面。" },

    { type: "h2", text: "为什么问题能带来更好的配对？" },

    { type: "h2", text: "1. 思维上的合拍" },
    { type: "p", text: "问题能显出两个人的思维方式有多契合。对同一个问题给出同样答案的两个人，多半在世界观、价值观和生活偏好上也相近。这是超越表层吸引力的真实合拍信号。" },

    { type: "h2", text: "2. 主动参与" },
    { type: "p", text: "滑动是被动的动作，你只是在对照片做反应。回答问题则要求主动参与。这份参与意味着更多的心力投入，也让配对成功的两个人彼此感觉更紧密。心理学把这称为 **投入效应**。" },

    { type: "h2", text: "3. 有内容的开场白" },
    { type: "p", text: "滑动式应用最头疼的问题之一，就是“不知道该写什么”的那一刻。在问答式交友里，问题本身就是天然的开场。像“你对那道题的答案真有意思，为什么这么想？”这样的开头，比干巴巴的一句“你好”管用得多。" },

    { type: "h2", text: "4. 先看性格的筛选" },
    { type: "p", text: "问题衡量的是性格上的合拍，与长相无关，这让整个系统对所有人都更公平。在滑动式应用里，少数资料占走了几乎全部注意力；在问答式交友里，所有人从同一条起跑线出发，因为决定权在你的答案。" },

    { type: "h2", accent: "green", text: "性格测试与合拍的科学" },
    { type: "p", text: "让一段关系撑下去的东西并不神秘：共同的价值观、彼此咬合的沟通方式、穿过冲突的能力、朝同一个方向的人生目标，以及双方都具备的情绪智力。滑动式应用一样也没测。问答式的机制却能间接抓住其中好几样，因为一个人给出的答案，会泄露他思考的方式。" },
    { type: "p", text: "想想“如果周末计划突然泡汤，你会怎么办？”这样一个问题。单单一个答案，就能说明这个人有多灵活、如何面对冲突、喜欢什么样的生活节奏。这类问题几秒钟就能触及闲聊一整晚也到不了的地方。" },

    { type: "h2", text: "在 Qulo 上出题指南" },
    { type: "p", text: "写出有效的问题，是获得优质配对的关键。在 Qulo 上出题时，请记住以下几点：" },
    { type: "ul", items: [
      "**话题要散开：**音乐、旅行、人生态度、幽默感 — 来自不同领域的问题能拼出更完整的合拍画像",
      "**别太简单也别太难：**人人都能猜中的题筛不掉任何人，谁也答不上的题则会断送你的配对机会",
      "**加入个人色彩：**像“我最喜欢的城市是哪座？”这样的问题，能衡量答题的人究竟有多了解你",
      "**定期更新：**让你的问题跟着兴趣的变化一起更新",
      "**2 到 4 道题最合适：**太少筛不出什么，太多则会拉低你的配对概率；付费方案的上限是 10 道",
    ] },

    { type: "quote", text: "问对问题，就是找对人。在 Qulo，配对不是巧合，而是一次有意识的发现。" },

    { type: "h2", text: "问答式交友的未来" },
    { type: "p", text: "交友行业正处在转折点上。人们想要的已不止是表层的配对，而问答式交友正是为这份需求而生。难的是写出好问题，所以 Qulo 备了一个现成的题库，灵感枯竭时可以翻一翻——那是事先借助人工智能整理好的存量，不是当场替你写题的模型。别人答对而与你配对的那道题，依然是你自己的。" },
    { type: "p", text: "以问题和互动为基础的配对方式很可能会继续扩散，因为另一条路早已显出了它的边界。Qulo 想做的是定标准的那个应用，而不是迟迟才去模仿的那个。" },

    { type: "h2", accent: "green", text: "结语：配对的未来在问题里" },
    { type: "p", text: "滑动模式确实给交友带来过真正的革新，但它的局限如今一目了然。问答式交友通向的是更深、更有意义、也更经得起时间的连接。在 Qulo 写下你的第一道问题，看看从好奇开始的配对是什么滋味。" },
  ],

  nl: [
    { type: "h2", text: "De beperkingen van traditionele datingapps" },
    { type: "p", text: "In het afgelopen decennium hebben datingapps ingrijpend veranderd hoe miljoenen mensen elkaar ontmoeten. De swipemechaniek die zich begin jaren tien door de sector verspreidde werd het dominante model, en vrijwel elke bekende app nam hetzelfde ontwerp over. Dat model kent serieuze problemen, en het zijn de gebruikers zelf die dat zeggen: in een onderzoek van **Forbes Health**, in 2024 samen met **OnePoll** uitgevoerd onder **1.000** datingappgebruikers in de Verenigde Staten, gaf **78%** aan emotioneel opgebrand te zijn geraakt van daten via apps. En slechts een klein deel van de matches die deze apps opleveren wordt ooit een echte date." },
    { type: "p", text: "Het fundamentele probleem van swipen is dat het je dwingt iemand te beoordelen op één foto en een paar regels tekst. Die aanpak zet mensen neer als een \"productcatalogus\" en verhindert dat er diepe verbindingen ontstaan. Uiteindelijk krijgen gebruikers last van \"swipemoeheid\" en laten ze de app links liggen of blijven ze hem emotioneel afgestompt gebruiken." },

    { type: "h2", text: "Het idee van quizdaten: een nieuw paradigma" },
    { type: "p", text: "Quizdaten definieert het matchingproces volledig opnieuw. Het uitgangspunt is simpel: wil je iemand leren kennen, kijk dan naar zijn gedachten en niet naar zijn foto's. Hier bedenkt iedereen zijn eigen vragen en wacht tot mogelijke matches ze oplossen. Goede antwoorden zijn het signaal dat het klikt." },
    { type: "p", text: "Dat vragen verbinding scheppen is meer dan intuïtie. In een studie die in 2017 verscheen in het **Journal of Personality and Social Psychology** analyseerden Huang, Yeomans, Brooks, Minson en Gino **1.961** beslissingen over een tweede date van **110** speeddaters, en zij vonden dat wie meer doorvragen stelde vaker opnieuw werd uitgenodigd. Nieuwsgierigheid is op een meetbare manier aantrekkelijk, en een app die op vragen draait zet die nieuwsgierigheid helemaal vooraan." },

    { type: "h2", text: "Waarom leveren vragen betere matches op?" },

    { type: "h2", text: "1. Cognitieve klik" },
    { type: "p", text: "Vragen laten zien hoe goed twee denkwijzen op elkaar aansluiten. Twee mensen die hetzelfde antwoord geven op dezelfde vraag delen hoogstwaarschijnlijk hun wereldbeeld, hun waarden en hun voorkeuren in het leven. Dat is een echte aanwijzing voor een klik, ver voorbij oppervlakkige aantrekkingskracht." },

    { type: "h2", text: "2. Actieve deelname" },
    { type: "p", text: "Swipen is een passieve handeling: je reageert alleen maar op foto's. Vragen beantwoorden vraagt actieve deelname. Die betrokkenheid betekent meer mentale investering en zorgt dat mensen die matchen zich sterker met elkaar verbonden voelen. In de psychologie heet dat het **investeringseffect**." },

    { type: "h2", text: "3. Gespreksopeningen die ergens over gaan" },
    { type: "p", text: "Een van de grootste problemen van swipe-apps is het moment van \"ik weet niet wat ik moet schrijven\". Bij quizdaten leveren de vragen zelf een natuurlijke opening. Een begin als \"Je antwoord op die vraag vond ik echt intrigerend — waarom denk je er zo over?\" werkt veel beter dan een kaal \"hoi\"." },

    { type: "h2", text: "4. Filteren op persoonlijkheid eerst" },
    { type: "p", text: "Vragen meten of persoonlijkheden bij elkaar passen, los van het uiterlijk, en dat maakt het systeem eerlijker voor iedereen. Op swipe-apps trekt een kleine minderheid van de profielen bijna alle aandacht naar zich toe; bij quizdaten begint iedereen met dezelfde kans, want wat telt zijn jouw antwoorden." },

    { type: "h2", accent: "green", text: "Persoonlijkheidstests en de wetenschap van de klik" },
    { type: "p", text: "Wat een relatie overeind houdt is geen groot raadsel: gedeelde waarden, communicatiestijlen die op elkaar passen, het vermogen om door een conflict heen te komen, levensdoelen die dezelfde kant op wijzen, en emotionele intelligentie aan beide kanten. Swipe-apps meten daar niets van. Systemen met vragen en antwoorden vangen er verschillende indirect op, want de antwoorden die iemand geeft verraden hoe diegene denkt." },
    { type: "p", text: "Neem een vraag als \"Wat zou je doen als je weekendplannen ineens in duigen vallen?\" Eén antwoord zegt al iets over iemands flexibiliteit, over hoe die met conflicten omgaat en over het levenstempo dat bij hem past. Zulke vragen brengen in seconden boven wat een hele avond koetjes en kalfjes niet bereikt." },

    { type: "h2", text: "Zo schrijf je vragen op Qulo" },
    { type: "p", text: "Goede vragen schrijven is de sleutel tot matches van kwaliteit. Hier is wat je op Qulo in gedachten houdt:" },
    { type: "ul", items: [
      "**Spreid je onderwerpen:** muziek, reizen, levensfilosofie, humor — vragen uit verschillende hoeken schetsen een vollediger beeld van de klik",
      "**Vermijd te makkelijk en te moeilijk:** wat iedereen raadt filtert niemand, en wat niemand kan weten maakt je matchkansen kapot",
      "**Voeg iets persoonlijks toe:** een vraag als \"Wat is mijn favoriete stad?\" meet hoe goed de ander je werkelijk kent",
      "**Ververs ze regelmatig:** werk je vragen bij zodat ze meebewegen met je interesses",
      "**2 tot 4 vragen is ideaal:** te weinig filtert onvoldoende, te veel verkleint je kans op een match — met een betaald abonnement ligt het plafond op 10",
    ] },

    { type: "quote", text: "De juiste vraag stellen betekent de juiste persoon vinden. Op Qulo is een match geen toeval — het is een bewuste ontdekking." },

    { type: "h2", text: "De toekomst van quizdaten" },
    { type: "p", text: "De datingsector staat op een kantelpunt. Mensen willen meer dan oppervlakkige matches, en quizdaten is precies voor die vraag gebouwd. Het lastige is het schrijven van goede vragen, dus houdt Qulo een bibliotheek met kant-en-klare vragen bij die je kunt doorbladeren als de inspiratie op is — een vooraf met behulp van AI opgestelde voorraad, geen model dat ter plekke vragen voor je schrijft. De vraag waarop iemand met je matcht, blijft je eigen vraag." },
    { type: "p", text: "Matching op basis van vragen en interactie zal zich waarschijnlijk verder verspreiden, want het alternatief heeft zijn grenzen allang laten zien. Qulo wil de app zijn die de standaard zet, niet die hem te laat nadoet." },

    { type: "h2", accent: "green", text: "Conclusie: de toekomst van matchen ligt in vragen" },
    { type: "p", text: "Het swipemodel bracht daten een echte vernieuwing, maar de grenzen ervan liggen inmiddels open en bloot. Quizdaten is de weg naar diepere, betekenisvollere en duurzamere verbindingen. Schrijf je eerste vraag op Qulo en ervaar hoe een match voelt die begint met nieuwsgierigheid." },
  ],

  pl: [
    { type: "h2", text: "Ograniczenia tradycyjnych aplikacji randkowych" },
    { type: "p", text: "W ostatniej dekadzie aplikacje randkowe całkowicie zmieniły sposób, w jaki poznają się miliony ludzi. Mechanika przesuwania, która rozeszła się po branży na początku lat dziesiątych, stała się modelem dominującym, a niemal każda znana aplikacja przyjęła to samo rozwiązanie. Ten model ma jednak poważne problemy i mówią o tym sami użytkownicy: w badaniu **Forbes Health** przeprowadzonym w 2024 roku wspólnie z **OnePoll** wśród **1000** użytkowników aplikacji randkowych w Stanach Zjednoczonych **78%** przyznało, że randkowanie przez aplikacje doprowadziło ich do wypalenia emocjonalnego. A tylko niewielka część dopasowań, które te aplikacje tworzą, kończy się prawdziwą randką." },
    { type: "p", text: "Podstawowy problem z przesuwaniem polega na tym, że każe oceniać człowieka po jednym zdjęciu i kilku linijkach opisu. Takie podejście ustawia ludzi jak \"katalog produktów\" i nie pozwala powstać głębszym więziom. Z czasem użytkownicy odczuwają \"zmęczenie przesuwaniem\" i albo porzucają aplikację, albo korzystają z niej dalej, emocjonalnie odklejeni." },

    { type: "h2", text: "Koncept randkowania przez pytania: nowy paradygmat" },
    { type: "p", text: "Randkowanie przez pytania definiuje proces dopasowania zupełnie od nowa. Punkt wyjścia jest prosty: jeśli chcesz kogoś poznać, patrz na jego myśli, a nie na jego zdjęcia. Każdy układa tu własne pytania i czeka, aż potencjalne dopasowania je rozwiążą. Poprawne odpowiedzi są sygnałem, że pasujecie do siebie." },
    { type: "p", text: "To, że pytania budują więź, nie jest wyłącznie intuicją. W badaniu opublikowanym w 2017 roku w **Journal of Personality and Social Psychology** Huang, Yeomans, Brooks, Minson i Gino przeanalizowali **1961** decyzji o drugiej randce podjętych przez **110** uczestników szybkich randek i stwierdzili, że ci, którzy zadawali więcej pytań pogłębiających, częściej byli zapraszani ponownie. Ciekawość jest atrakcyjna w sposób mierzalny, a aplikacja oparta na pytaniach stawia tę ciekawość na samym początku." },

    { type: "h2", text: "Dlaczego pytania dają lepsze dopasowania?" },

    { type: "h2", text: "1. Zgodność sposobu myślenia" },
    { type: "p", text: "Pytania pokazują, na ile dwa sposoby myślenia się schodzą. Dwie osoby, które na to samo pytanie odpowiadają tak samo, najprawdopodobniej mają zbliżony światopogląd, wartości i preferencje życiowe. To prawdziwy wskaźnik dopasowania, daleko poza powierzchowną atrakcyjnością." },

    { type: "h2", text: "2. Aktywny udział" },
    { type: "p", text: "Przesuwanie jest czynnością bierną: reagujesz jedynie na zdjęcia. Odpowiadanie na pytania wymaga aktywnego udziału. To zaangażowanie oznacza większą inwestycję myślową i sprawia, że dopasowane osoby czują się ze sobą bliżej związane. W psychologii nazywa się to **efektem zaangażowania**." },

    { type: "h2", text: "3. Sensowne początki rozmowy" },
    { type: "p", text: "Jednym z największych problemów aplikacji opartych na przesuwaniu jest moment \"nie wiem, co napisać\". Przy randkowaniu przez pytania to same pytania dają naturalny punkt zaczepienia. Otwarcie w rodzaju \"Twoja odpowiedź na to pytanie naprawdę mnie zaintrygowała — dlaczego tak uważasz?\" działa o wiele lepiej niż suche \"cześć\"." },

    { type: "h2", text: "4. Filtrowanie zaczynające się od osobowości" },
    { type: "p", text: "Pytania mierzą dopasowanie charakterów niezależnie od wyglądu, dzięki czemu system jest sprawiedliwszy dla wszystkich. W aplikacjach opartych na przesuwaniu niewielka mniejszość profili zbiera niemal całą uwagę; przy randkowaniu przez pytania wszyscy zaczynają z tą samą szansą, bo liczą się twoje odpowiedzi." },

    { type: "h2", accent: "green", text: "Testy osobowości i nauka o dopasowaniu" },
    { type: "p", text: "To, co utrzymuje związek, nie jest wielką tajemnicą: wspólne wartości, style komunikacji, które do siebie pasują, umiejętność przejścia przez konflikt, cele życiowe zwrócone w tę samą stronę i inteligencja emocjonalna po obu stronach. Aplikacje oparte na przesuwaniu nie mierzą żadnej z tych rzeczy. Systemy pytań i odpowiedzi wychwytują kilka z nich pośrednio, bo odpowiedzi człowieka zdradzają jego sposób myślenia." },
    { type: "p", text: "Weźmy pytanie w rodzaju \"Co byś zrobił, gdyby twoje plany na weekend nagle się rozsypały?\". Jedna odpowiedź mówi coś o elastyczności tej osoby, o jej podejściu do konfliktu i o tempie życia, które jej odpowiada. Takie pytania w kilka sekund wydobywają to, do czego cały wieczór rozmów o niczym by nie dotarł." },

    { type: "h2", text: "Jak układać pytania w Qulo" },
    { type: "p", text: "Dobre pytania to klucz do wartościowych dopasowań. Oto o czym warto pamiętać w Qulo:" },
    { type: "ul", items: [
      "**Rozrzuć tematy:** muzyka, podróże, filozofia życia, poczucie humoru — pytania z różnych obszarów dają pełniejszy obraz dopasowania",
      "**Unikaj zbyt łatwych i zbyt trudnych:** to, co każdy zgadnie, nikogo nie odsieje, a to, czego nikt nie wie, zabija twoje szanse na dopasowanie",
      "**Dodaj osobisty akcent:** pytanie w stylu \"Jakie jest moje ulubione miasto?\" mierzy, jak dobrze odpowiadający naprawdę cię zna",
      "**Odświeżaj je regularnie:** aktualizuj pytania, żeby nadążały za twoimi zainteresowaniami",
      "**Od 2 do 4 pytań jest optymalne:** za mało nie odsieje wystarczająco, za dużo obniży twoje prawdopodobieństwo dopasowania — w planie płatnym górna granica to 10",
    ] },

    { type: "quote", text: "Zadać właściwe pytanie to znaleźć właściwą osobę. W Qulo dopasowanie nie jest przypadkiem — jest świadomym odkryciem." },

    { type: "h2", text: "Przyszłość randkowania przez pytania" },
    { type: "p", text: "Branża randkowa jest w punkcie zwrotnym. Ludzie chcą czegoś więcej niż powierzchownych dopasowań, a randkowanie przez pytania powstało dokładnie pod tę potrzebę. Najtrudniejsze jest napisanie dobrych pytań, dlatego Qulo prowadzi bibliotekę gotowych pytań, którą można przejrzeć, gdy brakuje pomysłów — zapas przygotowany z wyprzedzeniem przy pomocy sztucznej inteligencji, a nie model piszący pytania za ciebie na bieżąco. Pytanie, na którym ktoś się z tobą dopasowuje, wciąż jest twoje." },
    { type: "p", text: "Dopasowywanie oparte na pytaniach i interakcji będzie się najpewniej rozprzestrzeniać dalej, bo alternatywa dawno pokazała swoje granice. Qulo chce być aplikacją, która wyznacza standard, a nie tą, która kopiuje go z opóźnieniem." },

    { type: "h2", accent: "green", text: "Wnioski: przyszłość dopasowania leży w pytaniach" },
    { type: "p", text: "Model oparty na przesuwaniu wniósł do randkowania prawdziwą nowość, ale jego granice widać już gołym okiem. Randkowanie przez pytania to droga do głębszych, bardziej znaczących i trwalszych więzi. Napisz swoje pierwsze pytanie w Qulo i przekonaj się, jak wygląda dopasowanie, które zaczyna się od ciekawości." },
  ],

  sv: [
    { type: "h2", text: "Begränsningarna hos traditionella dejtingappar" },
    { type: "p", text: "Under det senaste decenniet har dejtingappar i grunden förändrat hur miljontals människor möts. Swipemekaniken, som spred sig genom branschen i början av 2010-talet, blev den dominerande modellen och nästan alla kända appar tog efter samma upplägg. Modellen har allvarliga problem, och det är användarna själva som säger det: i en undersökning från **Forbes Health**, gjord 2024 tillsammans med **OnePoll** bland **1 000** dejtingappanvändare i USA, uppgav **78 %** att de blivit känslomässigt utbrända av att dejta via appar. Och bara en liten del av de matchningar apparna skapar blir någonsin en riktig dejt." },
    { type: "p", text: "Grundproblemet med swipandet är att det tvingar oss att bedöma en människa utifrån ett foto och några rader text. Upplägget ställer ut människor som en \"produktkatalog\" och hindrar djupa band från att uppstå. Med tiden drabbas användarna av \"swipetrötthet\" och lämnar antingen appen eller fortsätter använda den känslomässigt frånkopplade." },

    { type: "h2", text: "Idén med frågebaserad dejting: ett nytt paradigm" },
    { type: "p", text: "Frågebaserad dejting definierar om hela matchningsprocessen. Utgångspunkten är enkel: vill du lära känna någon ska du titta på personens tankar, inte på bilderna. Här skriver var och en sina egna frågor och väntar på att möjliga matchningar ska lösa dem. Rätt svar är signalen om att det klickar." },
    { type: "p", text: "Att frågor bygger kontakt är mer än en känsla. I en studie som publicerades 2017 i **Journal of Personality and Social Psychology** analyserade Huang, Yeomans, Brooks, Minson och Gino **1 961** beslut om en andra dejt fattade av **110** snabbdejtare, och fann att de som ställde fler följdfrågor oftare blev inbjudna igen. Nyfikenhet är attraktiv på ett mätbart sätt, och en app som bygger på frågor placerar den nyfikenheten allra först i processen." },

    { type: "h2", text: "Varför ger frågor bättre matchningar?" },

    { type: "h2", text: "1. Kognitiv samstämmighet" },
    { type: "p", text: "Frågor visar hur väl två sätt att tänka går ihop. Två personer som svarar likadant på samma fråga delar med stor sannolikhet världsbild, värderingar och livsval. Det är ett verkligt tecken på samstämmighet, långt bortom ytlig attraktion." },

    { type: "h2", text: "2. Aktivt deltagande" },
    { type: "p", text: "Att swipa är en passiv handling — man reagerar bara på foton. Att svara på frågor kräver aktivt deltagande. Det engagemanget innebär större mental investering och gör att de som matchar känner sig mer förbundna med varandra. Inom psykologin kallas det **investeringseffekten**." },

    { type: "h2", text: "3. Samtalsöppningar med innehåll" },
    { type: "p", text: "Ett av de största problemen med swipebaserade appar är ögonblicket \"jag vet inte vad jag ska skriva\". I frågebaserad dejting ger frågorna själva en naturlig ingång. En öppning som \"Ditt svar på den där frågan var verkligen intressant — varför tänker du så?\" fungerar långt bättre än ett tomt \"hej\"." },

    { type: "h2", text: "4. Filtrering som börjar i personligheten" },
    { type: "p", text: "Frågor mäter personlighetsmässig samstämmighet oberoende av utseende, vilket gör systemet rättvisare för alla. I swipebaserade appar drar en liten minoritet av profilerna åt sig nästan all uppmärksamhet; i frågebaserad dejting startar alla med samma chans, för det är dina svar som avgör." },

    { type: "h2", accent: "green", text: "Personlighetstester och vetenskapen om samstämmighet" },
    { type: "p", text: "Vad som håller ihop en relation är ingen större gåta: gemensamma värderingar, kommunikationsstilar som passar ihop, förmågan att ta sig igenom en konflikt, livsmål som pekar åt samma håll och känslomässig intelligens hos båda. Swipebaserade appar mäter ingenting av det. System med frågor och svar fångar flera av dem indirekt, eftersom en människas svar avslöjar hur hon tänker." },
    { type: "p", text: "Ta en fråga som \"Vad skulle du göra om helgplanerna plötsligt sprack?\". Ett enda svar säger något om personens flexibilitet, om hur hon hanterar en konflikt och om vilket livstempo hon trivs med. Sådana frågor plockar på sekunder fram det som en hel kväll av småprat inte når." },

    { type: "h2", text: "Guide till att skriva frågor på Qulo" },
    { type: "p", text: "Att skriva bra frågor är nyckeln till matchningar med kvalitet. Så här tänker du på Qulo:" },
    { type: "ul", items: [
      "**Sprid ut ämnena:** musik, resor, livsåskådning, humor — frågor från olika håll tecknar en mer komplett bild av samstämmigheten",
      "**Undvik för lätt och för svårt:** det alla kan gissa sållar ingen, och det ingen kan svara på tar död på dina matchchanser",
      "**Lägg in något personligt:** en fråga som \"Vilken är min favoritstad?\" mäter hur väl den som svarar faktiskt känner dig",
      "**Uppdatera dem regelbundet:** förnya frågorna så att de följer med när dina intressen ändras",
      "**2 till 4 frågor är lagom:** för få sållar inte tillräckligt, för många krymper sannolikheten för en matchning — med ett betalt abonnemang går taket upp till 10",
    ] },

    { type: "quote", text: "Att ställa rätt fråga är att hitta rätt person. På Qulo är en matchning ingen slump — den är en medveten upptäckt." },

    { type: "h2", text: "Framtiden för frågebaserad dejting" },
    { type: "p", text: "Dejtingbranschen står vid en vändpunkt. Människor vill ha mer än ytliga matchningar, och frågebaserad dejting är byggd just för det behovet. Det svåra är att skriva bra frågor, så Qulo har ett bibliotek med färdiga frågor att bläddra i när inspirationen tryter — ett förråd som skrivits i förväg med hjälp av AI, inte en modell som skriver frågor åt dig i stunden. Frågan som någon matchar med dig på är fortfarande din egen." },
    { type: "p", text: "Matchning som bygger på frågor och samspel lär fortsätta sprida sig, för alternativet har redan visat var dess gräns går. Qulo vill vara appen som sätter standarden, inte den som kopierar den för sent." },

    { type: "h2", accent: "green", text: "Slutsats: matchningens framtid ligger i frågorna" },
    { type: "p", text: "Swipemodellen förde med sig en verklig nyhet till dejtandet, men dess gränser syns numera tydligt. Frågebaserad dejting är vägen till djupare, mer meningsfulla och mer hållbara band. Skriv din första fråga på Qulo och märk hur en matchning känns när den börjar i nyfikenhet." },
  ],

  hi: [
    { type: "h2", text: "पारंपरिक डेटिंग ऐप्स की सीमाएँ" },
    { type: "p", text: "पिछले एक दशक में डेटिंग ऐप्स ने लाखों लोगों के मिलने-जुलने का तरीका जड़ से बदल दिया है। 2010 के दशक की शुरुआत में फैली स्वाइप की तरकीब जल्दी ही सबसे हावी मॉडल बन गई और लगभग हर बड़ी ऐप ने वही ढाँचा अपना लिया। लेकिन इस मॉडल में गंभीर दिक्कतें हैं, और यह बात खुद इस्तेमाल करने वाले कह रहे हैं: **Forbes Health** ने 2024 में **OnePoll** के साथ मिलकर अमेरिका के **1,000** डेटिंग ऐप उपयोगकर्ताओं पर जो सर्वेक्षण किया, उसमें **78%** ने बताया कि ऐप के ज़रिये डेटिंग से उन्हें भावनात्मक थकान हुई है। और इन ऐप्स पर बनने वाले मैचों में से केवल एक छोटा हिस्सा ही कभी असली मुलाक़ात तक पहुँचता है।" },
    { type: "p", text: "स्वाइप की बुनियादी समस्या यह है कि यह हमें एक तस्वीर और दो-चार पंक्तियों के परिचय पर किसी इंसान को आँकने पर मजबूर कर देती है। यह तरीका लोगों को \"उत्पादों की सूची\" की तरह सजा देता है और गहरे रिश्ते बनने ही नहीं देता। धीरे-धीरे उपयोगकर्ता \"स्वाइप थकान\" महसूस करते हैं और या तो ऐप छोड़ देते हैं या भावनात्मक रूप से कटे हुए इसे चलाते रहते हैं।" },

    { type: "h2", text: "क्विज़ डेटिंग की सोच: एक नया ढाँचा" },
    { type: "p", text: "क्विज़ डेटिंग मैच बनाने की पूरी प्रक्रिया को नए सिरे से गढ़ती है। शुरुआत का विचार सीधा है: किसी को जानना है तो उसकी तस्वीरें नहीं, उसके विचार देखिए। यहाँ हर कोई अपने सवाल बनाता है और इंतज़ार करता है कि संभावित साथी उन्हें हल करें। सही जवाब ही तालमेल का संकेत हैं।" },
    { type: "p", text: "सवाल रिश्ता बनाते हैं — यह महज़ अंदाज़ा नहीं है। **Journal of Personality and Social Psychology** में 2017 में छपे एक अध्ययन में Huang, Yeomans, Brooks, Minson और Gino ने स्पीड डेटिंग में शामिल **110** लोगों द्वारा लिए गए **1,961** \"दोबारा मिलें या नहीं\" फ़ैसलों का विश्लेषण किया और पाया कि जो लोग ज़्यादा गहराई वाले सवाल पूछते थे, उन्हें दोबारा बुलाए जाने की संभावना ज़्यादा थी। जिज्ञासा नापी जा सकने वाली तरह से आकर्षक है, और सवालों पर टिकी ऐप उसी जिज्ञासा को प्रक्रिया की सबसे पहली सीढ़ी बना देती है।" },

    { type: "h2", text: "सवाल बेहतर मैच क्यों बनाते हैं?" },

    { type: "h2", text: "1. सोच का तालमेल" },
    { type: "p", text: "सवाल दिखाते हैं कि दो लोगों की सोच कितनी मिलती है। एक ही सवाल का एक जैसा जवाब देने वाले दो लोगों का नज़रिया, मूल्य और जीवन की पसंद अक्सर मिलती-जुलती होती है। यह ऊपरी आकर्षण से कहीं आगे का, तालमेल का असली संकेत है।" },

    { type: "h2", text: "2. सक्रिय भागीदारी" },
    { type: "p", text: "स्वाइप करना निष्क्रिय काम है — आप बस तस्वीरों पर प्रतिक्रिया देते हैं। सवालों के जवाब देने के लिए सक्रिय भागीदारी चाहिए। यह भागीदारी ज़्यादा मानसिक निवेश माँगती है और मैच हुए लोगों को एक-दूसरे से ज़्यादा जुड़ा हुआ महसूस कराती है। मनोविज्ञान इसे **निवेश प्रभाव** कहता है।" },

    { type: "h2", text: "3. बातचीत की सार्थक शुरुआत" },
    { type: "p", text: "स्वाइप वाली ऐप्स की सबसे बड़ी उलझनों में एक है \"क्या लिखूँ, समझ नहीं आ रहा\" वाला पल। क्विज़ डेटिंग में सवाल खुद ही बातचीत का स्वाभाविक सिरा दे देते हैं। \"उस सवाल का तुम्हारा जवाब सच में दिलचस्प था — ऐसा क्यों लगता है तुम्हें?\" जैसी शुरुआत सूखे से \"नमस्ते\" से कहीं बेहतर चलती है।" },

    { type: "h2", text: "4. पहले व्यक्तित्व देखने वाली छँटाई" },
    { type: "p", text: "सवाल शक्ल-सूरत से बेपरवाह होकर व्यक्तित्व का तालमेल नापते हैं, जिससे पूरा सिस्टम सबके लिए ज़्यादा न्यायसंगत हो जाता है। स्वाइप वाली ऐप्स में प्रोफ़ाइलों का एक छोटा-सा हिस्सा लगभग सारा ध्यान बटोर लेता है; क्विज़ डेटिंग में सब एक ही जगह से शुरू करते हैं, क्योंकि यहाँ फ़ैसला आपके जवाब करते हैं।" },

    { type: "h2", accent: "green", text: "व्यक्तित्व परीक्षण और तालमेल का विज्ञान" },
    { type: "p", text: "रिश्ते को टिकाए रखने वाली चीज़ें कोई पहेली नहीं हैं: साझा मूल्य, आपस में बैठने वाले संवाद के तरीक़े, टकराव से गुज़र जाने की क्षमता, एक ही दिशा में देखते जीवन-लक्ष्य, और दोनों तरफ़ भावनात्मक समझ। स्वाइप वाली ऐप्स इनमें से कुछ भी नहीं नापतीं। सवाल-जवाब वाली व्यवस्था इनमें से कई को अप्रत्यक्ष रूप से पकड़ लेती है, क्योंकि किसी के जवाब उसकी सोचने की शैली खोल देते हैं।" },
    { type: "p", text: "\"अगर वीकेंड का प्लान अचानक बिगड़ जाए तो क्या करोगे?\" जैसा एक सवाल लीजिए। अकेला एक जवाब उस इंसान के लचीलेपन, टकराव से निपटने के अंदाज़ और पसंदीदा जीवन-रफ़्तार के बारे में बहुत कुछ कह देता है। ऐसे सवाल कुछ सेकंड में वहाँ पहुँच जाते हैं जहाँ पूरी शाम की हल्की-फुल्की बातचीत भी नहीं पहुँचती।" },

    { type: "h2", text: "Qulo पर सवाल बनाने की गाइड" },
    { type: "p", text: "अच्छे सवाल लिखना ही बढ़िया मैच की कुंजी है। Qulo पर सवाल बनाते समय इन बातों का ध्यान रखें:" },
    { type: "ul", items: [
      "**विषय बिखेरें:** संगीत, यात्रा, जीवन-दर्शन, हास्य — अलग-अलग क्षेत्रों के सवाल तालमेल की ज़्यादा पूरी तस्वीर बनाते हैं",
      "**बहुत आसान या बहुत कठिन से बचें:** जो सबको पता हो वह किसी को नहीं छाँटता, और जो किसी को न पता हो वह मैच की गुंजाइश ही ख़त्म कर देता है",
      "**निजी रंग जोड़ें:** \"मेरा पसंदीदा शहर कौन-सा है?\" जैसा सवाल नापता है कि जवाब देने वाला आपको सचमुच कितना जानता है",
      "**नियमित रूप से बदलें:** अपनी दिलचस्पियाँ बदलने के साथ सवालों को भी ताज़ा करते रहें",
      "**2 से 4 सवाल सबसे उपयुक्त हैं:** बहुत कम सवाल ठीक से नहीं छाँटते, बहुत ज़्यादा मैच की संभावना घटा देते हैं — भुगतान वाली योजना में यह सीमा 10 तक जाती है",
    ] },

    { type: "quote", text: "सही सवाल पूछना यानी सही इंसान तक पहुँचना। Qulo पर मैच होना इत्तेफ़ाक़ नहीं — यह एक सचेत खोज है।" },

    { type: "h2", text: "क्विज़ डेटिंग का भविष्य" },
    { type: "p", text: "डेटिंग की दुनिया एक मोड़ पर खड़ी है। लोग अब सतही मैच से आगे कुछ चाहते हैं, और क्विज़ डेटिंग ठीक इसी माँग के लिए बनी है। मुश्किल हिस्सा अच्छे सवाल लिखना है, इसलिए Qulo में पहले से तैयार सवालों की एक लाइब्रेरी रहती है, जिसे विचार न सूझने पर आप देख सकते हैं — यह पहले से एआई की मदद से तैयार किया गया संग्रह है, कोई ऐसा मॉडल नहीं जो उसी वक़्त आपके लिए सवाल लिख दे। जिस सवाल पर कोई आपसे मैच करता है, वह अब भी आपका ही होता है।" },
    { type: "p", text: "सवालों और आपसी सहभागिता पर टिका मैच बनाना आगे भी फैलता रहेगा, क्योंकि दूसरा रास्ता अपनी सीमा कब की दिखा चुका है। Qulo चाहता है कि वह मानक तय करने वाली ऐप बने, देर से उसकी नक़ल करने वाली नहीं।" },

    { type: "h2", accent: "green", text: "निष्कर्ष: मैच का भविष्य सवालों में है" },
    { type: "p", text: "स्वाइप वाले मॉडल ने डेटिंग को एक सच्ची नई चीज़ दी थी, मगर उसकी सीमाएँ अब साफ़ दिख रही हैं। क्विज़ डेटिंग गहरे, ज़्यादा अर्थपूर्ण और ज़्यादा टिकाऊ रिश्तों तक जाने का रास्ता है। Qulo पर अपना पहला सवाल लिखिए और देखिए कि जिज्ञासा से शुरू होने वाला मैच कैसा लगता है।" },
  ],
};
