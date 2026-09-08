import type { LocalizedGlossaryEntry } from "@/lib/constants/glossary";

/**
 * Limerence — involuntary, obsessive longing for one specific person, usually
 * without reciprocation.
 *
 * Source ground: `docs/marketing/seo-blog-pipeline/KAYNAK-limerence.md`, where
 * every claim below is tagged primary / secondary / unverified. Judgement calls
 * a later editor should not undo by accident:
 *
 * - THE PAGE'S SPINE IS THE CONTRADICTION. Two definitions of this word are in
 *   circulation and they disagree: the APA dictionary calls it a phase INSIDE a
 *   formed relationship that fades "a month or two" in, while peer-reviewed work
 *   since 2021 studies it as UNRECIPROCATED longing lasting years.
 *   Merriam-Webster carries both as separate senses, so the conflict is real and
 *   on the record. Most competing pages pick one silently. Do not "simplify" this
 *   section away — it is the only thing here nobody else is saying.
 *
 * - NO DURATION CLAIM. The figure all over the internet ("18 months to 3 years")
 *   traces to no primary source; the reachable sources actively disagree
 *   (weeks-to-years / a month or two / ~2 years / six months-to-years). The page
 *   gives the 2026 measurement with its sample attached, and nothing else.
 *
 * - NO PREVALENCE FIGURE, EVER. There is no prevalence study; the 2021 case
 *   report says "unknown prevalence" in as many words. The 42% comorbidity number
 *   is a rate WITHIN limerent samples, not a share of people — writing "42% of
 *   people" would be a fabrication.
 *
 * - NO NEUROSCIENCE. Every "dopamine / reward circuit / serotonin" claim traces
 *   to studies that measured ROMANTIC LOVE, not limerence. There is not one
 *   neuroimaging study of limerence in PubMed. Do not add the brain paragraph
 *   that every other page has.
 *
 * - NO DIAGNOSIS, IN EITHER DIRECTION. Absent from ICD-11 (queried directly, with
 *   a positive control) and not a formal DSM diagnosis. But "not classified" is
 *   not "not real", and the page says both, separately. Anyone describing months
 *   of impairment is pointed to a professional — that is the only closing line
 *   this page is entitled to.
 *
 * - THE QULO ANGLE IS MECHANICAL ONLY. Limerence feeds on uncertainty about
 *   reciprocation, and answering someone's questions turns that into a tested
 *   outcome rather than a guessed one. That connection is honest. Claiming the
 *   app prevents, reduces or treats limerence would be a clinical claim with zero
 *   evidence behind it — never write it.
 *
 * - TERM NAMES. Latin-script locales keep "Limerence"; the word is a coinage with
 *   no roots, so there is nothing to translate. `ru` Лимеренция, `ja` リメランス,
 *   `ko` 리머런스, `ar` الليمرنس, `hi` लिमरेंस. `zh` keeps the English word because
 *   the available Chinese renderings (迷恋综合征 and similar) smuggle in "syndrome"
 *   and imply a diagnosis the page explicitly denies.
 */
