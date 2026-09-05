import type { LocalizedArticle } from "@/components/blog/ArticleBlocks";

/**
 * "Does having too many options make dating worse?"
 *
 * ANGLE, and why it is not the usual paradox-of-choice piece: the general
 * claim did not survive its own meta-analysis. Scheibehenne, Greifeneder and
 * Todd pooled 63 conditions from 50 experiments (N = 5,036) and found a mean
 * effect size of virtually zero with wide variance between studies. Any article
 * that opens with the jam stand and treats choice overload as established is
 * skipping that. This one says so first, then reports what was measured in
 * dating specifically — which is narrower and more interesting than "more
 * choice makes you unhappy".
 *
 * SOURCES, all four verified before drafting:
 *  - Scheibehenne, Greifeneder & Todd (2010), Journal of Consumer Research
 *    37(3), 409–425 — the meta-analysis above.
 *  - Lenton & Francesconi (2010), Psychological Science — 84 speed-dating
 *    events, 1,868 women and 1,870 men. With more options on the night,
 *    attention shifted toward traits that read fast (height, weight) and away
 *    from ones that take time to establish (occupation, education).
 *  - Pronk & Denissen (2020), Social Psychological and Personality Science
 *    11(3), 388–396 — three studies; acceptance fell about 27% from the first
 *    option shown to the last. Sample sizes per study were not confirmed, so
 *    none is stated here.
 *  - D'Angelo & Toma (2017), Media Psychology 20 — 152 undergraduates choosing
 *    from a pool of 24 or of 6; the larger pool was less satisfied a week
 *    later. The small student sample is stated in the body rather than hidden.
 *
 * The D'Angelo & Toma paper's title contains an English idiom that is also a
 * competitor's brand name, so it is cited by authors, journal and year only —
 * the same way the Symul preprint is cited without a journal. Do not "restore"
 * the title.
 *
 * CLAIMS DELIBERATELY NOT MADE: that choice overload is settled science; that
 * a shorter queue produces better relationships (nobody measured that); any
 * figure for how many profiles people see, which has no source that is not a
 * dating company's own marketing.
 */
