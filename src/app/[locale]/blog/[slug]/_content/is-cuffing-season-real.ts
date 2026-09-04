import type { LocalizedArticle } from "@/components/blog/ArticleBlocks";

/**
 * "Is cuffing season real?" — the seasonal-pairing story, checked against the
 * research it is usually attributed to.
 *
 * ANGLE: every listicle tells this as a single cold-weather surge. The
 * peer-reviewed picture is bimodal and the mechanism is not romance, which is
 * a sharply different claim from the glossary entry at /glossary/cuffing-season
 * (which defines the term) — so the two do not compete for the same intent.
 *
 * SOURCES — all three verified before writing, per the pipeline's first rule:
 *
 *  1. Markey, P. M., & Markey, C. N. (2013). "Seasonal Variation in Internet
 *     Keyword Searches: A Proxy Assessment of Sex Mating Behaviors."
 *     *Archives of Sexual Behavior*, 42(4). Harmonic analysis of five years of
 *     Google keyword searches; a consistent six-month cycle with peaks in
 *     winter AND early summer. This is the load-bearing finding.
 *  2. Pawlowski, B., & Sorokowski, P. (2008). "Men's Attraction to Women's
 *     Bodies Changes Seasonally." *Perception*. 114 heterosexual men rating
 *     images across five seasons; body and breast ratings higher in winter,
 *     face ratings unchanged. The authors attribute it to a contrast effect.
 *     Presented WITH its limits — n=114, one year, one country, men only — not
 *     as proof of anything about relationships.
 *  3. Symul, Hsieh, Shea, Moreno, Skene, Holmes & Martinez, "Unmasking Seasonal
 *     Cycles in Human Fertility" (2020), an analysis of roughly half a million
 *     health-tracking app users. Deliberately cited by author list, scale and
 *     year and NOT by journal: it circulated as a medRxiv preprint and I could
 *     not confirm which venue published it. Do not add a journal name here
 *     without checking it first.
 *
 * CLAIMS DELIBERATELY NOT MADE: no share of people who "cuff", no breakup-rate
 * figure for spring, no hormone mechanism. Every circulating number on this
 * topic traces to a dating company's own marketing, which this site cannot
 * cite, so the post argues from the three studies above and from nothing else.
 *
 * Northern-hemisphere framing is stated as such in the body rather than
 * assumed, because the third source is precisely about the pattern inverting
 * below the equator.
 */