export const limerence: LocalizedGlossaryEntry = {
  en: {
    term: "Limerence",
    summary:
      "An involuntary, persistent state of obsessive longing for one specific person — usually someone who has not returned the feeling — marked by intrusive thoughts and a constant reading of signals for proof of interest.",
    blocks: [
      { type: "h2", text: "Two definitions, one word" },
      { type: "p", text: "Look this word up twice and you get two different answers. The APA's psychology dictionary describes it as intense desire and preoccupation with a partner **inside a relationship**, something that typically fades a month or two after the relationship forms. Peer-reviewed work since 2021 studies something else entirely: an involuntary, chronic longing for someone who has **not** returned it, lasting years rather than weeks." },
      { type: "p", text: "Merriam-Webster records both senses separately, so this is not a mix-up you can resolve by picking the better source — the word genuinely carries two meanings. Which one is meant matters enormously. One describes the ordinary intoxication of a new relationship. The other describes something that can take over a life, and that is the sense almost everyone means when they search for the word today." },
      { type: "h2", text: "Where the word came from" },
      { type: "p", text: "It was coined by the American psychologist Dorothy Tennov, who built the concept from more than 300 interviews about what it feels like to be in love and set it out in her 1979 book *Love and Limerence*. The word has no etymology on purpose — Tennov invented it from nothing, saying it had “no roots whatsoever”. It appeared in print at least as early as 1975, so despite feeling like a recent arrival it is roughly fifty years old." },
      { type: "h2", text: "How it differs from a crush" },
      { type: "ul", items: [
        "**It is not chosen.** People describe it as happening to them, sometimes about someone they do not even find suitable.",
        "**It does not pass on its own.** A crush comes and goes; this settles in and starts feeding on doubt.",
        "**Uncertainty makes it stronger, not weaker.** A clear no can be easier than an ambiguous maybe.",
        "**Attention narrows to one person.** Not a type, not a category — one specific individual, whom the research literature calls the limerent object.",
      ] },
      { type: "h2", text: "What is actually known — which is not much" },
      { type: "p", text: "The word does not appear in ICD-11, the WHO's classification of diseases, and it is not a formal diagnosis in the DSM either; the researchers studying it say so plainly, and a 2026 paper still lists the need for diagnostic criteria as an open problem. The first validated questionnaire for measuring it was only published in 2025. Popularly the term is everywhere; scientifically this is a small, young field." },
      { type: "p", text: "The largest study so far, published in *Acta Psychologica* in 2026, surveyed 1,647 people who reported experiencing limerence. Within that group an episode involved roughly two years of preoccupation with one person, and in a seven-day sampling of everyday thoughts, thinking about that person filled about half of participants' waking thought. Those figures describe people who already identify as limerent — they are not rates for the general population, and nobody has measured how common this is." },
      { type: "p", text: "You will also find confident claims online that limerence lasts eighteen months to three years, or that it runs on dopamine. Neither survives checking. The duration figure traces to no original source and the reachable ones contradict each other; the brain claims come from studies that measured romantic love, not limerence, and there is not a single neuroimaging study of it." },
      { type: "h2", accent: "green", text: "If you recognised yourself" },
      { type: "p", text: "Not being in a diagnostic manual does not make the experience less real. What people describe — thoughts they cannot put down, hours lost to re-reading old messages, a mood that rises and falls on whether someone replied — is a genuine and heavy thing, and treating it as a joke about being obsessed misses what it costs. If it has gone on for months, or it is interfering with work, sleep or the people around you, this is worth taking to a mental health professional. That is a real referral, not a polite way to end the page." },
      { type: "p", text: "One thing worth noticing: limerence runs on not knowing. As long as reciprocation stays an open question, there is always another signal to interpret, and the mind fills the silence with a version of the person rather than the person. Qulo will not change how anyone feels, and nothing here treats anything — but its mechanic does remove the guessing from one specific question. You answer what someone actually asked, and either you got it right or you did not. Interest is tested rather than deciphered." },
    ],
  },
  tr: {
    term: "Limerans",
    summary:
      "Belirli bir kişiye duyulan, çoğunlukla karşılık görmeyen, iradedışı ve süregen takıntılı özlem hâli; zihne girip çıkmayan düşünceler ve karşı taraftan ilgi kanıtı arayan sürekli bir işaret okumasıyla seyreder.",
    blocks: [
      { type: "h2", text: "Tek kelime, iki tanım" },
      { type: "p", text: "Bu kelimeye iki yerde bakarsanız iki farklı cevap alırsınız. APA'nın psikoloji sözlüğü, **kurulmuş bir ilişkinin içindeki** yoğun arzu ve meşguliyeti tarif ediyor; ilişki kurulduktan bir iki ay sonra sönen bir evre. 2021 sonrası hakemli araştırma ise bambaşka bir şeyi inceliyor: karşılık **görmeyen** birine duyulan, iradedışı, haftalarla değil yıllarla ölçülen süregen bir özlem." },
      { type: "p", text: "Merriam-Webster iki anlamı ayrı ayrı kaydediyor, yani bu “doğru kaynağı seçerek” çözülecek bir karışıklık değil — kelime gerçekten iki anlam taşıyor. Hangisinin kastedildiği de çok şey değiştiriyor. Biri yeni bir ilişkinin sıradan sarhoşluğunu anlatıyor. Diğeri bir hayatı devralabilecek bir şeyi anlatıyor ve bugün bu kelimeyi arayan hemen herkes ikincisini kastediyor." },
      { type: "h2", text: "Kelime nereden geliyor" },
      { type: "p", text: "Terimi ABD'li psikolog Dorothy Tennov uydurdu; kavramı âşık olmanın nasıl bir his olduğuna dair 300'den fazla görüşme üzerine kurdu ve 1979'da *Love and Limerence* kitabıyla ortaya koydu. Kelimenin bilinçli olarak hiçbir kökü yok — Tennov onu sıfırdan üretti ve “hiçbir kökü yok” dedi. Basında en az 1975'ten beri görünüyor; yani yeni bir şey gibi dursa da yaklaşık elli yaşında." },
      { type: "h2", text: "Geçici bir tutkunluktan farkı" },
      { type: "ul", items: [
        "**Seçilerek yaşanmıyor.** İnsanlar bunun başlarına geldiğini anlatıyor; bazen uygun bile bulmadıkları biri için.",
        "**Kendiliğinden geçmiyor.** Geçici tutkunluk gelir gider; bu yerleşir ve şüpheyle beslenmeye başlar.",
        "**Belirsizlik onu zayıflatmaz, güçlendirir.** Net bir hayır, muğlak bir belkiden daha kolay gelebilir.",
        "**Dikkat tek kişiye daralır.** Bir tip ya da kategori değil, tek bir kişi — araştırma literatürünün “limerent object” dediği kişi.",
      ] },
      { type: "h2", text: "Gerçekte ne biliniyor — pek az şey" },
      { type: "p", text: "Kelime, Dünya Sağlık Örgütü'nün hastalık sınıflandırması ICD-11'de geçmiyor; DSM'de de resmî bir tanı değil. Konuyu çalışan araştırmacılar bunu açıkça yazıyor ve 2026 tarihli bir makale hâlâ tanı ölçütü ihtiyacını açık bir sorun olarak sıralıyor. Ölçmek için doğrulanmış ilk anket ancak 2025'te yayımlandı. Popüler kullanımda terim her yerde; bilimsel olarak burası küçük ve genç bir alan." },
      { type: "p", text: "Bugüne kadarki en büyük çalışma 2026'da *Acta Psychologica*'da yayımlandı ve limerans yaşadığını bildiren 1.647 kişiyle yapıldı. Bu grup içinde bir dönem, tek bir kişiye yönelik yaklaşık iki yıllık bir zihinsel meşguliyet içeriyordu; gündelik düşüncelerin yedi gün boyunca örneklendiği bölümde ise o kişiyi düşünmek, katılımcıların uyanık düşüncesinin yarısı kadarını kaplıyordu. Bu sayılar kendini zaten limerans yaşayan olarak tanımlayan insanları anlatıyor — genel nüfusun oranları değil ve bunun ne kadar yaygın olduğunu kimse ölçmedi." },
      { type: "p", text: "İnternette limeransın on sekiz ay ile üç yıl arasında sürdüğüne ya da dopaminle işlediğine dair kendinden emin cümleler de bulacaksınız. İkisi de kontrolü kaldırmıyor. Süre rakamı hiçbir özgün kaynağa oturmuyor ve ulaşılabilen kaynaklar birbiriyle çelişiyor; beyin iddialarıysa limeransı değil romantik aşkı ölçen çalışmalardan geliyor — limerans üzerine tek bir beyin görüntüleme çalışması yok." },
      { type: "h2", accent: "green", text: "Kendinizi burada tanıdıysanız" },
      { type: "p", text: "Bir tanı kitabında yer almaması, yaşananı daha az gerçek yapmıyor. İnsanların anlattığı şey — bırakılamayan düşünceler, eski mesajları yeniden okuyarak geçen saatler, birinin cevap yazıp yazmamasına göre inip çıkan bir ruh hâli — hakiki ve ağır bir şey; bunu “takmışsın işte” diye geçiştirmek neye mal olduğunu görmemek olur. Aylardır sürüyorsa ya da işinizi, uykunuzu, çevrenizdeki insanları etkiliyorsa, bunu bir ruh sağlığı uzmanına götürmeye değer. Bu gerçek bir yönlendirme, sayfayı kibarca bitirme cümlesi değil." },
      { type: "p", text: "Fark etmeye değer bir nokta: limerans bilmemekle besleniyor. Karşılık açık bir soru olarak durduğu sürece yorumlanacak yeni bir işaret hep bulunur ve zihin sessizliği kişinin kendisiyle değil, ondan kurduğu bir versiyonla doldurur. Qulo kimsenin ne hissettiğini değiştirmez ve burada hiçbir şey tedavi edilmiyor — ama mekaniği tek bir sorudaki tahmini ortadan kaldırıyor. Karşı tarafın gerçekten sorduğu şeyi cevaplıyorsunuz; ya bildiniz ya bilemediniz. İlgi çözülmeye çalışılmıyor, sınanıyor." },
    ],
  },
  de: {
    term: "Limerence",
    summary:
      "Ein unwillkürlicher, anhaltender Zustand obsessiver Sehnsucht nach einem ganz bestimmten Menschen — meist nach jemandem, der das Gefühl nicht erwidert hat — geprägt von aufdringlichen Gedanken und dem ständigen Deuten von Signalen auf der Suche nach einem Beweis für Interesse.",
    blocks: [
      { type: "h2", text: "Ein Wort, zwei Definitionen" },
      { type: "p", text: "Schlägt man dieses Wort an zwei Stellen nach, bekommt man zwei verschiedene Antworten. Das psychologische Wörterbuch der APA beschreibt intensives Verlangen und Vereinnahmung durch einen Partner **innerhalb einer bestehenden Beziehung** — eine Phase, die ein, zwei Monate nach dem Beginn der Beziehung wieder abklingt. Die begutachtete Forschung seit 2021 untersucht etwas völlig anderes: eine unwillkürliche, chronische Sehnsucht nach jemandem, der sie **nicht** erwidert hat, und die eher Jahre als Wochen dauert." },
      { type: "p", text: "Merriam-Webster führt beide Bedeutungen getrennt auf; es handelt sich also nicht um eine Verwechslung, die man durch die Wahl der besseren Quelle auflösen könnte — das Wort trägt tatsächlich zwei Bedeutungen. Und es macht einen enormen Unterschied, welche gemeint ist. Die eine beschreibt den ganz gewöhnlichen Rausch einer frischen Beziehung. Die andere beschreibt etwas, das ein ganzes Leben übernehmen kann, und genau das meinen heute fast alle, die nach diesem Wort suchen." },
      { type: "h2", text: "Woher das Wort kommt" },
      { type: "p", text: "Geprägt hat es die US-amerikanische Psychologin Dorothy Tennov, die das Konzept aus mehr als 300 Interviews darüber entwickelte, wie es sich anfühlt, verliebt zu sein, und es 1979 in ihrem Buch *Love and Limerence* darlegte. Das Wort hat mit Absicht keine Etymologie — Tennov erfand es aus dem Nichts und sagte, es habe „überhaupt keine Wurzeln“. Gedruckt taucht es mindestens seit 1975 auf; es wirkt also neu, ist aber rund fünfzig Jahre alt." },
      { type: "h2", text: "Wodurch es sich von einer Schwärmerei unterscheidet" },
      { type: "ul", items: [
        "**Man sucht es sich nicht aus.** Betroffene beschreiben, dass es ihnen zustößt — manchmal wegen jemandem, den sie nicht einmal passend finden.",
        "**Es vergeht nicht von allein.** Eine Schwärmerei kommt und geht; dies setzt sich fest und beginnt, sich vom Zweifel zu nähren.",
        "**Ungewissheit macht es stärker, nicht schwächer.** Ein klares Nein kann leichter sein als ein vages Vielleicht.",
        "**Die Aufmerksamkeit verengt sich auf eine Person.** Kein Typ, keine Kategorie — ein bestimmter Mensch, den die Forschungsliteratur „limerent object“ nennt.",
      ] },
      { type: "h2", text: "Was tatsächlich bekannt ist — und das ist wenig" },
      { type: "p", text: "Das Wort kommt in der ICD-11, der Krankheitsklassifikation der WHO, nicht vor, und auch im DSM ist es keine formale Diagnose; die Forschenden, die dazu arbeiten, schreiben das ausdrücklich, und eine Arbeit von 2026 führt den Bedarf an diagnostischen Kriterien noch immer als offenes Problem. Der erste validierte Fragebogen zur Messung erschien erst 2025. Populär ist der Begriff überall; wissenschaftlich ist das hier ein kleines, junges Feld." },
      { type: "p", text: "Die bislang größte Studie, 2026 in *Acta Psychologica* erschienen, befragte 1.647 Menschen, die angaben, Limerence zu erleben. Innerhalb dieser Gruppe umfasste eine Episode rund zwei Jahre der Vereinnahmung durch eine einzige Person, und in einer siebentägigen Stichprobe des Alltagsdenkens füllten die Gedanken an diese Person etwa die Hälfte der wachen Gedanken der Teilnehmenden. Diese Zahlen beschreiben Menschen, die sich ohnehin als limerent verstehen — es sind keine Werte für die Allgemeinbevölkerung, und wie verbreitet das Ganze ist, hat niemand gemessen." },
      { type: "p", text: "Sie werden im Netz auch selbstbewusste Behauptungen finden, Limerence dauere achtzehn Monate bis drei Jahre oder laufe über Dopamin. Beides hält der Prüfung nicht stand. Die Zeitangabe lässt sich auf keine Originalquelle zurückführen, und die erreichbaren Quellen widersprechen einander; die Hirn-Behauptungen stammen aus Studien, die romantische Liebe gemessen haben, nicht Limerence — eine einzige Bildgebungsstudie dazu gibt es nicht." },
      { type: "h2", accent: "green", text: "Wenn Sie sich darin wiedererkannt haben" },
      { type: "p", text: "Nicht in einem Diagnosehandbuch zu stehen macht das Erlebte nicht weniger real. Was Menschen beschreiben — Gedanken, die sich nicht ablegen lassen, Stunden, die im Wiederlesen alter Nachrichten verschwinden, eine Stimmung, die daran hängt, ob jemand geantwortet hat — ist etwas Echtes und Schweres, und es als Witz über Besessenheit abzutun übersieht, was es kostet. Wenn es seit Monaten anhält oder Arbeit, Schlaf oder die Menschen um Sie herum beeinträchtigt, lohnt es sich, damit zu einer Fachperson für psychische Gesundheit zu gehen. Das ist eine ernst gemeinte Empfehlung und keine höfliche Art, die Seite zu beenden." },
      { type: "p", text: "Eine Sache ist bemerkenswert: Limerence lebt vom Nichtwissen. Solange die Erwiderung eine offene Frage bleibt, gibt es immer ein weiteres Signal zu deuten, und der Kopf füllt das Schweigen mit einer Version des Menschen statt mit dem Menschen selbst. Qulo ändert nichts daran, wie jemand fühlt, und hier wird nichts behandelt — aber die Mechanik nimmt aus einer ganz bestimmten Frage das Raten heraus. Sie beantworten das, was jemand tatsächlich gefragt hat, und entweder lagen Sie richtig oder nicht. Interesse wird nicht entziffert, sondern geprüft." },
    ],
  },
  fr: {
    term: "Limerence",
    summary:
      "État involontaire et persistant de désir obsessionnel pour une personne en particulier — le plus souvent quelqu’un qui n’a pas répondu au sentiment — fait de pensées intrusives et d’une lecture permanente des signaux à la recherche d’une preuve d’intérêt.",
    blocks: [
      { type: "h2", text: "Un mot, deux définitions" },
      { type: "p", text: "Cherchez ce mot à deux endroits et vous obtiendrez deux réponses différentes. Le dictionnaire de psychologie de l’APA décrit un désir intense et une préoccupation envers un partenaire **à l’intérieur d’une relation**, une phase qui s’estompe généralement un ou deux mois après la formation du couple. La recherche évaluée par les pairs depuis 2021 étudie tout autre chose : un manque involontaire et chronique envers quelqu’un qui ne l’a **pas** rendu, et qui dure des années plutôt que des semaines." },
      { type: "p", text: "Merriam-Webster enregistre les deux sens séparément : ce n’est donc pas une confusion que l’on résout en choisissant la meilleure source — le mot porte réellement deux significations. Et savoir laquelle est visée change tout. L’une décrit l’ivresse ordinaire d’une relation qui commence. L’autre décrit quelque chose qui peut prendre toute la place dans une vie, et c’est ce sens-là que vise presque tout le monde aujourd’hui en cherchant ce mot." },
      { type: "h2", text: "D’où vient le mot" },
      { type: "p", text: "Il a été forgé par la psychologue américaine Dorothy Tennov, qui a bâti le concept à partir de plus de 300 entretiens sur ce que l’on ressent quand on est amoureux et l’a exposé en 1979 dans son livre *Love and Limerence*. Le mot n’a délibérément aucune étymologie — Tennov l’a inventé de toutes pièces, en disant qu’il n’avait « aucune racine, absolument aucune ». On le trouve imprimé au moins depuis 1975 : malgré son air de nouveauté, il a une cinquantaine d’années." },
      { type: "h2", text: "En quoi cela diffère d’un béguin" },
      { type: "ul", items: [
        "**Cela ne se choisit pas.** Les personnes concernées disent que cela leur arrive, parfois pour quelqu’un qu’elles ne trouvent même pas fait pour elles.",
        "**Cela ne passe pas tout seul.** Un béguin va et vient ; ceci s’installe et se met à se nourrir du doute.",
        "**L’incertitude le renforce au lieu de l’affaiblir.** Un non net peut être plus facile qu’un peut-être flou.",
        "**L’attention se resserre sur une seule personne.** Pas un type, pas une catégorie — un individu précis, que la littérature de recherche appelle « limerent object ».",
      ] },
      { type: "h2", text: "Ce que l’on sait vraiment, c’est-à-dire peu de chose" },
      { type: "p", text: "Le mot ne figure pas dans la CIM-11, la classification des maladies de l’OMS, et ce n’est pas non plus un diagnostic formel dans le DSM ; les chercheurs qui travaillent dessus le disent sans détour, et un article de 2026 range encore le besoin de critères diagnostiques parmi les questions ouvertes. Le premier questionnaire validé pour le mesurer n’a été publié qu’en 2025. Dans l’usage courant le terme est partout ; scientifiquement, c’est un champ petit et jeune." },
      { type: "p", text: "L’étude la plus vaste à ce jour, publiée en 2026 dans *Acta Psychologica*, a interrogé 1 647 personnes déclarant vivre de la limerence. Au sein de ce groupe, un épisode comportait environ deux ans de préoccupation pour une seule personne et, lors d’un échantillonnage des pensées quotidiennes sur sept jours, penser à cette personne occupait à peu près la moitié de la pensée éveillée des participants. Ces chiffres décrivent des gens qui se reconnaissent déjà comme limerents : ce ne sont pas des taux pour la population générale, et personne n’a mesuré la fréquence du phénomène." },
      { type: "p", text: "Vous trouverez aussi en ligne des affirmations assurées : la limerence durerait de dix-huit mois à trois ans, ou fonctionnerait à la dopamine. Ni l’une ni l’autre ne résiste à la vérification. Le chiffre de durée ne remonte à aucune source originale et les sources accessibles se contredisent ; les affirmations sur le cerveau viennent d’études qui ont mesuré l’amour romantique, pas la limerence, et il n’existe pas une seule étude d’imagerie cérébrale à son sujet." },
      { type: "h2", accent: "green", text: "Si vous vous êtes reconnu" },
      { type: "p", text: "Ne pas figurer dans un manuel diagnostique ne rend pas l’expérience moins réelle. Ce que les gens décrivent — des pensées impossibles à poser, des heures perdues à relire d’anciens messages, une humeur qui monte et descend selon qu’une réponse est arrivée ou non — est quelque chose de véritable et de lourd, et en faire une plaisanterie sur l’obsession, c’est passer à côté de ce que cela coûte. Si cela dure depuis des mois, ou si cela empiète sur le travail, le sommeil ou vos proches, cela vaut la peine d’en parler à un professionnel de santé mentale. C’est une vraie orientation, pas une façon polie de conclure la page." },
      { type: "p", text: "Une chose mérite d’être remarquée : la limerence se nourrit de ne pas savoir. Tant que la réciprocité reste une question ouverte, il y a toujours un signal de plus à interpréter, et l’esprit remplit le silence avec une version de la personne plutôt qu’avec la personne. Qulo ne changera pas ce que quelqu’un ressent, et rien ici ne soigne quoi que ce soit — mais son mécanisme retire les suppositions d’une question bien précise. Vous répondez à ce que quelqu’un a réellement demandé, et soit vous avez trouvé, soit non. L’intérêt n’est pas déchiffré, il est mis à l’épreuve." },
    ],
  },
  es: {
    term: "Limerence",
    summary:
      "Estado involuntario y persistente de anhelo obsesivo por una persona concreta —normalmente alguien que no ha correspondido al sentimiento— marcado por pensamientos intrusivos y una lectura constante de señales en busca de pruebas de interés.",
    blocks: [
      { type: "h2", text: "Una palabra, dos definiciones" },
      { type: "p", text: "Busca esta palabra en dos sitios y obtendrás dos respuestas distintas. El diccionario de psicología de la APA describe un deseo intenso y una preocupación por la otra persona **dentro de una relación**, una fase que suele desvanecerse uno o dos meses después de que la relación se forme. La investigación revisada por pares desde 2021 estudia algo completamente distinto: un anhelo involuntario y crónico hacia alguien que **no** lo ha correspondido, y que dura años en lugar de semanas." },
      { type: "p", text: "Merriam-Webster recoge ambas acepciones por separado, así que no es una confusión que se resuelva eligiendo la mejor fuente: la palabra lleva de verdad dos significados. Y cuál de los dos se quiere decir importa muchísimo. Uno describe la embriaguez corriente de una relación que empieza. El otro describe algo capaz de apoderarse de una vida, y ese es el sentido que hoy tiene en mente casi todo el que busca la palabra." },
      { type: "h2", text: "De dónde viene la palabra" },
      { type: "p", text: "La acuñó la psicóloga estadounidense Dorothy Tennov, que construyó el concepto a partir de más de 300 entrevistas sobre qué se siente al estar enamorado y lo expuso en 1979 en su libro *Love and Limerence*. La palabra no tiene etimología a propósito: Tennov la inventó de la nada y dijo que no tenía «ninguna raíz en absoluto». Aparece impresa al menos desde 1975, así que, pese a sonar reciente, ronda el medio siglo." },
      { type: "h2", text: "En qué se diferencia de un flechazo" },
      { type: "ul", items: [
        "**No se elige.** Quienes lo viven cuentan que les ocurre, a veces por alguien que ni siquiera les parece adecuado.",
        "**No se pasa solo.** Un flechazo viene y va; esto se instala y empieza a alimentarse de la duda.",
        "**La incertidumbre lo fortalece, no lo debilita.** Un no claro puede resultar más llevadero que un quizá ambiguo.",
        "**La atención se estrecha en una sola persona.** No un tipo ni una categoría: un individuo concreto, al que la literatura científica llama «limerent object».",
      ] },
      { type: "h2", text: "Qué se sabe realmente, que no es mucho" },
      { type: "p", text: "La palabra no aparece en la CIE-11, la clasificación de enfermedades de la OMS, y tampoco es un diagnóstico formal en el DSM; los investigadores que la estudian lo dicen sin rodeos, y un artículo de 2026 sigue incluyendo la necesidad de criterios diagnósticos entre los problemas abiertos. El primer cuestionario validado para medirla se publicó apenas en 2025. En el uso popular el término está en todas partes; científicamente esto es un campo pequeño y joven." },
      { type: "p", text: "El mayor estudio hasta la fecha, publicado en *Acta Psychologica* en 2026, encuestó a 1.647 personas que declaraban experimentar limerence. Dentro de ese grupo, un episodio suponía alrededor de dos años de preocupación por una sola persona y, en un muestreo de siete días de los pensamientos cotidianos, pensar en esa persona ocupaba cerca de la mitad del pensamiento en vigilia de los participantes. Esas cifras describen a gente que ya se identifica como limerente: no son tasas de la población general, y nadie ha medido cuán común es esto." },
      { type: "p", text: "También encontrarás en internet afirmaciones muy seguras de que la limerence dura de dieciocho meses a tres años, o de que funciona con dopamina. Ninguna resiste la comprobación. La cifra de duración no remite a ninguna fuente original y las fuentes accesibles se contradicen entre sí; las afirmaciones sobre el cerebro proceden de estudios que midieron el amor romántico, no la limerence, y no existe un solo estudio de neuroimagen sobre ella." },
      { type: "h2", accent: "green", text: "Si te has reconocido aquí" },
      { type: "p", text: "Que no esté en un manual diagnóstico no hace menos real lo que se vive. Lo que la gente describe —pensamientos que no se pueden soltar, horas perdidas releyendo mensajes antiguos, un ánimo que sube y baja según si alguien ha contestado— es algo genuino y pesado, y tratarlo como una broma sobre estar obsesionado es no ver lo que cuesta. Si lleva meses, o está interfiriendo con el trabajo, el sueño o la gente que te rodea, merece la pena llevarlo a un profesional de salud mental. Es una derivación de verdad, no una manera cortés de cerrar la página." },
      { type: "p", text: "Vale la pena notar una cosa: la limerence se alimenta de no saber. Mientras la correspondencia siga siendo una pregunta abierta, siempre habrá otra señal que interpretar, y la mente llena el silencio con una versión de la persona en lugar de con la persona. Qulo no cambiará lo que nadie siente, y aquí no se trata nada, pero su mecánica sí elimina las suposiciones en una pregunta muy concreta. Respondes a lo que alguien preguntó de verdad, y o acertaste o no. El interés no se descifra: se pone a prueba." },
    ],
  },
  it: {
    term: "Limerence",
    summary:
      "Uno stato involontario e persistente di desiderio ossessivo per una persona precisa — di solito qualcuno che non ha ricambiato — fatto di pensieri intrusivi e di una lettura continua dei segnali alla ricerca di una prova d’interesse.",
    blocks: [
      { type: "h2", text: "Una parola, due definizioni" },
      { type: "p", text: "Cerca questa parola in due posti e otterrai due risposte diverse. Il dizionario di psicologia dell’APA descrive un desiderio intenso e una preoccupazione per il partner **dentro una relazione**, una fase che di solito si spegne un mese o due dopo che la relazione si è formata. La ricerca sottoposta a revisione dal 2021 studia invece tutt’altro: una nostalgia involontaria e cronica per qualcuno che **non** l’ha ricambiata, e che dura anni anziché settimane." },
      { type: "p", text: "Merriam-Webster registra i due significati separatamente: non è quindi un equivoco che si risolve scegliendo la fonte migliore — la parola porta davvero due sensi. E quale dei due si intenda cambia moltissimo. Uno descrive la normale ebbrezza di una relazione che comincia. L’altro descrive qualcosa che può prendersi una vita intera, ed è il senso che ha in mente quasi chiunque cerchi oggi questa parola." },
      { type: "h2", text: "Da dove viene la parola" },
      { type: "p", text: "L’ha coniata la psicologa statunitense Dorothy Tennov, che ha costruito il concetto su più di 300 interviste su che cosa si prova a essere innamorati e l’ha esposto nel 1979 nel libro *Love and Limerence*. La parola non ha etimologia di proposito: Tennov l’ha inventata dal nulla, dicendo che non aveva «nessuna radice». Compare in stampa almeno dal 1975, quindi, per quanto suoni recente, ha circa cinquant’anni." },
      { type: "h2", text: "In cosa differisce da una cotta" },
      { type: "ul", items: [
        "**Non si sceglie.** Chi la vive racconta che gli capita, a volte per qualcuno che non trova nemmeno adatto a sé.",
        "**Non passa da sola.** Una cotta va e viene; questa si insedia e comincia a nutrirsi del dubbio.",
        "**L’incertezza la rafforza, non la indebolisce.** Un no netto può pesare meno di un forse ambiguo.",
        "**L’attenzione si restringe a una persona sola.** Non un tipo, non una categoria: un individuo preciso, che la letteratura scientifica chiama «limerent object».",
      ] },
      { type: "h2", text: "Che cosa si sa davvero, cioè poco" },
      { type: "p", text: "La parola non compare nell’ICD-11, la classificazione delle malattie dell’OMS, e non è una diagnosi formale nemmeno nel DSM; i ricercatori che se ne occupano lo scrivono apertamente, e un articolo del 2026 elenca ancora il bisogno di criteri diagnostici tra i problemi aperti. Il primo questionario validato per misurarla è uscito solo nel 2025. Nell’uso comune il termine è ovunque; dal punto di vista scientifico questo è un campo piccolo e giovane." },
      { type: "p", text: "Lo studio più ampio finora, pubblicato su *Acta Psychologica* nel 2026, ha interrogato 1.647 persone che dichiaravano di provare limerence. All’interno di quel gruppo un episodio comportava circa due anni di preoccupazione per una sola persona e, in un campionamento di sette giorni dei pensieri quotidiani, pensare a quella persona occupava all’incirca metà del pensiero da svegli dei partecipanti. Quei numeri descrivono persone che già si riconoscono come limerenti: non sono tassi riferiti alla popolazione generale, e quanto sia diffuso nessuno l’ha misurato." },
      { type: "p", text: "Online troverai anche affermazioni sicure secondo cui la limerence dura dai diciotto mesi ai tre anni, o che è mossa dalla dopamina. Nessuna delle due regge alla verifica. Il dato sulla durata non risale ad alcuna fonte originale e le fonti raggiungibili si contraddicono; le affermazioni sul cervello vengono da studi che hanno misurato l’amore romantico, non la limerence, e non esiste un solo studio di neuroimmagini su di essa." },
      { type: "h2", accent: "green", text: "Se ti sei riconosciuto" },
      { type: "p", text: "Non essere in un manuale diagnostico non rende meno reale ciò che si prova. Quello che le persone descrivono — pensieri che non si riescono a posare, ore perse a rileggere vecchi messaggi, un umore che sale e scende a seconda che qualcuno abbia risposto — è una cosa autentica e pesante, e liquidarla come una battuta sull’essere fissati significa non vedere quanto costa. Se va avanti da mesi, o se interferisce con il lavoro, il sonno o le persone attorno a te, vale la pena portarla a un professionista della salute mentale. È un invio vero, non un modo garbato di chiudere la pagina." },
      { type: "p", text: "Una cosa vale la pena notarla: la limerence si nutre del non sapere. Finché la reciprocità resta una domanda aperta, c’è sempre un altro segnale da interpretare, e la mente riempie il silenzio con una versione della persona invece che con la persona. Qulo non cambierà quello che qualcuno prova, e qui non si cura nulla — ma il suo meccanismo toglie l’indovinello da una domanda ben precisa. Rispondi a ciò che qualcuno ha davvero chiesto, e o l’hai azzeccata o no. L’interesse non si decifra: si mette alla prova." },
    ],
  },
  pt: {
    term: "Limerence",
    summary:
      "Um estado involuntário e persistente de anseio obsessivo por uma pessoa específica — em geral alguém que não retribuiu o sentimento — marcado por pensamentos intrusivos e por uma leitura constante de sinais em busca de prova de interesse.",
    blocks: [
      { type: "h2", text: "Uma palavra, duas definições" },
      { type: "p", text: "Procure esta palavra em dois lugares e você receberá duas respostas diferentes. O dicionário de psicologia da APA descreve desejo intenso e preocupação com a outra pessoa **dentro de um relacionamento**, uma fase que costuma se dissipar um ou dois meses depois de o relacionamento se formar. A pesquisa revisada por pares desde 2021 estuda algo completamente distinto: um anseio involuntário e crônico por alguém que **não** o retribuiu, e que dura anos em vez de semanas." },
      { type: "p", text: "O Merriam-Webster registra os dois sentidos separadamente, ou seja, não é uma confusão que se resolva escolhendo a fonte melhor — a palavra carrega mesmo dois significados. E saber qual deles está em jogo muda muita coisa. Um descreve a embriaguez comum de um relacionamento que começa. O outro descreve algo capaz de tomar conta de uma vida, e é esse o sentido que quase todo mundo tem em mente ao procurar a palavra hoje." },
      { type: "h2", text: "De onde vem a palavra" },
      { type: "p", text: "Foi cunhada pela psicóloga norte-americana Dorothy Tennov, que construiu o conceito a partir de mais de 300 entrevistas sobre o que se sente ao estar apaixonado e o apresentou em 1979 no livro *Love and Limerence*. A palavra não tem etimologia de propósito: Tennov a inventou do zero e disse que ela não tinha “raiz nenhuma”. Aparece impressa desde pelo menos 1975, então, por mais que soe recente, tem cerca de cinquenta anos." },
      { type: "h2", text: "Como difere de uma paixonite" },
      { type: "ul", items: [
        "**Não se escolhe.** Quem passa por isso conta que aquilo acontece com a pessoa, às vezes por alguém que ela nem considera adequado.",
        "**Não passa sozinho.** Uma paixonite vai e vem; isto se instala e começa a se alimentar da dúvida.",
        "**A incerteza fortalece, não enfraquece.** Um não claro pode ser mais fácil do que um talvez ambíguo.",
        "**A atenção se estreita em uma única pessoa.** Não um tipo, não uma categoria: um indivíduo específico, que a literatura de pesquisa chama de “limerent object”.",
      ] },
      { type: "h2", text: "O que se sabe de fato, e não é muito" },
      { type: "p", text: "A palavra não aparece na CID-11, a classificação de doenças da OMS, e também não é um diagnóstico formal no DSM; os pesquisadores que a estudam dizem isso abertamente, e um artigo de 2026 ainda lista a necessidade de critérios diagnósticos como um problema em aberto. O primeiro questionário validado para medi-la só foi publicado em 2025. No uso popular o termo está em toda parte; cientificamente, este é um campo pequeno e jovem." },
      { type: "p", text: "O maior estudo até agora, publicado na *Acta Psychologica* em 2026, ouviu 1.647 pessoas que relataram vivenciar limerence. Dentro desse grupo, um episódio envolvia cerca de dois anos de preocupação com uma única pessoa e, numa amostragem de sete dias dos pensamentos do dia a dia, pensar naquela pessoa ocupava por volta da metade do pensamento desperto dos participantes. Esses números descrevem gente que já se reconhece nesse estado: não são taxas da população geral, e ninguém mediu o quanto isso é comum." },
      { type: "p", text: "Você também encontrará on-line afirmações confiantes de que a limerence dura de dezoito meses a três anos, ou de que ela funciona a dopamina. Nenhuma das duas sobrevive à verificação. O número da duração não remonta a nenhuma fonte original e as fontes acessíveis se contradizem; as afirmações sobre o cérebro vêm de estudos que mediram o amor romântico, não a limerence, e não existe um único estudo de neuroimagem sobre ela." },
      { type: "h2", accent: "green", text: "Se você se reconheceu aqui" },
      { type: "p", text: "Não constar de um manual diagnóstico não torna a experiência menos real. O que as pessoas descrevem — pensamentos impossíveis de largar, horas perdidas relendo mensagens antigas, um humor que sobe e desce conforme alguém tenha respondido ou não — é algo genuíno e pesado, e tratar isso como piada sobre estar obcecado é não enxergar o preço. Se já dura meses, ou se está atrapalhando o trabalho, o sono ou as pessoas ao seu redor, vale levar isso a um profissional de saúde mental. É um encaminhamento de verdade, não um jeito educado de encerrar a página." },
      { type: "p", text: "Uma coisa vale a pena notar: a limerence se alimenta de não saber. Enquanto a reciprocidade permanecer uma pergunta em aberto, sempre haverá mais um sinal para interpretar, e a mente preenche o silêncio com uma versão da pessoa em vez da pessoa. O Qulo não vai mudar o que alguém sente, e nada aqui trata coisa alguma — mas a mecânica dele tira o palpite de uma pergunta bem específica. Você responde ao que alguém de fato perguntou, e ou acertou ou não. O interesse não é decifrado: é testado." },
    ],
  },
  nl: {
    term: "Limerence",
    summary:
      "Een onvrijwillige, aanhoudende staat van obsessief verlangen naar één specifiek iemand — meestal iemand die het gevoel niet heeft beantwoord — met opdringerige gedachten en een voortdurend uitpluizen van signalen op zoek naar bewijs van interesse.",
    blocks: [
      { type: "h2", text: "Eén woord, twee definities" },
      { type: "p", text: "Zoek dit woord op twee plekken op en je krijgt twee verschillende antwoorden. Het psychologiewoordenboek van de APA beschrijft intens verlangen en in beslag genomen worden door een partner **binnen een relatie**, een fase die meestal een maand of twee na het ontstaan van de relatie wegebt. Peer-reviewed onderzoek sinds 2021 bestudeert iets heel anders: een onvrijwillig, chronisch verlangen naar iemand die het **niet** heeft beantwoord, en dat jaren duurt in plaats van weken." },
      { type: "p", text: "Merriam-Webster noteert beide betekenissen apart, dus dit is geen misverstand dat je oplost door de betere bron te kiezen — het woord draagt werkelijk twee betekenissen. En welke van de twee bedoeld wordt, maakt enorm veel uit. De ene beschrijft de gewone roes van een relatie die net begint. De andere beschrijft iets dat een leven kan overnemen, en dat is de betekenis die vandaag vrijwel iedereen bedoelt die dit woord opzoekt." },
      { type: "h2", text: "Waar het woord vandaan komt" },
      { type: "p", text: "Het is bedacht door de Amerikaanse psycholoog Dorothy Tennov, die het begrip opbouwde uit meer dan 300 interviews over hoe verliefd zijn voelt en het in 1979 uiteenzette in haar boek *Love and Limerence*. Het woord heeft met opzet geen etymologie — Tennov verzon het uit het niets en zei dat het “helemaal geen wortels” had. Het duikt al minstens sinds 1975 in druk op; hoe recent het ook klinkt, het is ongeveer vijftig jaar oud." },
      { type: "h2", text: "Waarin het verschilt van een gewone verliefdheid" },
      { type: "ul", items: [
        "**Je kiest er niet voor.** Mensen beschrijven dat het hun overkomt, soms om iemand die ze zelf niet eens geschikt vinden.",
        "**Het gaat niet vanzelf over.** Een verliefdheid komt en gaat; dit nestelt zich en gaat zich voeden met twijfel.",
        "**Onzekerheid maakt het sterker, niet zwakker.** Een duidelijk nee kan lichter zijn dan een vaag misschien.",
        "**De aandacht vernauwt zich tot één persoon.** Geen type, geen categorie — één specifiek iemand, in de onderzoeksliteratuur het “limerent object” genoemd.",
      ] },
      { type: "h2", text: "Wat er werkelijk bekend is — en dat is weinig" },
      { type: "p", text: "Het woord komt niet voor in de ICD-11, de ziekteclassificatie van de WHO, en het is ook in de DSM geen formele diagnose; de onderzoekers die zich ermee bezighouden schrijven dat onomwonden, en een artikel uit 2026 noemt de behoefte aan diagnostische criteria nog steeds een open probleem. De eerste gevalideerde vragenlijst om het te meten verscheen pas in 2025. In het populaire spraakgebruik is de term overal; wetenschappelijk is dit een klein, jong veld." },
      { type: "p", text: "Het grootste onderzoek tot nu toe, in 2026 gepubliceerd in *Acta Psychologica*, ondervroeg 1.647 mensen die zeiden limerence te ervaren. Binnen die groep besloeg één episode ongeveer twee jaar van in beslag genomen worden door één persoon, en in een zevendaagse steekproef van alledaagse gedachten vulde het denken aan die persoon ongeveer de helft van de wakkere gedachten van de deelnemers. Die cijfers beschrijven mensen die zichzelf al als limerent zien — het zijn geen percentages voor de algemene bevolking, en niemand heeft gemeten hoe vaak dit voorkomt." },
      { type: "p", text: "Online vind je ook stellige beweringen dat limerence achttien maanden tot drie jaar duurt, of dat het op dopamine draait. Geen van beide houdt stand bij controle. Het duurcijfer is naar geen enkele oorspronkelijke bron te herleiden en de bereikbare bronnen spreken elkaar tegen; de hersenbeweringen komen uit onderzoek dat romantische liefde mat, niet limerence, en er bestaat geen enkele hersenscanstudie naar." },
      { type: "h2", accent: "green", text: "Als je jezelf hierin herkende" },
      { type: "p", text: "Niet in een diagnosehandboek staan maakt de ervaring niet minder echt. Wat mensen beschrijven — gedachten die je niet kunt neerleggen, uren die verdwijnen in het herlezen van oude berichten, een stemming die stijgt en daalt met de vraag of iemand heeft geantwoord — is iets echts en zwaars, en er een grap over geobsedeerd zijn van maken gaat voorbij aan wat het kost. Als het al maanden duurt, of als het je werk, je slaap of de mensen om je heen in de weg zit, is het de moeite waard om ermee naar een professional in de geestelijke gezondheidszorg te gaan. Dat is een echte doorverwijzing, geen beleefde manier om de pagina af te sluiten." },
      { type: "p", text: "Eén ding is het opmerken waard: limerence teert op niet weten. Zolang wederkerigheid een open vraag blijft, is er altijd nóg een signaal om te duiden, en vult het hoofd de stilte met een versie van die persoon in plaats van met die persoon zelf. Qulo verandert niets aan wat iemand voelt, en hier wordt niets behandeld — maar de mechaniek haalt het gissen weg bij één heel specifieke vraag. Je beantwoordt wat iemand daadwerkelijk heeft gevraagd, en je had het goed of niet. Interesse wordt niet ontcijferd, maar getoetst." },
    ],
  },
  pl: {
    term: "Limerence",
    summary:
      "Mimowolny, uporczywy stan obsesyjnej tęsknoty za jedną konkretną osobą — najczęściej za kimś, kto tego uczucia nie odwzajemnił — z natrętnymi myślami i nieustannym odczytywaniem sygnałów w poszukiwaniu dowodu zainteresowania.",
    blocks: [
      { type: "h2", text: "Jedno słowo, dwie definicje" },
      { type: "p", text: "Sprawdź to słowo w dwóch miejscach, a dostaniesz dwie różne odpowiedzi. Słownik psychologiczny APA opisuje intensywne pragnienie i pochłonięcie drugą osobą **wewnątrz istniejącego związku** — fazę, która zwykle słabnie miesiąc czy dwa po tym, jak związek się zawiąże. Recenzowane badania po 2021 roku zajmują się czymś zupełnie innym: mimowolną, przewlekłą tęsknotą za kimś, kto jej **nie** odwzajemnił, trwającą raczej latami niż tygodniami." },
      { type: "p", text: "Merriam-Webster notuje oba znaczenia osobno, więc to nie jest pomyłka, którą da się rozstrzygnąć wyborem lepszego źródła — słowo naprawdę niesie dwa sensy. A to, które z nich ktoś ma na myśli, zmienia bardzo wiele. Jeden opisuje zwyczajne upojenie początkiem związku. Drugi opisuje coś, co potrafi przejąć całe życie, i właśnie ten sens ma dziś na myśli niemal każdy, kto wpisuje to słowo w wyszukiwarkę." },
      { type: "h2", text: "Skąd wzięło się to słowo" },
      { type: "p", text: "Ukuła je amerykańska psycholożka Dorothy Tennov, która zbudowała to pojęcie na ponad 300 wywiadach o tym, jak to jest być zakochanym, i przedstawiła je w 1979 roku w książce *Love and Limerence*. Słowo z premedytacją nie ma etymologii — Tennov wymyśliła je od zera, mówiąc, że nie ma ono „żadnych korzeni”. W druku pojawia się co najmniej od 1975 roku, więc mimo że brzmi świeżo, ma około pięćdziesięciu lat." },
      { type: "h2", text: "Czym różni się od zauroczenia" },
      { type: "ul", items: [
        "**Nie wybiera się tego.** Ludzie opowiadają, że to im się przydarza — czasem wobec kogoś, kogo sami nie uważają za odpowiedniego.",
        "**Nie mija samo.** Zauroczenie przychodzi i odchodzi; to zostaje i zaczyna karmić się wątpliwością.",
        "**Niepewność to wzmacnia, a nie osłabia.** Wyraźne nie bywa łatwiejsze niż niejasne może.",
        "**Uwaga zawęża się do jednej osoby.** Nie do typu ani kategorii — do jednego konkretnego człowieka, którego literatura naukowa nazywa „limerent object”.",
      ] },
      { type: "h2", text: "Co naprawdę wiadomo — a wiadomo niewiele" },
      { type: "p", text: "Słowo nie występuje w ICD-11, klasyfikacji chorób WHO, i nie jest też formalną diagnozą w DSM; badacze, którzy się tym zajmują, piszą to wprost, a artykuł z 2026 roku wciąż wymienia potrzebę kryteriów diagnostycznych jako problem otwarty. Pierwszy zwalidowany kwestionariusz do mierzenia tego zjawiska ukazał się dopiero w 2025 roku. W obiegu popularnym termin jest wszędzie; naukowo to wciąż mały i młody obszar." },
      { type: "p", text: "Największe dotąd badanie, opublikowane w *Acta Psychologica* w 2026 roku, objęło 1647 osób deklarujących, że doświadczają limerence. W tej grupie jeden epizod obejmował około dwóch lat pochłonięcia jedną osobą, a w siedmiodniowym próbkowaniu codziennych myśli myślenie o tej osobie zajmowało mniej więcej połowę czasu myślenia na jawie uczestników. Te liczby opisują ludzi, którzy już się z tym stanem utożsamiają — nie są to wskaźniki dla populacji ogólnej, a tego, jak częste jest to zjawisko, nikt nie zmierzył." },
      { type: "p", text: "W sieci znajdziesz też pewne siebie twierdzenia, że limerence trwa od osiemnastu miesięcy do trzech lat albo że napędza je dopamina. Żadne nie wytrzymuje sprawdzenia. Liczba dotycząca czasu trwania nie prowadzi do żadnego oryginalnego źródła, a dostępne źródła przeczą sobie nawzajem; twierdzenia o mózgu pochodzą z badań, które mierzyły miłość romantyczną, a nie limerence — nie ma ani jednego badania neuroobrazowego na jej temat." },
      { type: "h2", accent: "green", text: "Jeśli rozpoznajesz tu siebie" },
      { type: "p", text: "Nieobecność w podręczniku diagnostycznym nie czyni tego doświadczenia mniej rzeczywistym. To, co ludzie opisują — myśli, których nie da się odłożyć, godziny tracone na ponowne czytanie starych wiadomości, nastrój zależny od tego, czy ktoś odpisał — jest czymś prawdziwym i ciężkim, a kwitowanie tego żartem o obsesji nie widzi, ile to kosztuje. Jeśli trwa od miesięcy albo wchodzi w drogę pracy, snu czy ludziom wokół, warto pójść z tym do specjalisty zdrowia psychicznego. To realne skierowanie, a nie uprzejmy sposób zakończenia strony." },
      { type: "p", text: "Jedna rzecz warta uwagi: limerence żywi się niewiedzą. Dopóki wzajemność pozostaje pytaniem otwartym, zawsze znajdzie się kolejny sygnał do zinterpretowania, a umysł wypełnia ciszę własną wersją tej osoby zamiast nią samą. Qulo nie zmieni tego, co ktoś czuje, i nic tutaj niczego nie leczy — ale jego mechanika usuwa zgadywanie z jednego bardzo konkretnego pytania. Odpowiadasz na to, o co ktoś naprawdę zapytał, i albo trafiłeś, albo nie. Zainteresowania się nie odszyfrowuje — poddaje się je próbie." },
    ],
  },
  sv: {
    term: "Limerence",
    summary:
      "Ett ofrivilligt, ihållande tillstånd av besatt längtan efter en enda bestämd person — oftast någon som inte har besvarat känslan — präglat av påträngande tankar och ett ständigt tolkande av signaler i jakt på bevis för intresse.",
    blocks: [
      { type: "h2", text: "Ett ord, två definitioner" },
      { type: "p", text: "Slå upp ordet på två ställen och du får två olika svar. APA:s psykologilexikon beskriver intensiv åtrå och upptagenhet av en partner **inuti ett förhållande**, en fas som brukar klinga av en månad eller två efter att förhållandet bildats. Peer-granskad forskning sedan 2021 studerar något helt annat: en ofrivillig, kronisk längtan efter någon som **inte** har besvarat den, och som varar i år snarare än veckor." },
      { type: "p", text: "Merriam-Webster tar upp båda betydelserna var för sig, så det här är ingen förväxling som löses genom att välja den bättre källan — ordet bär faktiskt två betydelser. Och vilken som avses spelar oerhört stor roll. Den ena beskriver det vanliga ruset i ett förhållande som just börjat. Den andra beskriver något som kan ta över ett liv, och det är den betydelsen nästan alla menar när de söker på ordet i dag." },
      { type: "h2", text: "Var ordet kommer ifrån" },
      { type: "p", text: "Det myntades av den amerikanska psykologen Dorothy Tennov, som byggde begreppet på över 300 intervjuer om hur det känns att vara förälskad och lade fram det 1979 i boken *Love and Limerence*. Ordet saknar etymologi med avsikt — Tennov hittade på det från ingenting och sa att det inte hade ”några rötter alls”. Det förekommer i tryck åtminstone sedan 1975, så trots att det känns nytt är det ungefär femtio år gammalt." },
      { type: "h2", text: "Hur det skiljer sig från en förälskelse" },
      { type: "ul", items: [
        "**Det väljs inte.** De som lever med det beskriver att det händer dem, ibland kring någon de inte ens tycker passar dem.",
        "**Det går inte över av sig självt.** En förälskelse kommer och går; det här sätter sig och börjar livnära sig på tvivel.",
        "**Ovisshet gör det starkare, inte svagare.** Ett tydligt nej kan vara lättare än ett vagt kanske.",
        "**Uppmärksamheten smalnar till en enda person.** Ingen typ, ingen kategori — en bestämd individ, som forskningslitteraturen kallar ”limerent object”.",
      ] },
      { type: "h2", text: "Vad som faktiskt är känt — vilket inte är mycket" },
      { type: "p", text: "Ordet finns inte i ICD-11, WHO:s sjukdomsklassifikation, och det är inte heller en formell diagnos i DSM; forskarna som studerar det skriver det rakt ut, och en artikel från 2026 räknar fortfarande behovet av diagnostiska kriterier som ett olöst problem. Det första validerade formuläret för att mäta det publicerades så sent som 2025. I populärt bruk är termen överallt; vetenskapligt är det här ett litet och ungt fält." },
      { type: "p", text: "Den hittills största studien, publicerad i *Acta Psychologica* 2026, omfattade 1 647 personer som uppgav att de upplever limerence. Inom den gruppen innebar en episod ungefär två års upptagenhet av en enda person, och i en sjudagars mätning av vardagstankar fyllde tankarna på den personen omkring hälften av deltagarnas vakna tänkande. De siffrorna beskriver människor som redan ser sig själva som limerenta — de är inte tal för befolkningen i stort, och ingen har mätt hur vanligt det är." },
      { type: "p", text: "Du hittar också tvärsäkra påståenden på nätet om att limerence varar arton månader till tre år, eller att det drivs av dopamin. Inget av dem håller vid kontroll. Tidssiffran går inte att spåra till någon ursprungskälla och de källor som går att nå motsäger varandra; hjärnpåståendena kommer från studier som mätte romantisk kärlek, inte limerence, och det finns inte en enda hjärnavbildningsstudie av det." },
      { type: "h2", accent: "green", text: "Om du kände igen dig" },
      { type: "p", text: "Att inte stå i en diagnosmanual gör inte upplevelsen mindre verklig. Det människor beskriver — tankar som inte går att lägga ifrån sig, timmar som försvinner i omläsning av gamla meddelanden, ett humör som stiger och faller med om någon svarat — är något äkta och tungt, och att avfärda det som ett skämt om att vara besatt missar vad det kostar. Om det har pågått i månader, eller om det stör arbete, sömn eller människorna omkring dig, är det värt att ta upp med en psykolog eller annan vårdprofessionell. Det är en verklig hänvisning, inte ett artigt sätt att avsluta sidan." },
      { type: "p", text: "En sak är värd att lägga märke till: limerence lever på ovisshet. Så länge gensvaret förblir en öppen fråga finns det alltid ännu en signal att tolka, och huvudet fyller tystnaden med en version av personen i stället för med personen. Qulo ändrar inte vad någon känner, och ingenting här behandlar något — men mekaniken tar bort gissandet ur en enda bestämd fråga. Du svarar på det någon faktiskt har frågat, och antingen hade du rätt eller inte. Intresse dechiffreras inte, det prövas." },
    ],
  },
  ru: {
    term: "Лимеренция",
    summary:
      "Непроизвольное и устойчивое состояние навязчивой тоски по одному конкретному человеку — обычно по тому, кто не ответил взаимностью, — с неотвязными мыслями и постоянным считыванием сигналов в поисках доказательства интереса.",
    blocks: [
      { type: "h2", text: "Одно слово, два определения" },
      { type: "p", text: "Загляните в два разных словаря — получите два разных ответа. Психологический словарь APA описывает сильное влечение и поглощённость партнёром **внутри уже сложившихся отношений**: фазу, которая обычно затухает через месяц-другой после начала отношений. Рецензируемые исследования после 2021 года изучают совсем другое: непроизвольную, хроническую тоску по человеку, который **не** ответил взаимностью, и длится она годами, а не неделями." },
      { type: "p", text: "Merriam-Webster фиксирует оба значения по отдельности, так что это не путаница, которую можно снять, выбрав источник получше, — слово действительно несёт два смысла. И то, какой из них имеется в виду, меняет очень многое. Одно описывает обычное опьянение начавшихся отношений. Другое — то, что способно захватить целую жизнь, и сегодня почти каждый, кто ищет это слово, имеет в виду именно его." },
      { type: "h2", text: "Откуда взялось слово" },
      { type: "p", text: "Его придумала американский психолог Дороти Теннов: она построила понятие на более чем 300 интервью о том, каково это — быть влюблённым, и изложила его в 1979 году в книге *Love and Limerence*. У слова намеренно нет этимологии — Теннов сочинила его с нуля и говорила, что у него «нет вообще никаких корней». В печати оно встречается по меньшей мере с 1975 года, так что, при всей своей новизне на слух, ему около пятидесяти лет." },
      { type: "h2", text: "Чем это отличается от влюблённости" },
      { type: "ul", items: [
        "**Это не выбирают.** Люди описывают это как то, что с ними случается, — иногда из-за человека, которого они сами не считают подходящим.",
        "**Само это не проходит.** Влюблённость приходит и уходит; здесь состояние укореняется и начинает питаться сомнением.",
        "**Неопределённость его усиливает, а не ослабляет.** Ясное «нет» переносится легче, чем размытое «может быть».",
        "**Внимание сужается до одного человека.** Не тип и не категория — один конкретный человек, которого исследовательская литература называет «limerent object».",
      ] },
      { type: "h2", text: "Что известно на самом деле — а известно немного" },
      { type: "p", text: "Слова нет в МКБ-11, классификации болезней ВОЗ, и в DSM это тоже не формальный диагноз; исследователи, которые этим занимаются, пишут об этом прямо, а статья 2026 года всё ещё называет потребность в диагностических критериях нерешённой задачей. Первый валидированный опросник для измерения появился только в 2025 году. В массовом обиходе термин повсюду; с научной стороны это маленькая и молодая область." },
      { type: "p", text: "Самое крупное на сегодня исследование, опубликованное в *Acta Psychologica* в 2026 году, охватило 1647 человек, сообщивших, что переживают лимеренцию. Внутри этой группы один эпизод включал около двух лет поглощённости одним человеком, а в семидневной выборке повседневных мыслей мысли об этом человеке занимали примерно половину бодрствующего мышления участников. Эти цифры описывают тех, кто и так относит себя к лимерентным, — это не показатели для населения в целом, и насколько это распространено, никто не измерял." },
      { type: "p", text: "В сети вам встретятся и уверенные утверждения, будто лимеренция длится от восемнадцати месяцев до трёх лет или работает на дофамине. Ни то, ни другое проверки не выдерживает. Цифра о длительности не восходит ни к одному первоисточнику, а доступные источники противоречат друг другу; утверждения про мозг взяты из исследований, которые измеряли романтическую любовь, а не лимеренцию, — ни одного нейровизуализационного исследования о ней не существует." },
      { type: "h2", accent: "green", text: "Если вы узнали себя" },
      { type: "p", text: "Отсутствие в диагностическом справочнике не делает переживание менее настоящим. То, что описывают люди, — мысли, которые невозможно отложить, часы, уходящие на перечитывание старых сообщений, настроение, которое поднимается и падает от того, ответил кто-то или нет, — вещь подлинная и тяжёлая, и отмахнуться от неё шуткой про зацикленность значит не увидеть её цену. Если это длится месяцами или мешает работе, сну и людям рядом, с этим стоит пойти к специалисту в области психического здоровья. Это настоящая рекомендация, а не вежливый способ закончить страницу." },
      { type: "p", text: "Одну вещь стоит заметить: лимеренция кормится незнанием. Пока взаимность остаётся открытым вопросом, всегда найдётся ещё один сигнал для толкования, и голова заполняет тишину своей версией человека вместо самого человека. Qulo не изменит того, что кто-то чувствует, и здесь ничто ничего не лечит — но его механика убирает догадки из одного вполне конкретного вопроса. Вы отвечаете на то, о чём человек действительно спросил, и либо угадали, либо нет. Интерес не расшифровывают — его проверяют." },
    ],
  },
  ar: {
    term: "الليمرنس",
    summary:
      "حالة لا إرادية ومستمرة من الاشتياق المهووس لشخص بعينه — غالبًا شخص لم يبادل الشعور — تتسم بأفكار مقتحمة وقراءة دائمة للإشارات بحثًا عن دليل على الاهتمام.",
    blocks: [
      { type: "h2", text: "كلمة واحدة، تعريفان" },
      { type: "p", text: "ابحث عن هذه الكلمة في مكانين وستحصل على إجابتين مختلفتين. قاموس علم النفس الصادر عن الجمعية الأمريكية لعلم النفس يصف رغبة شديدة وانشغالًا بالطرف الآخر **داخل علاقة قائمة**، وهي مرحلة تخفّ عادةً بعد شهر أو شهرين من نشوء العلاقة. أما الأبحاث المحكّمة منذ 2021 فتدرس شيئًا مختلفًا تمامًا: اشتياقًا لا إراديًا ومزمنًا لشخص **لم** يبادله، يستمر سنوات لا أسابيع." },
      { type: "p", text: "ومعجم Merriam-Webster يسجّل المعنيين كلًّا على حدة، فالأمر ليس خلطًا يُحسم باختيار المصدر الأفضل — الكلمة تحمل معنيين فعلًا. وأيّهما المقصود يغيّر الكثير. أحدهما يصف النشوة العادية لعلاقة في بدايتها. والآخر يصف شيئًا قادرًا على الاستيلاء على حياة كاملة، وهو المعنى الذي يقصده اليوم كل من يبحث عن الكلمة تقريبًا." },
      { type: "h2", text: "من أين جاءت الكلمة" },
      { type: "p", text: "صاغتها عالمة النفس الأمريكية دوروثي تينوف، التي بنت المفهوم على أكثر من 300 مقابلة حول شعور الوقوع في الحب، وعرضته عام 1979 في كتابها *Love and Limerence*. الكلمة بلا اشتقاق عن قصد — اخترعتها تينوف من العدم وقالت إنها «بلا جذور على الإطلاق». وقد ظهرت مطبوعة منذ 1975 على الأقل، فرغم أنها تبدو حديثة فعمرها نحو خمسين عامًا." },
      { type: "h2", text: "كيف يختلف عن الإعجاب العابر" },
      { type: "ul", items: [
        "**لا يُختار.** يصفه أصحابه بأنه يحدث لهم، وأحيانًا تجاه شخص لا يرونه مناسبًا لهم أصلًا.",
        "**لا يزول وحده.** الإعجاب العابر يأتي ويذهب؛ أما هذا فيستقرّ ويبدأ في التغذّي على الشك.",
        "**الغموض يقوّيه لا يضعفه.** «لا» الواضحة قد تكون أسهل من «ربما» الملتبسة.",
        "**ينحصر الانتباه في شخص واحد.** ليس نمطًا ولا فئة — فرد بعينه، تسميه أدبيات البحث «limerent object».",
      ] },
      { type: "h2", text: "ما هو معروف فعلًا — وهو قليل" },
      { type: "p", text: "الكلمة لا ترد في التصنيف الدولي للأمراض ICD-11 الصادر عن منظمة الصحة العالمية، وليست تشخيصًا رسميًا في DSM كذلك؛ الباحثون المشتغلون بها يقولون ذلك صراحةً، وورقة من 2026 ما زالت تدرج الحاجة إلى معايير تشخيصية ضمن المسائل المفتوحة. وأول استبيان مُصدَّق لقياسها لم يُنشر إلا في 2025. الكلمة حاضرة في كل مكان شعبيًا؛ أما علميًا فهذا حقل صغير وحديث." },
      { type: "p", text: "أكبر دراسة حتى الآن، نُشرت في *Acta Psychologica* عام 2026، شملت 1647 شخصًا أفادوا بأنهم يعيشون الليمرنس. داخل هذه المجموعة، كانت النوبة الواحدة تمتد نحو سنتين من الانشغال الذهني بشخص واحد، وفي عيّنة من الأفكار اليومية على مدى سبعة أيام كان التفكير في ذلك الشخص يملأ نحو نصف تفكير المشاركين في ساعات اليقظة. هذه الأرقام تصف أشخاصًا يعرّفون أنفسهم أصلًا بأنهم يعيشون الليمرنس — وليست نسبًا للسكان عمومًا، ولم يقس أحد مدى شيوع الأمر." },
      { type: "p", text: "ستجد على الإنترنت أيضًا جملًا واثقة تقول إن الليمرنس يدوم من ثمانية عشر شهرًا إلى ثلاث سنوات، أو إنه يعمل بالدوبامين. ولا واحدة منهما تصمد أمام التدقيق. رقم المدة لا يعود إلى أي مصدر أصلي والمصادر المتاحة يناقض بعضها بعضًا؛ أما ادعاءات الدماغ فمصدرها دراسات قاست الحب الرومانسي لا الليمرنس، ولا توجد ولا دراسة تصوير دماغي واحدة عنه." },
      { type: "h2", accent: "green", text: "إن وجدت نفسك في هذا الوصف" },
      { type: "p", text: "غياب الكلمة عن دليل تشخيصي لا يجعل التجربة أقل واقعية. ما يصفه الناس — أفكار لا يمكن وضعها جانبًا، ساعات تضيع في إعادة قراءة رسائل قديمة، مزاج يرتفع وينخفض تبعًا لردٍّ وصل أو لم يصل — شيء حقيقي وثقيل، والاكتفاء بالسخرية منه بوصفه تعلّقًا عابرًا يغفل ما يكلّفه. إن استمر شهورًا، أو صار يعطّل العمل أو النوم أو علاقتك بمن حولك، فمن الجدير أن تعرضه على مختص في الصحة النفسية. هذه إحالة حقيقية، لا طريقة مهذّبة لإنهاء الصفحة." },
      { type: "p", text: "نقطة تستحق الانتباه: الليمرنس يتغذّى على عدم المعرفة. ما دامت المبادلة سؤالًا مفتوحًا، فهناك دائمًا إشارة أخرى تُفسَّر، ويملأ الذهن الصمت بنسخة من الشخص بدل الشخص نفسه. لن يغيّر Qulo ما يشعر به أحد، ولا شيء هنا يعالج شيئًا — لكن آليته تزيل التخمين من سؤال واحد بعينه. تجيب عمّا سأله الطرف الآخر فعلًا، فإما أصبت وإما لا. الاهتمام هنا لا يُفكّ رمزه، بل يُختبر." },
    ],
  },
  hi: {
    term: "लिमरेंस",
    summary:
      "किसी एक ख़ास व्यक्ति के लिए अनैच्छिक और लगातार बनी रहने वाली जुनूनी तड़प — आमतौर पर ऐसे व्यक्ति के लिए जिसने वह भाव लौटाया नहीं — जिसमें दख़लअंदाज़ ख़याल और दिलचस्पी का सबूत ढूँढ़ने के लिए हर संकेत को बार-बार पढ़ना शामिल है।",
    blocks: [
      { type: "h2", text: "एक शब्द, दो परिभाषाएँ" },
      { type: "p", text: "यह शब्द दो जगह देखिए और दो अलग जवाब मिलेंगे। एपीए का मनोविज्ञान शब्दकोश इसे **बने हुए रिश्ते के भीतर** साथी के प्रति तीव्र चाह और व्यस्तता बताता है — एक ऐसा दौर जो रिश्ता बनने के महीने-दो महीने बाद अमूमन ठंडा पड़ जाता है। वहीं 2021 के बाद की समीक्षित शोध बिलकुल दूसरी चीज़ का अध्ययन करती है: ऐसे व्यक्ति के लिए अनैच्छिक और दीर्घकालिक तड़प जिसने उसे लौटाया **नहीं**, और जो हफ़्तों नहीं, सालों तक टिकती है।" },
      { type: "p", text: "मेरियम-वेबस्टर दोनों अर्थ अलग-अलग दर्ज करता है, यानी यह ऐसी उलझन नहीं जो बेहतर स्रोत चुनकर सुलझ जाए — शब्द सचमुच दो अर्थ ढोता है। और कौन-सा अर्थ कहा जा रहा है, इससे बहुत फ़र्क़ पड़ता है। एक नए रिश्ते के आम नशे को बताता है। दूसरा उस चीज़ को बताता है जो पूरी ज़िंदगी अपने क़ब्ज़े में ले सकती है, और आज यह शब्द खोजने वाले क़रीब-क़रीब सभी लोग यही दूसरा अर्थ मन में रखते हैं।" },
      { type: "h2", text: "यह शब्द आया कहाँ से" },
      { type: "p", text: "इसे अमेरिकी मनोवैज्ञानिक डोरोथी टेनोव ने गढ़ा। उन्होंने यह अवधारणा प्यार में होने के अनुभव पर की गई 300 से ज़्यादा बातचीतों से बनाई और 1979 में अपनी किताब *Love and Limerence* में रखी। शब्द की कोई व्युत्पत्ति जान-बूझकर नहीं है — टेनोव ने इसे शून्य से बनाया और कहा कि इसकी “कोई जड़ ही नहीं है”। छपाई में यह कम से कम 1975 से मिलता है, यानी नया लगने के बावजूद यह लगभग पचास साल पुराना है।" },
      { type: "h2", text: "यह एक साधारण क्रश से कैसे अलग है" },
      { type: "ul", items: [
        "**यह चुना नहीं जाता।** लोग बताते हैं कि यह उनके साथ हो जाता है — कभी-कभी ऐसे व्यक्ति के लिए जिसे वे ख़ुद अपने लायक़ भी नहीं मानते।",
        "**यह अपने आप नहीं जाता।** क्रश आता-जाता रहता है; यह जम जाता है और शक से पोषण लेने लगता है।",
        "**अनिश्चितता इसे कमज़ोर नहीं, मज़बूत करती है।** साफ़ ‘ना’ अक्सर धुँधले ‘शायद’ से आसान होती है।",
        "**ध्यान सिमटकर एक व्यक्ति पर आ जाता है।** कोई ‘टाइप’ या श्रेणी नहीं — एक ख़ास इंसान, जिसे शोध साहित्य “limerent object” कहता है।",
      ] },
      { type: "h2", text: "असल में जो पता है — और वह बहुत कम है" },
      { type: "p", text: "यह शब्द डब्ल्यूएचओ के रोग वर्गीकरण ICD-11 में नहीं है, और DSM में भी यह औपचारिक निदान नहीं है; इस पर काम करने वाले शोधकर्ता यह साफ़ लिखते हैं, और 2026 का एक पर्चा आज भी नैदानिक मानदंडों की ज़रूरत को खुला सवाल बताता है। इसे मापने की पहली मान्य प्रश्नावली 2025 में ही छपी। लोकप्रिय इस्तेमाल में यह शब्द हर जगह है; वैज्ञानिक रूप से यह छोटा और नया क्षेत्र है।" },
      { type: "p", text: "अब तक का सबसे बड़ा अध्ययन 2026 में *Acta Psychologica* में छपा और इसमें ऐसे 1,647 लोग शामिल थे जिन्होंने ख़ुद बताया कि वे लिमरेंस से गुज़र रहे हैं। इस समूह के भीतर एक दौर में एक ही व्यक्ति को लेकर लगभग दो साल की मानसिक व्यस्तता थी, और रोज़मर्रा के ख़यालों के सात-दिनी नमूने में उस व्यक्ति के बारे में सोचना प्रतिभागियों की जागती हुई सोच का लगभग आधा हिस्सा घेरता था। ये आँकड़े उन लोगों को बताते हैं जो ख़ुद को पहले से इस हालत में मानते हैं — ये आम आबादी की दरें नहीं हैं, और यह कितना आम है, यह किसी ने मापा नहीं।" },
      { type: "p", text: "इंटरनेट पर आपको यह भी पूरे भरोसे से लिखा मिलेगा कि लिमरेंस अठारह महीने से तीन साल चलता है, या यह डोपामीन पर चलता है। दोनों जाँच में टिकते नहीं। अवधि वाला आँकड़ा किसी मूल स्रोत तक नहीं जाता और जो स्रोत उपलब्ध हैं वे आपस में उलटे पड़ते हैं; दिमाग़ वाले दावे उन अध्ययनों से आते हैं जिन्होंने रोमानी प्रेम मापा था, लिमरेंस नहीं — और इस पर एक भी न्यूरोइमेजिंग अध्ययन मौजूद नहीं है।" },
      { type: "h2", accent: "green", text: "अगर आपने ख़ुद को यहाँ पहचाना" },
      { type: "p", text: "किसी निदान-पुस्तिका में न होना अनुभव को कम सच्चा नहीं बनाता। लोग जो बताते हैं — ऐसे ख़याल जो रखे नहीं जाते, पुराने संदेश दोबारा पढ़ते हुए बीते घंटे, किसी के जवाब देने या न देने से ऊपर-नीचे होता मन — वह सचमुच का और भारी है, और इसे महज़ सनक कहकर टाल देना उसकी क़ीमत नहीं देखता। अगर यह महीनों से चल रहा है, या काम, नींद और आसपास के लोगों के बीच आ रहा है, तो इसे किसी मानसिक स्वास्थ्य पेशेवर तक ले जाना ठीक रहेगा। यह असली सलाह है, पन्ना ख़त्म करने का शिष्ट तरीक़ा नहीं।" },
      { type: "p", text: "एक बात ग़ौर करने लायक़ है: लिमरेंस न जानने से पलता है। जब तक जवाबी भाव एक खुला सवाल बना रहता है, तब तक पढ़ने के लिए एक और संकेत हमेशा बचा रहता है, और मन उस ख़ामोशी को उस इंसान से नहीं, अपने बनाए उसके संस्करण से भरता रहता है। Qulo किसी की भावना नहीं बदलेगा, और यहाँ किसी चीज़ का इलाज नहीं होता — पर उसकी बनावट एक बहुत ख़ास सवाल से अंदाज़ा लगाना हटा देती है। सामने वाले ने जो सचमुच पूछा है आप उसका जवाब देते हैं, और या तो सही हुआ या नहीं। दिलचस्पी को यहाँ बूझा नहीं जाता, परखा जाता है।" },
    ],
  },
  ja: {
    term: "リメランス",
    summary:
      "特定のひとりへの、意志ではどうにもならない執着的な恋しさが続く状態。多くはその想いが返ってこない相手に向かい、頭から離れない思考と、関心の証拠を探して相手の合図を読み続けることを伴う。",
    blocks: [
      { type: "h2", text: "ひとつの言葉、ふたつの定義" },
      { type: "p", text: "この言葉を二か所で引くと、二つの違う答えが返ってくる。米国心理学会（APA）の心理学辞典は、**すでに成立した関係の中で**相手に向かう強い欲求と没入を指し、関係ができてから一、二か月で薄れていく時期だと説明する。一方、2021年以降の査読研究が扱っているのはまったく別のものだ。想いを**返してくれない**相手への、意志によらない慢性的な恋しさで、続く長さは数週間ではなく数年である。" },
      { type: "p", text: "メリアム・ウェブスターは二つの語義を別々に立てている。つまりこれは、より良い出典を選べば片づく取り違えではなく、語そのものが二つの意味を抱えているということだ。そしてどちらの意味で言われているかで、話はまるで変わる。一方は始まったばかりの関係にありふれた酔いを指す。もう一方は人生を丸ごと呑み込みうるものを指し、いまこの語を検索する人のほとんどが思い浮かべているのは後者だ。" },
      { type: "h2", text: "言葉の出どころ" },
      { type: "p", text: "作ったのは米国の心理学者ドロシー・テノフで、「恋をしているとはどういう感じか」についての300を超えるインタビューから概念を組み立て、1979年の著書 *Love and Limerence* で示した。この語には意図的に語源がない。テノフはゼロから作り、「語根などまったくない」と述べている。活字では少なくとも1975年から現れており、新しく聞こえても実際は五十年ほどの歴史がある。" },
      { type: "h2", text: "ちょっとした片思いとの違い" },
      { type: "ul", items: [
        "**選んで始まるものではない。** 当人たちは「起きてしまった」と語る。ときには自分でも相応しいと思っていない相手に対して。",
        "**放っておいても終わらない。** 片思いは来ては去る。こちらは居座り、疑いを餌にして育っていく。",
        "**不確かさは弱めるどころか強める。** はっきりした「ノー」のほうが、曖昧な「かもしれない」より楽なことがある。",
        "**関心が一人に絞り込まれる。** タイプでもカテゴリーでもなく、特定の一人。研究文献ではこの相手を「limerent object」と呼ぶ。",
      ] },
      { type: "h2", text: "実際に分かっていること — つまり、ごくわずか" },
      { type: "p", text: "この語はWHOの疾病分類ICD-11には載っておらず、DSMでも正式な診断名ではない。研究者自身がそう明記しており、2026年の論文もなお診断基準の必要性を未解決の課題として挙げている。測定のための妥当性が確認された質問紙が出たのは2025年になってからだ。世間での流通量に対して、学術的にはまだ小さく若い分野である。" },
      { type: "p", text: "現時点で最大の研究は2026年に *Acta Psychologica* に掲載され、リメランスを経験していると回答した1,647人を対象にした。この集団の中では、一つの期間はおよそ2年にわたって一人の相手への没頭が続き、日常の思考を7日間サンプリングした部分では、その人について考えることが参加者の覚醒時の思考のおよそ半分を占めていた。これらの数字は、すでに自分をその状態にあると考えている人たちを描いたものであって、一般人口の割合ではない。どれほど広く見られるのかは、まだ誰も測っていない。" },
      { type: "p", text: "ネット上では、リメランスは十八か月から三年続くとか、ドーパミンで動いているといった断定も見かける。どちらも確かめると成り立たない。期間の数字はもとの出典にたどり着けず、たどれる資料同士が食い違っている。脳に関する主張のほうは、リメランスではなくロマンティックな恋愛を測った研究に由来するもので、リメランスの脳画像研究は一件も存在しない。" },
      { type: "h2", accent: "green", text: "ここに自分を見つけたなら" },
      { type: "p", text: "診断マニュアルに載っていないことは、その体験が本物でないという意味にはならない。人が語ること — 置いておけない思考、古いメッセージを読み返して消える時間、返事が来たかどうかで上下する気分 — は現実に重い出来事で、「ハマってるだけ」と笑い話にするのは、その代償を見ていないということだ。何か月も続いている、あるいは仕事や睡眠、周りの人との関係に食い込んでいるなら、精神保健の専門家に相談する価値がある。これは体よくページを締めるための一文ではなく、本当の勧めだ。" },
      { type: "p", text: "ひとつ気づいておきたいことがある。リメランスは「分からないこと」を燃料にする。相手が応えてくれるかどうかが開いた問いのままである限り、解釈すべき合図はいつまでも残り、頭はその沈黙を、相手そのものではなく自分の中でこしらえた相手像で埋めていく。Quloは誰かの気持ちを変えるものではないし、ここで何かが治療されるわけでもない。ただ、その仕組みはひとつの具体的な問いから推測を取り除く。相手が実際に出した問いに答え、当たったか、当たらなかったか、それだけだ。関心は読み解くものではなく、試されるものになる。" },
    ],
  },
  ko: {
    term: "리머런스",
    summary:
      "특정한 한 사람을 향한, 의지로 멈출 수 없고 오래 이어지는 집착적 그리움. 대개 그 마음을 돌려주지 않은 사람을 향하며, 머리에서 떠나지 않는 생각과 관심의 증거를 찾아 신호를 끊임없이 해석하는 상태로 나타난다.",
    blocks: [
      { type: "h2", text: "한 단어, 두 개의 정의" },
      { type: "p", text: "이 단어를 두 군데서 찾아보면 서로 다른 답이 나온다. 미국심리학회(APA)의 심리학 사전은 **이미 맺어진 관계 안에서** 상대를 향한 강한 욕구와 몰두를 가리키며, 관계가 시작되고 한두 달이면 잦아드는 시기라고 설명한다. 반면 2021년 이후의 동료 심사 연구가 다루는 것은 전혀 다른 상태다. 마음을 **돌려주지 않은** 사람을 향한, 의지와 무관하고 만성적인 그리움이며, 몇 주가 아니라 몇 년 단위로 이어진다." },
      { type: "p", text: "메리엄웹스터는 두 뜻을 각각 따로 싣는다. 더 나은 출처를 고르면 정리되는 혼동이 아니라, 단어 자체가 실제로 두 의미를 지니고 있다는 뜻이다. 그리고 어느 쪽을 말하는지에 따라 이야기는 완전히 달라진다. 하나는 갓 시작한 관계의 흔한 도취를 가리킨다. 다른 하나는 한 사람의 삶을 통째로 가져갈 수 있는 무언가를 가리키고, 오늘 이 단어를 검색하는 사람들 대부분이 떠올리는 것은 후자다." },
      { type: "h2", text: "이 말은 어디서 왔나" },
      { type: "p", text: "미국 심리학자 도로시 테노프가 만든 말이다. 그는 “사랑에 빠진다는 것은 어떤 느낌인가”를 두고 300건이 넘는 인터뷰를 진행해 개념을 세웠고, 1979년 책 *Love and Limerence*에서 이를 정리했다. 이 단어에는 의도적으로 어원이 없다. 테노프는 아무것도 없는 데서 만들어냈고 “뿌리라고 할 것이 전혀 없다”고 말했다. 활자로는 늦어도 1975년부터 등장하니, 새말처럼 들려도 나이는 오십 년쯤 됐다." },
      { type: "h2", text: "잠깐의 짝사랑과 다른 점" },
      { type: "ul", items: [
        "**고르는 게 아니다.** 겪는 사람들은 그냥 일어난 일이라고 말한다. 때로는 스스로도 어울린다고 생각하지 않는 상대에게.",
        "**저절로 지나가지 않는다.** 짝사랑은 왔다가 간다. 이것은 자리를 잡고 의심을 먹으며 자란다.",
        "**불확실함은 약화가 아니라 강화 요인이다.** 분명한 거절이 애매한 “아마도”보다 오히려 견디기 쉬울 수 있다.",
        "**관심이 한 사람으로 좁아진다.** 유형이나 범주가 아니라 특정한 한 사람이며, 연구 문헌은 그 상대를 “limerent object”라고 부른다.",
      ] },
      { type: "h2", text: "실제로 알려진 것 — 그리 많지 않다" },
      { type: "p", text: "이 단어는 WHO의 질병 분류 ICD-11에 없고, DSM에서도 공식 진단명이 아니다. 이를 연구하는 사람들이 직접 그렇게 쓰고 있으며, 2026년 논문도 진단 기준의 필요성을 여전히 열린 과제로 남겨 두었다. 이를 측정할 타당화된 설문지는 2025년에야 발표됐다. 대중적으로는 어디에나 있는 말이지만, 학문적으로는 아직 작고 어린 분야다." },
      { type: "p", text: "지금까지 가장 큰 연구는 2026년 *Acta Psychologica*에 실렸고, 리머런스를 겪고 있다고 답한 1,647명을 조사했다. 이 집단 안에서 한 시기는 한 사람을 향한 약 2년의 몰두를 포함했고, 일상적인 생각을 7일간 표집한 부분에서는 그 사람을 떠올리는 일이 참가자들이 깨어 있는 동안의 생각 가운데 절반가량을 채웠다. 이 수치는 이미 스스로를 그런 상태로 여기는 사람들을 설명한 것이지 일반 인구의 비율이 아니며, 이것이 얼마나 흔한지는 아무도 측정하지 않았다." },
      { type: "p", text: "인터넷에서는 리머런스가 열여덟 달에서 3년간 지속된다거나 도파민으로 작동한다는 단정적인 문장도 보게 된다. 둘 다 확인을 견디지 못한다. 지속 기간 수치는 어떤 원자료로도 이어지지 않고, 접근 가능한 자료들끼리 서로 어긋난다. 뇌에 관한 주장은 리머런스가 아니라 낭만적 사랑을 측정한 연구에서 온 것이며, 리머런스를 다룬 뇌영상 연구는 단 한 편도 없다." },
      { type: "h2", accent: "green", text: "여기서 자신을 발견했다면" },
      { type: "p", text: "진단 편람에 없다는 사실이 그 경험을 덜 현실적으로 만들지는 않는다. 사람들이 말하는 것 — 내려놓아지지 않는 생각, 옛 메시지를 다시 읽으며 사라지는 시간, 답장이 왔는지에 따라 오르내리는 기분 — 은 실제이고 무거운 일이다. 이를 그저 집착이라는 농담으로 넘기는 건 그 대가를 보지 않는 것이다. 몇 달째 이어지고 있거나 일, 잠, 곁에 있는 사람들에게까지 지장을 주고 있다면 정신건강 전문가를 찾아갈 만하다. 이건 페이지를 정중히 마무리하려는 말이 아니라 진짜 권유다." },
      { type: "p", text: "한 가지는 짚어 둘 만하다. 리머런스는 모른다는 사실을 먹고 자란다. 상대의 마음이 열린 질문으로 남아 있는 한 해석할 신호는 늘 하나 더 생기고, 머릿속은 그 침묵을 그 사람이 아니라 그 사람에 대한 자기 나름의 판본으로 채운다. Qulo가 누군가의 감정을 바꾸지는 않고, 여기서 무엇이 치료되지도 않는다. 다만 그 방식은 아주 구체적인 한 가지 질문에서 추측을 걷어낸다. 상대가 실제로 물은 것에 답하고, 맞혔거나 못 맞혔거나 둘 중 하나다. 관심은 해독하는 것이 아니라 시험되는 것이 된다." },
    ],
  },
  zh: {
    term: "Limerence",
    summary:
      "一种不由自主、久久不散的痴迷式思念，指向某一个特定的人——通常是并未回应这份感情的人——伴随挥之不去的念头，以及为了寻找对方在意的证据而反复解读每一个信号。",
    blocks: [
      { type: "h2", text: "同一个词，两种定义" },
      { type: "p", text: "把这个词查两遍，你会得到两种答案。美国心理学会（APA）的心理学词典把它描述成**在一段已经确立的关系里**对伴侣的强烈渴望与全神贯注，通常在关系成立后一两个月就会淡下去。而 2021 年以来的同行评议研究谈的完全是另一回事：对一个**没有**回应自己的人产生的、不由自主的长期思念，持续的单位是年，而不是周。" },
      { type: "p", text: "《韦氏词典》把两个义项分开收录，所以这不是挑一个更好的来源就能了结的混淆——这个词确实同时承载两种意思。而说的是哪一种，差别极大。一种描述的是一段新关系里再普通不过的沉醉；另一种描述的是可能接管一个人整段生活的东西，而今天绝大多数搜索这个词的人，想说的正是后者。" },
      { type: "h2", text: "这个词从哪里来" },
      { type: "p", text: "它是美国心理学家多萝西·滕诺夫造出来的。她以 300 多次关于“恋爱是什么感觉”的访谈为基础建立了这个概念，并在 1979 年的著作 *Love and Limerence* 中提出。这个词故意没有词源——滕诺夫从零编造了它，说它“根本没有任何词根”。它至少从 1975 年起就出现在印刷品里，所以尽管听上去很新，它其实已经有五十年左右的历史。" },
      { type: "h2", text: "它和一时的心动有什么不同" },
      { type: "ul", items: [
        "**它不是选择来的。** 当事人说的是这件事发生在自己身上，有时对象甚至是自己都不觉得合适的人。",
        "**它不会自己过去。** 一时的心动来了又走；这个会住下来，并开始靠怀疑喂养自己。",
        "**不确定让它更强，而不是更弱。** 一个明确的“不”，往往比一个含糊的“也许”更容易承受。",
        "**注意力收窄到一个人身上。** 不是某一类人，也不是某个类别，而是一个具体的人；研究文献称之为“limerent object”。",
      ] },
      { type: "h2", text: "真正已知的部分——其实很少" },
      { type: "p", text: "这个词没有出现在世界卫生组织的疾病分类 ICD-11 里，在 DSM 中也不是正式诊断；研究它的学者把这一点写得很明白，2026 年的一篇论文仍把“需要诊断标准”列为尚未解决的问题。用来测量它的第一份经过效度检验的问卷，直到 2025 年才发表。在大众语汇里这个词到处都是；在学术上，这还是一个又小又年轻的领域。" },
      { type: "p", text: "迄今规模最大的研究 2026 年发表在 *Acta Psychologica*，调查了 1,647 名自述正在经历 limerence 的人。在这一群体中，一次这样的经历大约伴随两年对同一个人的念念不忘；在为期七天的日常思绪取样里，想到那个人占去了参与者清醒时思考的大约一半。这些数字描述的是本来就认为自己处于这种状态的人——它们不是一般人群的比例，而这件事到底有多普遍，还没有人测量过。" },
      { type: "p", text: "网上也会看到很笃定的说法：limerence 会持续十八个月到三年，或者说它由多巴胺驱动。两种说法都经不起核对。时长那个数字追不到任何原始出处，能查到的资料彼此矛盾；关于大脑的说法则来自测量浪漫爱情、而非 limerence 的研究，针对它本身的脑成像研究一项也没有。" },
      { type: "h2", accent: "green", text: "如果你在这里认出了自己" },
      { type: "p", text: "没有被写进诊断手册，并不会让这段经历变得不真实。人们描述的那些事——放不下的念头、反复重读旧消息而消失的几个小时、随着对方有没有回复而起落的情绪——是真实而沉重的，把它当成“你就是太执着了”的玩笑，就是没有看见它的代价。如果这已经持续了好几个月，或者开始影响你的工作、睡眠和身边的人，那么值得带着它去找精神健康方面的专业人士。这是一句真正的建议，不是把页面客气收尾的话。" },
      { type: "p", text: "有一点值得留意：limerence 靠“不知道”活着。只要对方是否回应还是一个悬着的问题，就永远还有下一个信号可以解读，而脑子会用自己构想出来的那个版本去填满沉默，而不是那个人本身。Qulo 不会改变任何人的感受，这里也不治疗任何东西——但它的机制确实把猜测从一个非常具体的问题里拿走了。你回答的是对方真正问出的问题，答对了，或者没有。兴趣不是被破译的，而是被验证的。" },
    ],
  },
};