export const paradoxOfChoiceDating: LocalizedArticle = {
  tr: [
    {
      "type": "p",
      "text": "Çok fazla seçeneğin insanı kötü seçim yapmaya ittiğini, dating uygulamalarının bu yüzden böyle hissettirdiğini duymuşsundur. Derli toplu bir açıklama. Bir o kadar da sallantıda — ve kanıtlardan sağ çıkan hâli, dolaşımdaki hâlinden hem daha dar hem daha işe yarar."
    },
    {
      "type": "h2",
      "text": "Genel iddia kendi meta-analizinden sağ çıkamadı"
    },
    {
      "type": "p",
      "text": "Fikir, bir ürünün çok çeşidiyle karşılaşan alışverişçilerin az çeşitle karşılaşanlardan daha az satın aldığı ünlü deneylerden geliyor. Hızla yayıldı, çünkü herkesin tanıdığı bir hissi açıklıyor. Ama 2010'da **Scheibehenne, Greifeneder ve Todd**, **Journal of Consumer Research**'te **50 deneyden 63 koşulu**, toplam **5.036 kişiyi** bir araya getirdi ve ortalama etki büyüklüğünü neredeyse sıfır buldu — çalışmalar arasında geniş bir dağılımla. Bazıları güçlü bir seçim yükü buldu. Bazıları fazla seçeneğin işi kolaylaştırdığını."
    },
    {
      "type": "p",
      "text": "Yani battaniye gibi örten hâli — daha çok seçenek, hep daha kötü sonuç — kanıtın desteklediği bir şey değil. Bir yazı alışveriş deneyiyle açılıp konuyu kapanmış sayıyorsa, alanın kendi kendini denetlediği kısmı atlamış demektir."
    },
    {
      "type": "h2",
      "text": "Ama flört ayrıca ölçüldü"
    },
    {
      "type": "p",
      "text": "İşin ilginçleştiği yer burası, çünkü flörte özgü bulgular mutlulukla ilgili değil. **Neye dikkat ettiğinle** ilgili."
    },
    {
      "type": "p",
      "text": "**Lenton ve Francesconi**, **Psychological Science**'ta **84 hızlı tanışma etkinliğini** — **1.868 kadın ve 1.870 erkek** — inceledi. Etkinlikteki kişi sayısı arttıkça seçim yapanlar bir saniyede okunabilen özelliklere kaydı, sohbet gerektiren özelliklerden uzaklaştı. Boy ve kilo kararda ağırlık kazandı. Meslek ve eğitim kaybetti."
    },
    {
      "type": "p",
      "text": "O çalışmada kimse yüzeysel olmaya karar vermedi. Bu kayma, harcanacak dikkatten fazla malzeme olduğunda insanın yaptığı şey. Bir dating uygulamasında aynı baskı bir akşamla sınırlı değil, sürekli — ve bir saniyede okunan özellikler tam da fotoğrafın taşıdıkları:"
    },
    {
      "type": "ul",
      "items": [
        "Yüz, beden, görünen yaş — tek kelime okumadan önce görünür",
        "Yazılmışsa boy, çünkü tek bir sayı",
        "Fotoğrafların pahalı görünüp görünmediği, ki bu sınıf hakkında bir tahmin",
        "Bayrak, rozet ya da unvan iliştirilmiş her şey"
      ]
    },
    {
      "type": "h2",
      "text": "Ne kadar uzun bakarsan o kadar çok eliyorsun"
    },
    {
      "type": "p",
      "text": "**Pronk ve Denissen** bunun üzerine üç çalışma yürüttü, **Social Psychological and Personality Science**'ta yayımlandı. Aday değerlendirilen bir oturum boyunca herhangi birini kabul etme olasılığı, **ilk gösterilenden sonuncusuna doğru yaklaşık %27 düştü**. Buna eleme zihniyeti diyorlar: ne kadar çok seçenek geçirirsen hepsi hakkında o kadar karamsarlaşıyorsun."
    },
    {
      "type": "p",
      "text": "Rahatsız edici sonuç şu: oturumunun sonlarında çıkan kişi kendi değeri üzerinden değerlendirilmiyor. Kırk karar derinliğindeki biri tarafından değerlendiriliyor. Aynı profili başa alsan daha iyi sonuç alıyor."
    },
    {
      "type": "h2",
      "text": "Sonrasındaki memnuniyet"
    },
    {
      "type": "p",
      "text": "**D'Angelo ve Toma**, **Media Psychology**'de sonrasını test etti: **152 üniversite öğrencisi** ya **24** ya da **6** kişilik bir havuzdan birini seçti, bir hafta sonra memnuniyetleri soruldu. 24'lük havuzdan seçenler seçtikleri kişiden daha az memnundu. Açıkça söylemek gerekir: bu laboratuvarda küçük bir öğrenci örneklemi, gerçek ilişkilerin incelenmesi değil; kendi hayatın hakkında bir bulgu değil, bir ipucu olarak okunmalı."
    },
    {
      "type": "p",
      "text": "Üç bulguyu yan yana koyunca — Lenton'ınki, Pronk'unki ve bu — dürüst özet dar kalıyor. Uzun bir kuyruk tek başına seni mutsuz etmiyor. Bir insanın hangi parçalarını tarttığını değiştiriyor, ilerledikçe seni daha eleyici yapıyor ve yaptığın seçim konusunda seni daha az yerleşmiş bırakabiliyor."
    },
    {
      "type": "h2",
      "text": "Bu ne söylüyor, ne söylemiyor"
    },
    {
      "type": "ul",
      "items": [
        "**Söylemiyor:** az seçenek daha iyi ilişki üretir. Bunu kimse ölçmedi.",
        "**Söylemiyor:** yüzeyselsin. Dikkatin sonlu olduğunu ve tükendiğini söylüyor.",
        "**Söylüyor:** birinin kuyruğunda nerede çıktığı, onu nasıl değerlendirdiğini etkiliyor.",
        "**Söylüyor:** fark edilmesi zaman alan özellikler, zaman olmadığında kaybediyor."
      ]
    },
    {
      "type": "p",
      "text": "Bu, alıştığın iddiadan daha küçük ve daha uygulanabilir bir iddia. Sorun soyut anlamda bolluk değil. Hızlı bir kuyruğun, ölçütlerini sessizce en hızlı değerlendirilebilen şeye doğru yeniden ağırlıklandırması."
    },
    {
      "type": "h2",
      "text": "Peki ne yapmalı",
      "accent": "green"
    },
    {
      "type": "p",
      "text": "Bunların hiçbiri bir şey silmeyi gerektirmiyor. Dikkati, kişi başına hiç kalmayana kadar yaymak yerine bilerek harcamayı gerektiriyor."
    },
    {
      "type": "ul",
      "items": [
        "Bir oturuşta kaç kişiye bakacağına önceden karar ver ve sıkıldığında değil, orada dur.",
        "Oturumun neresinde olduğunu fark et. Arka arkaya on bir kez hayır dediysen on ikinci karar onlarla değil seninle ilgili.",
        "Karar vermeden önce profili aç. İki cümle okumak, yavaş bir özelliğin hızlı olanla yarışmasına izin vermenin en ucuz yolu.",
        "Bir şey merakını uyandırdığında o gün harekete geç. Merak kuyruğa alınmaya dayanmıyor."
      ]
    },
    {
      "type": "p",
      "text": "Qulo'da kuyruk yapısı gereği kısa, çünkü birine ulaşmak onun kendisi hakkında yazdığı soruları yanıtlamaktan geçiyor — ücretsiz planda 2 ila 4 soru, ücretli planda 10'a kadar, her birinde dört şık ve hepsinin doğru olması gerekiyor. Bu, dikkat cinsinden bilinçli bir maliyet ve araştırmanın tarif ettiği hızlı taramanın tam tersi. Kimseyi daha uyumlu yapmıyor; sadece bir insan hakkında yaptığın ilk şeyin fotoğrafı sıralamak değil, yazdığı bir şeyi okumak olması demek."
    },
    {
      "type": "quote",
      "text": "Bulgu hiçbir zaman seçeneğin insanı mutsuz ettiği değildi. Dikkatin tükendiği ve en hızlı değerlendirilenin değerlendirildiğiydi."
    }
  ],
  en: [
    {
      "type": "p",
      "text": "You have probably heard that having too many options makes you worse at choosing, and that this is why dating apps feel the way they do. It is a tidy explanation. It is also shakier than it sounds — and the version that survives the evidence is more specific, and more useful, than the one in circulation."
    },
    {
      "type": "h2",
      "text": "The general claim did not survive its own meta-analysis"
    },
    {
      "type": "p",
      "text": "The idea comes from a set of famous experiments about shoppers facing many varieties of a product and buying less than shoppers facing few. It spread fast because it explains a feeling everyone recognises. But in 2010, **Scheibehenne, Greifeneder and Todd** pooled **63 conditions from 50 experiments** covering **5,036 people** in the **Journal of Consumer Research**, and found a mean effect size of virtually zero — with wide variation between studies. Some found strong choice overload. Others found more options helped."
    },
    {
      "type": "p",
      "text": "So the blanket version — more options, worse outcomes, always — is not something the evidence supports. If an article opens with the shopping study and treats the matter as settled, it has skipped the part where the field checked."
    },
    {
      "type": "h2",
      "text": "Dating, though, was measured on its own"
    },
    {
      "type": "p",
      "text": "This is where it gets interesting, because the dating-specific findings are not about happiness at all. They are about **what you pay attention to**."
    },
    {
      "type": "p",
      "text": "**Lenton and Francesconi** analysed **84 speed-dating events** — **1,868 women and 1,870 men** — in **Psychological Science**. As the number of people at an event went up, choosers shifted toward characteristics that can be read in a second, and away from the ones that take a conversation to establish. Height and weight gained weight in the decision. Occupation and education lost it."
    },
    {
      "type": "p",
      "text": "Nobody in that study decided to become shallow. The shift is what a person does when there is more to get through than there is attention to spend. In a dating app the same pressure is constant rather than one evening long, and the traits that read in a second are exactly the ones a photograph carries:"
    },
    {
      "type": "ul",
      "items": [
        "Face, body, apparent age — visible before you have read a word",
        "Height, if it is written down, because it is one number",
        "Whether the photos look expensive, which is a guess about class",
        "Anything with a flag, a badge or a job title attached to it"
      ]
    },
    {
      "type": "h2",
      "text": "The longer you look, the more you turn down"
    },
    {
      "type": "p",
      "text": "**Pronk and Denissen** ran three studies on this, published in **Social Psychological and Personality Science**. Across a session of judging potential partners, the chance of accepting any given one fell by about **27% from the first shown to the last**. They call it a rejection mind-set: the more options you go through, the more pessimistic you become about all of them."
    },
    {
      "type": "p",
      "text": "The uncomfortable implication is that the person who appears late in your session is not being judged on their merits. They are being judged by someone forty decisions deep. Move them to the front and the same profile does better."
    },
    {
      "type": "h2",
      "text": "And satisfaction afterwards"
    },
    {
      "type": "p",
      "text": "**D'Angelo and Toma**, in **Media Psychology**, tested the aftermath: **152 undergraduates** picked a partner from a pool of either **24 or 6**, and were asked a week later how satisfied they were. The people who had chosen from 24 were less satisfied with the person they picked. Worth saying plainly: this is a small student sample in a laboratory, not a study of real relationships, and it should be read as a suggestion rather than a finding about your life."
    },
    {
      "type": "p",
      "text": "Put those three findings together — Lenton's, Pronk's and this one — and the honest summary is narrow. A long queue does not make you unhappy by itself. It changes which parts of a person you weigh, it makes you more rejecting as you go, and it may leave you less settled about the choice you did make."
    },
    {
      "type": "h2",
      "text": "What this does and does not tell you"
    },
    {
      "type": "ul",
      "items": [
        "**It does not say** fewer options produce better relationships. Nobody has measured that.",
        "**It does not say** you are shallow. It says attention is finite and gets spent.",
        "**It does say** that where someone appears in your queue affects how you judge them.",
        "**It does say** that traits which take time to notice lose out when there is no time."
      ]
    },
    {
      "type": "p",
      "text": "Which is a smaller claim than the one you usually hear, and a more actionable one. The problem is not abundance in the abstract. It is that a fast queue quietly reweights your criteria toward whatever can be judged fastest."
    },
    {
      "type": "h2",
      "text": "What to do about it",
      "accent": "green"
    },
    {
      "type": "p",
      "text": "None of this requires deleting anything. It requires spending attention on purpose rather than spreading it until there is none left per person."
    },
    {
      "type": "ul",
      "items": [
        "Decide in advance how many people you will look at in a sitting, and stop there rather than when you get bored.",
        "Notice where you are in a session. If you have said no eleven times in a row, the twelfth judgement is about you, not them.",
        "Open the profile before deciding. Reading two sentences is the cheapest way to let a slow trait compete with a fast one.",
        "When something makes you curious, act on it that day. Curiosity does not survive being queued."
      ]
    },
    {
      "type": "p",
      "text": "On Qulo the queue is shorter by construction, because getting to someone means answering the questions they wrote about themselves — 2 to 4 of them on the free plan, up to 10 on a paid one, four options each, and every answer has to be right. That is a deliberate cost in attention, and it is the opposite of the fast scan the research describes. It does not make anyone more compatible; it just means the first thing you do about a person is read something they wrote rather than rank a photograph."
    },
    {
      "type": "quote",
      "text": "The finding was never that choice makes people miserable. It was that attention runs out, and whatever is quickest to judge gets judged."
    }
  ],
  de: [
    {
      "type": "p",
      "text": "Du hast wahrscheinlich gehört, dass zu viel Auswahl einen schlechter wählen lässt und dass Dating-Apps sich deshalb so anfühlen, wie sie sich anfühlen. Eine ordentliche Erklärung. Sie ist auch wackliger, als sie klingt — denn die Fassung, die die Belege überlebt, ist genauer und nützlicher als die, die im Umlauf ist."
    },
    {
      "type": "h2",
      "text": "Die allgemeine These hat ihre eigene Meta-Analyse nicht überlebt"
    },
    {
      "type": "p",
      "text": "Die Idee stammt aus einer Reihe berühmter Experimente: Wer vor vielen Varianten eines Produkts stand, kaufte weniger als wer nur wenige vor sich hatte. Sie verbreitete sich schnell, weil sie ein Gefühl erklärt, das jeder kennt. Aber 2010 fassten **Scheibehenne, Greifeneder und Todd** im **Journal of Consumer Research** **63 Bedingungen aus 50 Experimenten** mit **5.036 Personen** zusammen und fanden eine mittlere Effektstärke von praktisch null — bei großer Streuung zwischen den Studien. Manche fanden eine starke Überforderung durch Auswahl. Andere fanden, dass mehr Optionen halfen."
    },
    {
      "type": "p",
      "text": "Die pauschale Fassung also — mehr Auswahl, schlechteres Ergebnis, immer — wird von den Belegen nicht getragen. Wenn ein Artikel mit dem Einkaufsexperiment beginnt und die Sache für erledigt hält, hat er genau den Teil übersprungen, in dem das Fach nachgeprüft hat."
    },
    {
      "type": "h2",
      "text": "Dating dagegen wurde eigens gemessen"
    },
    {
      "type": "p",
      "text": "Hier wird es interessant, denn die Befunde speziell zum Dating handeln überhaupt nicht von Glück. Sie handeln davon, **worauf du achtest**."
    },
    {
      "type": "p",
      "text": "**Lenton und Francesconi** werteten in **Psychological Science** **84 Speed-Dating-Veranstaltungen** aus — **1.868 Frauen und 1.870 Männer**. Je mehr Menschen bei einer Veranstaltung waren, desto stärker verschoben sich die Entscheidungen hin zu Merkmalen, die sich in einer Sekunde ablesen lassen, und weg von denen, für die man ein Gespräch braucht. Größe und Gewicht bekamen mehr Gewicht in der Entscheidung. Beruf und Bildung verloren es."
    },
    {
      "type": "p",
      "text": "Niemand in dieser Studie hat beschlossen, oberflächlich zu werden. Die Verschiebung ist das, was ein Mensch tut, wenn mehr zu bewältigen ist, als Aufmerksamkeit da ist. In einer Dating-App ist derselbe Druck nicht auf einen Abend begrenzt, sondern dauerhaft — und die Merkmale, die sich in einer Sekunde lesen lassen, sind genau die, die ein Foto transportiert:"
    },
    {
      "type": "ul",
      "items": [
        "Gesicht, Körper, geschätztes Alter — sichtbar, bevor du ein Wort gelesen hast",
        "Die Körpergröße, falls sie dabeisteht, weil sie eine einzige Zahl ist",
        "Ob die Fotos teuer wirken, was eine Vermutung über die soziale Schicht ist",
        "Alles, woran eine Flagge, ein Abzeichen oder ein Jobtitel hängt"
      ]
    },
    {
      "type": "h2",
      "text": "Je länger du schaust, desto mehr sortierst du aus"
    },
    {
      "type": "p",
      "text": "**Pronk und Denissen** haben dazu drei Studien durchgeführt, veröffentlicht in **Social Psychological and Personality Science**. Über eine Sitzung hinweg, in der mögliche Partner beurteilt wurden, sank die Wahrscheinlichkeit, irgendjemanden anzunehmen, um rund **27 % von der ersten gezeigten Person bis zur letzten**. Sie nennen es eine Ablehnungshaltung: Je mehr Optionen du durchgehst, desto pessimistischer wirst du gegenüber allen."
    },
    {
      "type": "p",
      "text": "Die unangenehme Folgerung: Wer spät in deiner Sitzung auftaucht, wird nicht nach den eigenen Vorzügen beurteilt, sondern von jemandem, der vierzig Entscheidungen tief steckt. Schieb dieselbe Person nach vorn, und dasselbe Profil schneidet besser ab."
    },
    {
      "type": "h2",
      "text": "Und die Zufriedenheit danach"
    },
    {
      "type": "p",
      "text": "**D'Angelo und Toma** haben das Danach untersucht: **152 Studierende** wählten eine Person aus einem Pool von entweder **24 oder 6** aus und wurden eine Woche später gefragt, wie zufrieden sie seien. Wer aus 24 gewählt hatte, war mit der gewählten Person weniger zufrieden. Klar gesagt: Das ist eine kleine studentische Stichprobe im Labor, keine Untersuchung echter Beziehungen — sie ist als Hinweis zu lesen, nicht als Befund über dein Leben."
    },
    {
      "type": "p",
      "text": "Legt man die drei nebeneinander, fällt die ehrliche Zusammenfassung schmal aus. Eine lange Warteschlange macht dich nicht von selbst unglücklich. Sie verändert, welche Teile eines Menschen du gewichtest, sie lässt dich im Verlauf häufiger ablehnen, und sie kann dich mit der getroffenen Wahl weniger im Reinen zurücklassen."
    },
    {
      "type": "h2",
      "text": "Was das sagt und was nicht"
    },
    {
      "type": "ul",
      "items": [
        "**Es sagt nicht**, dass weniger Auswahl bessere Beziehungen hervorbringt. Das hat niemand gemessen.",
        "**Es sagt nicht**, dass du oberflächlich bist. Es sagt, dass Aufmerksamkeit endlich ist und aufgebraucht wird.",
        "**Es sagt sehr wohl**, dass die Stelle, an der jemand in deiner Warteschlange auftaucht, beeinflusst, wie du ihn beurteilst.",
        "**Es sagt sehr wohl**, dass Merkmale, deren Wahrnehmung Zeit braucht, verlieren, wenn keine Zeit da ist."
      ]
    },
    {
      "type": "p",
      "text": "Das ist eine kleinere Behauptung als die, die man üblicherweise hört — und eine, mit der sich etwas anfangen lässt. Das Problem ist nicht die Fülle an sich. Es ist, dass eine schnelle Warteschlange deine Kriterien leise zu dem hin verschiebt, was sich am schnellsten beurteilen lässt."
    },
    {
      "type": "h2",
      "accent": "green",
      "text": "Was du dagegen tun kannst"
    },
    {
      "type": "p",
      "text": "Nichts davon verlangt, irgendetwas zu löschen. Es verlangt, Aufmerksamkeit bewusst auszugeben, statt sie zu verteilen, bis pro Person nichts mehr übrig ist."
    },
    {
      "type": "ul",
      "items": [
        "Entscheide vorher, wie viele Menschen du in einer Sitzung anschaust, und hör dann auf — nicht erst, wenn du gelangweilt bist.",
        "Merk dir, wo in einer Sitzung du gerade bist. Wenn du elfmal hintereinander Nein gesagt hast, sagt das zwölfte Urteil etwas über dich, nicht über die Person.",
        "Öffne das Profil, bevor du entscheidest. Zwei Sätze zu lesen ist der billigste Weg, ein langsames Merkmal gegen ein schnelles antreten zu lassen.",
        "Wenn dich etwas neugierig macht, handle noch am selben Tag. Neugier überlebt es nicht, in die Warteschlange gestellt zu werden."
      ]
    },
    {
      "type": "p",
      "text": "Bei Qulo ist die Warteschlange schon vom Aufbau her kürzer, denn zu jemandem zu gelangen heißt, die Fragen zu beantworten, die diese Person über sich selbst geschrieben hat — 2 bis 4 davon im kostenlosen Tarif, bis zu 10 mit einem kostenpflichtigen Abo, je vier Antwortmöglichkeiten, und jede Antwort muss stimmen. Das ist ein bewusster Preis in Aufmerksamkeit, und es ist das Gegenteil des schnellen Scannens, das die Forschung beschreibt. Es macht niemanden kompatibler; es heißt nur, dass das Erste, was du über einen Menschen tust, das Lesen von etwas ist, das er geschrieben hat, statt das Einsortieren eines Fotos."
    },
    {
      "type": "quote",
      "text": "Der Befund war nie, dass Auswahl Menschen unglücklich macht. Er war, dass Aufmerksamkeit ausgeht — und dass beurteilt wird, was sich am schnellsten beurteilen lässt."
    }
  ],
  fr: [
    {
      "type": "p",
      "text": "Vous avez sans doute entendu dire que trop de choix vous rend moins bon pour choisir, et que c'est pour cela que les applications de rencontre donnent la sensation qu'elles donnent. L'explication est nette. Elle est aussi plus fragile qu'elle n'en a l'air — et la version qui survit aux données est plus précise, et plus utile, que celle qui circule."
    },
    {
      "type": "h2",
      "text": "L'affirmation générale n'a pas survécu à sa propre méta-analyse"
    },
    {
      "type": "p",
      "text": "L'idée vient d'une série d'expériences célèbres où des clients placés devant de nombreuses variantes d'un produit achetaient moins que ceux qui n'en avaient que quelques-unes. Elle s'est répandue vite parce qu'elle explique une sensation que tout le monde reconnaît. Mais en 2010, **Scheibehenne, Greifeneder et Todd** ont réuni dans le **Journal of Consumer Research** **63 conditions issues de 50 expériences** portant sur **5 036 personnes**, et ont trouvé une taille d'effet moyenne quasi nulle — avec de fortes variations d'une étude à l'autre. Certaines observaient une forte surcharge de choix. D'autres, que davantage d'options aidait."
    },
    {
      "type": "p",
      "text": "La version générale — plus d'options, moins bons résultats, toujours — n'est donc pas soutenue par les données. Si un article s'ouvre sur l'expérience de supermarché et traite l'affaire comme réglée, il a sauté le moment où la discipline a vérifié."
    },
    {
      "type": "h2",
      "text": "Les rencontres, elles, ont été mesurées à part"
    },
    {
      "type": "p",
      "text": "C'est là que cela devient intéressant, car les résultats propres aux rencontres ne parlent pas du tout de bonheur. Ils parlent de **ce à quoi vous prêtez attention**."
    },
    {
      "type": "p",
      "text": "**Lenton et Francesconi** ont analysé dans **Psychological Science** **84 soirées de speed dating** — **1 868 femmes et 1 870 hommes**. À mesure que le nombre de participants augmentait, les choix se déplaçaient vers des caractéristiques lisibles en une seconde, et s'éloignaient de celles qui demandent une conversation pour être établies. La taille et le poids ont pris du poids dans la décision. La profession et le niveau d'études en ont perdu."
    },
    {
      "type": "p",
      "text": "Personne, dans cette étude, n'a décidé de devenir superficiel. Ce déplacement est ce que fait quelqu'un quand il y a plus à traiter que d'attention à dépenser. Dans une application de rencontre, la même pression n'est pas limitée à une soirée : elle est permanente. Et les traits lisibles en une seconde sont exactement ceux que porte une photo :"
    },
    {
      "type": "ul",
      "items": [
        "Le visage, le corps, l'âge apparent — visibles avant d'avoir lu un mot",
        "La taille, quand elle est indiquée, parce que c'est un seul chiffre",
        "Le fait que les photos aient l'air chères, ce qui est une supposition sur le milieu social",
        "Tout ce à quoi est accroché un drapeau, un badge ou un intitulé de poste"
      ]
    },
    {
      "type": "h2",
      "text": "Plus vous regardez longtemps, plus vous refusez"
    },
    {
      "type": "p",
      "text": "**Pronk et Denissen** ont mené trois études là-dessus, publiées dans **Social Psychological and Personality Science**. Au fil d'une session d'évaluation de partenaires possibles, la probabilité d'en accepter un baissait d'environ **27 % entre le premier profil montré et le dernier**. Ils appellent cela un état d'esprit de rejet : plus vous parcourez d'options, plus vous devenez pessimiste sur l'ensemble."
    },
    {
      "type": "p",
      "text": "L'implication est inconfortable : la personne qui apparaît tard dans votre session n'est pas jugée sur ce qu'elle vaut. Elle est jugée par quelqu'un qui en est à sa quarantième décision. Placez-la en tête, et le même profil s'en sort mieux."
    },
    {
      "type": "h2",
      "text": "Et la satisfaction ensuite"
    },
    {
      "type": "p",
      "text": "**D'Angelo et Toma** ont testé l'après : **152 étudiants** ont choisi un partenaire dans un ensemble de **24 ou de 6**, puis on leur a demandé une semaine plus tard s'ils étaient satisfaits. Ceux qui avaient choisi parmi 24 étaient moins satisfaits de la personne retenue. À dire clairement : il s'agit d'un petit échantillon étudiant en laboratoire, pas d'une étude de relations réelles, et cela se lit comme une piste plutôt que comme un résultat sur votre vie."
    },
    {
      "type": "p",
      "text": "Mises côte à côte, les trois donnent un résumé honnête et étroit. Une longue file ne vous rend pas malheureux en soi. Elle change les parties d'une personne que vous pesez, elle vous fait refuser davantage à mesure que vous avancez, et elle peut vous laisser moins tranquille avec le choix que vous avez fait."
    },
    {
      "type": "h2",
      "text": "Ce que cela dit et ce que cela ne dit pas"
    },
    {
      "type": "ul",
      "items": [
        "**Cela ne dit pas** que moins d'options produisent de meilleures relations. Personne ne l'a mesuré.",
        "**Cela ne dit pas** que vous êtes superficiel. Cela dit que l'attention est limitée et qu'elle se dépense.",
        "**Cela dit bien** que l'endroit où quelqu'un apparaît dans votre file influence la façon dont vous le jugez.",
        "**Cela dit bien** que les traits qui demandent du temps pour être remarqués perdent quand il n'y a pas de temps."
      ]
    },
    {
      "type": "p",
      "text": "C'est une affirmation plus petite que celle qu'on entend d'habitude, et plus exploitable. Le problème n'est pas l'abondance dans l'abstrait. C'est qu'une file rapide déplace discrètement le poids de vos critères vers ce qui se juge le plus vite."
    },
    {
      "type": "h2",
      "accent": "green",
      "text": "Ce qu'on peut y faire"
    },
    {
      "type": "p",
      "text": "Rien de tout cela n'exige de supprimer quoi que ce soit. Cela exige de dépenser son attention exprès, plutôt que de l'étaler jusqu'à ce qu'il n'en reste plus par personne."
    },
    {
      "type": "ul",
      "items": [
        "Décidez à l'avance combien de personnes vous regarderez d'affilée, et arrêtez-vous là plutôt qu'au moment où vous vous ennuyez.",
        "Repérez où vous en êtes dans la session. Si vous avez dit non onze fois de suite, le douzième jugement parle de vous, pas de la personne.",
        "Ouvrez le profil avant de décider. Lire deux phrases est le moyen le moins coûteux de laisser un trait lent concourir avec un trait rapide.",
        "Quand quelque chose éveille votre curiosité, agissez le jour même. La curiosité ne survit pas à la mise en file d'attente."
      ]
    },
    {
      "type": "p",
      "text": "Sur Qulo, la file est plus courte par construction : atteindre quelqu'un passe par répondre aux questions que cette personne a écrites sur elle-même — de 2 à 4 avec l'offre gratuite, jusqu'à 10 avec un abonnement payant, quatre options chacune, et chaque réponse doit être juste. C'est un coût d'attention volontaire, et c'est l'inverse du balayage rapide que décrit la recherche. Cela ne rend personne plus compatible ; cela veut simplement dire que la première chose que vous faites d'une personne est de lire quelque chose qu'elle a écrit, plutôt que de classer une photo."
    },
    {
      "type": "quote",
      "text": "Le résultat n'a jamais été que le choix rend malheureux. Il a été que l'attention s'épuise, et que ce qui se juge le plus vite est ce qui est jugé."
    }
  ],
  es: [
    {
      "type": "p",
      "text": "Seguramente has oído que tener demasiadas opciones te hace elegir peor, y que por eso las apps de citas dan la sensación que dan. Es una explicación ordenada. También es más frágil de lo que parece: la versión que sobrevive a la evidencia es más concreta, y más útil, que la que circula."
    },
    {
      "type": "h2",
      "text": "La afirmación general no sobrevivió a su propio metaanálisis"
    },
    {
      "type": "p",
      "text": "La idea viene de una serie de experimentos famosos en los que quienes tenían delante muchas variedades de un producto compraban menos que quienes tenían pocas. Se extendió rápido porque explica una sensación que todo el mundo reconoce. Pero en 2010, **Scheibehenne, Greifeneder y Todd** reunieron en el **Journal of Consumer Research** **63 condiciones de 50 experimentos** con **5.036 personas**, y encontraron un tamaño del efecto medio prácticamente nulo, con mucha variación entre estudios. Algunos hallaron una sobrecarga de opciones fuerte. Otros hallaron que más opciones ayudaban."
    },
    {
      "type": "p",
      "text": "Así que la versión general —más opciones, peores resultados, siempre— no es algo que la evidencia sostenga. Si un artículo abre con el experimento del supermercado y da el asunto por cerrado, se ha saltado justo la parte en la que el campo lo comprobó."
    },
    {
      "type": "h2",
      "text": "Las citas, en cambio, se midieron aparte"
    },
    {
      "type": "p",
      "text": "Aquí es donde se pone interesante, porque los hallazgos específicos sobre citas no van de felicidad en absoluto. Van de **a qué le prestas atención**."
    },
    {
      "type": "p",
      "text": "**Lenton y Francesconi** analizaron en **Psychological Science** **84 eventos de citas rápidas**: **1.868 mujeres y 1.870 hombres**. A medida que subía el número de personas en un evento, quienes elegían se desplazaban hacia características que se leen en un segundo y se alejaban de las que necesitan una conversación para quedar claras. La altura y el peso ganaron peso en la decisión. La ocupación y los estudios lo perdieron."
    },
    {
      "type": "p",
      "text": "Nadie en ese estudio decidió volverse superficial. El desplazamiento es lo que hace una persona cuando hay más que revisar que atención para gastar. En una app de citas la misma presión no dura una noche, sino que es constante, y los rasgos que se leen en un segundo son exactamente los que lleva una foto:"
    },
    {
      "type": "ul",
      "items": [
        "Cara, cuerpo, edad aparente: visibles antes de haber leído una palabra",
        "La altura, si está escrita, porque es un solo número",
        "Si las fotos parecen caras, que es una suposición sobre la clase social",
        "Cualquier cosa con una bandera, una insignia o un cargo colgando de ella"
      ]
    },
    {
      "type": "h2",
      "text": "Cuanto más miras, más descartas"
    },
    {
      "type": "p",
      "text": "**Pronk y Denissen** hicieron tres estudios sobre esto, publicados en **Social Psychological and Personality Science**. A lo largo de una sesión juzgando posibles parejas, la probabilidad de aceptar a cualquiera de ellas cayó alrededor de un **27 % entre la primera persona mostrada y la última**. Lo llaman mentalidad de rechazo: cuantas más opciones recorres, más pesimista te vuelves respecto a todas."
    },
    {
      "type": "p",
      "text": "La implicación incómoda es que quien aparece tarde en tu sesión no está siendo juzgado por lo que vale. Lo juzga alguien que lleva cuarenta decisiones encima. Mueve a esa misma persona al principio y el mismo perfil sale mejor parado."
    },
    {
      "type": "h2",
      "text": "Y la satisfacción posterior"
    },
    {
      "type": "p",
      "text": "**D'Angelo y Toma** midieron lo que viene después: **152 estudiantes universitarios** eligieron pareja de un conjunto de **24 o de 6**, y una semana más tarde se les preguntó cuánta satisfacción sentían. Quienes habían elegido entre 24 estaban menos satisfechos con la persona elegida. Conviene decirlo claro: es una muestra pequeña de estudiantes en un laboratorio, no un estudio de relaciones reales, y hay que leerlo como una sugerencia y no como un hallazgo sobre tu vida."
    },
    {
      "type": "p",
      "text": "Juntando los tres, el resumen honesto queda estrecho. Una fila larga no te hace infeliz por sí sola. Cambia qué partes de una persona pesas, hace que descartes más según avanzas, y puede dejarte menos tranquilo con la elección que sí hiciste."
    },
    {
      "type": "h2",
      "text": "Qué dice esto y qué no dice"
    },
    {
      "type": "ul",
      "items": [
        "**No dice** que menos opciones produzcan mejores relaciones. Nadie lo ha medido.",
        "**No dice** que seas superficial. Dice que la atención es finita y se gasta.",
        "**Sí dice** que el lugar en el que alguien aparece en tu fila afecta a cómo lo juzgas.",
        "**Sí dice** que los rasgos que tardan en notarse pierden cuando no hay tiempo."
      ]
    },
    {
      "type": "p",
      "text": "Es una afirmación más pequeña que la que sueles oír, y más accionable. El problema no es la abundancia en abstracto. Es que una fila rápida reajusta en silencio el peso de tus criterios hacia lo que se puede juzgar más rápido."
    },
    {
      "type": "h2",
      "accent": "green",
      "text": "Qué puedes hacer al respecto"
    },
    {
      "type": "p",
      "text": "Nada de esto exige borrar nada. Exige gastar atención a propósito en lugar de repartirla hasta que no quede nada por persona."
    },
    {
      "type": "ul",
      "items": [
        "Decide de antemano a cuántas personas vas a mirar de una sentada, y para ahí en vez de parar cuando te aburras.",
        "Fíjate en qué punto de la sesión estás. Si has dicho que no once veces seguidas, el juicio número doce habla de ti, no de la otra persona.",
        "Abre el perfil antes de decidir. Leer dos frases es la manera más barata de dejar que un rasgo lento compita con uno rápido.",
        "Cuando algo te dé curiosidad, actúa ese mismo día. La curiosidad no sobrevive a quedarse en la fila."
      ]
    },
    {
      "type": "p",
      "text": "En Qulo la fila es más corta por diseño, porque llegar a alguien pasa por responder las preguntas que esa persona ha escrito sobre sí misma: de 2 a 4 en el plan gratuito, hasta 10 con un plan de pago, cuatro opciones cada una, y todas las respuestas tienen que ser correctas. Es un precio deliberado en atención, y es lo contrario del barrido rápido que describe la investigación. No hace a nadie más compatible; solo significa que lo primero que haces con una persona es leer algo que escribió, en vez de ordenar una foto."
    },
    {
      "type": "quote",
      "text": "El hallazgo nunca fue que la elección haga infeliz a la gente. Fue que la atención se agota, y que se juzga lo que se puede juzgar más rápido."
    }
  ],
  ar: [
    {
      "type": "p",
      "text": "ربما سمعت أن كثرة الخيارات تجعلك أسوأ في الاختيار، وأن هذا هو سبب الإحساس الذي تتركه فيك تطبيقات المواعدة. إنه تفسير أنيق. وهو كذلك أكثر هشاشة ممّا يبدو — والصيغة التي تصمد أمام الأدلة أضيق وأكثر نفعًا من الصيغة المتداولة."
    },
    {
      "type": "h2",
      "text": "الادعاء العام لم ينجُ من تحليله البعدي"
    },
    {
      "type": "p",
      "text": "جاءت الفكرة من مجموعة تجارب شهيرة عن متسوّقين وُضعوا أمام أصناف كثيرة من منتج واحد فاشتروا أقلّ ممّن وُضعوا أمام أصناف قليلة. وانتشرت سريعًا لأنها تشرح شعورًا يعرفه الجميع. لكن في عام 2010 جمع **شايبيهينه وغرايفينيدر وتود** ما مجموعه **63 حالة تجريبية من 50 تجربة** شملت **5,036 شخصًا** ونشروا ذلك في **Journal of Consumer Research**: متوسط حجم الأثر كان صفرًا تقريبًا، مع تباين واسع بين الدراسات. فبعضها وجد عبء اختيار قويًا، وبعضها وجد أن الخيارات الأكثر تساعد."
    },
    {
      "type": "p",
      "text": "أي أن الصيغة الشاملة — خيارات أكثر تعني نتائج أسوأ، دائمًا — ليست شيئًا تسنده الأدلة. وإذا افتتح مقال كلامه بتجربة التسوّق وعامل المسألة كأنها محسومة، فهو قد تخطّى الجزء الذي راجع فيه الميدان نفسه."
    },
    {
      "type": "h2",
      "text": "أمّا المواعدة فقيست وحدها"
    },
    {
      "type": "p",
      "text": "هنا يصبح الأمر مثيرًا، لأن النتائج الخاصة بالمواعدة لا تتعلّق بالسعادة إطلاقًا. إنها تتعلّق **بما تعطيه انتباهك**."
    },
    {
      "type": "p",
      "text": "في **Psychological Science** حلّل **لينتون وفرانتشيسكوني** ما عدده **84 فعالية للتعارف السريع** — **1,868 امرأة و1,870 رجلًا**. وكلما زاد عدد الحاضرين في الفعالية، مال المختارون نحو الصفات التي تُقرأ في ثانية، وابتعدوا عن الصفات التي تحتاج محادثة كي تتبيّن. زاد وزن الطول والوزن في القرار، وفقدت المهنة والتعليم وزنهما."
    },
    {
      "type": "p",
      "text": "لم يقرّر أحد في تلك الدراسة أن يصير سطحيًا. هذا الميل هو ما يفعله الإنسان حين يكون أمامه ما يفوق ما لديه من انتباه ينفقه. وفي تطبيق المواعدة يكون الضغط نفسه دائمًا لا محصورًا في أمسية واحدة، والصفات التي تُقرأ في ثانية هي بالضبط ما تحمله الصورة:"
    },
    {
      "type": "ul",
      "items": [
        "الوجه والجسد والعمر الظاهر — مرئية قبل أن تقرأ كلمة واحدة",
        "الطول، إن كان مكتوبًا، لأنه رقم واحد",
        "ما إذا كانت الصور تبدو باهظة، وهو تخمين عن الطبقة",
        "كل ما عُلّق عليه علم أو شارة أو مسمّى وظيفي"
      ]
    },
    {
      "type": "h2",
      "text": "كلما طال نظرك، زاد ما ترفضه"
    },
    {
      "type": "p",
      "text": "أجرى **برونك ودينيسن** ثلاث دراسات في هذا الأمر، نُشرت في **Social Psychological and Personality Science**. فعلى امتداد جلسة واحدة من تقييم شركاء محتملين، انخفض احتمال قبول أي واحد منهم بنحو **27% من أول من عُرض إلى آخرهم**. ويسمّون ذلك عقلية الرفض: كلما مررت على خيارات أكثر، ازددت تشاؤمًا حيالها جميعًا."
    },
    {
      "type": "p",
      "text": "والنتيجة المزعجة أن من يظهر متأخرًا في جلستك لا يُحكم عليه بما هو عليه، بل يحكم عليه شخص قطع أربعين قرارًا قبله. انقله إلى المقدّمة، وسيبلي الملف نفسه بلاءً أحسن."
    },
    {
      "type": "h2",
      "text": "ثم الرضا بعد ذلك"
    },
    {
      "type": "p",
      "text": "اختبر **دانجيلو وتوما** ما يأتي لاحقًا: اختار **152 طالبًا جامعيًا** شريكًا من مجموعة من **24 شخصًا أو من 6**، ثم سُئلوا بعد أسبوع عن مدى رضاهم. وكان من اختاروا من بين 24 أقلّ رضًا عمّن اختاروه. ويجدر قول ذلك صراحة: هذه عيّنة طلابية صغيرة في مختبر، لا دراسة لعلاقات حقيقية، وينبغي أن تُقرأ بوصفها إشارة لا نتيجة عن حياتك."
    },
    {
      "type": "p",
      "text": "اجمع الثلاث معًا وسيخرج التلخيص الأمين ضيّقًا. الطابور الطويل بذاته لا يجعلك تعيسًا، لكنه يغيّر أي أجزاء الإنسان تزنها، ويجعلك أكثر رفضًا كلما تقدّمت، وقد يتركك أقلّ اطمئنانًا إلى الاختيار الذي أجريته فعلًا."
    },
    {
      "type": "h2",
      "text": "ماذا يقول هذا وماذا لا يقول"
    },
    {
      "type": "ul",
      "items": [
        "**لا يقول** إن الخيارات الأقلّ تنتج علاقات أفضل. لم يقس أحد ذلك.",
        "**لا يقول** إنك سطحي. بل يقول إن الانتباه محدود وإنه ينفد.",
        "**بل يقول** إن موضع ظهور شخص في طابورك يؤثّر في حكمك عليه.",
        "**بل يقول** إن الصفات التي يستغرق تبيّنها وقتًا تخسر حين لا يكون هناك وقت."
      ]
    },
    {
      "type": "p",
      "text": "وهذا ادعاء أصغر ممّا تسمعه عادة، وأقرب إلى التطبيق. المشكلة ليست الوفرة في المطلق، بل أن الطابور السريع يعيد ترجيح معاييرك بهدوء نحو كل ما يمكن الحكم عليه أسرع."
    },
    {
      "type": "h2",
      "text": "ما العمل إذًا",
      "accent": "green"
    },
    {
      "type": "p",
      "text": "لا شيء من هذا يستلزم حذف أي شيء. إنما يستلزم أن تنفق انتباهك عن قصد، بدل أن تبسطه حتى لا يبقى منه شيء لكل شخص."
    },
    {
      "type": "ul",
      "items": [
        "قرّر مسبقًا كم شخصًا ستنظر إليه في الجلسة الواحدة، وتوقّف عند ذلك الحدّ لا حين يصيبك الملل.",
        "انتبه إلى موقعك من الجلسة. فإن قلت \"لا\" إحدى عشرة مرة متتالية، فالحكم الثاني عشر عنك أنت لا عنه.",
        "افتح الملف الشخصي قبل أن تقرّر. قراءة جملتين أرخص وسيلة تتيح لصفة بطيئة أن تنافس صفة سريعة.",
        "وإذا أثار فيك شيء الفضول، فتصرّف بشأنه في اليوم نفسه. الفضول لا يصمد في الطابور."
      ]
    },
    {
      "type": "p",
      "text": "في Qulo يكون الطابور أقصر بحكم البناء، لأن الوصول إلى شخص يمرّ بالإجابة عن الأسئلة التي كتبها عن نفسه — ما بين 2 و4 منها في الخطة المجانية، وحتى 10 في خطة مدفوعة، بأربعة خيارات لكل سؤال، وكل إجابة يجب أن تكون صحيحة. هذه كلفة مقصودة من الانتباه، وهي نقيض المسح السريع الذي تصفه الأبحاث. وهي لا تجعل أحدًا أكثر توافقًا؛ إنما تعني أن أول ما تفعله تجاه إنسان هو أن تقرأ شيئًا كتبه، لا أن ترتّب صورة."
    },
    {
      "type": "quote",
      "text": "لم تكن النتيجة يومًا أن الاختيار يجعل الناس تعساء، بل أن الانتباه ينفد، وأن ما يُحكم عليه هو أسرع ما يمكن الحكم عليه."
    }
  ],
  ru: [
    {
      "type": "p",
      "text": "Вы наверняка слышали, что от избытка вариантов человек выбирает хуже и что именно поэтому приложения для знакомств ощущаются так, как ощущаются. Объяснение аккуратное. Оно же и куда более шаткое, чем звучит, — а версия, которая выдерживает проверку данными, конкретнее и полезнее той, что ходит по рукам."
    },
    {
      "type": "h2",
      "text": "Общий тезис не пережил собственный метаанализ"
    },
    {
      "type": "p",
      "text": "Идея выросла из знаменитых экспериментов о покупателях, которые перед множеством разновидностей товара покупали меньше, чем перед несколькими. Она разошлась быстро, потому что объясняет знакомое всем ощущение. Но в 2010 году **Шайбехенне, Грайфенедер и Тодд** свели вместе **63 условия из 50 экспериментов**, охвативших **5036 человек**, и опубликовали это в **Journal of Consumer Research**: средний размер эффекта оказался практически нулевым — при большом разбросе между исследованиями. Одни находили сильную перегрузку выбором. Другие — что вариантов побольше только помогает."
    },
    {
      "type": "p",
      "text": "То есть версия «оптом» — больше вариантов, всегда хуже результат — данными не поддержана. Если текст открывается магазинным экспериментом и считает вопрос закрытым, он пропустил ту часть, где область перепроверила сама себя."
    },
    {
      "type": "h2",
      "text": "Но знакомства измеряли отдельно"
    },
    {
      "type": "p",
      "text": "Здесь и начинается интересное, потому что выводы про знакомства вообще не о счастье. Они о том, **на что вы обращаете внимание**."
    },
    {
      "type": "p",
      "text": "**Лентон и Франческони** разобрали **84 вечера быстрых свиданий** — **1868 женщин и 1870 мужчин** — в **Psychological Science**. Чем больше людей приходило на вечер, тем сильнее выбирающие смещались к признакам, которые считываются за секунду, и уходили от тех, для которых нужен разговор. Рост и вес прибавляли веса в решении. Профессия и образование его теряли."
    },
    {
      "type": "p",
      "text": "Никто в том исследовании не решал стать поверхностным. Это смещение — то, что человек делает, когда материала больше, чем внимания на него. В приложении для знакомств такое давление не ограничено одним вечером, оно постоянное, — а признаки, считываемые за секунду, это ровно то, что несёт фотография:"
    },
    {
      "type": "ul",
      "items": [
        "Лицо, фигура, видимый возраст — заметны раньше, чем вы прочли хоть слово",
        "Рост, если он указан, потому что это одно число",
        "Выглядят ли фотографии дорого — то есть догадка о социальном слое",
        "Всё, к чему прицеплены флаг, значок или должность"
      ]
    },
    {
      "type": "h2",
      "text": "Чем дольше вы смотрите, тем чаще отказываете"
    },
    {
      "type": "p",
      "text": "**Пронк и Дениссен** провели на эту тему три исследования, опубликованные в **Social Psychological and Personality Science**. За одну сессию оценивания возможных партнёров вероятность принять любого из них падала примерно на **27% от первого показанного к последнему**. Они называют это установкой на отказ: чем больше вариантов вы проходите, тем пессимистичнее смотрите на всех сразу."
    },
    {
      "type": "p",
      "text": "Неприятный вывод в том, что человека, попавшего в конец вашей сессии, оценивают не по его достоинствам. Его оценивает тот, кто уже принял сорок решений. Переставьте его в начало — и та же анкета покажет себя лучше."
    },
    {
      "type": "h2",
      "text": "И удовлетворённость потом"
    },
    {
      "type": "p",
      "text": "**Д'Анджело и Тома** проверили, что происходит после: **152 студента** выбирали партнёра из группы в **24 человека или в 6**, а через неделю их спрашивали, насколько они довольны. Те, кто выбирал из 24, были менее довольны выбранным человеком. Стоит сказать прямо: это маленькая студенческая выборка в лаборатории, а не исследование настоящих отношений, и читать это надо как подсказку, а не как вывод о вашей жизни."
    },
    {
      "type": "p",
      "text": "Сложите три работы вместе — и честное резюме окажется узким. Длинная очередь сама по себе не делает вас несчастным. Она меняет, какие части человека вы взвешиваете, заставляет вас отказывать всё чаще по ходу дела и может оставить вас менее уверенным в том выборе, который вы всё-таки сделали."
    },
    {
      "type": "h2",
      "text": "Что отсюда следует и что нет"
    },
    {
      "type": "ul",
      "items": [
        "**Не следует**, что меньше вариантов дают лучшие отношения. Этого никто не измерял.",
        "**Не следует**, что вы поверхностны. Следует, что внимание конечно и расходуется.",
        "**Следует**, что место человека в вашей очереди влияет на то, как вы его оцениваете.",
        "**Следует**, что признаки, которые нужно успеть заметить, проигрывают там, где времени нет."
      ]
    },
    {
      "type": "p",
      "text": "Это утверждение меньше того, которое вы обычно слышите, и с ним можно что-то сделать. Проблема не в изобилии как таковом. Проблема в том, что быстрая очередь тихо смещает веса ваших критериев в сторону всего, что оценивается быстрее всего."
    },
    {
      "type": "h2",
      "text": "Что с этим делать",
      "accent": "green"
    },
    {
      "type": "p",
      "text": "Ничего из этого не требует что-то удалять. Требуется тратить внимание намеренно, а не размазывать его так, что на человека не остаётся ничего."
    },
    {
      "type": "ul",
      "items": [
        "Заранее решите, сколько людей посмотрите за один заход, и остановитесь там, а не тогда, когда станет скучно.",
        "Замечайте, в какой точке сессии вы находитесь. Если вы одиннадцать раз подряд сказали «нет», двенадцатое решение — про вас, а не про него.",
        "Открывайте анкету до решения. Прочитать два предложения — самый дешёвый способ дать медленному признаку посоревноваться с быстрым.",
        "Если что-то вызвало любопытство, сделайте с этим что-нибудь в тот же день. Любопытство не переживает очереди."
      ]
    },
    {
      "type": "p",
      "text": "В Qulo очередь короче по устройству, потому что дойти до человека можно, только ответив на вопросы, которые он написал о себе, — от 2 до 4 на бесплатном тарифе, до 10 на платном, по четыре варианта в каждом, и все ответы должны быть верными. Это осознанная плата вниманием и полная противоположность быстрому просмотру, который описывают исследования. Совместимее это никого не делает; просто первое, что вы делаете с человеком, — читаете написанное им, а не ранжируете фотографию."
    },
    {
      "type": "quote",
      "text": "Вывод никогда не состоял в том, что выбор делает людей несчастными. Он состоял в том, что внимание заканчивается, и оценённым оказывается то, что быстрее всего оценить."
    }
  ],
  pt: [
    {
      "type": "p",
      "text": "Você provavelmente já ouviu que ter opções demais faz você escolher pior, e que é por isso que os aplicativos de relacionamento parecem o que parecem. É uma explicação arrumadinha. Também é mais frágil do que soa — e a versão que sobrevive às evidências é mais específica, e mais útil, do que a que circula por aí."
    },
    {
      "type": "h2",
      "text": "A afirmação geral não sobreviveu à própria meta-análise"
    },
    {
      "type": "p",
      "text": "A ideia vem de um conjunto de experimentos famosos sobre compradores que, diante de muitas variedades de um produto, compravam menos do que compradores diante de poucas. Espalhou-se rápido porque explica uma sensação que todo mundo reconhece. Mas em 2010, **Scheibehenne, Greifeneder e Todd** reuniram **63 condições de 50 experimentos** cobrindo **5.036 pessoas** no **Journal of Consumer Research**, e encontraram um tamanho de efeito médio de praticamente zero — com ampla variação entre os estudos. Alguns encontraram sobrecarga de escolha forte. Outros encontraram que mais opções ajudavam."
    },
    {
      "type": "p",
      "text": "Ou seja, a versão que cobre tudo — mais opções, resultados piores, sempre — não é algo que as evidências sustentem. Se um artigo abre com o estudo do supermercado e trata o assunto como resolvido, ele pulou a parte em que a própria área foi conferir."
    },
    {
      "type": "h2",
      "text": "O namoro, porém, foi medido à parte"
    },
    {
      "type": "p",
      "text": "É aqui que fica interessante, porque os achados específicos sobre namoro não têm nada a ver com felicidade. Têm a ver com **aquilo a que você presta atenção**."
    },
    {
      "type": "p",
      "text": "**Lenton e Francesconi** analisaram **84 eventos de encontros rápidos** — **1.868 mulheres e 1.870 homens** — na **Psychological Science**. À medida que o número de pessoas num evento subia, quem escolhia se deslocava para características que dá para ler num segundo, e se afastava daquelas que só uma conversa estabelece. Altura e peso ganharam peso na decisão. Profissão e escolaridade perderam."
    },
    {
      "type": "p",
      "text": "Ninguém naquele estudo decidiu ficar superficial. O deslocamento é o que uma pessoa faz quando há mais coisa para percorrer do que atenção para gastar. Num aplicativo de relacionamento a mesma pressão é constante, e não limitada a uma noite, e os traços que se leem num segundo são exatamente os que uma fotografia carrega:"
    },
    {
      "type": "ul",
      "items": [
        "Rosto, corpo, idade aparente — visíveis antes de você ler uma palavra",
        "Altura, se estiver escrita, porque é um número só",
        "Se as fotos parecem caras, o que é um palpite sobre classe social",
        "Qualquer coisa com uma bandeira, um selo ou um cargo pendurado"
      ]
    },
    {
      "type": "h2",
      "text": "Quanto mais tempo você olha, mais gente você recusa"
    },
    {
      "type": "p",
      "text": "**Pronk e Denissen** conduziram três estudos sobre isso, publicados na **Social Psychological and Personality Science**. Ao longo de uma sessão avaliando parceiros em potencial, a chance de aceitar qualquer um deles caiu cerca de **27% do primeiro mostrado para o último**. Eles chamam isso de mentalidade de rejeição: quanto mais opções você percorre, mais pessimista você fica em relação a todas elas."
    },
    {
      "type": "p",
      "text": "A implicação incômoda é que a pessoa que aparece tarde na sua sessão não está sendo julgada pelos próprios méritos. Está sendo julgada por alguém quarenta decisões adentro. Coloque essa pessoa no começo e o mesmo perfil se sai melhor."
    },
    {
      "type": "h2",
      "text": "E a satisfação depois"
    },
    {
      "type": "p",
      "text": "**D'Angelo e Toma** testaram o depois: **152 universitários** escolheram um parceiro num grupo de **24 ou de 6**, e uma semana depois foram perguntados o quanto estavam satisfeitos. Quem havia escolhido entre 24 estava menos satisfeito com a pessoa escolhida. Vale dizer com todas as letras: é uma amostra pequena de estudantes em laboratório, não um estudo de relacionamentos reais, e deve ser lido como uma sugestão, não como um achado sobre a sua vida."
    },
    {
      "type": "p",
      "text": "Juntando os três, o resumo honesto é estreito. Uma fila longa não deixa você infeliz por si só. Ela muda quais partes de uma pessoa você pesa, faz você recusar mais conforme avança e pode deixar você menos tranquilo com a escolha que fez."
    },
    {
      "type": "h2",
      "text": "O que isso diz e o que não diz"
    },
    {
      "type": "ul",
      "items": [
        "**Não diz** que menos opções produzem relacionamentos melhores. Ninguém mediu isso.",
        "**Não diz** que você é superficial. Diz que a atenção é finita e se gasta.",
        "**Diz, sim,** que o lugar onde alguém aparece na sua fila afeta como você o julga.",
        "**Diz, sim,** que traços que levam tempo para notar saem perdendo quando não há tempo."
      ]
    },
    {
      "type": "p",
      "text": "O que é uma afirmação menor do que a que você costuma ouvir, e mais acionável. O problema não é a abundância em abstrato. É que uma fila rápida redistribui em silêncio o peso dos seus critérios em direção a tudo aquilo que puder ser julgado mais rápido."
    },
    {
      "type": "h2",
      "text": "O que fazer a respeito",
      "accent": "green"
    },
    {
      "type": "p",
      "text": "Nada disso exige apagar coisa nenhuma. Exige gastar atenção de propósito, em vez de espalhá-la até não sobrar nenhuma por pessoa."
    },
    {
      "type": "ul",
      "items": [
        "Decida de antemão quantas pessoas você vai ver numa sentada, e pare aí, não quando o tédio bater.",
        "Perceba em que ponto da sessão você está. Se você disse \"não\" onze vezes seguidas, o décimo segundo julgamento é sobre você, não sobre a pessoa.",
        "Abra o perfil antes de decidir. Ler duas frases é o jeito mais barato de deixar um traço lento competir com um rápido.",
        "Quando algo despertar a sua curiosidade, aja no mesmo dia. Curiosidade não sobrevive a entrar na fila."
      ]
    },
    {
      "type": "p",
      "text": "No Qulo a fila é mais curta por construção, porque chegar até alguém passa por responder as perguntas que essa pessoa escreveu sobre si mesma — de 2 a 4 delas no plano gratuito, até 10 num plano pago, quatro alternativas em cada uma, e todas as respostas têm de estar certas. É um custo deliberado em atenção, e é o oposto da varredura rápida que a pesquisa descreve. Isso não torna ninguém mais compatível; só significa que a primeira coisa que você faz a respeito de uma pessoa é ler algo que ela escreveu, em vez de classificar uma fotografia."
    },
    {
      "type": "quote",
      "text": "O achado nunca foi que a escolha deixa as pessoas infelizes. Foi que a atenção acaba, e o que for mais rápido de julgar é o que acaba julgado."
    }
  ],
  it: [
    {
      "type": "p",
      "text": "Avrai sentito dire che avere troppe opzioni ti fa scegliere peggio, e che è per questo che le app di incontri danno la sensazione che danno. È una spiegazione ordinata. Ed è anche più fragile di quanto sembri — perché la versione che sopravvive alle prove è più precisa, e più utile, di quella che circola."
    },
    {
      "type": "h2",
      "text": "L'affermazione generale non è sopravvissuta alla propria meta-analisi"
    },
    {
      "type": "p",
      "text": "L'idea nasce da una serie di esperimenti famosi in cui i clienti davanti a molte varianti di un prodotto compravano meno di quelli che ne avevano poche. Si è diffusa in fretta perché spiega una sensazione che tutti riconoscono. Ma nel 2010 **Scheibehenne, Greifeneder e Todd** hanno messo insieme sul **Journal of Consumer Research** **63 condizioni tratte da 50 esperimenti** su **5.036 persone**, e hanno trovato una dimensione dell'effetto media praticamente nulla, con una forte variabilità tra gli studi. Alcuni trovavano un sovraccarico di scelta netto. Altri trovavano che più opzioni aiutavano."
    },
    {
      "type": "p",
      "text": "La versione generale — più opzioni, risultati peggiori, sempre — non è quindi sostenuta dalle prove. Se un articolo apre con l'esperimento al supermercato e dà la questione per chiusa, ha saltato proprio il punto in cui la disciplina ha verificato."
    },
    {
      "type": "h2",
      "text": "Gli incontri, però, sono stati misurati a parte"
    },
    {
      "type": "p",
      "text": "Qui la cosa si fa interessante, perché i risultati specifici sugli incontri non parlano affatto di felicità. Parlano di **a che cosa presti attenzione**."
    },
    {
      "type": "p",
      "text": "**Lenton e Francesconi** hanno analizzato su **Psychological Science** **84 serate di speed dating**: **1.868 donne e 1.870 uomini**. Man mano che il numero di presenti a una serata saliva, chi sceglieva si spostava verso caratteristiche leggibili in un secondo e si allontanava da quelle che richiedono una conversazione per emergere. Altezza e peso hanno acquistato peso nella decisione. Lavoro e istruzione l'hanno perso."
    },
    {
      "type": "p",
      "text": "Nessuno, in quello studio, ha deciso di diventare superficiale. Lo spostamento è ciò che fa una persona quando c'è più roba da smaltire di quanta attenzione ci sia da spendere. In un'app di incontri la stessa pressione non dura una sera: è costante. E i tratti che si leggono in un secondo sono esattamente quelli che una foto porta con sé:"
    },
    {
      "type": "ul",
      "items": [
        "Viso, corpo, età apparente — visibili prima che tu abbia letto una parola",
        "L'altezza, se è scritta, perché è un numero solo",
        "Se le foto sembrano costose, che è un'ipotesi sulla classe sociale",
        "Qualsiasi cosa a cui sia attaccata una bandiera, un distintivo o un titolo di lavoro"
      ]
    },
    {
      "type": "h2",
      "text": "Più a lungo guardi, più scarti"
    },
    {
      "type": "p",
      "text": "**Pronk e Denissen** hanno condotto tre studi su questo, pubblicati su **Social Psychological and Personality Science**. Nel corso di una sessione di valutazione di potenziali partner, la probabilità di accettarne uno qualsiasi è scesa di circa il **27% dal primo mostrato all'ultimo**. La chiamano mentalità del rifiuto: più opzioni attraversi, più diventi pessimista su tutte."
    },
    {
      "type": "p",
      "text": "L'implicazione scomoda è che chi compare tardi nella tua sessione non viene giudicato per quello che vale. Viene giudicato da qualcuno che è a quaranta decisioni di profondità. Sposta la stessa persona all'inizio e lo stesso profilo va meglio."
    },
    {
      "type": "h2",
      "text": "E la soddisfazione dopo"
    },
    {
      "type": "p",
      "text": "**D'Angelo e Toma** hanno testato il dopo: **152 studenti universitari** hanno scelto un partner da un insieme di **24 o di 6**, e una settimana più tardi è stato chiesto loro quanto fossero soddisfatti. Chi aveva scelto tra 24 era meno soddisfatto della persona scelta. Vale la pena dirlo chiaramente: è un piccolo campione di studenti in laboratorio, non uno studio su relazioni reali, e va letto come un indizio, non come un risultato sulla tua vita."
    },
    {
      "type": "p",
      "text": "Messi insieme, i tre danno un riassunto onesto e stretto. Una fila lunga non ti rende infelice di per sé. Cambia quali parti di una persona pesi, ti fa scartare di più man mano che vai avanti, e può lasciarti meno tranquillo sulla scelta che hai fatto."
    },
    {
      "type": "h2",
      "text": "Che cosa dice e che cosa non dice"
    },
    {
      "type": "ul",
      "items": [
        "**Non dice** che meno opzioni producano relazioni migliori. Nessuno l'ha misurato.",
        "**Non dice** che sei superficiale. Dice che l'attenzione è limitata e si consuma.",
        "**Dice invece** che il punto in cui qualcuno compare nella tua fila influisce su come lo giudichi.",
        "**Dice invece** che i tratti che richiedono tempo per essere notati perdono quando tempo non ce n'è."
      ]
    },
    {
      "type": "p",
      "text": "È un'affermazione più piccola di quella che si sente di solito, e più utilizzabile. Il problema non è l'abbondanza in astratto. È che una fila veloce sposta in silenzio il peso dei tuoi criteri verso ciò che si giudica più in fretta."
    },
    {
      "type": "h2",
      "accent": "green",
      "text": "Che cosa farci"
    },
    {
      "type": "p",
      "text": "Niente di tutto questo richiede di cancellare qualcosa. Richiede di spendere attenzione di proposito, invece di spalmarla finché non ne resta più per nessuno."
    },
    {
      "type": "ul",
      "items": [
        "Decidi in anticipo quante persone guarderai in una seduta, e fermati lì invece che quando ti annoi.",
        "Nota a che punto della sessione sei. Se hai detto no undici volte di fila, il dodicesimo giudizio riguarda te, non l'altra persona.",
        "Apri il profilo prima di decidere. Leggere due frasi è il modo più economico per far competere un tratto lento con uno veloce.",
        "Quando qualcosa ti incuriosisce, muoviti quel giorno stesso. La curiosità non sopravvive alla fila."
      ]
    },
    {
      "type": "p",
      "text": "Su Qulo la fila è più corta per come è costruita, perché arrivare a qualcuno significa rispondere alle domande che quella persona ha scritto su di sé — da 2 a 4 con il piano gratuito, fino a 10 con un piano a pagamento, quattro opzioni ciascuna, e ogni risposta deve essere giusta. È un costo di attenzione voluto, ed è l'opposto della scansione veloce che la ricerca descrive. Non rende nessuno più compatibile; significa soltanto che la prima cosa che fai di una persona è leggere qualcosa che ha scritto, invece di mettere in classifica una foto."
    },
    {
      "type": "quote",
      "text": "Il risultato non è mai stato che la scelta rende infelici. È stato che l'attenzione si esaurisce, e che a essere giudicato è ciò che si giudica più in fretta."
    }
  ],
  ja: [
    {
      "type": "p",
      "text": "選択肢が多すぎると人は選ぶのが下手になる、だからマッチングアプリはああいう感じなのだ——そう聞いたことがあるはずです。きれいに片づく説明です。そして、聞こえるほど盤石ではありません。証拠を生き延びた版は、世に出回っている版よりも狭く、そのぶん役に立ちます。"
    },
    {
      "type": "h2",
      "text": "一般論のほうは、自身のメタ分析を生き延びませんでした"
    },
    {
      "type": "p",
      "text": "発想のもとは、ある商品の種類がたくさん並んだ棚の前に立った買い物客が、少ない棚の前に立った客より買わなくなる、という有名な一連の実験です。誰もが心当たりのある感覚を説明してくれるので、一気に広まりました。ところが2010年、**Scheibehenne、Greifeneder、Todd** の三氏が **Journal of Consumer Research** で **50の実験から63の条件**、のべ **5,036人** をまとめたところ、平均の効果量はほぼゼロでした——しかも研究ごとのばらつきが大きい。強い選択過多（choice overload）を見つけた研究もあれば、選択肢が多いほうが助けになったと見つけた研究もありました。"
    },
    {
      "type": "p",
      "text": "つまり、何でも一括りにした版——選択肢が増えれば結果は必ず悪くなる——は、証拠が支えているものではありません。買い物の実験で書き出して話は決着済みとして扱う記事があれば、その分野が自分で検算した部分を飛ばしています。"
    },
    {
      "type": "h2",
      "text": "ただし、出会いは別に測られました"
    },
    {
      "type": "p",
      "text": "面白くなるのはここからです。出会いに絞った知見は、そもそも幸福度の話ではないからです。**あなたが何に注意を向けるか**の話なのです。"
    },
    {
      "type": "p",
      "text": "**Lenton と Francesconi** の両氏は **Psychological Science** で、**スピードデートのイベント84回**——**女性1,868人と男性1,870人**——を分析しました。イベントの参加人数が増えるほど、選ぶ側は一秒で読める特徴のほうへ寄り、会話をしないと分からない特徴から離れていきました。身長と体重が判断のなかで重みを増し、職業と学歴は重みを失いました。"
    },
    {
      "type": "p",
      "text": "その研究で、浅くなろうと決めた人は一人もいません。この移動は、注げる注意より片づけるべき量のほうが多いときに人がすることです。マッチングアプリでは同じ圧力が一晩ぶんではなく常時かかっていて、一秒で読める特徴とは、まさに写真が運ぶものです。"
    },
    {
      "type": "ul",
      "items": [
        "顔、体つき、見た目の年齢——一語も読まないうちに見えるもの",
        "書いてあれば身長。数字がひとつだからです",
        "写真が高そうに見えるかどうか。これは階層についての推測です",
        "旗やバッジや肩書きが付いているもの、すべて"
      ]
    },
    {
      "type": "h2",
      "text": "長く見るほど、断る数は増えます"
    },
    {
      "type": "p",
      "text": "**Pronk と Denissen** の両氏はこれについて三つの研究を行い、**Social Psychological and Personality Science** に発表しました。候補を判断していく一回の作業のなかで、任意の相手を受け入れる確率は **最初に見せられた人から最後の人までで約27%下がりました**。二人はこれを拒絶マインドセット（rejection mind-set）と呼びます。通り過ぎた選択肢が増えるほど、そのすべてに対して悲観的になっていく、ということです。"
    },
    {
      "type": "p",
      "text": "居心地の悪い含意はこうです。あなたの作業の終盤に現れた人は、その人自身の中身で判断されていません。四十の判断を通り抜けてきた誰かに判断されています。同じプロフィールを先頭に動かせば、結果はよくなります。"
    },
    {
      "type": "h2",
      "text": "そして、あとに残る満足度"
    },
    {
      "type": "p",
      "text": "**D'Angelo と Toma** の両氏はその後日談を検証しました。**152人の大学生**が **24人** または **6人** の候補群から相手を選び、一週間後にどれくらい満足しているかを尋ねられました。24人から選んだ人たちのほうが、自分の選んだ相手への満足度が低くなりました。はっきり言っておく価値があります。これは実験室での小さな学生サンプルであって、現実の関係を調べた研究ではありません。あなたの人生についての結論ではなく、ひとつの示唆として読むべきものです。"
    },
    {
      "type": "p",
      "text": "三つの知見を並べて出てくる正直な要約は、狭いものです。長い行列そのものがあなたを不幸にするわけではありません。人のどの部分を量るかを変え、進むほどあなたを断る側に寄せ、実際に下した選択について落ち着きにくくさせるかもしれない——言えるのはそこまでです。"
    },
    {
      "type": "h2",
      "text": "これが言っていること、言っていないこと"
    },
    {
      "type": "ul",
      "items": [
        "**言っていないこと:** 選択肢が少ないほうが良い関係を生む。それを測った人は誰もいません。",
        "**言っていないこと:** あなたが浅い。言っているのは、注意は有限で、使えばなくなるということです。",
        "**言っていること:** 誰かが自分の行列のどこに現れるかが、その人をどう判断するかに影響する。",
        "**言っていること:** 気づくのに時間がかかる特徴は、時間がないときに負ける。"
      ]
    },
    {
      "type": "p",
      "text": "これは、ふだん耳にする主張より小さく、そのぶん手が付けやすい主張です。問題は抽象的な意味での豊富さではありません。速い行列が、あなたの基準を「いちばん速く判断できるもの」のほうへ静かに重みづけし直してしまうことです。"
    },
    {
      "type": "h2",
      "text": "では、どうすればいいか",
      "accent": "green"
    },
    {
      "type": "p",
      "text": "どれも何かを消すことを求めていません。求めているのは、一人あたりに何も残らなくなるまで注意を薄く広げるのではなく、意図して注意を使うことです。"
    },
    {
      "type": "ul",
      "items": [
        "一度に何人まで見るかを先に決めて、飽きたときではなくそこで止めましょう。",
        "自分がその作業のどのあたりにいるかに気づきましょう。十一回続けてノーと言ったなら、十二回目の判断は相手ではなくあなたの話です。",
        "決める前にプロフィールを開きましょう。二文読むことは、遅い特徴に速い特徴と競わせるいちばん安上がりな方法です。",
        "気になったものがあれば、その日のうちに動きましょう。好奇心は行列に並ばされると生き残りません。"
      ]
    },
    {
      "type": "p",
      "text": "Qulo では行列が構造的に短くなります。誰かに届くには、その人が自分について書いた質問に答える必要があるからです——無料プランなら2問から4問、有料プランなら最大10問、それぞれ四択で、すべて正解しなければなりません。これは注意という意味での意図的なコストで、研究が描く速いスキャンとは正反対です。それで誰かの相性が良くなるわけではありません。ただ、ある人について最初にすることが、写真を格付けすることではなく、その人が書いたものを読むことになる、というだけです。"
    },
    {
      "type": "quote",
      "text": "知見は、選択が人を不幸にするというものでは一度もありませんでした。注意が尽きること、そして最も速く判断できるものが判断されること——それが知見でした。"
    }
  ],
  ko: [
    {
      "type": "p",
      "text": "선택지가 너무 많으면 고르는 일을 더 못하게 되고, 데이팅 앱이 그렇게 느껴지는 이유도 그것이라는 말을 들어 보셨을 겁니다. 깔끔한 설명입니다. 그리고 들리는 것보다 훨씬 흔들립니다 — 증거를 통과한 판본은 유통되는 판본보다 좁고, 그만큼 더 쓸모 있습니다."
    },
    {
      "type": "h2",
      "text": "일반론은 자기 메타분석을 통과하지 못했습니다"
    },
    {
      "type": "p",
      "text": "이 발상은 한 제품의 종류가 많이 놓인 매대 앞의 손님이 적게 놓인 매대 앞의 손님보다 덜 산다는 유명한 실험들에서 왔습니다. 누구나 아는 감각을 설명해 주기 때문에 빠르게 퍼졌습니다. 그런데 2010년 **Scheibehenne, Greifeneder, Todd**가 **Journal of Consumer Research**에서 **50개 실험의 63개 조건**, 모두 **5,036명**을 모아 분석한 결과, 평균 효과 크기는 사실상 없는 것과 다름없었습니다 — 연구들 사이의 편차는 컸습니다. 강한 선택 과부하(choice overload)를 찾은 연구도 있었고, 선택지가 많은 편이 도움이 되었다고 찾은 연구도 있었습니다."
    },
    {
      "type": "p",
      "text": "그러니 모든 경우를 덮는 판본 — 선택지가 많으면 결과는 언제나 나빠진다 — 은 증거가 뒷받침하는 이야기가 아닙니다. 어떤 글이 쇼핑 실험으로 시작해 문제를 끝난 일로 다룬다면, 그 분야가 스스로 검산한 대목을 건너뛴 것입니다."
    },
    {
      "type": "h2",
      "text": "다만 연애는 따로 측정되었습니다"
    },
    {
      "type": "p",
      "text": "흥미로워지는 지점이 여기입니다. 연애에 국한된 결과들은 애초에 행복에 관한 것이 아니기 때문입니다. 그것들은 **당신이 무엇에 주의를 기울이는지**에 관한 것입니다."
    },
    {
      "type": "p",
      "text": "**Lenton과 Francesconi**는 **Psychological Science**에서 **스피드 데이팅 행사 84회** — **여성 1,868명과 남성 1,870명** — 를 분석했습니다. 행사에 온 사람 수가 늘수록 고르는 쪽은 일 초 만에 읽히는 특징으로 옮겨 갔고, 대화를 해야 알 수 있는 특징에서는 멀어졌습니다. 키와 몸무게가 판단에서 무게를 얻었고, 직업과 학력은 잃었습니다."
    },
    {
      "type": "p",
      "text": "그 연구에서 얄팍해지기로 결심한 사람은 아무도 없습니다. 이 이동은 쓸 수 있는 주의보다 처리할 것이 많을 때 사람이 하는 일입니다. 데이팅 앱에서는 같은 압력이 하룻저녁이 아니라 늘 걸려 있고, 일 초 만에 읽히는 특징은 정확히 사진이 실어 나르는 것들입니다."
    },
    {
      "type": "ul",
      "items": [
        "얼굴, 몸, 겉으로 보이는 나이 — 한 글자도 읽기 전에 보인다",
        "적혀 있다면 키. 숫자 하나이기 때문이다",
        "사진이 비싸 보이는지 여부. 이건 계층에 대한 짐작이다",
        "깃발이나 배지, 직함이 붙은 모든 것"
      ]
    },
    {
      "type": "h2",
      "text": "오래 볼수록 더 많이 거절합니다"
    },
    {
      "type": "p",
      "text": "**Pronk와 Denissen**은 이에 대해 세 편의 연구를 진행해 **Social Psychological and Personality Science**에 실었습니다. 후보를 판단하는 한 회기 동안, 주어진 상대를 받아들일 확률은 **처음 보여 준 사람에서 마지막 사람까지 약 27% 떨어졌습니다**. 두 사람은 이를 거절 마인드셋(rejection mind-set)이라고 부릅니다. 넘긴 선택지가 많아질수록 그 모두에 대해 더 비관적이 된다는 뜻입니다."
    },
    {
      "type": "p",
      "text": "불편한 함의는 이렇습니다. 당신의 회기 후반부에 나타난 사람은 자기 자신의 됨됨이로 평가받지 않습니다. 마흔 번의 결정을 지나온 누군가에게 평가받습니다. 같은 프로필을 앞으로 옮기면 결과가 더 좋아집니다."
    },
    {
      "type": "h2",
      "text": "그리고 그 뒤의 만족도"
    },
    {
      "type": "p",
      "text": "**D'Angelo와 Toma**는 그 뒤를 검증했습니다. **대학생 152명**이 **24명** 또는 **6명**의 후보군에서 상대를 골랐고, 일주일 뒤에 얼마나 만족하는지 질문을 받았습니다. 24명 중에서 고른 사람들은 자기가 고른 상대에 대해 덜 만족했습니다. 분명히 말해 둘 필요가 있습니다. 이것은 실험실의 작은 학생 표본이지 실제 관계를 조사한 연구가 아니며, 당신의 삶에 대한 결론이 아니라 하나의 시사점으로 읽어야 합니다."
    },
    {
      "type": "p",
      "text": "세 가지 결과를 나란히 놓으면 정직한 요약은 좁습니다. 긴 줄 자체가 당신을 불행하게 만들지는 않습니다. 그것은 사람의 어느 부분을 저울에 올릴지를 바꾸고, 진행할수록 당신을 더 거절하는 쪽으로 밀며, 이미 내린 선택에 대해 덜 자리 잡게 만들 수 있습니다."
    },
    {
      "type": "h2",
      "text": "이것이 말해 주는 것과 말해 주지 않는 것"
    },
    {
      "type": "ul",
      "items": [
        "**말하지 않습니다:** 선택지가 적으면 더 나은 관계가 만들어진다. 그것을 측정한 사람은 없습니다.",
        "**말하지 않습니다:** 당신이 얄팍하다. 주의는 유한하고 쓰면 없어진다고 말할 뿐입니다.",
        "**말합니다:** 누군가가 당신의 줄에서 어디쯤 나타나는지가 그를 어떻게 판단할지에 영향을 줍니다.",
        "**말합니다:** 알아차리는 데 시간이 걸리는 특징은 시간이 없을 때 밀려납니다."
      ]
    },
    {
      "type": "p",
      "text": "이것은 흔히 듣는 주장보다 작고, 그만큼 손댈 수 있는 주장입니다. 문제는 추상적인 의미의 풍요가 아닙니다. 빠른 줄이 당신의 기준을 가장 빨리 판단할 수 있는 쪽으로 조용히 다시 가중한다는 것입니다."
    },
    {
      "type": "h2",
      "text": "그래서 무엇을 하면 되나",
      "accent": "green"
    },
    {
      "type": "p",
      "text": "어느 것도 무언가를 지우라고 요구하지 않습니다. 요구하는 것은, 사람마다 남는 것이 없을 때까지 주의를 펼치는 대신 의도해서 주의를 쓰는 일입니다."
    },
    {
      "type": "ul",
      "items": [
        "한 번 앉아서 몇 명을 볼지 미리 정하고, 지칠 때가 아니라 거기서 멈추세요.",
        "자신이 회기의 어디쯤인지 알아차리세요. 연달아 열한 번 아니라고 했다면 열두 번째 판단은 상대가 아니라 당신에 관한 것입니다.",
        "결정하기 전에 프로필을 여세요. 두 문장을 읽는 것은 느린 특징이 빠른 특징과 겨루게 해 주는 가장 값싼 방법입니다.",
        "무언가 궁금해졌다면 그날 안에 움직이세요. 호기심은 줄을 세워 두면 살아남지 못합니다."
      ]
    },
    {
      "type": "p",
      "text": "Qulo에서는 줄이 구조적으로 짧습니다. 누군가에게 닿으려면 그 사람이 자기에 대해 쓴 질문에 답해야 하기 때문입니다 — 무료 플랜에서는 2개에서 4개, 유료 플랜에서는 최대 10개이고, 각 질문에 선택지는 네 개이며, 전부 맞혀야 합니다. 이것은 주의로 치르는 의도된 비용이고, 연구가 묘사하는 빠른 훑기의 정반대입니다. 그렇다고 누가 더 잘 맞게 되는 것은 아닙니다. 다만 어떤 사람에 대해 당신이 가장 먼저 하는 일이 사진의 순위를 매기는 것이 아니라 그 사람이 쓴 것을 읽는 일이 된다는 뜻입니다."
    },
    {
      "type": "quote",
      "text": "결과는 선택이 사람을 비참하게 만든다는 것이 결코 아니었습니다. 주의가 바닥난다는 것, 그리고 가장 빨리 판단할 수 있는 것이 판단된다는 것이었습니다."
    }
  ],
  zh: [
    {
      "type": "p",
      "text": "你大概听过这样的说法：可选的太多，人反而更不会选，而交友软件之所以是现在这个样子，原因就在这里。这是个干净利落的解释。它也比听上去更站不住脚——真正经得起证据的那个版本更窄，也更有用。"
    },
    {
      "type": "h2",
      "text": "笼统的说法没能通过自己的元分析"
    },
    {
      "type": "p",
      "text": "这个想法来自一组著名实验：面对同一种商品的很多款式的顾客，比面对很少款式的顾客买得更少。它传播得很快，因为它解释了一种人人都认得出的感觉。但在 2010 年，**Scheibehenne、Greifeneder 与 Todd** 在 **Journal of Consumer Research** 上汇总了 **50 项实验中的 63 个条件**、共 **5,036 人**，发现平均效应量几乎为零——而且研究之间的差异很大。有的研究发现了很强的选择过载（choice overload），有的则发现选项多反而帮上了忙。"
    },
    {
      "type": "p",
      "text": "所以，那个一概而论的版本——选项越多，结果总是越糟——并不是证据支持的东西。如果一篇文章以购物实验开场，并把这件事当成已有定论，那它跳过的正是这个领域自己复核的那一段。"
    },
    {
      "type": "h2",
      "text": "不过，约会是被单独测量过的"
    },
    {
      "type": "p",
      "text": "有意思的地方从这里开始，因为专门针对约会的那些发现，根本不是关于幸福感的。它们关于的是**你把注意力放在什么上面**。"
    },
    {
      "type": "p",
      "text": "**Lenton 与 Francesconi** 在 **Psychological Science** 上分析了 **84 场快速约会活动**——**1,868 名女性和 1,870 名男性**。随着一场活动里人数增加，做选择的人向那些一秒钟就能读出来的特征偏移，而远离那些需要一段对话才能确认的特征。身高和体重在决定里变重了，职业和学历变轻了。"
    },
    {
      "type": "p",
      "text": "那项研究里没有人决定要变得肤浅。这种偏移，是一个人在要处理的东西多过能花的注意力时会做的事。在交友软件里，同样的压力不是持续一个晚上，而是一直都在；而一秒钟就能读出来的特征，恰恰是一张照片所承载的："
    },
    {
      "type": "ul",
      "items": [
        "脸、身材、看上去的年纪——你还没读到一个字就已经看见了",
        "身高，如果写了的话，因为它只是一个数字",
        "照片看起来贵不贵，这是对阶层的一种猜测",
        "任何带着旗子、徽章或职位头衔的东西"
      ]
    },
    {
      "type": "h2",
      "text": "你看得越久，拒绝得越多"
    },
    {
      "type": "p",
      "text": "**Pronk 与 Denissen** 就此做了三项研究，发表在 **Social Psychological and Personality Science** 上。在一场评估潜在对象的过程中，接受其中任何一个人的概率，**从第一个出现的到最后一个下降了大约 27%**。他们把这叫作拒绝心态（rejection mind-set）：你翻过的选项越多，对所有这些人就越悲观。"
    },
    {
      "type": "p",
      "text": "让人不太舒服的推论是：在你这一轮里出现得晚的人，并不是按他自己的样子被评判的。评判他的，是一个已经做了四十次决定的人。把同一份资料挪到最前面，它的结果就会更好。"
    },
    {
      "type": "h2",
      "text": "以及事后的满意度"
    },
    {
      "type": "p",
      "text": "**D'Angelo 与 Toma** 检验了后续：**152 名大学生**从 **24 人**或 **6 人**的候选池里挑一个对象，一周之后被问及有多满意。从 24 人里挑的人，对自己挑中的对象更不满意。有必要说清楚：这是实验室里一个很小的学生样本，不是对真实关系的研究，应该被当作一种提示来读，而不是关于你生活的结论。"
    },
    {
      "type": "p",
      "text": "把这三条发现放在一起，诚实的总结是很窄的。长队本身不会让你不开心。它改变的是你掂量一个人的哪些部分，它让你越往后越容易拒绝，而且它可能让你对已经做出的选择更不安定。"
    },
    {
      "type": "h2",
      "text": "这说明了什么，又没说明什么"
    },
    {
      "type": "ul",
      "items": [
        "**它没有说：**选项更少就能带来更好的关系。没有人测量过这件事。",
        "**它没有说：**你很肤浅。它说的是注意力有限，而且会被用完。",
        "**它确实说了：**一个人出现在你队列里的位置，会影响你怎么评判他。",
        "**它确实说了：**需要花时间才能注意到的特质，在没有时间的时候会吃亏。"
      ]
    },
    {
      "type": "p",
      "text": "这比你通常听到的那个主张要小，也更能落到实处。问题不在于抽象意义上的“多”。问题在于，一条快速流动的队列会悄悄把你的标准重新加权，偏向那些最快就能判断的东西。"
    },
    {
      "type": "h2",
      "text": "那该怎么办",
      "accent": "green"
    },
    {
      "type": "p",
      "text": "这些都不要求你删掉什么。它们要求的是有意识地花掉注意力，而不是把它摊薄到每个人身上都不剩。"
    },
    {
      "type": "ul",
      "items": [
        "提前决定一次要看多少人，然后停在那里，而不是停在你觉得烦了的时候。",
        "留意自己在这一轮的什么位置。如果你已经连着说了十一次不，那么第十二次判断说的是你，不是对方。",
        "做决定之前先打开资料。读两句话，是让一个慢特质和一个快特质同场竞争最便宜的办法。",
        "有什么让你好奇，就在当天行动。好奇心经不起排队。"
      ]
    },
    {
      "type": "p",
      "text": "在 Qulo 上，队列在结构上就更短，因为要走到一个人面前，就得回答他为自己写下的问题——免费方案 2 到 4 道，付费方案最多 10 道，每道四个选项，而且必须全部答对。这是以注意力计价的一笔有意为之的成本，和研究所描述的快速扫视正好相反。它并不会让谁变得更合适；它只是让你对一个人做的第一件事，是读他写下的东西，而不是给一张照片排名。"
    },
    {
      "type": "quote",
      "text": "那个发现从来不是“选择让人痛苦”。它是：注意力会用完，而最快能被判断的东西，就是被判断的那个。"
    }
  ],
  nl: [
    {
      "type": "p",
      "text": "Je hebt waarschijnlijk gehoord dat te veel keuze je slechter laat kiezen, en dat datingapps daarom voelen zoals ze voelen. Een nette verklaring. En wankeler dan hij klinkt — want de versie die het bewijs overleeft, is preciezer en bruikbaarder dan de versie die rondgaat."
    },
    {
      "type": "h2",
      "text": "De algemene bewering overleefde haar eigen meta-analyse niet"
    },
    {
      "type": "p",
      "text": "Het idee komt uit een reeks beroemde experimenten waarin klanten die voor veel varianten van een product stonden minder kochten dan klanten die er weinig zagen. Het verspreidde zich snel, omdat het een gevoel verklaart dat iedereen herkent. Maar in 2010 brachten **Scheibehenne, Greifeneder en Todd** in het **Journal of Consumer Research** **63 condities uit 50 experimenten** samen, over **5.036 mensen**, en vonden ze een gemiddelde effectgrootte van vrijwel nul — met grote verschillen tussen de studies. Sommige vonden sterke keuzestress. Andere vonden dat meer opties juist hielpen."
    },
    {
      "type": "p",
      "text": "De algemene versie — meer opties, altijd slechtere uitkomsten — wordt dus niet gedragen door het bewijs. Als een artikel opent met het supermarktexperiment en de zaak als afgedaan behandelt, heeft het precies het deel overgeslagen waarin het vakgebied ging controleren."
    },
    {
      "type": "h2",
      "text": "Daten is wél apart gemeten"
    },
    {
      "type": "p",
      "text": "Hier wordt het interessant, want de bevindingen die specifiek over daten gaan, gaan helemaal niet over geluk. Ze gaan over **waar je aandacht naartoe gaat**."
    },
    {
      "type": "p",
      "text": "**Lenton en Francesconi** analyseerden in **Psychological Science** **84 speeddate-avonden** — **1.868 vrouwen en 1.870 mannen**. Naarmate er meer mensen op een avond waren, verschoven de keuzes naar kenmerken die je in een seconde afleest, en weg van kenmerken waar een gesprek voor nodig is. Lengte en gewicht kregen meer gewicht in de beslissing. Beroep en opleiding verloren het."
    },
    {
      "type": "p",
      "text": "Niemand in dat onderzoek besloot oppervlakkig te worden. De verschuiving is wat een mens doet als er meer door te nemen is dan er aandacht te besteden valt. In een datingapp duurt diezelfde druk niet één avond maar is hij constant, en de kenmerken die je in een seconde leest zijn precies de kenmerken die een foto meedraagt:"
    },
    {
      "type": "ul",
      "items": [
        "Gezicht, lichaam, geschatte leeftijd — zichtbaar voor je één woord hebt gelezen",
        "Lengte, als die erbij staat, want dat is één getal",
        "Of de foto's er duur uitzien, wat een gok is over klasse",
        "Alles waar een vlag, een badge of een functietitel aan hangt"
      ]
    },
    {
      "type": "h2",
      "text": "Hoe langer je kijkt, hoe meer je afwijst"
    },
    {
      "type": "p",
      "text": "**Pronk en Denissen** deden hier drie studies naar, gepubliceerd in **Social Psychological and Personality Science**. Over een sessie waarin mogelijke partners werden beoordeeld, daalde de kans dat iemand werd geaccepteerd met ongeveer **27% van de eerst getoonde tot de laatste**. Ze noemen het een afwijzende instelling: hoe meer opties je doorloopt, hoe pessimistischer je over allemaal wordt."
    },
    {
      "type": "p",
      "text": "De ongemakkelijke implicatie is dat iemand die laat in je sessie verschijnt niet op eigen merites wordt beoordeeld. Diegene wordt beoordeeld door iemand die veertig beslissingen diep zit. Zet dezelfde persoon vooraan en hetzelfde profiel doet het beter."
    },
    {
      "type": "h2",
      "text": "En de tevredenheid daarna"
    },
    {
      "type": "p",
      "text": "**D'Angelo en Toma** testten het vervolg: **152 studenten** kozen een partner uit een groep van **24 of 6**, en kregen een week later de vraag hoe tevreden ze waren. Wie uit 24 had gekozen, was minder tevreden over de gekozen persoon. Even duidelijk gezegd: dit is een kleine studentensteekproef in een laboratorium, geen onderzoek naar echte relaties, en het moet gelezen worden als een aanwijzing en niet als een bevinding over jouw leven."
    },
    {
      "type": "p",
      "text": "Leg de drie naast elkaar en de eerlijke samenvatting is smal. Een lange rij maakt je op zichzelf niet ongelukkig. Hij verandert welke delen van iemand je meeweegt, hij laat je gaandeweg meer afwijzen, en hij kan je minder gerust laten over de keuze die je wél maakte."
    },
    {
      "type": "h2",
      "text": "Wat dit wel en niet zegt"
    },
    {
      "type": "ul",
      "items": [
        "**Het zegt niet** dat minder opties betere relaties opleveren. Dat heeft niemand gemeten.",
        "**Het zegt niet** dat je oppervlakkig bent. Het zegt dat aandacht eindig is en opraakt.",
        "**Het zegt wel** dat de plek waar iemand in je rij verschijnt invloed heeft op hoe je diegene beoordeelt.",
        "**Het zegt wel** dat kenmerken die tijd kosten om op te merken verliezen als die tijd er niet is."
      ]
    },
    {
      "type": "p",
      "text": "Dat is een kleinere bewering dan je meestal hoort, en een bruikbaardere. Het probleem is niet overvloed in het algemeen. Het is dat een snelle rij het gewicht van je criteria stilletjes verschuift richting alles wat het snelst te beoordelen is."
    },
    {
      "type": "h2",
      "accent": "green",
      "text": "Wat je eraan kunt doen"
    },
    {
      "type": "p",
      "text": "Niets hiervan vraagt om iets te verwijderen. Het vraagt om aandacht met opzet uit te geven in plaats van haar uit te smeren tot er per persoon niets meer over is."
    },
    {
      "type": "ul",
      "items": [
        "Bepaal vooraf naar hoeveel mensen je in één keer gaat kijken, en stop daar in plaats van wanneer je je verveelt.",
        "Merk op waar je in een sessie zit. Als je elf keer op rij nee hebt gezegd, gaat het twaalfde oordeel over jou en niet over die ander.",
        "Open het profiel voor je beslist. Twee zinnen lezen is de goedkoopste manier om een traag kenmerk te laten concurreren met een snel kenmerk.",
        "Als iets je nieuwsgierig maakt, doe er die dag iets mee. Nieuwsgierigheid overleeft het niet om in de rij te worden gezet."
      ]
    },
    {
      "type": "p",
      "text": "Op Qulo is de rij korter door hoe hij gebouwd is, want bij iemand komen betekent de vragen beantwoorden die diegene zelf heeft geschreven — 2 tot 4 daarvan met het gratis abonnement, tot 10 met een betaald abonnement, elk met vier opties, en elk antwoord moet kloppen. Dat is een bewuste prijs in aandacht, en het is het tegenovergestelde van het snelle scannen dat het onderzoek beschrijft. Het maakt niemand compatibeler; het betekent alleen dat het eerste wat je met iemand doet, iets lezen is dat diegene heeft geschreven, in plaats van een foto rangschikken."
    },
    {
      "type": "quote",
      "text": "De bevinding was nooit dat keuze mensen ongelukkig maakt. De bevinding was dat aandacht opraakt, en dat wat het snelst te beoordelen is, beoordeeld wordt."
    }
  ],
  pl: [
    {
      "type": "p",
      "text": "Pewnie znasz tę tezę: zbyt wiele opcji pogarsza twoje wybory i właśnie dlatego aplikacje randkowe działają tak, jak działają. To zgrabne wyjaśnienie. Jest też mniej pewne, niż brzmi — a wersja, która przetrwała zderzenie z danymi, jest węższa i bardziej użyteczna niż ta, która krąży w obiegu."
    },
    {
      "type": "h2",
      "text": "Ogólna teza nie przetrwała własnej metaanalizy"
    },
    {
      "type": "p",
      "text": "Pomysł wziął się z serii słynnych eksperymentów o kupujących, którzy postawieni przed wieloma wariantami produktu kupowali mniej niż ci postawieni przed kilkoma. Rozszedł się szybko, bo tłumaczy uczucie, które każdy zna. Ale w 2010 roku **Scheibehenne, Greifeneder i Todd** zebrali razem **63 warunki z 50 eksperymentów** obejmujące **5036 osób** i opisali to w **Journal of Consumer Research**: średnia wielkość efektu okazała się praktycznie zerowa, przy szerokim rozrzucie między badaniami. Jedne wykazały silne przeciążenie wyborem. Inne — że więcej opcji pomagało."
    },
    {
      "type": "p",
      "text": "Wersja hurtowa — więcej opcji, gorszy wynik, zawsze — nie jest więc czymś, co dane potwierdzają. Jeśli tekst zaczyna się od badania o zakupach i traktuje sprawę jako rozstrzygniętą, to pominął moment, w którym dziedzina sama się sprawdziła."
    },
    {
      "type": "h2",
      "text": "Randkowanie zmierzono jednak osobno"
    },
    {
      "type": "p",
      "text": "Tu robi się ciekawie, bo ustalenia dotyczące wprost randkowania w ogóle nie mówią o szczęściu. Mówią o tym, **na co zwracasz uwagę**."
    },
    {
      "type": "p",
      "text": "**Lenton i Francesconi** przeanalizowali **84 wieczory szybkich randek** — **1868 kobiet i 1870 mężczyzn** — na łamach **Psychological Science**. Im więcej osób pojawiało się na wieczorze, tym bardziej wybierający przesuwali się w stronę cech, które da się odczytać w sekundę, i odchodzili od tych, na których ustalenie potrzeba rozmowy. Wzrost i waga zyskiwały na wadze w decyzji. Zawód i wykształcenie na niej traciły."
    },
    {
      "type": "p",
      "text": "Nikt w tym badaniu nie postanowił zrobić się powierzchowny. To przesunięcie jest tym, co człowiek robi, gdy materiału do przerobienia jest więcej niż uwagi do wydania. W aplikacji randkowej ta sama presja nie trwa jeden wieczór, tylko cały czas — a cechy czytelne w sekundę to dokładnie te, które niesie zdjęcie:"
    },
    {
      "type": "ul",
      "items": [
        "Twarz, sylwetka, pozorny wiek — widoczne, zanim przeczytasz choć słowo",
        "Wzrost, jeśli jest wpisany, bo to jedna liczba",
        "To, czy zdjęcia wyglądają drogo, czyli zgadywanie klasy społecznej",
        "Wszystko, do czego doczepiono flagę, odznakę albo nazwę stanowiska"
      ]
    },
    {
      "type": "h2",
      "text": "Im dłużej patrzysz, tym więcej odrzucasz"
    },
    {
      "type": "p",
      "text": "**Pronk i Denissen** przeprowadzili nad tym trzy badania, opublikowane w **Social Psychological and Personality Science**. W trakcie jednej sesji oceniania potencjalnych partnerów szansa na zaakceptowanie kogokolwiek spadała o około **27% od pierwszej pokazanej osoby do ostatniej**. Nazywają to nastawieniem na odrzucanie: im więcej opcji przerabiasz, tym bardziej pesymistycznie patrzysz na nie wszystkie."
    },
    {
      "type": "p",
      "text": "Niewygodny wniosek jest taki, że osoba, która pojawia się późno w twojej sesji, nie jest oceniana za to, kim jest. Jest oceniana przez kogoś czterdzieści decyzji w głąb. Przesuń ją na początek, a ten sam profil wypadnie lepiej."
    },
    {
      "type": "h2",
      "text": "I zadowolenie potem"
    },
    {
      "type": "p",
      "text": "**D'Angelo i Toma** sprawdzili, co dzieje się później: **152 studentów** wybrało partnera z puli **24 albo 6 osób**, a tydzień później zapytano ich o zadowolenie. Ci, którzy wybierali spośród 24, byli mniej zadowoleni z osoby, którą wybrali. Trzeba powiedzieć wprost: to mała próba studencka w laboratorium, a nie badanie prawdziwych związków, i należy ją czytać jako sugestię, a nie jako ustalenie na temat twojego życia."
    },
    {
      "type": "p",
      "text": "Zestaw te trzy rzeczy razem, a uczciwe podsumowanie okaże się wąskie. Długa kolejka sama z siebie nie czyni cię nieszczęśliwym. Zmienia to, które części człowieka ważysz, sprawia, że w miarę przewijania coraz częściej odrzucasz, i może zostawić cię mniej pewnym dokonanego wyboru."
    },
    {
      "type": "h2",
      "text": "Co to mówi, a czego nie mówi"
    },
    {
      "type": "ul",
      "items": [
        "**Nie mówi**, że mniej opcji daje lepsze związki. Nikt tego nie zmierzył.",
        "**Nie mówi**, że jesteś powierzchowny. Mówi, że uwaga jest skończona i że się zużywa.",
        "**Mówi za to**, że miejsce, w którym ktoś pojawia się w twojej kolejce, wpływa na twoją ocenę.",
        "**Mówi za to**, że cechy wymagające czasu przegrywają tam, gdzie czasu nie ma."
      ]
    },
    {
      "type": "p",
      "text": "To twierdzenie mniejsze niż to, które zwykle słyszysz, i bardziej praktyczne. Problemem nie jest obfitość w ogóle. Problemem jest to, że szybka kolejka po cichu przesuwa wagi twoich kryteriów w stronę wszystkiego, co da się ocenić najszybciej."
    },
    {
      "type": "h2",
      "text": "Co z tym zrobić",
      "accent": "green"
    },
    {
      "type": "p",
      "text": "Nic z tego nie wymaga kasowania czegokolwiek. Wymaga wydawania uwagi z rozmysłem, zamiast rozprowadzania jej aż do zera na osobę."
    },
    {
      "type": "ul",
      "items": [
        "Zdecyduj z góry, ile osób obejrzysz za jednym posiedzeniem, i skończ w tym miejscu, a nie wtedy, gdy ci się znudzi.",
        "Zauważ, w którym miejscu sesji jesteś. Jeśli jedenaście razy z rzędu padło „nie”, dwunasta ocena mówi o tobie, nie o tej osobie.",
        "Otwórz profil, zanim zdecydujesz. Przeczytanie dwóch zdań to najtańszy sposób, żeby wolna cecha mogła stanąć do wyścigu z szybką.",
        "Kiedy coś cię zaciekawi, zrób z tym coś tego samego dnia. Ciekawość nie znosi stania w kolejce."
      ]
    },
    {
      "type": "p",
      "text": "W Qulo kolejka jest krótsza z samej konstrukcji, bo żeby dotrzeć do kogoś, trzeba odpowiedzieć na pytania, które ta osoba napisała o sobie — od 2 do 4 z nich w planie darmowym, do 10 w planie płatnym, po cztery odpowiedzi do wyboru w każdym, i wszystkie muszą być trafione. To celowy koszt w uwadze i dokładne przeciwieństwo szybkiego skanowania, które opisują badania. Nikogo to nie czyni bardziej dopasowanym; oznacza tylko tyle, że pierwszą rzeczą, jaką robisz z drugim człowiekiem, jest przeczytanie czegoś, co napisał, a nie ocenienie zdjęcia."
    },
    {
      "type": "quote",
      "text": "Ustalenie nigdy nie brzmiało: wybór czyni ludzi nieszczęśliwymi. Brzmiało: uwaga się kończy, a ocenę dostaje to, co najszybciej da się ocenić."
    }
  ],
  sv: [
    {
      "type": "p",
      "text": "Du har säkert hört att för många alternativ gör dig sämre på att välja, och att det är därför dejtingappar känns som de gör. Det är en prydlig förklaring. Den är också skakigare än den låter — och den version som överlever underlaget är mer specifik, och mer användbar, än den som är i omlopp."
    },
    {
      "type": "h2",
      "text": "Den allmänna tesen överlevde inte sin egen metaanalys"
    },
    {
      "type": "p",
      "text": "Idén kommer från en rad berömda experiment om kunder som ställdes inför många varianter av en produkt och köpte mindre än kunder som ställdes inför få. Den spred sig snabbt, för den förklarar en känsla alla känner igen. Men 2010 slog **Scheibehenne, Greifeneder och Todd** ihop **63 betingelser från 50 experiment** som omfattade **5 036 personer** i **Journal of Consumer Research**, och fann en genomsnittlig effektstorlek på i praktiken noll — med stor spridning mellan studierna. Vissa fann kraftig valöverbelastning. Andra fann att fler alternativ hjälpte."
    },
    {
      "type": "p",
      "text": "Den svepande versionen — fler alternativ, sämre utfall, alltid — är alltså inte något underlaget bär. Om en artikel öppnar med butiksstudien och behandlar saken som avgjord har den hoppat över den del där fältet gick tillbaka och kontrollerade."
    },
    {
      "type": "h2",
      "text": "Dejting mättes däremot för sig"
    },
    {
      "type": "p",
      "text": "Det är här det blir intressant, för de dejtingspecifika fynden handlar inte alls om lycka. De handlar om **vad du ägnar uppmärksamhet åt**."
    },
    {
      "type": "p",
      "text": "**Lenton och Francesconi** analyserade **84 snabbdejtningskvällar** — **1 868 kvinnor och 1 870 män** — i **Psychological Science**. Ju fler människor det var på en kväll, desto mer förflyttade sig de väljande mot egenskaper som går att läsa av på en sekund, och bort från dem som kräver ett samtal för att fastställas. Längd och vikt vägde tyngre i beslutet. Yrke och utbildning vägde lättare."
    },
    {
      "type": "p",
      "text": "Ingen i den studien bestämde sig för att bli ytlig. Förskjutningen är vad en människa gör när det finns mer att beta av än det finns uppmärksamhet att lägga. I en dejtingapp är samma tryck konstant i stället för en kväll långt, och de egenskaper som läses av på en sekund är precis de som ett fotografi bär med sig:"
    },
    {
      "type": "ul",
      "items": [
        "Ansikte, kropp, uppskattad ålder — synligt innan du har läst ett ord",
        "Längd, om den står skriven, eftersom det är en enda siffra",
        "Om bilderna ser dyra ut, vilket är en gissning om klass",
        "Allt som har en flagga, en märkning eller en yrkestitel fäst vid sig"
      ]
    },
    {
      "type": "h2",
      "text": "Ju längre du tittar, desto fler tackar du nej till"
    },
    {
      "type": "p",
      "text": "**Pronk och Denissen** gjorde tre studier om det här, publicerade i **Social Psychological and Personality Science**. Under ett pass av att bedöma möjliga partner sjönk chansen att acceptera en given person med ungefär **27 % från den först visade till den sist visade**. De kallar det ett avslagsläge: ju fler alternativ du betar av, desto mer pessimistisk blir du om allihop."
    },
    {
      "type": "p",
      "text": "Den obekväma följden är att den som dyker upp sent i ditt pass inte bedöms efter sina egna meriter. Den personen bedöms av någon som är fyrtio beslut in. Flytta personen först i kön och samma profil klarar sig bättre."
    },
    {
      "type": "h2",
      "text": "Och nöjdheten efteråt"
    },
    {
      "type": "p",
      "text": "**D'Angelo och Toma** testade efterspelet: **152 studenter** valde en partner ur en pool på antingen **24 eller 6**, och fick en vecka senare frågan hur nöjda de var. De som hade valt ur 24 var mindre nöjda med den de valt. Värt att säga rent ut: det här är ett litet studenturval i ett laboratorium, inte en studie av verkliga relationer, och det bör läsas som ett uppslag snarare än ett fynd om ditt liv."
    },
    {
      "type": "p",
      "text": "Lägg ihop de tre och den ärliga sammanfattningen blir smal. En lång kö gör dig inte olycklig i sig. Den ändrar vilka delar av en människa du väger, den gör dig mer avvisande ju längre du kommer, och den kan lämna dig mindre tillfreds med det val du faktiskt gjorde."
    },
    {
      "type": "h2",
      "text": "Vad detta säger och inte säger"
    },
    {
      "type": "ul",
      "items": [
        "**Det säger inte** att färre alternativ ger bättre relationer. Ingen har mätt det.",
        "**Det säger inte** att du är ytlig. Det säger att uppmärksamhet är ändlig och tar slut.",
        "**Det säger däremot** att var någon dyker upp i din kö påverkar hur du bedömer personen.",
        "**Det säger däremot** att egenskaper som tar tid att märka förlorar när tiden inte finns."
      ]
    },
    {
      "type": "p",
      "text": "Vilket är ett mindre påstående än det du brukar höra, och ett mer användbart. Problemet är inte överflödet i abstrakt mening. Problemet är att en snabb kö tyst viktar om dina kriterier mot det som går snabbast att bedöma."
    },
    {
      "type": "h2",
      "text": "Vad du kan göra åt det",
      "accent": "green"
    },
    {
      "type": "p",
      "text": "Inget av det här kräver att du raderar något. Det kräver att du lägger uppmärksamhet med avsikt i stället för att breda ut den tills det inte finns någon kvar per person."
    },
    {
      "type": "ul",
      "items": [
        "Bestäm i förväg hur många människor du ska titta på under ett pass, och sluta där i stället för när du tröttnar.",
        "Lägg märke till var i passet du befinner dig. Har du sagt \"nej\" elva gånger i rad handlar den tolfte bedömningen om dig, inte om personen.",
        "Öppna profilen innan du bestämmer dig. Att läsa två meningar är det billigaste sättet att låta en långsam egenskap tävla med en snabb.",
        "När något gör dig nyfiken, gör något åt det samma dag. Nyfikenhet överlever inte att ställas i kö."
      ]
    },
    {
      "type": "p",
      "text": "På Qulo är kön kortare av konstruktion, eftersom vägen fram till någon går genom att svara på de frågor personen har skrivit om sig själv — 2 till 4 av dem i gratisplanen, upp till 10 med ett betalt abonnemang, fyra svarsalternativ på varje, och varje svar måste vara rätt. Det är en medveten kostnad i uppmärksamhet, och raka motsatsen till den snabba avsökning forskningen beskriver. Det gör ingen mer kompatibel; det betyder bara att det första du gör med en människa är att läsa något personen har skrivit i stället för att rangordna ett fotografi."
    },
    {
      "type": "quote",
      "text": "Fyndet var aldrig att valfrihet gör människor olyckliga. Det var att uppmärksamheten tar slut, och att det som är snabbast att bedöma är det som blir bedömt."
    }
  ],
  hi: [
    {
      "type": "p",
      "text": "आपने शायद सुना होगा कि विकल्प ज़्यादा हों तो इंसान चुनने में और ख़राब हो जाता है, और डेटिंग ऐप्स जैसी लगती हैं उसकी वजह भी यही है। यह एक साफ़-सुथरी व्याख्या है। यह उतनी मज़बूत भी नहीं जितनी सुनने में लगती है — और सबूतों से जो रूप बचकर निकलता है, वह चलन में मौजूद रूप से ज़्यादा संकरा और ज़्यादा काम का है।"
    },
    {
      "type": "h2",
      "text": "आम दावा अपने ही मेटा-विश्लेषण में टिक नहीं पाया"
    },
    {
      "type": "p",
      "text": "यह विचार उन मशहूर प्रयोगों से आया है जिनमें किसी एक चीज़ की बहुत सारी क़िस्मों के सामने खड़े ग्राहक, कम क़िस्मों के सामने खड़े ग्राहकों से कम ख़रीदते थे। यह तेज़ी से फैला क्योंकि यह उस एहसास को समझा देता है जिसे हर कोई पहचानता है। पर 2010 में **Scheibehenne, Greifeneder और Todd** ने **Journal of Consumer Research** में **50 प्रयोगों की 63 स्थितियाँ** और कुल **5,036 लोग** एक साथ रखे, और औसत प्रभाव लगभग शून्य निकला — अध्ययनों के बीच फ़र्क़ बहुत बड़ा था। कुछ अध्ययनों में विकल्पों का तगड़ा अतिभार (choice overload) मिला। कुछ में ज़्यादा विकल्प मददगार निकले।"
    },
    {
      "type": "p",
      "text": "तो हर हाल पर चढ़ जाने वाला रूप — विकल्प ज़्यादा, नतीजे हमेशा बदतर — वह नहीं है जिसे सबूत सँभालते हों। कोई लेख अगर ख़रीदारी वाले प्रयोग से शुरू होकर मामले को तय मान लेता है, तो उसने वही हिस्सा छोड़ दिया है जहाँ इस क्षेत्र ने ख़ुद अपनी जाँच की।"
    },
    {
      "type": "h2",
      "text": "पर डेटिंग को अलग से मापा गया"
    },
    {
      "type": "p",
      "text": "दिलचस्प बात यहीं से शुरू होती है, क्योंकि डेटिंग से जुड़े नतीजे ख़ुशी के बारे में हैं ही नहीं। वे इस बारे में हैं कि **आप ध्यान किस पर देते हैं**।"
    },
    {
      "type": "p",
      "text": "**Lenton और Francesconi** ने **Psychological Science** में **84 स्पीड-डेटिंग आयोजनों** का विश्लेषण किया — **1,868 महिलाएँ और 1,870 पुरुष**। किसी आयोजन में लोगों की संख्या जितनी बढ़ी, चुनने वाले उतना ही उन ख़ूबियों की ओर खिसके जो एक सेकंड में पढ़ी जा सकती हैं, और उनसे दूर हटे जिन्हें जानने के लिए बातचीत चाहिए। क़द और वज़न का वज़न फ़ैसले में बढ़ गया। पेशा और पढ़ाई का घट गया।"
    },
    {
      "type": "p",
      "text": "उस अध्ययन में किसी ने सतही होने का फ़ैसला नहीं किया था। यह खिसकाव वही है जो इंसान तब करता है जब निपटाने को उससे ज़्यादा हो जितना ध्यान उसके पास ख़र्च करने को है। डेटिंग ऐप में यही दबाव एक शाम भर नहीं, लगातार बना रहता है — और जो ख़ूबियाँ एक सेकंड में पढ़ी जाती हैं, ठीक वही एक तस्वीर लेकर चलती है:"
    },
    {
      "type": "ul",
      "items": [
        "चेहरा, शरीर, दिखने वाली उम्र — एक शब्द पढ़ने से पहले ही दिख जाते हैं",
        "क़द, अगर लिखा हो, क्योंकि वह बस एक संख्या है",
        "तस्वीरें महँगी लगती हैं या नहीं, जो असल में वर्ग के बारे में एक अंदाज़ा है",
        "हर वह चीज़ जिस पर कोई झंडा, कोई बैज या कोई पदनाम लगा हो"
      ]
    },
    {
      "type": "h2",
      "text": "जितनी देर देखेंगे, उतना ज़्यादा ठुकराएँगे"
    },
    {
      "type": "p",
      "text": "**Pronk और Denissen** ने इस पर तीन अध्ययन किए, जो **Social Psychological and Personality Science** में छपे। संभावित साथियों को परखने के एक सत्र के दौरान, उनमें से किसी को भी स्वीकार करने की संभावना **पहले दिखाए गए व्यक्ति से आख़िरी तक लगभग 27% गिर गई**। वे इसे अस्वीकार वाली मानसिकता (rejection mind-set) कहते हैं: आप जितने ज़्यादा विकल्पों से गुज़रते हैं, उन सबके बारे में उतने ही निराश होते जाते हैं।"
    },
    {
      "type": "p",
      "text": "असहज नतीजा यह है कि आपके सत्र में देर से आने वाले व्यक्ति को उसकी अपनी ख़ूबियों पर नहीं परखा जा रहा। उसे कोई ऐसा परख रहा है जो चालीस फ़ैसले गहरे जा चुका है। उसी प्रोफ़ाइल को शुरू में ले आइए, और वही प्रोफ़ाइल बेहतर करती है।"
    },
    {
      "type": "h2",
      "text": "और उसके बाद की संतुष्टि"
    },
    {
      "type": "p",
      "text": "**D'Angelo और Toma** ने इसके बाद वाले हिस्से को परखा: **152 स्नातक विद्यार्थियों** ने **24** या **6** लोगों के समूह में से एक साथी चुना, और एक हफ़्ते बाद उनसे पूछा गया कि वे कितने संतुष्ट हैं। जिन्होंने 24 में से चुना था, वे अपने चुने हुए व्यक्ति से कम संतुष्ट थे। साफ़ कहना ज़रूरी है: यह प्रयोगशाला में विद्यार्थियों का एक छोटा नमूना है, असली रिश्तों का अध्ययन नहीं — और इसे अपनी ज़िंदगी के बारे में किसी नतीजे की तरह नहीं, एक इशारे की तरह पढ़ा जाना चाहिए।"
    },
    {
      "type": "p",
      "text": "तीनों नतीजों को साथ रखिए तो ईमानदार सारांश संकरा निकलता है। लंबी क़तार अपने आप आपको दुखी नहीं करती। वह यह बदलती है कि आप किसी इंसान के कौन-से हिस्से तौलते हैं, आगे बढ़ते-बढ़ते आपको ज़्यादा ठुकराने वाला बनाती है, और जो चुनाव आपने किया उसे लेकर आपको कम टिका हुआ छोड़ सकती है।"
    },
    {
      "type": "h2",
      "text": "यह क्या बताता है और क्या नहीं"
    },
    {
      "type": "ul",
      "items": [
        "**यह नहीं कहता** कि कम विकल्प बेहतर रिश्ते बनाते हैं। यह किसी ने मापा ही नहीं।",
        "**यह नहीं कहता** कि आप सतही हैं। यह कहता है कि ध्यान सीमित है और ख़र्च हो जाता है।",
        "**यह कहता है** कि कोई आपकी क़तार में कहाँ आता है, इससे तय होता है कि आप उसे कैसे परखेंगे।",
        "**यह कहता है** कि जिन ख़ूबियों को पहचानने में वक़्त लगता है, वक़्त न होने पर वही पीछे रह जाती हैं।"
      ]
    },
    {
      "type": "p",
      "text": "यह उस दावे से छोटा दावा है जो आप आम तौर पर सुनते हैं, और उतना ही ज़्यादा करने लायक़। दिक़्क़त बहुतायत में नहीं है। दिक़्क़त यह है कि तेज़ चलती क़तार चुपचाप आपके मापदंडों का वज़न उस तरफ़ खिसका देती है जिसे सबसे जल्दी परखा जा सकता है।"
    },
    {
      "type": "h2",
      "text": "इसका क्या करें",
      "accent": "green"
    },
    {
      "type": "p",
      "text": "इसमें से किसी के लिए कुछ मिटाने की ज़रूरत नहीं है। ज़रूरत इसकी है कि ध्यान को इतना फैलाने के बजाय कि हर व्यक्ति के हिस्से कुछ बचे ही नहीं, उसे इरादे के साथ ख़र्च किया जाए।"
    },
    {
      "type": "ul",
      "items": [
        "पहले से तय कर लें कि एक बैठक में कितने लोगों को देखेंगे, और वहीं रुकें — तब नहीं जब ऊब जाएँ।",
        "ध्यान रखें कि आप सत्र में कहाँ हैं। अगर आपने लगातार ग्यारह बार ना कहा है, तो बारहवाँ फ़ैसला आपके बारे में है, उनके बारे में नहीं।",
        "तय करने से पहले प्रोफ़ाइल खोलें। दो वाक्य पढ़ना सबसे सस्ता तरीक़ा है कि कोई धीमी ख़ूबी किसी तेज़ ख़ूबी से मुक़ाबला कर सके।",
        "कोई चीज़ आपकी जिज्ञासा जगाए तो उसी दिन कुछ करें। जिज्ञासा क़तार में खड़े रहकर बची नहीं रहती।"
      ]
    },
    {
      "type": "p",
      "text": "Qulo पर क़तार बनावट से ही छोटी है, क्योंकि किसी तक पहुँचने का मतलब है उसके अपने बारे में लिखे सवालों के जवाब देना — मुफ़्त प्लान पर 2 से 4 सवाल, सशुल्क प्लान पर 10 तक, हर सवाल में चार विकल्प, और हर जवाब सही होना चाहिए। यह ध्यान के रूप में चुकाई गई एक जान-बूझकर रखी गई क़ीमत है, और यह उस तेज़ स्कैन का ठीक उल्टा है जिसका वर्णन शोध करता है। इससे कोई ज़्यादा अनुकूल नहीं हो जाता; इसका बस इतना मतलब है कि किसी इंसान के बारे में आपका पहला काम यह होता है कि आप उसका लिखा कुछ पढ़ें, न कि किसी तस्वीर को क्रम में लगाएँ।"
    },
    {
      "type": "quote",
      "text": "नतीजा कभी यह था ही नहीं कि विकल्प इंसान को दुखी कर देते हैं। नतीजा यह था कि ध्यान चुक जाता है, और जिसे सबसे जल्दी परखा जा सकता है, वही परखा जाता है।"
    }
  ],
};