export const isCuffingSeasonReal: LocalizedArticle = {
  tr: [
    {
      "type": "p",
      "text": "Hikâye her sonbahar geliyor. Akşamlar kısalıyor, içimizde kadim bir şey kıpırdıyor ve bekârlar soğuk aylar için çiftleşip ilkbaharda dağılıyor. İyi bir hikâye. Kesinleşmiş bir gerçek gibi tekrarlanıyor. Dayandırıldığı araştırma ise gözle görülür biçimde daha tuhaf bir şey söylüyor."
    },
    {
      "type": "h2",
      "text": "Mevsimin bir değil, iki tepesi var"
    },
    {
      "type": "p",
      "text": "Mevsimsel eşleşmeye dair en çok atıf alan kanıt, Patrick ve Charlotte Markey'nin **Archives of Sexual Behavior** dergisinde yayımlanan 2013 tarihli çalışması. Cinsellik ve eş arayışıyla ilgili Google aramalarının beş yıllık verisinde harmonik analiz yapmışlar ve tutarlı bir döngü bulmuşlar — ama **altı aylık** bir döngü: aramalar kışın ve bir kez de erken yazın tepe yapıyor."
    },
    {
      "type": "p",
      "text": "Bu, cuffing season hikâyesi değil. Soğuk ve yalnızlığın tetiklediği tek bir kış dalgası, yılda tek tepe verirdi. Altı ay arayla iki tepe başka bir şeyi tarif ediyor: birden fazla nedeni olan ve nedenlerinden biri yılın en sıcak dönemine düşen bir ritim."
    },
    {
      "type": "h2",
      "text": "Kış etkisi gerçek, ama reklam edildiğinden küçük"
    },
    {
      "type": "p",
      "text": "Çekicilikle ilgili gerçek bir mevsimsel bulgu var. Boguslaw Pawlowski ve Piotr Sorokowski 2008'de **Perception** dergisinde yayımladıkları çalışmada, 114 heteroseksüel erkeğe aynı görselleri beş mevsim boyunca değerlendirtmişler. Kadın vücutlarına verilen puanlar kışın yazdan yüksek çıkmış. Yüzlere verilen puanlar ise hiç değişmemiş."
    },
    {
      "type": "p",
      "text": "Yazarların kendi açıklaması romantizm değil. Bir **kontrast etkisi** öneriyorlar: insanlar yazın başkalarının vücutlarını çok daha fazla görüyor, çıta yukarı kayıyor ve aynı görsel bu çıtaya karşı daha düşük puan alıyor. Bu algısal bir tuhaflık; eşleşme arzusunun mevsimselliği değil."
    },
    {
      "type": "ul",
      "items": [
        "Fotoğraflara verilen puanları ölçtü; gerçek insanlar hakkındaki kararları değil.",
        "Yüzlerin değerlendirilmesinde hiçbir mevsimsel değişim bulmadı.",
        "114 erkek, tek ülke, tek yıl — bir etkiyi fark etmeye yeter, üzerine mevsim kurmaya yetmez.",
        "Yazarların önerdiği mekanizma alışma; arzu değil."
      ]
    },
    {
      "type": "h2",
      "text": "Sonra yarımküre işi tersine çeviriyor"
    },
    {
      "type": "p",
      "text": "En rahatsız edici kanıt doğum verisinden geliyor. Laurence Symul ve meslektaşlarının yaklaşık yarım milyon sağlık takip uygulaması kullanıcısı üzerinde yaptığı analiz, doğum mevsimselliğini asıl belirleyenin mevsimsel cinsellik değil **mevsimsel doğurganlık** olduğunu buldu; tatiller çevresindeki artış eğride yalnızca küçük tümsekleri açıklıyor. Doğurganlık kuzey yarımkürede sonbahar ekinoksu ile kış gündönümü arasında, güney yarımkürede ise kış gündönümünün hemen ardından tepe yapıyor."
    },
    {
      "type": "p",
      "text": "Bunu cuffing season hikâyesini aklınızda tutarak yeniden okuyun. Desen ekvatorun iki yanında da gündönümünü izliyor; yani aralık ayını, tatilleri ya da yılbaşını izlemiyor. Burada mevsimsel olan şey, insanların yaşadığı takvimi değil gün ışığını takip ediyor."
    },
    {
      "type": "h2",
      "text": "Flört hayatınızda gerçekten mevsimsel olan ne"
    },
    {
      "type": "p",
      "text": "Bunların hiçbiri sonbaharın haziranla aynı hissettirdiği anlamına gelmiyor. Değişen şeyin biyolojiniz değil koşullarınız olduğu anlamına geliyor. Kuzey yarımkürede kış, insanların nerede olduğunu, kimi gördüğünü ve kendilerine ne sorulduğunu yeniden düzenliyor."
    },
    {
      "type": "ul",
      "items": [
        "Planlar iç mekâna taşınıyor; bu da ilk buluşmayı bir yürüyüşten uzun bir şeye dönüştürüyor.",
        "Tatiller, bekâr olmanın başkalarınca gündeme getirildiği bir tarihi takvime yerleştiriyor.",
        "Aile toplantıları soruyu yüksek sesle ve herkesin önünde soruyor.",
        "Programsız uzun akşamlar telefona uzanmayı kolaylaştırıyor."
      ]
    },
    {
      "type": "p",
      "text": "Bu gerçek bir mevsimsel etki ve tamamen toplumsal. Ayrıca hikâyenin ilkbahar yarısını da hiçbir hormondan daha iyi açıklıyor: takvim iki insanı birbirine ittiği için kurulan bir düzen, takvim itmeyi bıraktığında yeniden gözden geçirilmeye eğilimli."
    },
    {
      "type": "h2",
      "text": "Risk mevsim değil, atladığınız şey"
    },
    {
      "type": "p",
      "text": "Mevsimsel bir pencerede başlayan ilişki mahkûm değildir. İyilerinin çoğu, iki insanın aynı soğuk salı gününü boş bulmasıyla başlar. Ters giden şey bundan daha dar: mevsim başlamak için bir sebep veriyor, insanlar da bunu, bu kişiyi gerçekten isteyip istemediğinizi öğrendiğiniz kısmı atlamak için sebep sayıyor."
    },
    {
      "type": "p",
      "text": "Sinyali basit. Biriyle neden konuştuğunuzu havadan, tatillerden ya da haftanızın ne kadar sessiz geçtiğinden bahsetmeden anlatabiliyorsanız, elinizde bir cevap var. Anlatamıyorsanız, elinizde bir mevsim var."
    },
    {
      "type": "h2",
      "text": "Pencereyi değerlendirmek",
      "accent": "green"
    },
    {
      "type": "p",
      "text": "Pratik hamle, mevsim sizin yerinize karar vermeden ne istediğinize karar vermek. Beş yıllık plan değil — haziranda eksikliğini fark edecek kadar belirli olması yeter."
    },
    {
      "type": "ul",
      "items": [
        "Bundan gerçekten istediğiniz bir şeyi, üçüncü haftadan sonra değil ilk mesajdan önce adlandırın.",
        "Cevabını yazın da merak edeceğiniz bir şey sorun.",
        "Birlikte yaptığınız planların sıcak bir ayda boş bir akşamla temasa dayanıp dayanmadığına bakın.",
        "Akrabaların o rahatsız edici sorusunu baskı değil bilgi sayın — size ne istediğinizi soruyor, sadece kötü bir biçimde."
      ]
    },
    {
      "type": "p",
      "text": "Qulo'nun kurulu olduğu kısım da tam burası. Qulo'da kendinizle ilgili 2 ila 4 çoktan seçmeli soru yazıyorsunuz — ücretli planda 10'a kadar — her birinde dört şık var ve doğru cevabı siz işaretliyorsunuz. Biri sizinle ancak hepsini doğru bilerek eşleşiyor. Bu, kimsenin kim olduğunu doğrulamıyor ve uyumu ölçmüyor. Yaptığı şey, ilk filtreyi bir fotoğraftan küçük bir dikkat eylemine taşımak — yani mevsimsel pencerenin insanı atlamaya ayarttığı adımın ta kendisi."
    },
    {
      "type": "quote",
      "text": "Bir mevsim size neden konuşmaya başladığınızı söyleyebilir. Bu kişiyi haziranda da seçer miydiniz, onu söyleyemez. Onu ancak sormaya zahmet ettiğiniz sorular söyler."
    }
  ],
  en: [
    {
      "type": "p",
      "text": "The story arrives every autumn. The evenings get shorter, something ancient stirs, and single people start pairing off for the cold months before drifting apart in spring. It is a good story. It is repeated as settled fact. And the research it gets attributed to says something noticeably stranger."
    },
    {
      "type": "h2",
      "text": "The season has two peaks, not one"
    },
    {
      "type": "p",
      "text": "The most-cited evidence for seasonal mating is a 2013 paper by Patrick and Charlotte Markey in **Archives of Sexual Behavior**. They ran a harmonic analysis over five years of Google keyword searches related to sex and mate-seeking, and found a consistent cycle — but a **six-month** one, with searches peaking in winter and again in early summer."
    },
    {
      "type": "p",
      "text": "That is not the cuffing-season story. A single winter surge driven by cold and loneliness would show one annual peak. Two peaks, half a year apart, describe something else: a rhythm with more than one cause, one of which lands in the warmest part of the year."
    },
    {
      "type": "h2",
      "text": "The winter effect is real, and smaller than advertised"
    },
    {
      "type": "p",
      "text": "There is a genuine seasonal finding about attraction. In 2008 Boguslaw Pawlowski and Piotr Sorokowski published a study in **Perception** in which 114 heterosexual men rated the same images across five seasons. Ratings of women's bodies were higher in winter than in summer. Ratings of faces did not move at all."
    },
    {
      "type": "p",
      "text": "The authors' own explanation is not romance. They propose a **contrast effect**: people see far more of other people's bodies in summer, so the bar drifts upward, and the same image scores lower against it. That is a perceptual quirk, not a seasonal urge to partner up."
    },
    {
      "type": "ul",
      "items": [
        "It measured ratings of photographs, not decisions about real people.",
        "It found no seasonal change at all in how faces were rated.",
        "114 men, one country, one year — enough to notice an effect, not enough to build a season on.",
        "The mechanism the authors propose is habituation, not desire."
      ]
    },
    {
      "type": "h2",
      "text": "Then the hemisphere flips it"
    },
    {
      "type": "p",
      "text": "The most awkward evidence comes from birth data. An analysis by Laurence Symul and colleagues of roughly half a million users of health-tracking apps found that birth seasonality is driven mainly by **seasonal fertility** rather than by seasonal sex — increased activity around holidays explains only minor bumps in the curve. Fertility peaked between the autumn equinox and the winter solstice in the northern hemisphere, and shortly after the winter solstice in the southern."
    },
    {
      "type": "p",
      "text": "Read that again with the cuffing-season story in mind. The pattern tracks the solstice on both sides of the equator, which means it is not tracking December, or the holidays, or the end of the year. Whatever is seasonal here is following daylight, not the calendar people actually live by."
    },
    {
      "type": "h2",
      "text": "What is genuinely seasonal about your dating life"
    },
    {
      "type": "p",
      "text": "None of this means autumn feels the same as June. It means the thing that changes is your circumstances rather than your biology. Winter in the northern hemisphere reorganises where people are, who they see, and what they are asked."
    },
    {
      "type": "ul",
      "items": [
        "Plans move indoors, which turns a first meeting into something longer than a walk.",
        "Holidays put a date on the calendar where being single becomes a topic other people raise.",
        "Family gatherings supply the question, out loud, in front of everyone.",
        "Long evenings with nothing scheduled make a phone easier to reach for."
      ]
    },
    {
      "type": "p",
      "text": "That is a real seasonal effect, and it is entirely social. It also explains the spring half of the story better than any hormone does: an arrangement that formed because the calendar pushed two people together tends to be re-examined when the calendar stops pushing."
    },
    {
      "type": "h2",
      "text": "The risk is not the season. It is what you skipped."
    },
    {
      "type": "p",
      "text": "A relationship that begins in a seasonal window is not doomed. Plenty of good ones start because two people happened to be free on the same cold Tuesday. What goes wrong is narrower than that: the season supplies a reason to start, and people take it as a reason to skip the part where you find out whether you actually want this person."
    },
    {
      "type": "p",
      "text": "The tell is simple. If you can describe why you are talking to someone without mentioning the weather, the holidays, or how quiet your week is, you have an answer. If you cannot, you have a season."
    },
    {
      "type": "h2",
      "text": "Making the window count",
      "accent": "green"
    },
    {
      "type": "p",
      "text": "The practical move is to decide what you want before the season decides for you. Not a five-year plan — just enough specificity that you would notice if it were missing in June."
    },
    {
      "type": "ul",
      "items": [
        "Name one thing you actually want from this, before the first message rather than after the third week.",
        "Ask something you would still care about the answer to in summer.",
        "Notice whether your plans together survive contact with a free evening in a warm month.",
        "Treat the awkward relatives' question as information, not pressure — it is asking you what you want, badly."
      ]
    },
    {
      "type": "p",
      "text": "This is also the part Qulo is built around. On Qulo you write between 2 and 4 multiple-choice questions about yourself — up to 10 on a paid plan — with four options each, and you mark the true answer. Someone matches with you by getting every one of them right. It does not verify who anyone is and it does not measure compatibility. What it does is move the first filter from a photograph to a small act of attention, which is precisely the step a seasonal window tempts people to skip."
    },
    {
      "type": "quote",
      "text": "A season can tell you why you started talking. It cannot tell you whether you would have chosen this person in June. Only the questions you bothered to ask can do that."
    }
  ],
  de: [
    {
      "type": "p",
      "text": "Die Geschichte kommt jeden Herbst. Die Abende werden kürzer, etwas Uraltes regt sich, und Alleinstehende tun sich für die kalten Monate zusammen, um im Frühjahr wieder auseinanderzudriften — auf Englisch heißt das Cuffing Season. Es ist eine gute Geschichte. Sie wird wie eine ausgemachte Sache weitererzählt. Und die Forschung, der sie zugeschrieben wird, sagt etwas merklich Seltsameres."
    },
    {
      "type": "h2",
      "text": "Die Saison hat zwei Spitzen, nicht eine"
    },
    {
      "type": "p",
      "text": "Der meistzitierte Beleg für saisonale Partnersuche ist eine Arbeit von Patrick und Charlotte Markey aus dem Jahr 2013 in **Archives of Sexual Behavior**. Sie führten eine harmonische Analyse über fünf Jahre Google-Suchbegriffe rund um Sex und Partnersuche durch und fanden einen beständigen Zyklus — aber einen **halbjährlichen**: Die Suchanfragen erreichten ihren Höhepunkt im Winter und noch einmal im Frühsommer."
    },
    {
      "type": "p",
      "text": "Das ist nicht die Geschichte der Cuffing Season. Ein einzelner Winterschub, ausgelöst von Kälte und Einsamkeit, ergäbe eine Spitze pro Jahr. Zwei Spitzen im Abstand eines halben Jahres beschreiben etwas anderes: einen Rhythmus mit mehr als einer Ursache, von denen eine in die wärmste Zeit des Jahres fällt."
    },
    {
      "type": "h2",
      "text": "Der Wintereffekt ist real — und kleiner als beworben"
    },
    {
      "type": "p",
      "text": "Es gibt einen echten saisonalen Befund zur Anziehung. 2008 veröffentlichten Boguslaw Pawlowski und Piotr Sorokowski in **Perception** eine Studie, in der 114 heterosexuelle Männer dieselben Bilder über fünf Jahreszeiten hinweg bewerteten. Die Bewertungen weiblicher Körper fielen im Winter höher aus als im Sommer. Die Bewertungen der Gesichter bewegten sich überhaupt nicht."
    },
    {
      "type": "p",
      "text": "Die Erklärung der Autoren selbst hat nichts mit Romantik zu tun. Sie schlagen einen **Kontrasteffekt** vor: Im Sommer sieht man weit mehr von den Körpern anderer Menschen, die Messlatte wandert nach oben, und dasselbe Bild schneidet dagegen schlechter ab. Das ist eine Eigenart der Wahrnehmung, kein saisonaler Drang, sich zu binden."
    },
    {
      "type": "ul",
      "items": [
        "Gemessen wurden Bewertungen von Fotos, nicht Entscheidungen über reale Menschen.",
        "Bei der Bewertung von Gesichtern fand sich überhaupt keine saisonale Veränderung.",
        "114 Männer, ein Land, ein Jahr — genug, um einen Effekt zu bemerken, zu wenig, um darauf eine Saison zu bauen.",
        "Der Mechanismus, den die Autoren vorschlagen, ist Gewöhnung, nicht Verlangen."
      ]
    },
    {
      "type": "h2",
      "text": "Und dann dreht die Erdhalbkugel das Ganze um"
    },
    {
      "type": "p",
      "text": "Der unbequemste Beleg kommt aus Geburtsdaten. Eine Analyse von Laurence Symul und Kollegen mit rund einer halben Million Nutzerinnen und Nutzern von Gesundheits-Apps ergab, dass die Saisonalität der Geburten hauptsächlich von **saisonaler Fruchtbarkeit** getrieben wird und nicht von saisonalem Sex — vermehrte Aktivität rund um die Feiertage erklärt nur kleine Ausschläge in der Kurve. Die Fruchtbarkeit erreichte auf der Nordhalbkugel zwischen Herbst-Tagundnachtgleiche und Wintersonnenwende ihren Höhepunkt, auf der Südhalbkugel kurz nach der Wintersonnenwende."
    },
    {
      "type": "p",
      "text": "Lies das noch einmal mit der Cuffing-Season-Geschichte im Kopf. Das Muster folgt der Sonnenwende auf beiden Seiten des Äquators, das heißt: Es folgt nicht dem Dezember, nicht den Feiertagen, nicht dem Jahresende. Was hier saisonal ist, richtet sich nach dem Tageslicht und nicht nach dem Kalender, in dem Menschen tatsächlich leben."
    },
    {
      "type": "h2",
      "text": "Was an deinem Dating-Leben wirklich saisonal ist"
    },
    {
      "type": "p",
      "text": "Nichts davon heißt, dass sich der Herbst anfühlt wie der Juni. Es heißt, dass sich deine Umstände ändern und nicht deine Biologie. Der Winter auf der Nordhalbkugel ordnet neu, wo Menschen sind, wen sie sehen und was sie gefragt werden."
    },
    {
      "type": "ul",
      "items": [
        "Pläne wandern nach drinnen, was aus einem ersten Treffen etwas Längeres macht als einen Spaziergang.",
        "Die Feiertage setzen ein Datum in den Kalender, an dem Alleinsein zum Thema wird, das andere ansprechen.",
        "Familientreffen liefern die Frage — laut und vor allen.",
        "Lange Abende ohne Programm machen es leichter, zum Telefon zu greifen."
      ]
    },
    {
      "type": "p",
      "text": "Das ist ein echter saisonaler Effekt, und er ist vollständig sozial. Er erklärt außerdem die Frühjahrshälfte der Geschichte besser als jedes Hormon: Eine Verbindung, die entstand, weil der Kalender zwei Menschen zusammengeschoben hat, wird meist noch einmal geprüft, wenn der Kalender aufhört zu schieben."
    },
    {
      "type": "h2",
      "text": "Das Risiko ist nicht die Saison. Es ist das, was du übersprungen hast."
    },
    {
      "type": "p",
      "text": "Eine Beziehung, die in einem saisonalen Fenster beginnt, ist nicht verloren. Viele gute fangen an, weil zwei Menschen am selben kalten Dienstag zufällig frei hatten. Was schiefgeht, ist enger gefasst: Die Saison liefert einen Grund anzufangen, und Menschen nehmen ihn als Grund, den Teil zu überspringen, in dem man herausfindet, ob man diesen Menschen überhaupt will."
    },
    {
      "type": "p",
      "text": "Das Erkennungszeichen ist einfach. Wenn du beschreiben kannst, warum du mit jemandem sprichst, ohne das Wetter, die Feiertage oder die Stille deiner Woche zu erwähnen, hast du eine Antwort. Wenn nicht, hast du eine Jahreszeit."
    },
    {
      "type": "h2",
      "text": "Das Fenster nutzen",
      "accent": "green"
    },
    {
      "type": "p",
      "text": "Der praktische Zug ist, zu entscheiden, was du willst, bevor die Saison es für dich entscheidet. Kein Fünfjahresplan — nur so konkret, dass du es im Juni bemerken würdest, wenn es fehlte."
    },
    {
      "type": "ul",
      "items": [
        "Benenne eine Sache, die du davon wirklich willst — vor der ersten Nachricht und nicht nach der dritten Woche.",
        "Stell eine Frage, deren Antwort dich auch im Sommer noch interessieren würde.",
        "Achte darauf, ob eure gemeinsamen Pläne den Kontakt mit einem freien Abend in einem warmen Monat überstehen.",
        "Nimm die unangenehme Frage der Verwandtschaft als Information und nicht als Druck — sie fragt dich, was du willst, nur ungeschickt."
      ]
    },
    {
      "type": "p",
      "text": "Genau um diesen Punkt herum ist Qulo gebaut. Auf Qulo schreibst du zwischen 2 und 4 Multiple-Choice-Fragen über dich selbst — im kostenpflichtigen Tarif bis zu 10 — mit je vier Antwortmöglichkeiten, und du markierst die richtige Antwort. Jemand matcht mit dir, indem er jede einzelne davon richtig beantwortet. Es überprüft niemandes Identität und es misst keine Kompatibilität. Was es tut: Es verschiebt den ersten Filter von einem Foto zu einem kleinen Akt der Aufmerksamkeit — und genau das ist der Schritt, zu dessen Überspringen ein saisonales Fenster verführt."
    },
    {
      "type": "quote",
      "text": "Eine Jahreszeit kann dir sagen, warum ihr angefangen habt zu reden. Sie kann dir nicht sagen, ob du diesen Menschen auch im Juni gewählt hättest. Das können nur die Fragen, die du dir die Mühe gemacht hast zu stellen."
    }
  ],
  fr: [
    {
      "type": "p",
      "text": "L'histoire revient chaque automne. Les soirées raccourcissent, quelque chose d'ancien s'agite, et les célibataires se mettent en couple pour les mois froids avant de s'éloigner au printemps — c'est ce que l'anglais appelle la cuffing season. C'est une bonne histoire. On la répète comme un fait établi. Et la recherche à laquelle on l'attribue dit quelque chose de nettement plus étrange."
    },
    {
      "type": "h2",
      "text": "La saison a deux pics, pas un"
    },
    {
      "type": "p",
      "text": "La preuve la plus citée d'un accouplement saisonnier est un article de 2013 signé Patrick et Charlotte Markey dans **Archives of Sexual Behavior**. Ils ont mené une analyse harmonique sur cinq années de recherches Google liées au sexe et à la quête d'un partenaire, et ont trouvé un cycle constant — mais un cycle de **six mois**, avec des pics en hiver puis de nouveau au début de l'été."
    },
    {
      "type": "p",
      "text": "Ce n'est pas l'histoire de la cuffing season. Une poussée hivernale unique, provoquée par le froid et la solitude, donnerait un seul pic annuel. Deux pics séparés de six mois décrivent autre chose : un rythme à plusieurs causes, dont l'une tombe au moment le plus chaud de l'année."
    },
    {
      "type": "h2",
      "text": "L'effet hiver est réel, et plus petit qu'annoncé"
    },
    {
      "type": "p",
      "text": "Il existe bien un résultat saisonnier sur l'attirance. En 2008, Boguslaw Pawlowski et Piotr Sorokowski ont publié dans **Perception** une étude où 114 hommes hétérosexuels notaient les mêmes images au fil de cinq saisons. Les notes attribuées aux corps féminins étaient plus élevées en hiver qu'en été. Celles attribuées aux visages n'ont pas bougé du tout."
    },
    {
      "type": "p",
      "text": "L'explication avancée par les auteurs eux-mêmes n'a rien de romantique. Ils proposent un **effet de contraste** : on voit bien plus le corps des autres en été, le repère se déplace vers le haut, et la même image obtient une note plus basse par comparaison. C'est une bizarrerie de la perception, pas une envie saisonnière de se mettre en couple."
    },
    {
      "type": "ul",
      "items": [
        "L'étude mesurait des notes attribuées à des photographies, pas des décisions concernant de vraies personnes.",
        "Elle n'a trouvé aucune variation saisonnière dans la façon dont les visages étaient notés.",
        "114 hommes, un pays, une année : de quoi repérer un effet, pas de quoi bâtir une saison.",
        "Le mécanisme proposé par les auteurs est l'accoutumance, pas le désir."
      ]
    },
    {
      "type": "h2",
      "text": "Puis l'hémisphère inverse tout"
    },
    {
      "type": "p",
      "text": "La preuve la plus embarrassante vient des données de naissances. Une analyse menée par Laurence Symul et ses collègues sur environ un demi-million d'utilisateurs d'applications de suivi de santé a montré que la saisonnalité des naissances est surtout portée par la **fertilité saisonnière** plutôt que par une sexualité saisonnière : le regain d'activité autour des fêtes n'explique que de petites bosses sur la courbe. La fertilité culminait entre l'équinoxe d'automne et le solstice d'hiver dans l'hémisphère nord, et peu après le solstice d'hiver dans l'hémisphère sud."
    },
    {
      "type": "p",
      "text": "Relisez cela en gardant l'histoire de la cuffing season en tête. Le motif suit le solstice des deux côtés de l'équateur, ce qui veut dire qu'il ne suit ni décembre, ni les fêtes, ni la fin de l'année. Ce qui est saisonnier ici suit la lumière du jour, pas le calendrier dans lequel les gens vivent réellement."
    },
    {
      "type": "h2",
      "text": "Ce qui est vraiment saisonnier dans votre vie amoureuse"
    },
    {
      "type": "p",
      "text": "Rien de tout cela ne signifie que l'automne ressemble au mois de juin. Cela signifie que ce qui change, ce sont vos circonstances et non votre biologie. Dans l'hémisphère nord, l'hiver réorganise où sont les gens, qui ils voient et ce qu'on leur demande."
    },
    {
      "type": "ul",
      "items": [
        "Les projets rentrent à l'intérieur, ce qui transforme une première rencontre en quelque chose de plus long qu'une promenade.",
        "Les fêtes inscrivent au calendrier une date où être célibataire devient un sujet que les autres soulèvent.",
        "Les réunions de famille fournissent la question, à voix haute, devant tout le monde.",
        "Les longues soirées sans rien de prévu rendent le téléphone plus facile à attraper."
      ]
    },
    {
      "type": "p",
      "text": "C'est un vrai effet saisonnier, et il est entièrement social. Il explique aussi la moitié printanière de l'histoire mieux que ne le fait aucune hormone : un arrangement né parce que le calendrier a rapproché deux personnes a tendance à être réexaminé quand le calendrier cesse de pousser."
    },
    {
      "type": "h2",
      "text": "Le risque, ce n'est pas la saison. C'est ce que vous avez sauté."
    },
    {
      "type": "p",
      "text": "Une relation qui commence dans une fenêtre saisonnière n'est pas condamnée. Beaucoup de belles histoires démarrent parce que deux personnes se sont trouvées libres le même mardi glacial. Ce qui déraille est plus étroit que cela : la saison fournit une raison de commencer, et on la prend pour une raison de sauter le moment où l'on découvre si l'on veut vraiment de cette personne."
    },
    {
      "type": "p",
      "text": "Le signe est simple. Si vous pouvez expliquer pourquoi vous parlez à quelqu'un sans mentionner la météo, les fêtes ou le vide de votre semaine, vous avez une réponse. Sinon, vous avez une saison."
    },
    {
      "type": "h2",
      "text": "Faire compter la fenêtre",
      "accent": "green"
    },
    {
      "type": "p",
      "text": "Le geste pratique consiste à décider ce que vous voulez avant que la saison ne le décide pour vous. Pas un plan sur cinq ans — juste assez précis pour que son absence vous saute aux yeux au mois de juin."
    },
    {
      "type": "ul",
      "items": [
        "Nommez une chose que vous voulez vraiment de tout cela, avant le premier message plutôt qu'après la troisième semaine.",
        "Posez une question dont la réponse vous intéresserait encore en été.",
        "Regardez si vos projets communs survivent à une soirée libre pendant un mois chaud.",
        "Prenez la question gênante de la famille pour une information et non pour une pression : elle vous demande ce que vous voulez, très maladroitement."
      ]
    },
    {
      "type": "p",
      "text": "C'est aussi le point autour duquel Qulo est construit. Sur Qulo, vous écrivez entre 2 et 4 questions à choix multiples sur vous-même — jusqu'à 10 avec un abonnement payant — chacune avec quatre options, et vous marquez la bonne réponse. Quelqu'un matche avec vous en répondant correctement à toutes. Cela ne vérifie l'identité de personne et cela ne mesure aucune compatibilité. Ce que cela fait, c'est déplacer le premier filtre d'une photographie vers un petit acte d'attention — précisément l'étape qu'une fenêtre saisonnière donne envie de sauter."
    },
    {
      "type": "quote",
      "text": "Une saison peut vous dire pourquoi vous avez commencé à vous parler. Elle ne peut pas vous dire si vous auriez choisi cette personne au mois de juin. Seules les questions que vous avez pris la peine de poser le peuvent."
    }
  ],
  es: [
    {
      "type": "p",
      "text": "La historia llega cada otoño. Las tardes se acortan, algo antiguo se remueve y quienes están solteros se emparejan para los meses fríos antes de separarse en primavera: es lo que en inglés se llama cuffing season, una expresión nacida en los inviernos del norte. Es una buena historia. Se repite como si fuera un hecho cerrado. Y la investigación a la que se le atribuye dice algo bastante más raro."
    },
    {
      "type": "h2",
      "text": "La temporada tiene dos picos, no uno"
    },
    {
      "type": "p",
      "text": "La prueba más citada sobre el apareamiento estacional es un artículo de 2013 de Patrick y Charlotte Markey en **Archives of Sexual Behavior**. Hicieron un análisis armónico sobre cinco años de búsquedas de Google relacionadas con el sexo y la búsqueda de pareja, y encontraron un ciclo constante, pero un ciclo de **seis meses**: las búsquedas alcanzaban su pico en invierno y otra vez a principios del verano."
    },
    {
      "type": "p",
      "text": "Esa no es la historia de la cuffing season. Un único repunte invernal provocado por el frío y la soledad daría un solo pico al año. Dos picos separados por medio año describen otra cosa: un ritmo con más de una causa, y una de ellas cae en la parte más cálida del año."
    },
    {
      "type": "h2",
      "text": "El efecto invierno es real, y más pequeño de lo anunciado"
    },
    {
      "type": "p",
      "text": "Sí existe un hallazgo estacional sobre la atracción. En 2008, Boguslaw Pawlowski y Piotr Sorokowski publicaron en **Perception** un estudio en el que 114 hombres heterosexuales puntuaron las mismas imágenes a lo largo de cinco estaciones. Las puntuaciones de los cuerpos de mujeres fueron más altas en invierno que en verano. Las de las caras no se movieron en absoluto."
    },
    {
      "type": "p",
      "text": "La explicación de los propios autores no es romántica. Proponen un **efecto de contraste**: en verano se ven muchos más cuerpos ajenos, el listón sube y la misma imagen puntúa más bajo frente a él. Es una rareza de la percepción, no un impulso estacional de emparejarse."
    },
    {
      "type": "ul",
      "items": [
        "Midió puntuaciones de fotografías, no decisiones sobre personas reales.",
        "No encontró ningún cambio estacional en la forma de puntuar las caras.",
        "114 hombres, un país, un año: suficiente para notar un efecto, no para levantar una temporada encima.",
        "El mecanismo que proponen los autores es la habituación, no el deseo."
      ]
    },
    {
      "type": "h2",
      "text": "Y entonces el hemisferio le da la vuelta"
    },
    {
      "type": "p",
      "text": "La prueba más incómoda viene de los datos de nacimientos. Un análisis de Laurence Symul y sus colegas sobre cerca de medio millón de usuarios de apps de seguimiento de salud encontró que la estacionalidad de los nacimientos la impulsa sobre todo la **fertilidad estacional** y no el sexo estacional: el aumento de actividad alrededor de las fiestas solo explica pequeños bultos en la curva. La fertilidad alcanzó su pico entre el equinoccio de otoño y el solsticio de invierno en el hemisferio norte, y poco después del solsticio de invierno en el hemisferio sur."
    },
    {
      "type": "p",
      "text": "Vuelve a leerlo con la historia de la cuffing season en mente. El patrón sigue al solsticio a ambos lados del ecuador, lo que significa que no sigue a diciembre, ni a las fiestas, ni al final del año. Lo que aquí es estacional sigue a la luz del día y no al calendario que la gente vive de verdad."
    },
    {
      "type": "h2",
      "text": "Qué es de verdad estacional en tu vida amorosa"
    },
    {
      "type": "p",
      "text": "Nada de esto significa que el otoño se sienta igual que el verano. Significa que lo que cambia son tus circunstancias y no tu biología. En el hemisferio norte, el invierno reorganiza dónde está la gente, a quién ve y qué le preguntan."
    },
    {
      "type": "ul",
      "items": [
        "Los planes se meten puertas adentro, y eso convierte un primer encuentro en algo más largo que un paseo.",
        "Las fiestas ponen en el calendario una fecha en la que estar soltero se vuelve un tema que sacan los demás.",
        "Las reuniones familiares aportan la pregunta, en voz alta y delante de todos.",
        "Las noches largas sin nada planeado hacen que sea más fácil echar mano del teléfono."
      ]
    },
    {
      "type": "p",
      "text": "Ese sí es un efecto estacional real, y es enteramente social. Además explica la mitad primaveral de la historia mejor que cualquier hormona: un arreglo que se formó porque el calendario juntó a dos personas tiende a revisarse cuando el calendario deja de empujar."
    },
    {
      "type": "h2",
      "text": "El riesgo no es la temporada. Es lo que te saltaste."
    },
    {
      "type": "p",
      "text": "Una relación que empieza en una ventana estacional no está condenada. Muchas buenas empiezan porque dos personas coincidieron libres el mismo martes frío. Lo que sale mal es más estrecho que eso: la temporada da un motivo para empezar, y la gente lo toma como motivo para saltarse la parte en la que averiguas si de verdad quieres a esta persona."
    },
    {
      "type": "p",
      "text": "La señal es simple. Si puedes explicar por qué estás hablando con alguien sin mencionar el tiempo, las fiestas o lo tranquila que está tu semana, tienes una respuesta. Si no puedes, tienes una temporada."
    },
    {
      "type": "h2",
      "text": "Aprovechar la ventana",
      "accent": "green"
    },
    {
      "type": "p",
      "text": "La jugada práctica es decidir qué quieres antes de que lo decida la temporada por ti. No un plan a cinco años: solo lo bastante concreto como para que notaras su falta en pleno verano."
    },
    {
      "type": "ul",
      "items": [
        "Nombra una cosa que de verdad quieras de esto, antes del primer mensaje y no después de la tercera semana.",
        "Pregunta algo cuya respuesta te seguiría importando en verano.",
        "Fíjate en si los planes en común sobreviven al contacto con una noche libre en un mes cálido.",
        "Toma la pregunta incómoda de tus parientes como información y no como presión: te está preguntando qué quieres, solo que mal."
      ]
    },
    {
      "type": "p",
      "text": "Esta es también la parte alrededor de la cual está construido Qulo. En Qulo escribes entre 2 y 4 preguntas de opción múltiple sobre ti —hasta 10 con un plan de pago—, cada una con cuatro opciones, y marcas la respuesta verdadera. Alguien hace match contigo acertándolas todas. No verifica la identidad de nadie y no mide compatibilidad. Lo que hace es mover el primer filtro de una fotografía a un pequeño acto de atención, que es justo el paso que una ventana estacional tienta a saltarse."
    },
    {
      "type": "quote",
      "text": "Una temporada puede decirte por qué empezaste a hablar con alguien. No puede decirte si habrías elegido a esta persona en pleno verano. Eso solo lo dicen las preguntas que te molestaste en hacer."
    }
  ],
  ar: [
    {
      "type": "p",
      "text": "تعود الحكاية كل خريف. تقصر الأمسيات، ويتحرّك شيء قديم في الداخل، ويبدأ العزّاب في الارتباط لأشهر البرد قبل أن يفترقوا في الربيع. هذا ما تسميه الإنجليزية cuffing season، أي موسم الارتباط المؤقت. حكاية جيدة، تُكرَّر بوصفها حقيقة مستقرة. أما البحث الذي تُنسب إليه فيقول شيئًا أغرب بوضوح."
    },
    {
      "type": "h2",
      "text": "للموسم قمّتان لا قمّة واحدة"
    },
    {
      "type": "p",
      "text": "أكثر الأدلة استشهادًا على موسمية البحث عن شريك دراسة نشرها باتريك وشارلوت ماركي عام 2013 في **Archives of Sexual Behavior**. أجريا تحليلًا توافقيًا على خمس سنوات من عمليات البحث في Google المتعلقة بالجنس والبحث عن شريك، فوجدا دورة ثابتة — لكنها دورة **من ستة أشهر**، إذ تبلغ عمليات البحث ذروتها شتاءً ثم مرة أخرى في مطلع الصيف."
    },
    {
      "type": "p",
      "text": "هذه ليست حكاية موسم الارتباط المؤقت. موجة شتوية واحدة يحرّكها البرد والوحدة كانت ستُظهر ذروة واحدة في السنة. أما ذروتان تفصل بينهما ستة أشهر فتصفان شيئًا آخر: إيقاعًا له أكثر من سبب، وأحد أسبابه يقع في أشد أوقات السنة حرارة."
    },
    {
      "type": "h2",
      "text": "أثر الشتاء حقيقي، وأصغر مما يُروَّج له"
    },
    {
      "type": "p",
      "text": "ثمة نتيجة موسمية حقيقية تتعلق بالانجذاب. ففي عام 2008 نشر بوغوسلاف بافلوفسكي وبيوتر سوروكوفسكي دراسة في **Perception** قيّم فيها 114 رجلًا غيريًا الصور نفسها عبر خمسة فصول. جاءت الدرجات الممنوحة لأجساد النساء أعلى في الشتاء منها في الصيف، بينما لم تتحرّك درجات الوجوه إطلاقًا."
    },
    {
      "type": "p",
      "text": "تفسير الباحثَين نفسيهما ليس رومانسيًا. يقترحان **أثر التباين**: في الصيف يرى الناس أجساد الآخرين أكثر بكثير، فترتفع العتبة من تلقاء نفسها، وتحصل الصورة ذاتها على درجة أدنى مقارنة بها. هذه خصوصية في الإدراك، لا رغبة موسمية في الارتباط."
    },
    {
      "type": "ul",
      "items": [
        "قاست درجات ممنوحة لصور فوتوغرافية، لا قرارات تخص أشخاصًا حقيقيين.",
        "لم تجد أي تغيّر موسمي على الإطلاق في تقييم الوجوه.",
        "114 رجلًا، وبلد واحد، وسنة واحدة — يكفي لملاحظة أثر، ولا يكفي لبناء موسم كامل عليه.",
        "الآلية التي يقترحها الباحثان هي الاعتياد، لا الرغبة."
      ]
    },
    {
      "type": "h2",
      "text": "ثم يقلب نصف الكرة الأمر رأسًا على عقب"
    },
    {
      "type": "p",
      "text": "أشد الأدلة إحراجًا يأتي من بيانات المواليد. فقد وجد تحليل أجراه لورانس سيمول وزملاؤه لنحو نصف مليون مستخدم لتطبيقات تتبّع الصحة أن موسمية المواليد تحرّكها في المقام الأول **الخصوبة الموسمية** لا الجنس الموسمي؛ والنشاط المتزايد حول الأعياد لا يفسّر سوى نتوءات صغيرة في المنحنى. وبلغت الخصوبة ذروتها بين الاعتدال الخريفي والانقلاب الشتوي في نصف الكرة الشمالي، وبُعيد الانقلاب الشتوي في نصف الكرة الجنوبي."
    },
    {
      "type": "p",
      "text": "أعد قراءة هذا وحكاية موسم الارتباط المؤقت في ذهنك. النمط يتبع الانقلاب الشمسي على جانبي خط الاستواء، أي أنه لا يتبع ديسمبر ولا الأعياد ولا نهاية السنة. ما هو موسمي هنا يتبع ضوء النهار، لا التقويم الذي يعيش الناس وفقه فعلًا."
    },
    {
      "type": "h2",
      "text": "ما هو موسمي حقًا في حياتك العاطفية"
    },
    {
      "type": "p",
      "text": "لا شيء من هذا يعني أن الخريف يشبه يونيو في الإحساس. بل يعني أن ما يتغيّر هو ظروفك لا بيولوجيتك. الشتاء في نصف الكرة الشمالي يعيد ترتيب أين يكون الناس، ومن يرون، وما الذي يُسألون عنه."
    },
    {
      "type": "ul",
      "items": [
        "تنتقل الخطط إلى الداخل، فيتحول اللقاء الأول إلى شيء أطول من نزهة.",
        "تضع الأعياد في التقويم تاريخًا يصبح فيه كونك أعزب موضوعًا يطرحه الآخرون.",
        "توفّر اجتماعات العائلة السؤال نفسه، بصوت عالٍ وأمام الجميع.",
        "الأمسيات الطويلة التي لا شيء فيها مجدول تجعل الوصول إلى الهاتف أسهل."
      ]
    },
    {
      "type": "p",
      "text": "هذا أثر موسمي حقيقي، وهو اجتماعي بالكامل. وهو يفسّر أيضًا النصف الربيعي من الحكاية أفضل من أي هرمون: ترتيب نشأ لأن التقويم دفع شخصين أحدهما نحو الآخر يميل إلى إعادة النظر فيه حين يتوقف التقويم عن الدفع."
    },
    {
      "type": "h2",
      "text": "الخطر ليس الموسم، بل ما تخطّيته"
    },
    {
      "type": "p",
      "text": "العلاقة التي تبدأ في نافذة موسمية ليست محكومة بالفشل. كثير من العلاقات الجيدة بدأ لأن شخصين صادف أنهما كانا فارغَين في الثلاثاء البارد نفسه. أما ما يسير على نحو خاطئ فأضيق من ذلك: الموسم يوفّر سببًا للبدء، فيأخذه الناس سببًا لتخطّي الجزء الذي تكتشف فيه إن كنت تريد هذا الشخص فعلًا."
    },
    {
      "type": "p",
      "text": "العلامة بسيطة. إن استطعت أن تصف لماذا تتحدث إلى أحدهم دون ذكر الطقس أو الأعياد أو مدى هدوء أسبوعك، فلديك إجابة. وإن لم تستطع، فلديك موسم."
    },
    {
      "type": "h2",
      "text": "استثمار هذه النافذة",
      "accent": "green"
    },
    {
      "type": "p",
      "text": "الخطوة العملية أن تقرّر ما تريده قبل أن يقرّر الموسم عنك. ليست خطة لخمس سنوات — بل قدرًا من التحديد يكفي لتلاحظ غيابه في يونيو."
    },
    {
      "type": "ul",
      "items": [
        "سمِّ شيئًا واحدًا تريده فعلًا من هذا، قبل الرسالة الأولى لا بعد الأسبوع الثالث.",
        "اطرح سؤالًا ستظل إجابته تهمّك في الصيف.",
        "لاحظ ما إذا كانت خططكما معًا تصمد أمام أمسية فارغة في شهر حار.",
        "تعامل مع سؤال الأقارب المحرج بوصفه معلومة لا ضغطًا — فهو يسألك عمّا تريده، لكن بطريقة سيئة."
      ]
    },
    {
      "type": "p",
      "text": "وهذا تحديدًا ما بُني Qulo حوله. في Qulo تكتب عن نفسك من 2 إلى 4 أسئلة اختيار من متعدد — وحتى 10 أسئلة في الخطة المدفوعة — بأربعة خيارات لكل سؤال، وتحدّد أنت الإجابة الصحيحة. ولا يتطابق معك أحد إلا بالإجابة عنها جميعًا إجابة صحيحة. وهو لا يتحقق من هوية أحد ولا يقيس التوافق. ما يفعله أنه ينقل الفلتر الأول من صورة فوتوغرافية إلى فعل انتباه صغير — وهي بالضبط الخطوة التي تغري النافذة الموسمية بتخطّيها."
    },
    {
      "type": "quote",
      "text": "قد يخبرك الموسم لماذا بدأتما الحديث. لكنه لا يخبرك إن كنت ستختار هذا الشخص في يونيو. لا يقول ذلك سوى الأسئلة التي تجشّمت عناء طرحها."
    }
  ],
  ru: [
    {
      "type": "p",
      "text": "Эта история возвращается каждую осень. Вечера укорачиваются, что-то древнее шевелится, и одинокие люди начинают сходиться на холодные месяцы, чтобы весной снова разойтись. Это и есть каффинг-сезон, от английского cuffing season: быть к кому-то пристёгнутым до весны. История хорошая. Её повторяют как установленный факт. А исследования, которым её приписывают, говорят нечто заметно более странное."
    },
    {
      "type": "h2",
      "text": "У сезона два пика, а не один"
    },
    {
      "type": "p",
      "text": "Самое цитируемое свидетельство сезонности в поиске пары — работа Патрика и Шарлотты Марки 2013 года в **Archives of Sexual Behavior**. Они провели гармонический анализ пяти лет поисковых запросов в Google, связанных с сексом и поиском партнёра, и нашли устойчивый цикл — но **шестимесячный**, с пиками запросов зимой и ещё раз в начале лета."
    },
    {
      "type": "p",
      "text": "Это не история про каффинг-сезон. Одна зимняя волна, вызванная холодом и одиночеством, дала бы один пик в году. Два пика с разницей в полгода описывают другое: ритм, у которого больше одной причины, и одна из них приходится на самую тёплую часть года."
    },
    {
      "type": "h2",
      "text": "Зимний эффект реален и меньше, чем его рекламируют"
    },
    {
      "type": "p",
      "text": "Настоящая сезонная находка о привлекательности всё же есть. В 2008 году Богуслав Павловский и Пётр Сороковский опубликовали в **Perception** исследование, в котором 114 гетеросексуальных мужчин оценивали одни и те же изображения на протяжении пяти сезонов. Оценки женских тел зимой оказались выше, чем летом. Оценки лиц не сдвинулись вовсе."
    },
    {
      "type": "p",
      "text": "Объяснение самих авторов далеко от романтики. Они предлагают **эффект контраста**: летом люди видят чужие тела гораздо чаще, планка сама собой поднимается, и то же изображение получает на её фоне меньше. Это особенность восприятия, а не сезонное желание с кем-то сойтись."
    },
    {
      "type": "ul",
      "items": [
        "Измеряли оценки фотографий, а не решения о живых людях.",
        "Никакой сезонной разницы в оценках лиц не нашлось вообще.",
        "114 мужчин, одна страна, один год — достаточно, чтобы заметить эффект, и мало, чтобы построить на этом целый сезон.",
        "Механизм, который предлагают авторы, — привыкание, а не влечение."
      ]
    },
    {
      "type": "h2",
      "text": "А потом полушарие всё переворачивает"
    },
    {
      "type": "p",
      "text": "Самое неудобное свидетельство приходит из данных о рождаемости. Анализ Лоранса Симюля с коллегами примерно по полумиллиону пользователей приложений для отслеживания здоровья показал, что сезонность рождений определяется главным образом **сезонной фертильностью**, а не сезонным сексом: рост активности вокруг праздников объясняет лишь небольшие бугорки на кривой. Фертильность достигала пика между осенним равноденствием и зимним солнцестоянием в северном полушарии и вскоре после зимнего солнцестояния в южном."
    },
    {
      "type": "p",
      "text": "Перечитайте это, держа в голове историю про каффинг-сезон. Узор следует за солнцестоянием по обе стороны экватора, а значит, он следует не за декабрём, не за праздниками и не за концом года. То, что здесь действительно сезонно, идёт за дневным светом, а не за календарём, по которому люди живут."
    },
    {
      "type": "h2",
      "text": "Что в вашей личной жизни сезонно на самом деле"
    },
    {
      "type": "p",
      "text": "Ничто из этого не означает, что осень ощущается так же, как июнь. Означает лишь, что меняются ваши обстоятельства, а не ваша биология. Зима в северном полушарии перестраивает то, где люди находятся, кого они видят и о чём их спрашивают."
    },
    {
      "type": "ul",
      "items": [
        "Планы уходят в помещения, и первая встреча превращается во что-то более долгое, чем прогулка.",
        "Праздники ставят в календаре дату, к которой быть одному становится темой, которую поднимают другие.",
        "Семейные застолья подают тот самый вопрос вслух и при всех.",
        "Долгие вечера, в которых ничего не запланировано, делают телефон ближе к руке."
      ]
    },
    {
      "type": "p",
      "text": "Это реальный сезонный эффект, и он целиком социальный. Он же объясняет весеннюю половину истории лучше любого гормона: договорённость, возникшая потому, что календарь свёл двоих, обычно пересматривается, когда календарь перестаёт давить."
    },
    {
      "type": "h2",
      "text": "Риск не в сезоне. Риск в том, что вы пропустили."
    },
    {
      "type": "p",
      "text": "Отношения, начавшиеся в сезонном окне, не обречены. Множество хороших начались потому, что двое случайно оказались свободны в один и тот же холодный вторник. Ломается кое-что более узкое: сезон даёт повод начать, а люди принимают это за повод пропустить ту часть, где выясняется, нужен ли вам этот человек вообще."
    },
    {
      "type": "p",
      "text": "Признак простой. Если вы можете объяснить, почему разговариваете с человеком, не упоминая погоду, праздники и то, насколько пуста ваша неделя, — у вас есть ответ. Если не можете, у вас есть сезон."
    },
    {
      "type": "h2",
      "text": "Как не потратить это окно впустую",
      "accent": "green"
    },
    {
      "type": "p",
      "text": "Практичный ход — решить, чего вы хотите, до того как сезон решит за вас. Не план на пять лет, а ровно столько конкретики, чтобы вы заметили её отсутствие в июне."
    },
    {
      "type": "ul",
      "items": [
        "Назовите одну вещь, которую вы действительно хотите от этого, до первого сообщения, а не после третьей недели.",
        "Задайте вопрос, ответ на который был бы вам важен и летом.",
        "Посмотрите, выдержат ли ваши общие планы встречу со свободным вечером в тёплом месяце.",
        "Отнеситесь к неловкому вопросу родственников как к информации, а не к давлению: он спрашивает, чего вы хотите, просто делает это плохо."
      ]
    },
    {
      "type": "p",
      "text": "Именно вокруг этого и построен Qulo. На Qulo вы пишете о себе от 2 до 4 вопросов с вариантами ответа — до 10 на платном тарифе — по четыре варианта в каждом, и сами отмечаете верный. Совпадение случается, только когда человек отвечает правильно на все. Это не подтверждает, кто есть кто, и не измеряет совместимость. Оно лишь переносит первый фильтр с фотографии на маленькое усилие внимания — ровно тот шаг, пропустить который и подталкивает сезонное окно."
    },
    {
      "type": "quote",
      "text": "Сезон может сказать вам, почему вы начали разговор. Он не скажет, выбрали бы вы этого человека в июне. Это могут сказать только вопросы, которые вы дали себе труд задать."
    }
  ],
  pt: [
    {
      "type": "p",
      "text": "A história volta todo outono no hemisfério norte: as noites encurtam, algo ancestral se mexe e os solteiros começam a formar pares para atravessar os meses frios, antes de se afastarem na primavera. É a chamada cuffing season — do inglês cuff, algema: ficar preso a alguém durante o frio. É uma boa história. Repetida como fato consolidado. E a pesquisa a que costumam atribuí-la diz algo bem mais estranho."
    },
    {
      "type": "h2",
      "text": "A temporada tem dois picos, não um"
    },
    {
      "type": "p",
      "text": "A evidência mais citada para o acasalamento sazonal é um artigo de 2013 de Patrick e Charlotte Markey na **Archives of Sexual Behavior**. Eles rodaram uma análise harmônica sobre cinco anos de buscas no Google ligadas a sexo e à procura de parceiro e encontraram um ciclo consistente — mas de **seis meses**, com as buscas atingindo pico no inverno e de novo no começo do verão."
    },
    {
      "type": "p",
      "text": "Essa não é a história da cuffing season. Uma única onda de inverno movida por frio e solidão mostraria um pico por ano. Dois picos, separados por meio ano, descrevem outra coisa: um ritmo com mais de uma causa, e uma delas cai na parte mais quente do ano."
    },
    {
      "type": "h2",
      "text": "O efeito do inverno é real, e menor do que anunciam"
    },
    {
      "type": "p",
      "text": "Existe um achado sazonal genuíno sobre atração. Em 2008, Boguslaw Pawlowski e Piotr Sorokowski publicaram na **Perception** um estudo em que 114 homens heterossexuais avaliaram as mesmas imagens ao longo de cinco estações. As notas dadas aos corpos das mulheres foram mais altas no inverno do que no verão. As notas dadas aos rostos não se moveram nada."
    },
    {
      "type": "p",
      "text": "A explicação dos próprios autores não tem nada de romântica. Eles propõem um **efeito de contraste**: no verão as pessoas veem muito mais o corpo das outras, então a régua sobe e a mesma imagem pontua menos contra ela. Isso é uma esquisitice da percepção, não um impulso sazonal de formar par."
    },
    {
      "type": "ul",
      "items": [
        "Mediu notas dadas a fotografias, não decisões sobre pessoas reais.",
        "Não encontrou nenhuma mudança sazonal na avaliação dos rostos.",
        "São 114 homens, um país, um ano — o bastante para notar um efeito, não para fundar uma temporada.",
        "O mecanismo que os autores propõem é habituação, não desejo."
      ]
    },
    {
      "type": "h2",
      "text": "Aí o hemisfério inverte tudo"
    },
    {
      "type": "p",
      "text": "A evidência mais incômoda vem dos dados de nascimento. Uma análise de Laurence Symul e colegas, com cerca de meio milhão de usuários de aplicativos de monitoramento de saúde, concluiu que a sazonalidade dos nascimentos é conduzida sobretudo pela **fertilidade sazonal**, e não por sexo sazonal — o aumento de atividade em torno das festas explica apenas pequenas saliências na curva. A fertilidade teve pico entre o equinócio de outono e o solstício de inverno no hemisfério norte, e logo depois do solstício de inverno no hemisfério sul."
    },
    {
      "type": "p",
      "text": "Releia isso com a história da cuffing season na cabeça. O padrão acompanha o solstício dos dois lados do equador, o que significa que ele não está acompanhando dezembro, nem as festas, nem o fim do ano. O que há de sazonal aqui segue a luz do dia, e não o calendário em que as pessoas de fato vivem."
    },
    {
      "type": "h2",
      "text": "O que é de fato sazonal na sua vida amorosa"
    },
    {
      "type": "p",
      "text": "Nada disso quer dizer que o outono seja igual a junho — e vale deixar claro de qual junho se fala aqui: o do hemisfério norte, onde junho é verão. A estação descrita neste texto não é a sua. O que muda são as circunstâncias, não a biologia. O inverno do hemisfério norte reorganiza onde as pessoas estão, quem elas veem e o que perguntam a elas."
    },
    {
      "type": "ul",
      "items": [
        "Os programas vão para dentro de casa, o que transforma um primeiro encontro em algo mais longo do que uma caminhada.",
        "As festas marcam no calendário uma data em que estar solteiro vira assunto levantado pelos outros.",
        "As reuniões de família fornecem a pergunta, em voz alta, na frente de todo mundo.",
        "Noites longas sem nada marcado deixam o celular mais fácil de alcançar."
      ]
    },
    {
      "type": "p",
      "text": "Esse é um efeito sazonal real, e é inteiramente social. Ele também explica a metade primaveril da história melhor do que qualquer hormônio: um arranjo que se formou porque o calendário empurrou duas pessoas uma para a outra tende a ser reexaminado quando o calendário para de empurrar."
    },
    {
      "type": "h2",
      "text": "O risco não é a temporada. É o que você pulou."
    },
    {
      "type": "p",
      "text": "Uma relação que começa numa janela sazonal não está condenada. Muita coisa boa começa porque duas pessoas por acaso estavam livres na mesma terça-feira fria. O que dá errado é mais estreito do que isso: a temporada fornece um motivo para começar, e as pessoas tomam isso como motivo para pular a parte em que se descobre se você quer mesmo essa pessoa."
    },
    {
      "type": "p",
      "text": "O sinal é simples. Se você consegue explicar por que está falando com alguém sem mencionar o tempo, as festas ou o quanto sua semana está vazia, você tem uma resposta. Se não consegue, você tem uma temporada."
    },
    {
      "type": "h2",
      "text": "Aproveitar a janela",
      "accent": "green"
    },
    {
      "type": "p",
      "text": "A jogada prática é decidir o que você quer antes que a temporada decida por você. Não um plano de cinco anos — só especificidade suficiente para você notar a falta em junho."
    },
    {
      "type": "ul",
      "items": [
        "Dê nome a uma coisa que você realmente quer disso, antes da primeira mensagem e não depois da terceira semana.",
        "Faça uma pergunta cuja resposta ainda te interessaria no verão.",
        "Repare se os planos de vocês dois sobrevivem ao contato com uma noite livre num mês quente.",
        "Trate a pergunta constrangedora dos parentes como informação, não como pressão — ela está perguntando o que você quer, só que mal."
      ]
    },
    {
      "type": "p",
      "text": "Essa é também a parte em torno da qual o Qulo foi construído. No Qulo você escreve de 2 a 4 perguntas de múltipla escolha sobre você mesmo — até 10 num plano pago — com quatro alternativas cada, e marca a resposta verdadeira. Alguém dá match com você acertando todas elas. Isso não verifica quem ninguém é e não mede compatibilidade. O que faz é mover o primeiro filtro de uma fotografia para um pequeno ato de atenção, que é exatamente o passo que uma janela sazonal tenta a pessoa a pular."
    },
    {
      "type": "quote",
      "text": "Uma temporada pode dizer por que vocês começaram a conversar. Não pode dizer se você teria escolhido essa pessoa em junho. Só as perguntas que você se deu ao trabalho de fazer conseguem isso."
    }
  ],
  it: [
    {
      "type": "p",
      "text": "La storia arriva ogni autunno. Le sere si accorciano, qualcosa di antico si muove e chi è single si accoppia per i mesi freddi, per poi allontanarsi in primavera: è quella che in inglese si chiama cuffing season. È una bella storia. Viene ripetuta come un fatto acquisito. E la ricerca a cui viene attribuita dice qualcosa di decisamente più strano."
    },
    {
      "type": "h2",
      "text": "La stagione ha due picchi, non uno"
    },
    {
      "type": "p",
      "text": "La prova più citata sull'accoppiamento stagionale è un articolo del 2013 di Patrick e Charlotte Markey su **Archives of Sexual Behavior**. Hanno condotto un'analisi armonica su cinque anni di ricerche su Google legate al sesso e alla ricerca di un partner, e hanno trovato un ciclo costante — ma di **sei mesi**, con picchi in inverno e di nuovo all'inizio dell'estate."
    },
    {
      "type": "p",
      "text": "Non è la storia della cuffing season. Un'unica ondata invernale spinta dal freddo e dalla solitudine darebbe un solo picco all'anno. Due picchi a sei mesi di distanza descrivono altro: un ritmo con più di una causa, e una di queste cade nel periodo più caldo dell'anno."
    },
    {
      "type": "h2",
      "text": "L'effetto inverno è reale, e più piccolo di come viene venduto"
    },
    {
      "type": "p",
      "text": "Un risultato stagionale sull'attrazione esiste davvero. Nel 2008 Boguslaw Pawlowski e Piotr Sorokowski hanno pubblicato su **Perception** uno studio in cui 114 uomini eterosessuali hanno valutato le stesse immagini nell'arco di cinque stagioni. I punteggi dati ai corpi femminili erano più alti in inverno che in estate. Quelli dati ai volti non si sono mossi affatto."
    },
    {
      "type": "p",
      "text": "La spiegazione degli autori stessi non è romantica. Propongono un **effetto contrasto**: d'estate si vedono molti più corpi altrui, l'asticella si alza e la stessa immagine, confrontata con quella, prende un voto più basso. È una stranezza percettiva, non una spinta stagionale a mettersi insieme."
    },
    {
      "type": "ul",
      "items": [
        "Ha misurato voti dati a fotografie, non decisioni su persone reali.",
        "Non ha trovato alcuna variazione stagionale nel modo in cui venivano valutati i volti.",
        "114 uomini, un paese, un anno: abbastanza per notare un effetto, non abbastanza per costruirci sopra una stagione.",
        "Il meccanismo proposto dagli autori è l'abitudine, non il desiderio."
      ]
    },
    {
      "type": "h2",
      "text": "Poi l'emisfero ribalta tutto"
    },
    {
      "type": "p",
      "text": "La prova più scomoda arriva dai dati sulle nascite. Un'analisi di Laurence Symul e colleghi su circa mezzo milione di utenti di app per il monitoraggio della salute ha rilevato che la stagionalità delle nascite dipende soprattutto dalla **fertilità stagionale** e non dal sesso stagionale: l'aumento di attività attorno alle feste spiega solo piccoli rialzi nella curva. La fertilità raggiungeva il picco tra l'equinozio d'autunno e il solstizio d'inverno nell'emisfero nord, e poco dopo il solstizio d'inverno in quello sud."
    },
    {
      "type": "p",
      "text": "Rileggilo tenendo a mente la storia della cuffing season. Lo schema segue il solstizio da entrambi i lati dell'equatore, il che significa che non sta seguendo dicembre, né le feste, né la fine dell'anno. Ciò che qui è stagionale segue la luce del giorno e non il calendario in cui le persone vivono davvero."
    },
    {
      "type": "h2",
      "text": "Che cosa è davvero stagionale nella tua vita sentimentale"
    },
    {
      "type": "p",
      "text": "Niente di tutto questo significa che l'autunno sia uguale a giugno. Significa che a cambiare sono le tue circostanze e non la tua biologia. Nell'emisfero nord l'inverno riorganizza dove stanno le persone, chi vedono e che cosa viene chiesto loro."
    },
    {
      "type": "ul",
      "items": [
        "I programmi si spostano al chiuso, e questo trasforma un primo incontro in qualcosa di più lungo di una passeggiata.",
        "Le feste mettono in calendario una data in cui essere single diventa un argomento che tirano fuori gli altri.",
        "I pranzi di famiglia forniscono la domanda, ad alta voce, davanti a tutti.",
        "Le lunghe serate senza niente in programma rendono più facile allungare la mano verso il telefono."
      ]
    },
    {
      "type": "p",
      "text": "Questo è un effetto stagionale vero, ed è del tutto sociale. Spiega anche la metà primaverile della storia meglio di qualsiasi ormone: un accordo nato perché il calendario ha spinto due persone l'una verso l'altra tende a essere riesaminato quando il calendario smette di spingere."
    },
    {
      "type": "h2",
      "text": "Il rischio non è la stagione. È quello che hai saltato."
    },
    {
      "type": "p",
      "text": "Una relazione che comincia in una finestra stagionale non è condannata. Tante di quelle belle nascono perché due persone si sono trovate libere lo stesso martedì freddo. Quello che va storto è più circoscritto: la stagione offre un motivo per iniziare, e le persone lo prendono come motivo per saltare la parte in cui scopri se questa persona la vuoi davvero."
    },
    {
      "type": "p",
      "text": "Il segnale è semplice. Se riesci a spiegare perché stai parlando con qualcuno senza tirare in ballo il tempo, le feste o quanto è silenziosa la tua settimana, hai una risposta. Se non ci riesci, hai una stagione."
    },
    {
      "type": "h2",
      "text": "Far valere la finestra",
      "accent": "green"
    },
    {
      "type": "p",
      "text": "La mossa pratica è decidere che cosa vuoi prima che decida la stagione al posto tuo. Non un piano quinquennale: solo abbastanza preciso da accorgertene, a giugno, se non ci fosse."
    },
    {
      "type": "ul",
      "items": [
        "Dai un nome a una cosa che vuoi davvero da tutto questo, prima del primo messaggio e non dopo la terza settimana.",
        "Fai una domanda la cui risposta ti interesserebbe ancora d'estate.",
        "Guarda se i programmi che fate insieme reggono l'urto di una serata libera in un mese caldo.",
        "Prendi la domanda imbarazzante dei parenti come informazione e non come pressione: ti sta chiedendo che cosa vuoi, solo che lo fa male."
      ]
    },
    {
      "type": "p",
      "text": "È anche il punto attorno a cui è costruito Qulo. Su Qulo scrivi da 2 a 4 domande a scelta multipla su di te — fino a 10 con un piano a pagamento — ciascuna con quattro opzioni, e sei tu a segnare la risposta giusta. Qualcuno fa match con te rispondendo correttamente a tutte. Non verifica l'identità di nessuno e non misura la compatibilità. Quello che fa è spostare il primo filtro da una fotografia a un piccolo atto di attenzione, cioè esattamente il passaggio che una finestra stagionale spinge a saltare."
    },
    {
      "type": "quote",
      "text": "Una stagione può dirti perché avete iniziato a parlarvi. Non può dirti se avresti scelto questa persona a giugno. Quello lo dicono soltanto le domande che ti sei preso la briga di fare."
    }
  ],
  ja: [
    {
      "type": "p",
      "text": "その話は毎年、秋になると回ってきます。日が短くなり、私たちの中で何か古いものが動きだし、ひとりで平気だった人たちが寒い数か月のために誰かとくっつき、春になるとまた離れていく——英語で cuffing season、日本語でもカフィングシーズンと呼ばれる、あの話です。よくできた話です。すでに決着のついた事実のように繰り返されます。そして、その根拠とされている研究のほうは、目に見えて奇妙なことを言っています。"
    },
    {
      "type": "h2",
      "text": "この季節の山は、ひとつではなくふたつ"
    },
    {
      "type": "p",
      "text": "季節と求愛行動の関係について最もよく引用される根拠は、Patrick Markey と Charlotte Markey が2013年に **Archives of Sexual Behavior** で発表した論文です。二人は、性や相手探しに関連する Google の検索キーワード五年分に調和解析をかけ、一貫した周期を見つけました。ただしそれは**六か月**の周期で、検索は冬に山を迎え、初夏にもう一度山を迎えていたのです。"
    },
    {
      "type": "p",
      "text": "これはカフィングシーズンの話ではありません。寒さと孤独が押し上げる冬のひと波なら、年に一度の山として現れるはずです。半年ずれた二つの山が描いているのは別のものです。原因がひとつではないリズム、しかもそのうちの一つが、一年でいちばん暑い時期に落ちるリズムです。"
    },
    {
      "type": "h2",
      "text": "冬の効果は本物、ただし宣伝より小さい"
    },
    {
      "type": "p",
      "text": "魅力の感じ方については、本物の季節的な知見があります。2008年、Boguslaw Pawlowski と Piotr Sorokowski は **Perception** に研究を発表しました。114人の異性愛男性が、同じ画像を五つの季節にわたって評価するというものです。女性の身体に対する評価は、夏よりも冬のほうが高くなりました。顔に対する評価は、まったく動きませんでした。"
    },
    {
      "type": "p",
      "text": "著者たち自身の説明はロマンスではありません。彼らが提案するのは**対比効果**です。夏は他人の身体を目にする機会がはるかに多いので基準が上へ動き、同じ画像がその基準に対して低い点をつけられる。これは知覚のくせであって、誰かとくっつきたくなる季節の衝動ではありません。"
    },
    {
      "type": "ul",
      "items": [
        "測ったのは写真への評価であって、実在の相手についての判断ではありません。",
        "顔の評価には、季節による変化がまったく見つかりませんでした。",
        "114人の男性、一つの国、一年間——効果に気づくには足りますが、その上に季節を建てるには足りません。",
        "著者たちが提案する仕組みは慣れであって、欲望ではありません。"
      ]
    },
    {
      "type": "h2",
      "text": "そこへ半球がひっくり返す"
    },
    {
      "type": "p",
      "text": "いちばん具合の悪い根拠は、出生データから出てきます。Laurence Symul らが健康管理アプリの利用者およそ五十万人を分析したところ、出生の季節性を主に動かしているのは季節ごとの性行動ではなく、**季節による妊娠しやすさ**でした。休暇の前後に性行動が増えることは、曲線のわずかな膨らみを説明するにとどまります。妊娠しやすさは、北半球では秋分から冬至のあいだに、南半球では冬至の少しあとに山を迎えていました。"
    },
    {
      "type": "p",
      "text": "カフィングシーズンの話を頭に置いて、もう一度読んでみてください。このパターンは赤道の両側で冬至を追いかけています。つまり、十二月を追いかけているのでも、休暇シーズンを追いかけているのでも、年の終わりを追いかけているのでもありません。ここで季節的なのは日照であって、人が実際に生きているカレンダーではないのです。"
    },
    {
      "type": "h2",
      "text": "あなたの恋愛で、本当に季節的なもの"
    },
    {
      "type": "p",
      "text": "以上のどれも、秋が六月と同じに感じられるという意味ではありません。変わるのはあなたの生理ではなく、あなたの状況だという意味です。北半球の冬は、人がどこにいるか、誰と会うか、そして何を尋ねられるかを組み替えます。"
    },
    {
      "type": "ul",
      "items": [
        "予定が屋内に移り、初対面が散歩より長い時間になります。",
        "クリスマスや年末年始は、ひとりでいることが他人の話題になる日をカレンダーに置きます。",
        "帰省先の集まりが、その質問を声に出して、みんなの前で差し出します。",
        "予定の入っていない長い夜は、スマホに手を伸ばしやすくします。"
      ]
    },
    {
      "type": "p",
      "text": "これは本物の季節効果で、しかも完全に社会的なものです。そしてこの話の春の側についても、どんなホルモンよりうまく説明してくれます。カレンダーが二人を押し合わせたからできた関係は、カレンダーが押すのをやめたときに見直されやすいのです。"
    },
    {
      "type": "h2",
      "text": "危ないのは季節ではなく、飛ばした部分"
    },
    {
      "type": "p",
      "text": "季節の窓のなかで始まった関係が、それだけで駄目になるわけではありません。良い関係の多くは、二人が同じ寒い火曜日にたまたま空いていたから始まっています。うまくいかなくなるのは、もっと狭い一点です。季節は始める理由をくれる。そして人はそれを、この相手を本当に望んでいるのかを確かめる部分を飛ばしてよい理由として受け取ってしまうのです。"
    },
    {
      "type": "p",
      "text": "見分け方は簡単です。その人と話している理由を、天気にも、年末年始にも、自分の一週間がどれだけ静かかにも触れずに説明できるなら、あなたの手元にあるのは答えです。説明できないなら、手元にあるのは季節です。"
    },
    {
      "type": "h2",
      "text": "その窓を活かすために",
      "accent": "green"
    },
    {
      "type": "p",
      "text": "現実的な一手は、季節があなたの代わりに決めてしまう前に、自分が何を望むのかを決めておくことです。五年計画は要りません。六月にそれが欠けていたら気づく、その程度に具体的であれば十分です。"
    },
    {
      "type": "ul",
      "items": [
        "ここから本当に得たいものを一つ、三週目のあとではなく最初のメッセージの前に、言葉にしておきます。",
        "夏になっても答えが気になるような質問を、ひとつします。",
        "二人の予定が、暖かい月の空いた夜と接触しても生き残るかどうかを見ます。",
        "親戚のあの気まずい質問を、圧力ではなく情報として扱います。下手なやり方ではあれ、あなたが何を望むのかを尋ねているのですから。"
      ]
    },
    {
      "type": "p",
      "text": "Qulo が組み立てられているのも、まさにこの部分です。Qulo では、自分について2問から4問の選択式の質問を書きます——有料プランなら最大10問まで——それぞれに四つの選択肢を用意し、正解はあなた自身が印をつけます。相手はそのすべてに正解して、はじめてあなたとマッチします。これは誰かが誰であるかを検証しませんし、相性を測りもしません。するのは、最初のふるいを写真から小さな注意の行為へ移すことだけです。そしてそれこそ、季節の窓が人に飛ばさせたくなる、あの一歩なのです。"
    },
    {
      "type": "quote",
      "text": "季節は、なぜ話し始めたのかを教えてくれます。けれど、六月でもこの人を選んだかどうかは教えてくれません。それを教えられるのは、あなたが手間をかけて尋ねた質問だけです。"
    }
  ],
  ko: [
    {
      "type": "p",
      "text": "이 이야기는 해마다 가을이면 돌아옵니다. 저녁이 짧아지고, 안에서 아주 오래된 무언가가 꿈틀거리고, 혼자서도 잘 지내던 사람들이 추운 몇 달을 위해 짝을 지었다가 봄이 되면 다시 흩어진다는 이야기 — 영어로 cuffing season, 우리말로는 커핑 시즌이라고 부르는 그것입니다. 잘 만들어진 이야기입니다. 이미 결론이 난 사실처럼 반복됩니다. 그런데 정작 근거로 지목되는 연구는 눈에 띄게 더 이상한 말을 합니다."
    },
    {
      "type": "h2",
      "text": "봉우리는 하나가 아니라 둘입니다"
    },
    {
      "type": "p",
      "text": "계절과 짝짓기를 잇는 근거로 가장 많이 인용되는 것은 Patrick Markey와 Charlotte Markey가 2013년 **Archives of Sexual Behavior**에 실은 논문입니다. 두 사람은 성과 상대 찾기에 관련된 구글 검색어 5년치에 조화 분석을 돌려 일관된 주기를 찾아냈습니다. 다만 그것은 **여섯 달**짜리 주기였고, 검색은 겨울에 한 번, 초여름에 다시 한 번 정점을 찍었습니다."
    },
    {
      "type": "p",
      "text": "이건 커핑 시즌 이야기가 아닙니다. 추위와 외로움이 밀어 올린 겨울의 물결 하나였다면 연간 정점은 하나로 나타났을 것입니다. 반년 간격의 두 정점은 다른 것을 그립니다. 원인이 하나가 아닌 리듬, 그리고 그 원인 가운데 하나는 일 년 중 가장 더운 시기에 떨어지는 리듬입니다."
    },
    {
      "type": "h2",
      "text": "겨울 효과는 실재하지만, 광고보다 작습니다"
    },
    {
      "type": "p",
      "text": "끌림에 관한 진짜 계절적 발견이 하나 있습니다. 2008년 Boguslaw Pawlowski와 Piotr Sorokowski는 **Perception**에 연구를 발표했습니다. 이성애자 남성 114명이 같은 이미지를 다섯 계절에 걸쳐 평가한 연구입니다. 여성의 몸에 대한 평가는 여름보다 겨울에 높았습니다. 얼굴에 대한 평가는 전혀 움직이지 않았습니다."
    },
    {
      "type": "p",
      "text": "저자들 자신의 설명은 낭만이 아닙니다. 그들이 내놓은 것은 **대비 효과**입니다. 여름에는 다른 사람의 몸을 훨씬 많이 보게 되니 기준선이 위로 밀려 올라가고, 같은 이미지가 그 기준에 견주어 낮은 점수를 받는다는 것입니다. 이것은 지각의 버릇이지, 짝을 지으려는 계절의 충동이 아닙니다."
    },
    {
      "type": "ul",
      "items": [
        "사진에 매긴 점수를 측정했을 뿐, 실제 사람에 대한 결정을 측정한 것이 아닙니다.",
        "얼굴을 평가하는 방식에서는 계절에 따른 변화가 전혀 나오지 않았습니다.",
        "남성 114명, 한 나라, 한 해 — 어떤 효과를 알아차리기에는 충분하지만, 그 위에 계절 하나를 세우기에는 부족합니다.",
        "저자들이 제시한 기제는 익숙해짐이지 욕망이 아닙니다."
      ]
    },
    {
      "type": "h2",
      "text": "그다음, 반구가 이야기를 뒤집습니다"
    },
    {
      "type": "p",
      "text": "가장 곤란한 근거는 출생 데이터에서 나옵니다. Laurence Symul과 동료들이 건강 기록 앱 이용자 약 50만 명을 분석한 결과, 출생의 계절성을 주로 움직이는 것은 계절에 따른 성관계가 아니라 **계절에 따른 임신 가능성**이었습니다. 연휴 무렵에 늘어나는 성적 활동은 곡선의 작은 융기만 설명할 뿐입니다. 임신 가능성은 북반구에서는 추분과 동지 사이에, 남반구에서는 동지 직후에 정점에 이르렀습니다."
    },
    {
      "type": "p",
      "text": "커핑 시즌 이야기를 염두에 두고 이 대목을 다시 읽어 보세요. 이 패턴은 적도의 양쪽에서 모두 동지를 따라갑니다. 다시 말해 12월을 따라가는 것도, 연말 연휴를 따라가는 것도, 한 해의 끝을 따라가는 것도 아닙니다. 여기서 계절을 타는 것은 사람들이 실제로 살아가는 달력이 아니라 햇빛입니다."
    },
    {
      "type": "h2",
      "text": "당신의 연애에서 정말로 계절을 타는 것"
    },
    {
      "type": "p",
      "text": "이 가운데 어느 것도 가을이 6월과 똑같이 느껴진다는 뜻은 아닙니다. 바뀌는 것이 생물학이 아니라 상황이라는 뜻입니다. 북반구의 겨울은 사람들이 어디에 있는지, 누구를 만나는지, 그리고 어떤 질문을 받는지를 다시 배치합니다."
    },
    {
      "type": "ul",
      "items": [
        "약속이 실내로 옮겨 가고, 그래서 첫 만남이 산책보다 긴 무언가가 됩니다.",
        "크리스마스와 연말은 혼자라는 사실이 남들이 꺼내는 화제가 되는 날짜를 달력에 박아 둡니다.",
        "가족이 모이는 자리는 그 질문을 소리 내어, 모두가 보는 앞에서 건넵니다.",
        "아무 일정도 없는 긴 저녁은 휴대폰에 손이 가기 쉽게 만듭니다."
      ]
    },
    {
      "type": "p",
      "text": "이것은 진짜 계절 효과이고, 전적으로 사회적인 효과입니다. 게다가 이 이야기의 봄쪽 절반도 어떤 호르몬보다 잘 설명해 줍니다. 달력이 두 사람을 밀어붙여서 생긴 관계는, 달력이 밀기를 멈출 때 다시 검토되기 마련이니까요."
    },
    {
      "type": "h2",
      "text": "위험한 것은 계절이 아니라, 당신이 건너뛴 부분입니다"
    },
    {
      "type": "p",
      "text": "계절이라는 창 안에서 시작된 관계라고 해서 끝이 정해진 것은 아닙니다. 좋은 관계 상당수는 두 사람이 같은 추운 화요일에 마침 시간이 비어서 시작됐습니다. 잘못되는 지점은 그보다 훨씬 좁습니다. 계절은 시작할 이유를 건네주는데, 사람들은 그것을 이 사람을 정말 원하는지 확인하는 대목을 건너뛸 이유로 받아들입니다."
    },
    {
      "type": "p",
      "text": "신호는 간단합니다. 지금 이 사람과 왜 이야기하고 있는지를 날씨도, 연말도, 이번 주가 얼마나 한가한지도 꺼내지 않고 설명할 수 있다면, 당신에게는 답이 있습니다. 설명할 수 없다면, 당신에게 있는 것은 계절입니다."
    },
    {
      "type": "h2",
      "text": "계절이라는 창을 살리려면",
      "accent": "green"
    },
    {
      "type": "p",
      "text": "현실적인 수는 계절이 당신 대신 결정하기 전에 당신이 원하는 것을 정해 두는 것입니다. 5개년 계획을 세우라는 말이 아닙니다. 6월에 그것이 없으면 알아차릴 만큼만 구체적이면 충분합니다."
    },
    {
      "type": "ul",
      "items": [
        "여기서 정말 원하는 것 하나를, 셋째 주가 지난 뒤가 아니라 첫 메시지를 보내기 전에 말로 정해 두세요.",
        "여름에도 답이 궁금할 만한 질문을 하나 던지세요.",
        "함께 세운 계획이 따뜻한 달의 한가한 저녁과 부딪히고도 살아남는지 지켜보세요.",
        "친척들의 그 불편한 질문을 압박이 아니라 정보로 받아들이세요. 서툴게 묻고 있을 뿐, 당신이 무엇을 원하는지를 묻는 질문이니까요."
      ]
    },
    {
      "type": "p",
      "text": "Qulo가 바로 이 대목을 중심으로 만들어졌습니다. Qulo에서는 자신에 대한 객관식 질문을 2개에서 4개까지 쓰고, 유료 플랜에서는 최대 10개까지 쓸 수 있으며, 각 질문에는 보기가 네 개이고 정답은 본인이 표시합니다. 상대는 그 전부를 맞혀야만 당신과 매칭됩니다. 이것은 누가 누구인지 검증하지 않고, 궁합을 재지도 않습니다. 하는 일은 첫 번째 필터를 사진에서 작은 주의의 행위로 옮기는 것뿐이고, 그것이야말로 계절이라는 창이 사람들에게 건너뛰라고 부추기는 바로 그 단계입니다."
    },
    {
      "type": "quote",
      "text": "계절은 당신이 왜 이야기를 시작했는지 알려 줄 수 있습니다. 하지만 6월에도 이 사람을 골랐을지는 알려 주지 못합니다. 그것을 알려 줄 수 있는 것은 당신이 수고를 들여 물어본 질문뿐입니다."
    }
  ],
  zh: [
    {
      "type": "p",
      "text": "这个故事每年入秋都会回来一次。天黑得越来越早，身体里某种古老的东西开始动，本来一个人过得挺好的人开始凑成对熬过冷天，等春天一到又各自散开——英文里叫 cuffing season，中文常说抱团过冬期。这是个好故事。它被当成板上钉钉的事实反复讲。而那些被拿来给它背书的研究，说的其实是另一件明显更奇怪的事。"
    },
    {
      "type": "h2",
      "text": "这个季节有两个高峰，不是一个"
    },
    {
      "type": "p",
      "text": "关于季节与择偶，被引用最多的证据是 Patrick Markey 与 Charlotte Markey 2013 年发表在 **Archives of Sexual Behavior** 上的一篇论文。他们对五年间与性和找对象有关的谷歌搜索关键词做了调和分析，找到了一个稳定的周期——但那是一个**六个月**的周期：搜索量在冬天冲上一个高峰，初夏又冲上一个。"
    },
    {
      "type": "p",
      "text": "这不是抱团过冬期的故事。如果只是寒冷和孤独推出来的一波冬季高潮，一年里应该只出现一个高峰。相隔半年的两个高峰描述的是另一种东西：一种原因不止一个的节律，而其中一个原因，恰好落在一年里最热的时候。"
    },
    {
      "type": "h2",
      "text": "冬天的效应是真的，但比宣传的小"
    },
    {
      "type": "p",
      "text": "关于吸引力，确实有一个真实的季节性发现。2008 年，Boguslaw Pawlowski 与 Piotr Sorokowski 在 **Perception** 上发表了一项研究：114 名异性恋男性在五个季节里对同一批图片打分。对女性身体的评分，冬天高于夏天。对面孔的评分，完全没有动。"
    },
    {
      "type": "p",
      "text": "作者自己给出的解释与浪漫无关。他们提出的是**对比效应**：夏天人们看到别人身体的机会多得多，标准因此被抬高，同一张图片放在这个标准下就得分更低。这是知觉上的一个小毛病，不是想要成双成对的季节性冲动。"
    },
    {
      "type": "ul",
      "items": [
        "它测的是人对照片的评分，不是人对真实对象做出的决定。",
        "在面孔的评分上，它没有找到任何季节性变化。",
        "114 名男性、一个国家、一年时间——足够注意到一个效应，不足以在上面盖起一整个季节。",
        "作者提出的机制是习惯化，不是欲望。"
      ]
    },
    {
      "type": "h2",
      "text": "然后，半球把它整个翻了过来"
    },
    {
      "type": "p",
      "text": "最难堪的证据来自出生数据。Laurence Symul 和同事分析了大约五十万名健康记录应用的使用者，发现出生的季节性主要由**季节性的受孕能力**推动，而不是由季节性的性行为推动——节假日前后增多的性行为只能解释曲线上很小的隆起。在北半球，受孕能力的高峰落在秋分与冬至之间；在南半球，落在冬至之后不久。"
    },
    {
      "type": "p",
      "text": "把抱团过冬期的故事放在心里，再读一遍上面这段。这个规律在赤道两边都跟着冬至走，也就是说，它跟的不是十二月，不是节假日，也不是年底。这里真正随季节走的是日照，而不是人们实际过日子的那本日历。"
    },
    {
      "type": "h2",
      "text": "你的感情生活里，真正随季节变的是什么"
    },
    {
      "type": "p",
      "text": "以上这些都不表示秋天和六月感觉一样。它表示变的是你的处境，而不是你的生理。北半球的冬天重新安排了人在哪里、见到谁，以及会被问到什么。"
    },
    {
      "type": "ul",
      "items": [
        "约会挪进室内，于是第一次见面变成比散一圈步长得多的一段时间。",
        "节假日在日历上钉下一个日子，让一个人过成为别人主动提起的话题。",
        "亲戚聚在一起时，那个问题会被当众、出声地问出来。",
        "什么都没安排的漫长夜晚，让人更容易伸手去拿手机。"
      ]
    },
    {
      "type": "p",
      "text": "这是一个真实的季节效应，而且完全是社会性的。它也比任何激素都更好地解释了这个故事的春天那一半：因为日历把两个人推到一起才形成的关系，往往会在日历停止推动的时候被重新掂量。"
    },
    {
      "type": "h2",
      "text": "有风险的不是季节，是你跳过的那一步"
    },
    {
      "type": "p",
      "text": "在季节这扇窗里开始的关系，并不注定失败。很多好关系的起点，只是两个人恰好在同一个寒冷的星期二都有空。真正出问题的地方要窄得多：季节给了你一个开始的理由，而人们把它当成了跳过那一步的理由——跳过弄清楚自己到底是不是真的想要这个人。"
    },
    {
      "type": "p",
      "text": "分辨的方法很简单。如果你能说清楚自己为什么在跟这个人聊天，而不用提天气、不用提节假日、不用提这一周有多空，那你手上有的是一个答案。如果说不清楚，你手上有的是一个季节。"
    },
    {
      "type": "h2",
      "text": "把这扇窗用出价值",
      "accent": "green"
    },
    {
      "type": "p",
      "text": "实际的做法，是在季节替你做决定之前，先决定自己想要什么。不需要五年计划——具体到六月里少了它你会察觉，就够了。"
    },
    {
      "type": "ul",
      "items": [
        "把你真正想从这段关系里得到的一件事说出来，在第一条消息之前，而不是第三周之后。",
        "问一个到了夏天你依然在乎答案的问题。",
        "看看你们一起定下的计划，撞上暖和月份里一个空出来的晚上，还能不能活下来。",
        "把亲戚那句让人尴尬的追问当成信息，而不是压力——它问的其实是你想要什么，只是问得很笨。"
      ]
    },
    {
      "type": "p",
      "text": "这也正是 Qulo 围绕着搭起来的那一部分。在 Qulo 上，你为自己写 2 到 4 道选择题，付费方案最多可以写 10 道，每道四个选项，正确答案由你自己标出。别人要全部答对，才能和你配对。它不会核实任何人是谁，也不会衡量合不合适。它做的只是把第一道筛选从一张照片挪到一个小小的注意力动作上——而那恰好就是季节这扇窗最容易诱人跳过的一步。"
    },
    {
      "type": "quote",
      "text": "季节可以告诉你，你们为什么开始说话。它没法告诉你，如果换到六月，你还会不会选这个人。能回答这一点的，只有你肯花力气问出口的那些问题。"
    }
  ],
  nl: [
    {
      "type": "p",
      "text": "Het verhaal komt elk najaar terug. De avonden worden korter, er roert zich iets oerouds, en singles vormen koppels voor de koude maanden om in het voorjaar weer uit elkaar te drijven — in het Engels heet dat cuffing season. Het is een goed verhaal. Het wordt herhaald als vaststaand feit. En het onderzoek waaraan het wordt toegeschreven zegt iets merkbaar vreemders."
    },
    {
      "type": "h2",
      "text": "Het seizoen heeft twee pieken, niet één"
    },
    {
      "type": "p",
      "text": "Het meest geciteerde bewijs voor seizoensgebonden partnerkeuze is een artikel uit 2013 van Patrick en Charlotte Markey in **Archives of Sexual Behavior**. Ze voerden een harmonische analyse uit op vijf jaar aan Google-zoekopdrachten rond seks en het zoeken van een partner, en vonden een consistente cyclus — maar een van **zes maanden**, met pieken in de winter en opnieuw in de vroege zomer."
    },
    {
      "type": "p",
      "text": "Dat is niet het verhaal van cuffing season. Eén winterse golf, aangedreven door kou en eenzaamheid, zou één piek per jaar geven. Twee pieken, een half jaar uit elkaar, beschrijven iets anders: een ritme met meer dan één oorzaak, waarvan er één in het warmste deel van het jaar valt."
    },
    {
      "type": "h2",
      "text": "Het wintereffect is echt, en kleiner dan geadverteerd"
    },
    {
      "type": "p",
      "text": "Er bestaat wel degelijk een seizoensbevinding over aantrekkingskracht. In 2008 publiceerden Boguslaw Pawlowski en Piotr Sorokowski in **Perception** een studie waarin 114 heteroseksuele mannen dezelfde beelden beoordeelden over vijf seizoenen. De beoordelingen van vrouwenlichamen lagen in de winter hoger dan in de zomer. De beoordelingen van gezichten bewogen helemaal niet."
    },
    {
      "type": "p",
      "text": "De verklaring van de auteurs zelf is niet romantisch. Zij stellen een **contrasteffect** voor: mensen zien in de zomer veel meer van andermans lichaam, waardoor de lat omhoogschuift en hetzelfde beeld daartegen lager scoort. Dat is een eigenaardigheid van de waarneming, geen seizoensdrang om je te binden."
    },
    {
      "type": "ul",
      "items": [
        "Het mat beoordelingen van foto's, geen beslissingen over echte mensen.",
        "Het vond helemaal geen seizoensverandering in hoe gezichten werden beoordeeld.",
        "114 mannen, één land, één jaar — genoeg om een effect op te merken, niet genoeg om er een seizoen op te bouwen.",
        "Het mechanisme dat de auteurs voorstellen is gewenning, geen verlangen."
      ]
    },
    {
      "type": "h2",
      "text": "En dan draait het halfrond het om"
    },
    {
      "type": "p",
      "text": "Het ongemakkelijkste bewijs komt uit geboortecijfers. Een analyse van Laurence Symul en collega's onder ruwweg een half miljoen gebruikers van gezondheidsapps liet zien dat de seizoensverdeling van geboorten vooral wordt gedreven door **seizoensgebonden vruchtbaarheid** en niet door seizoensgebonden seks: meer activiteit rond de feestdagen verklaart slechts kleine bulten in de curve. De vruchtbaarheid piekte op het noordelijk halfrond tussen de herfstequinox en de winterzonnewende, en op het zuidelijk halfrond kort na de winterzonnewende."
    },
    {
      "type": "p",
      "text": "Lees dat nog eens met het verhaal van cuffing season in je hoofd. Het patroon volgt de zonnewende aan beide kanten van de evenaar, wat betekent dat het niet december volgt, of de feestdagen, of het einde van het jaar. Wat hier seizoensgebonden is, volgt het daglicht en niet de kalender waarin mensen daadwerkelijk leven."
    },
    {
      "type": "h2",
      "text": "Wat er echt seizoensgebonden is aan je datingleven"
    },
    {
      "type": "p",
      "text": "Niets hiervan betekent dat het najaar hetzelfde voelt als juni. Het betekent dat wat verandert je omstandigheden zijn en niet je biologie. De winter op het noordelijk halfrond herschikt waar mensen zijn, wie ze zien en wat hun gevraagd wordt."
    },
    {
      "type": "ul",
      "items": [
        "Plannen verhuizen naar binnen, waardoor een eerste ontmoeting iets langers wordt dan een wandeling.",
        "De feestdagen zetten een datum in de agenda waarop single zijn een onderwerp wordt dat anderen aansnijden.",
        "Familiebijeenkomsten leveren de vraag, hardop, waar iedereen bij is.",
        "Lange avonden zonder afspraken maken het makkelijker om naar je telefoon te grijpen."
      ]
    },
    {
      "type": "p",
      "text": "Dat is een echt seizoenseffect, en het is volledig sociaal. Het verklaart ook de voorjaarshelft van het verhaal beter dan welk hormoon dan ook: een afspraak die ontstond doordat de kalender twee mensen naar elkaar toe duwde, wordt meestal opnieuw bekeken zodra de kalender ophoudt met duwen."
    },
    {
      "type": "h2",
      "text": "Het risico is niet het seizoen. Het is wat je hebt overgeslagen."
    },
    {
      "type": "p",
      "text": "Een relatie die in een seizoensvenster begint is niet gedoemd. Een heleboel goede beginnen doordat twee mensen toevallig vrij waren op dezelfde koude dinsdag. Wat er misgaat is smaller dan dat: het seizoen levert een reden om te beginnen, en mensen nemen dat als reden om het deel over te slaan waarin je uitzoekt of je deze persoon eigenlijk wel wilt."
    },
    {
      "type": "p",
      "text": "Het teken is simpel. Als je kunt uitleggen waarom je met iemand praat zonder het weer, de feestdagen of de leegte van je week te noemen, heb je een antwoord. Als dat niet lukt, heb je een seizoen."
    },
    {
      "type": "h2",
      "text": "Het venster laten tellen",
      "accent": "green"
    },
    {
      "type": "p",
      "text": "De praktische zet is om te bepalen wat je wilt voordat het seizoen dat voor je bepaalt. Geen vijfjarenplan — net specifiek genoeg dat je het in juni zou missen als het er niet was."
    },
    {
      "type": "ul",
      "items": [
        "Benoem één ding dat je hier echt uit wilt halen, vóór het eerste bericht en niet na de derde week.",
        "Stel een vraag waarvan het antwoord je in de zomer nog steeds iets zou doen.",
        "Let erop of jullie gezamenlijke plannen een vrije avond in een warme maand overleven.",
        "Zie de ongemakkelijke vraag van familie als informatie en niet als druk — die vraagt je wat je wilt, alleen heel onhandig."
      ]
    },
    {
      "type": "p",
      "text": "Dit is ook het punt waar Qulo omheen is gebouwd. Op Qulo schrijf je tussen de 2 en 4 meerkeuzevragen over jezelf — tot 10 met een betaald abonnement — elk met vier antwoordopties, en jij markeert het juiste antwoord. Iemand matcht met jou door ze allemaal goed te beantwoorden. Het verifieert niet wie iemand is en het meet geen compatibiliteit. Wat het wel doet, is het eerste filter verplaatsen van een foto naar een kleine daad van aandacht — precies de stap die een seizoensvenster je verleidt over te slaan."
    },
    {
      "type": "quote",
      "text": "Een seizoen kan je vertellen waarom jullie zijn gaan praten. Het kan je niet vertellen of je deze persoon in juni ook had gekozen. Dat vertellen alleen de vragen die je de moeite nam om te stellen."
    }
  ],
  pl: [
    {
      "type": "p",
      "text": "Ta opowieść wraca co jesień. Wieczory się skracają, coś pradawnego się porusza, a single łączą się w pary na zimne miesiące, żeby wiosną znowu się od siebie oddalić. To właśnie angielszczyzna nazywa cuffing season, od słowa cuff, czyli kajdanki: być do kogoś przypiętym na czas chłodów. Dobra opowieść. Powtarzana jak ustalony fakt. A badania, którym się ją przypisuje, mówią coś wyraźnie dziwniejszego."
    },
    {
      "type": "h2",
      "text": "Ten sezon ma dwa szczyty, nie jeden"
    },
    {
      "type": "p",
      "text": "Najczęściej cytowanym dowodem na sezonowość doboru par jest praca Patricka i Charlotte Markeyów z 2013 roku w **Archives of Sexual Behavior**. Przeprowadzili analizę harmoniczną pięciu lat wyszukiwań w Google dotyczących seksu i szukania partnera i znaleźli stały cykl — ale **sześciomiesięczny**, ze szczytami wyszukiwań zimą i ponownie wczesnym latem."
    },
    {
      "type": "p",
      "text": "To nie jest opowieść o cuffing season. Pojedyncza zimowa fala napędzana chłodem i samotnością dałaby jeden szczyt w roku. Dwa szczyty oddalone o pół roku opisują coś innego: rytm, który ma więcej niż jedną przyczynę, a jedna z nich wypada w najcieplejszej części roku."
    },
    {
      "type": "h2",
      "text": "Efekt zimy jest prawdziwy i mniejszy, niż się go reklamuje"
    },
    {
      "type": "p",
      "text": "Istnieje autentyczne sezonowe odkrycie dotyczące atrakcyjności. W 2008 roku Bogusław Pawłowski i Piotr Sorokowski opublikowali w **Perception** badanie, w którym 114 heteroseksualnych mężczyzn oceniało te same zdjęcia przez pięć pór roku. Oceny kobiecych ciał były zimą wyższe niż latem. Oceny twarzy nie drgnęły w ogóle."
    },
    {
      "type": "p",
      "text": "Wyjaśnienie samych autorów nie ma nic wspólnego z romantyzmem. Proponują **efekt kontrastu**: latem ludzie widzą znacznie więcej cudzych ciał, więc poprzeczka podnosi się sama, a to samo zdjęcie wypada przy niej gorzej. To osobliwość percepcji, a nie sezonowa potrzeba wiązania się z kimś."
    },
    {
      "type": "ul",
      "items": [
        "Mierzyło oceny fotografii, a nie decyzje dotyczące prawdziwych ludzi.",
        "Nie znalazło żadnej sezonowej zmiany w ocenach twarzy.",
        "To 114 mężczyzn, jeden kraj, jeden rok — dość, by zauważyć efekt, za mało, by zbudować na tym całą porę roku.",
        "Mechanizm, który proponują autorzy, to przyzwyczajenie, a nie pożądanie."
      ]
    },
    {
      "type": "h2",
      "text": "A potem półkula wywraca to do góry nogami"
    },
    {
      "type": "p",
      "text": "Najbardziej niewygodny dowód pochodzi z danych o urodzeniach. Analiza Laurence'a Symula i współpracowników, obejmująca około pół miliona użytkowników aplikacji do monitorowania zdrowia, wykazała, że sezonowość urodzeń wynika przede wszystkim z **sezonowej płodności**, a nie z sezonowego seksu — wzmożona aktywność wokół świąt tłumaczy jedynie niewielkie wybrzuszenia na krzywej. Płodność osiągała szczyt między równonocą jesienną a przesileniem zimowym na półkuli północnej, a na południowej krótko po przesileniu zimowym."
    },
    {
      "type": "p",
      "text": "Przeczytaj to jeszcze raz, mając w głowie opowieść o cuffing season. Wzór podąża za przesileniem po obu stronach równika, co znaczy, że nie podąża ani za grudniem, ani za świętami, ani za końcem roku. To, co jest tu sezonowe, idzie za światłem dnia, a nie za kalendarzem, którym ludzie naprawdę żyją."
    },
    {
      "type": "h2",
      "text": "Co w twoim życiu uczuciowym jest naprawdę sezonowe"
    },
    {
      "type": "p",
      "text": "Nic z tego nie znaczy, że jesień jest tym samym co czerwiec. Znaczy, że zmieniają się twoje okoliczności, a nie twoja biologia. Zima na półkuli północnej przestawia to, gdzie ludzie są, kogo widują i o co się ich pyta."
    },
    {
      "type": "ul",
      "items": [
        "Plany przenoszą się do środka, co zamienia pierwsze spotkanie w coś dłuższego niż spacer.",
        "Święta wpisują w kalendarz datę, przy której bycie singlem staje się tematem podnoszonym przez innych.",
        "Rodzinne spotkania dostarczają pytania, na głos i przy wszystkich.",
        "Długie wieczory, w których nic nie zaplanowano, sprawiają, że łatwiej sięgnąć po telefon."
      ]
    },
    {
      "type": "p",
      "text": "To prawdziwy efekt sezonowy i jest w całości społeczny. Tłumaczy też wiosenną połowę tej opowieści lepiej niż jakikolwiek hormon: układ, który powstał, bo kalendarz popchnął dwoje ludzi ku sobie, zwykle trafia pod rozwagę wtedy, gdy kalendarz przestaje popychać."
    },
    {
      "type": "h2",
      "text": "Ryzykiem nie jest sezon. Jest nim to, co pominąłeś."
    },
    {
      "type": "p",
      "text": "Związek, który zaczyna się w sezonowym oknie, nie jest skazany. Mnóstwo dobrych zaczęło się dlatego, że dwoje ludzi akurat miało wolne w ten sam zimny wtorek. To, co idzie źle, jest węższe: sezon dostarcza powodu, żeby zacząć, a ludzie biorą to za powód, żeby pominąć tę część, w której sprawdza się, czy naprawdę chce się tej osoby."
    },
    {
      "type": "p",
      "text": "Sygnał jest prosty. Jeśli potrafisz wyjaśnić, dlaczego z kimś rozmawiasz, nie wspominając o pogodzie, świętach ani o tym, jak pusty masz tydzień, masz odpowiedź. Jeśli nie potrafisz, masz sezon."
    },
    {
      "type": "h2",
      "text": "Jak wykorzystać to okno",
      "accent": "green"
    },
    {
      "type": "p",
      "text": "Praktyczny ruch to zdecydować, czego chcesz, zanim sezon zdecyduje za ciebie. Nie plan na pięć lat — tyle konkretu, żebyś zauważył jego brak w czerwcu."
    },
    {
      "type": "ul",
      "items": [
        "Nazwij jedną rzecz, której naprawdę z tego chcesz, przed pierwszą wiadomością, a nie po trzecim tygodniu.",
        "Zadaj pytanie, którego odpowiedź obchodziłaby cię także latem.",
        "Sprawdź, czy wasze wspólne plany wytrzymują zderzenie z wolnym wieczorem w ciepłym miesiącu.",
        "Potraktuj to niezręczne pytanie krewnych jako informację, a nie presję — pyta cię o to, czego chcesz, tylko nieudolnie."
      ]
    },
    {
      "type": "p",
      "text": "Wokół tego właśnie zbudowano Qulo. W Qulo piszesz o sobie od 2 do 4 pytań jednokrotnego wyboru — do 10 pytań w planie płatnym — z czterema odpowiedziami do wyboru przy każdym, i sam zaznaczasz tę prawdziwą. Ktoś dopasowuje się do ciebie, odpowiadając poprawnie na wszystkie. To nie weryfikuje niczyjej tożsamości i nie mierzy zgodności charakterów. Robi co innego: przenosi pierwszy filtr ze zdjęcia na drobny akt uwagi — czyli dokładnie ten krok, który sezonowe okno kusi, żeby pominąć."
    },
    {
      "type": "quote",
      "text": "Sezon może ci powiedzieć, dlaczego zaczęliście rozmawiać. Nie powie, czy wybrałbyś tę osobę w czerwcu. To potrafią tylko pytania, które zadałeś sobie trud, żeby postawić."
    }
  ],
  sv: [
    {
      "type": "p",
      "text": "Berättelsen kommer varje höst. Kvällarna blir kortare, något urgammalt rör på sig och singlar börjar para ihop sig inför de kalla månaderna för att glida isär igen på våren. Det är den så kallade cuffing season, från engelskans cuff, handfängsel: att sitta fast i någon över vintern. Det är en bra berättelse. Den upprepas som avgjord sanning. Och forskningen den tillskrivs säger något märkbart konstigare."
    },
    {
      "type": "h2",
      "text": "Säsongen har två toppar, inte en"
    },
    {
      "type": "p",
      "text": "Det mest citerade belägget för säsongsbunden parbildning är en artikel från 2013 av Patrick och Charlotte Markey i **Archives of Sexual Behavior**. De gjorde en harmonisk analys av fem års Google-sökningar kopplade till sex och partnersökande och hittade en genomgående cykel — men en på **sex månader**, med sökningar som toppar på vintern och en gång till på försommaren."
    },
    {
      "type": "p",
      "text": "Det är inte berättelsen om cuffing season. En enda vintervåg driven av kyla och ensamhet skulle ge en topp om året. Två toppar, ett halvår isär, beskriver något annat: en rytm med mer än en orsak, varav den ena infaller i årets varmaste del."
    },
    {
      "type": "h2",
      "text": "Vintereffekten är verklig, och mindre än vad som utlovas"
    },
    {
      "type": "p",
      "text": "Det finns ett äkta säsongsfynd om attraktion. År 2008 publicerade Boguslaw Pawlowski och Piotr Sorokowski en studie i **Perception** där 114 heterosexuella män bedömde samma bilder över fem årstider. Bedömningarna av kvinnors kroppar var högre på vintern än på sommaren. Bedömningarna av ansikten rörde sig inte alls."
    },
    {
      "type": "p",
      "text": "Författarnas egen förklaring handlar inte om romantik. De föreslår en **kontrasteffekt**: på sommaren ser man betydligt mer av andras kroppar, så ribban glider uppåt och samma bild får lägre betyg mot den. Det är en egenhet i varseblivningen, inte en säsongsbunden lust att skaffa någon."
    },
    {
      "type": "ul",
      "items": [
        "Den mätte bedömningar av fotografier, inte beslut om verkliga människor.",
        "Den fann ingen säsongsvariation alls i hur ansikten bedömdes.",
        "114 män, ett land, ett år — nog för att se en effekt, inte nog för att bygga en årstid på.",
        "Mekanismen författarna föreslår är tillvänjning, inte begär."
      ]
    },
    {
      "type": "h2",
      "text": "Sedan vänder halvklotet på alltihop"
    },
    {
      "type": "p",
      "text": "Det mest obekväma belägget kommer från födelsedata. En analys av Laurence Symul med kollegor, på ungefär en halv miljon användare av hälsoappar, fann att säsongsvariationen i födslar främst drivs av **säsongsbunden fruktsamhet** snarare än av säsongsbundet sex — ökad aktivitet kring helgerna förklarar bara små bulor på kurvan. Fruktsamheten toppade mellan höstdagjämningen och vintersolståndet på norra halvklotet, och strax efter vintersolståndet på det södra."
    },
    {
      "type": "p",
      "text": "Läs det en gång till med berättelsen om cuffing season i bakhuvudet. Mönstret följer solståndet på båda sidor om ekvatorn, vilket betyder att det inte följer december, inte helgerna och inte årsskiftet. Det som är säsongsbundet här följer dagsljuset, inte den kalender människor faktiskt lever efter."
    },
    {
      "type": "h2",
      "text": "Det här är verkligen säsongsbundet i ditt dejtingliv"
    },
    {
      "type": "p",
      "text": "Inget av detta betyder att hösten känns som juni. Det betyder att det som ändras är dina omständigheter snarare än din biologi. Vintern på norra halvklotet organiserar om var människor befinner sig, vilka de träffar och vad de får för frågor."
    },
    {
      "type": "ul",
      "items": [
        "Planerna flyttar inomhus, vilket gör ett första möte till något längre än en promenad.",
        "Helgerna sätter ett datum i kalendern där att vara singel blir ett ämne andra tar upp.",
        "Släktmiddagarna levererar frågan, högt och inför alla.",
        "Långa kvällar utan något inbokat gör telefonen lättare att sträcka sig efter."
      ]
    },
    {
      "type": "p",
      "text": "Det är en verklig säsongseffekt, och den är helt och hållet social. Den förklarar också vårhalvan av berättelsen bättre än något hormon gör: ett upplägg som uppstod för att kalendern tryckte ihop två människor tenderar att omprövas när kalendern slutar trycka."
    },
    {
      "type": "h2",
      "text": "Risken är inte säsongen. Det är det du hoppade över."
    },
    {
      "type": "p",
      "text": "Ett förhållande som börjar i ett säsongsfönster är inte dömt. Massor av bra relationer börjar för att två personer råkade vara lediga samma kalla tisdag. Det som går snett är smalare än så: säsongen levererar ett skäl att börja, och folk tar det som ett skäl att hoppa över den del där man tar reda på om man faktiskt vill ha den här personen."
    },
    {
      "type": "p",
      "text": "Tecknet är enkelt. Om du kan beskriva varför du pratar med någon utan att nämna vädret, helgerna eller hur tyst din vecka är, har du ett svar. Om du inte kan det, har du en säsong."
    },
    {
      "type": "h2",
      "text": "Att få ut något av fönstret",
      "accent": "green"
    },
    {
      "type": "p",
      "text": "Det praktiska draget är att bestämma vad du vill innan säsongen bestämmer åt dig. Ingen femårsplan — bara så pass mycket att du skulle märka om det saknades i juni."
    },
    {
      "type": "ul",
      "items": [
        "Sätt ord på en sak du faktiskt vill ha ut av det här, före första meddelandet snarare än efter tredje veckan.",
        "Ställ en fråga vars svar du fortfarande skulle bry dig om på sommaren.",
        "Lägg märke till om era gemensamma planer överlever mötet med en ledig kväll i en varm månad.",
        "Behandla släktens obekväma fråga som information, inte press — den frågar dig vad du vill, bara klumpigt."
      ]
    },
    {
      "type": "p",
      "text": "Det är också det här Qulo är byggt kring. På Qulo skriver du 2 till 4 flervalsfrågor om dig själv — upp till 10 med ett betalt abonnemang — med fyra svarsalternativ vardera, och du markerar det sanna svaret. Någon matchar med dig genom att få varenda en rätt. Det verifierar inte vem någon är och det mäter ingen kompatibilitet. Vad det gör är att flytta det första filtret från ett fotografi till en liten handling av uppmärksamhet, vilket är precis det steg ett säsongsfönster frestar folk att hoppa över."
    },
    {
      "type": "quote",
      "text": "En säsong kan berätta varför ni började prata. Den kan inte berätta om du hade valt den här personen i juni. Det kan bara de frågor du gjorde dig besväret att ställa."
    }
  ],
  hi: [
    {
      "type": "p",
      "text": "यह कहानी हर शरद ऋतु में लौट आती है। शामें छोटी होने लगती हैं, भीतर कुछ बहुत पुराना कसमसाता है, और अकेले ठीक-ठाक चल रहे लोग ठंडे महीनों के लिए जोड़े बनाने लगते हैं — फिर वसंत आते ही बिखर जाते हैं। अंग्रेज़ी में इसे cuffing season कहते हैं, हिंदी में कफ़िंग सीज़न। कहानी अच्छी है। इसे तय हो चुके तथ्य की तरह दोहराया जाता है। और जिस शोध के नाम पर यह दोहराई जाती है, वह साफ़ तौर पर कहीं ज़्यादा अजीब बात कहता है।"
    },
    {
      "type": "h2",
      "text": "इस मौसम की चोटी एक नहीं, दो हैं"
    },
    {
      "type": "p",
      "text": "मौसम और जोड़ी बनने के रिश्ते पर सबसे ज़्यादा उद्धृत सबूत Patrick Markey और Charlotte Markey का 2013 का पर्चा है, जो **Archives of Sexual Behavior** में छपा। दोनों ने सेक्स और साथी की तलाश से जुड़े गूगल सर्च शब्दों के पाँच साल के आँकड़ों पर हार्मोनिक विश्लेषण किया और एक स्थिर चक्र पाया — लेकिन वह **छह महीने** का चक्र था, जिसमें सर्च सर्दियों में चोटी पर पहुँचती है और फिर शुरुआती गर्मियों में दोबारा।"
    },
    {
      "type": "p",
      "text": "यह कफ़िंग सीज़न वाली कहानी नहीं है। ठंड और अकेलेपन से उठी अकेली सर्दियों की लहर होती तो साल में एक ही चोटी दिखती। छह महीने के फ़ासले पर बनी दो चोटियाँ किसी और चीज़ का नक़्शा हैं: एक ऐसी लय जिसके कारण एक से ज़्यादा हैं, और जिनमें से एक कारण साल के सबसे गर्म हिस्से पर आकर बैठता है।"
    },
    {
      "type": "h2",
      "text": "सर्दियों का असर असली है, पर जितना बताया जाता है उतना नहीं"
    },
    {
      "type": "p",
      "text": "आकर्षण को लेकर एक सचमुच की मौसमी खोज मौजूद है। 2008 में Boguslaw Pawlowski और Piotr Sorokowski ने **Perception** में एक अध्ययन छापा, जिसमें 114 विषमलैंगिक पुरुषों ने पाँच मौसमों में वही तस्वीरें आँकीं। महिलाओं के शरीर को दिए गए अंक गर्मियों के मुक़ाबले सर्दियों में ऊँचे रहे। चेहरों को दिए गए अंक बिलकुल नहीं हिले।"
    },
    {
      "type": "p",
      "text": "ख़ुद लेखकों की व्याख्या रोमांस की नहीं है। वे एक **कंट्रास्ट इफ़ेक्ट** का सुझाव देते हैं: गर्मियों में लोग दूसरों के शरीर कहीं ज़्यादा देखते हैं, इसलिए पैमाना ऊपर खिसक जाता है और वही तस्वीर उसके सामने कम अंक पाती है। यह देखने की एक आदत है, जोड़ा बनाने की कोई मौसमी तलब नहीं।"
    },
    {
      "type": "ul",
      "items": [
        "इसने तस्वीरों को दिए गए अंक नापे, असली लोगों के बारे में लिए गए फ़ैसले नहीं।",
        "चेहरों के आकलन में इसे मौसम के साथ कोई बदलाव मिला ही नहीं।",
        "114 पुरुष, एक देश, एक साल — किसी असर को नोटिस करने भर को काफ़ी, उस पर पूरा मौसम खड़ा करने को नहीं।",
        "लेखक जिस तंत्र का सुझाव देते हैं वह अभ्यस्त हो जाना है, इच्छा नहीं।"
      ]
    },
    {
      "type": "h2",
      "text": "फिर गोलार्ध इसे उलट देता है"
    },
    {
      "type": "p",
      "text": "सबसे असहज सबूत जन्म के आँकड़ों से आता है। Laurence Symul और उनके साथियों ने सेहत पर नज़र रखने वाले ऐप्स के क़रीब पाँच लाख उपयोगकर्ताओं का विश्लेषण किया और पाया कि जन्मों की मौसमी लय को मुख्य रूप से मौसमी यौन गतिविधि नहीं, बल्कि **मौसमी प्रजनन-क्षमता** चलाती है — छुट्टियों के आसपास बढ़ी यौन गतिविधि वक्र के सिर्फ़ छोटे उभार समझाती है। प्रजनन-क्षमता उत्तरी गोलार्ध में शरद विषुव और शीत संक्रांति के बीच चोटी पर पहुँची, और दक्षिणी गोलार्ध में शीत संक्रांति के थोड़ी देर बाद।"
    },
    {
      "type": "p",
      "text": "इसे कफ़िंग सीज़न की कहानी ध्यान में रखते हुए दोबारा पढ़िए। यह रुझान भूमध्य रेखा के दोनों ओर संक्रांति के पीछे चलता है, यानी यह न दिसंबर के पीछे चल रहा है, न छुट्टियों के, न साल के अंत के। यहाँ जो कुछ मौसमी है वह दिन के उजाले के पीछे चल रहा है — उस कैलेंडर के पीछे नहीं जिसे लोग असल में जीते हैं।"
    },
    {
      "type": "h2",
      "text": "आपकी डेटिंग ज़िंदगी में सचमुच मौसमी क्या है"
    },
    {
      "type": "p",
      "text": "इनमें से कोई बात यह नहीं कहती कि शरद और जून एक जैसे लगते हैं। यह कहती है कि जो बदलता है वह आपका जीव-विज्ञान नहीं, आपकी परिस्थिति है। उत्तरी गोलार्ध के ठंडे महीने — और भारत में उन्हीं महीनों पर पड़ने वाला त्योहारों और शादियों का सीज़न — यह दोबारा तय कर देते हैं कि लोग कहाँ होते हैं, किससे मिलते हैं और उनसे क्या पूछा जाता है।"
    },
    {
      "type": "ul",
      "items": [
        "मिलना-जुलना कार्यक्रमों में बदल जाता है, और पहली मुलाक़ात एक छोटी-सी वॉक से कहीं लंबी चीज़ बन जाती है।",
        "त्योहार और शादियाँ कैलेंडर पर वे तारीख़ें रख देती हैं जहाँ अकेले होना दूसरों का उठाया हुआ विषय बन जाता है।",
        "रिश्तेदारों की भीड़ वही सवाल ऊँची आवाज़ में, सबके सामने रख देती है।",
        "बिना किसी तय काम के लंबी शामें फ़ोन तक हाथ पहुँचाना आसान कर देती हैं।"
      ]
    },
    {
      "type": "p",
      "text": "यह एक असली मौसमी असर है, और पूरी तरह सामाजिक है। यह कहानी के वसंत वाले आधे हिस्से को भी किसी हॉर्मोन से कहीं बेहतर समझाता है: जो बंदोबस्त इसलिए बना क्योंकि कैलेंडर ने दो लोगों को एक-दूसरे की तरफ़ धकेल दिया था, कैलेंडर के धकेलना बंद करते ही उसकी दोबारा जाँच होने लगती है।"
    },
    {
      "type": "h2",
      "text": "ख़तरा मौसम नहीं है, वह हिस्सा है जो आपने छोड़ दिया"
    },
    {
      "type": "p",
      "text": "किसी मौसमी खिड़की में शुरू हुआ रिश्ता तय नहीं है कि टूटेगा। बहुत सारे अच्छे रिश्ते सिर्फ़ इसलिए शुरू हुए कि दो लोग एक ही ठंडे मंगलवार को ख़ाली थे। गड़बड़ इससे कहीं संकरी जगह पर होती है: मौसम शुरू करने की एक वजह देता है, और लोग उसे उस हिस्से को छोड़ देने की वजह मान लेते हैं जहाँ पता चलता है कि आप सचमुच इस इंसान को चाहते हैं या नहीं।"
    },
    {
      "type": "p",
      "text": "पहचान आसान है। अगर आप बता सकें कि आप इस इंसान से क्यों बात कर रहे हैं — मौसम, त्योहारों या इस हफ़्ते के ख़ालीपन का ज़िक्र किए बिना — तो आपके पास एक जवाब है। नहीं बता सकते, तो आपके पास एक मौसम है।"
    },
    {
      "type": "h2",
      "text": "इस खिड़की को बेकार मत जाने दीजिए",
      "accent": "green"
    },
    {
      "type": "p",
      "text": "व्यावहारिक क़दम यह है कि मौसम आपके लिए तय कर दे, उससे पहले आप ख़ुद तय कर लें कि आपको क्या चाहिए। पाँच साल की योजना नहीं — बस इतना साफ़ कि जून में उसकी कमी आपको महसूस हो जाए।"
    },
    {
      "type": "ul",
      "items": [
        "इस रिश्ते से आप जो एक चीज़ सचमुच चाहते हैं, उसे तीसरे हफ़्ते के बाद नहीं, पहले मैसेज से पहले नाम दीजिए।",
        "ऐसा कुछ पूछिए जिसका जवाब गर्मियों में भी आपके लिए मायने रखे।",
        "देखिए कि साथ बनाई गई योजनाएँ किसी गर्म महीने की ख़ाली शाम से टकराकर बचती हैं या नहीं।",
        "रिश्तेदारों के उस असहज सवाल को दबाव नहीं, जानकारी मानिए — वह पूछ तो यही रहा है कि आप क्या चाहते हैं, बस बहुत भद्दे तरीक़े से।"
      ]
    },
    {
      "type": "p",
      "text": "Qulo भी ठीक इसी हिस्से के इर्द-गिर्द बना है। Qulo पर आप अपने बारे में 2 से 4 बहुविकल्पीय सवाल लिखते हैं — भुगतान वाली योजना में 10 तक — हर सवाल में चार विकल्प होते हैं और सही जवाब पर निशान आप ख़ुद लगाते हैं। कोई आपसे तभी मैच करता है जब वह हर एक सवाल सही कर दे। यह किसी की पहचान की पुष्टि नहीं करता और अनुकूलता भी नहीं नापता। यह सिर्फ़ पहली छननी को तस्वीर से हटाकर ध्यान की एक छोटी-सी क्रिया पर ले आता है — और ठीक यही वह क़दम है जिसे छोड़ देने का लालच मौसमी खिड़की देती है।"
    },
    {
      "type": "quote",
      "text": "मौसम आपको बता सकता है कि बात शुरू क्यों हुई। यह नहीं बता सकता कि जून में भी आप इसी इंसान को चुनते या नहीं। वह सिर्फ़ वही सवाल बता सकते हैं जो पूछने की तकलीफ़ आपने उठाई।"
    }
  ],
};
