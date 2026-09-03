import type { LocalizedArticle } from "@/components/blog/ArticleBlocks";

/**
 * "Online Dating Safety Tips" — migrated from inline per-locale JSX.
 * Canonical source: `en`; every one of the 16 locales is a full translation, so
 * no locale falls back to English any more (the legacy component shipped only
 * `tr` and `en`, serving the English body under 14 locales whose `hreflang`
 * promised otherwise). `**bold**` renders as <strong>.
 *
 * Statistics policy: the legacy post opened with "approximately 53% of dating
 * app users have encountered someone who lied in their profile" — no source, no
 * study, not traceable — and that number is gone. So are the other unsourced
 * quantitative claims it carried: "romance scam cases are increasing every
 * year" (a trend assertion with nothing behind it) and "most catfishing cases
 * are revealed during the video call stage" (a "most" with no denominator).
 * Each was rewritten qualitatively; the practical advice they introduced was
 * never dependent on the figure. The only figures kept are from **SSRS, "The
 * Public and Online Dating 2026"** (fielded January 2026, n=2,012 US adults,
 * MoE ±2.5pp; see `SSRS_2026` in `src/lib/constants/stats.ts`), attributed
 * inline: 57% say meeting an app match in person is generally safe, 43% say it
 * is not, and 55% of women vs 30% of men say it is not. The "10 golden rules"
 * count and the numbered headings are structure, not statistics. Do not
 * reintroduce a number here without a named primary source.
 *
 * Product-claim policy: the legacy "Qulo's Safety Features" list claimed
 * "profile verification — a system that verifies users are real people", which
 * reads as ID verification and is not something Qulo does. The list now
 * describes only mechanisms that actually exist: encrypted storage, email
 * verification before a profile becomes visible, block and report in the
 * three-dot menu on every profile and chat, and reports read by a person in a
 * moderation panel. No automated moderation, photo screening, dedicated
 * trust-and-safety team or ID check is claimed anywhere, and every locale keeps
 * the honest closing note that no app can make meeting a stranger risk-free.
 *
 * Brand rule: Qulo is the only dating app nameable on this site. Everything
 * else is described generically as "dating apps" / "swipe-based apps".
 *
 * Note: the block model has no h3, so the original h3 sub-headings ("1. Choose
 * Your Profile Photos Wisely", …) are authored as purple h2. The two headings
 * the original markup rendered in `text-qulo-green` — "10 Golden Rules" and the
 * closing "Conclusion: Date Safely" — keep `accent: "green"` at the same
 * positions (block indices 3 and 29); every other heading is purple. That is
 * the complete green count: 2. (The legacy blockquote carried
 * `border-qulo-purple`; `ArticleBlocks` renders every quote with a green
 * border, which is the shared house style and not an accent.)
 */
export const onlineDatingSafetyTips: LocalizedArticle = {
  en: [
    { type: "h2", text: "Why Is Online Dating Safety Important?" },
    { type: "p", text: "Online dating has helped millions of people meet their partners. It also carries risks worth naming plainly: fake profiles, scam attempts, and the ordinary uncertainty of meeting a stranger. Nearly all of it can be managed by an informed user. This guide covers what you need to know to keep your online dating experience both safe and enjoyable." },
    { type: "p", text: "People are not naive about this. In **SSRS**'s survey \"The Public and Online Dating 2026\", fielded in January 2026 among **2,012** US adults, **57%** said that meeting someone in person after matching on a dating app is generally safe, while **43%** said it is not. The split is sharply gendered: **55%** of women said it is not safe, against **30%** of men. Romance scams remain one of the most common ways people are targeted on dating platforms — but with the right precautions, online dating can be a genuinely safe experience." },

    { type: "h2", accent: "green", text: "10 Golden Rules" },

    { type: "h2", text: "1. Choose Your Profile Photos Wisely" },
    { type: "p", text: "Your profile photos should introduce you while also protecting your personal safety. Avoid photos that reveal your home address, your workplace, or the places you visit regularly. Details like your car's license plate, an address label at home, or a business card should never be visible in a photo. Prefer neutral settings over instantly recognizable locations." },

    { type: "h2", text: "2. Protect Your Personal Information" },
    { type: "p", text: "During your first conversations, don't share your full name, home address, work address, or any financial information. Even your surname can open the door to a great deal about you through social media. Use only your first name until trust is established, and save detailed personal information for face-to-face conversation." },

    { type: "h2", text: "3. Prefer In-App Messaging" },
    { type: "p", text: "Avoid handing out your personal phone number or social media accounts early in the getting-to-know process. Dating apps generally offer reporting and blocking tools inside the chat, which help you deal with problematic behaviour and cut someone off if you need to. Share personal contact details only after several video calls or an in-person meeting." },

    { type: "h2", text: "4. Choose Public Places for First Dates" },
    { type: "p", text: "Your first date should always be somewhere public and busy. Cafés, restaurants and shopping centres are good choices. Don't accept an invitation to their home and don't invite them to yours. Pick a place you can reach on your own — getting into the other person's car is not appropriate for a first meeting." },

    { type: "h2", text: "5. Inform Someone You Trust" },
    { type: "p", text: "Before you go, tell a trusted friend or family member the details: where you'll be, what time, and the other person's name. Send them a message or two during the date, or agree on a \"safety check-in\" time in advance. Some apps offer built-in features for exactly this." },

    { type: "h2", text: "6. Verify Through Video Calls" },
    { type: "p", text: "Have at least one video call before meeting in person. It lets you confirm that the person matches their profile photos. A video call is one of the simplest ways to expose a fake profile, which is why someone who keeps refusing one is a serious red flag." },

    { type: "h2", text: "7. Be Cautious with Alcohol and Substances" },
    { type: "p", text: "Keep alcohol to a minimum on a first date, or skip it entirely. Alcohol dulls your judgement and makes potential risks harder to notice. Always order your own drinks and make sure they are prepared in your line of sight. Never leave a drink unattended." },

    { type: "h2", text: "8. Don't Fall for Financial Traps" },
    { type: "p", text: "Asking for money or for financial details while you are still getting to know each other is one of the most common scam patterns there is. Never send money to someone you haven't met in person, never share banking information, and don't accept offers of financial help. A money request dressed up as an \"emergency\" is a stop sign at any stage of a relationship." },

    { type: "h2", text: "9. Recognize Red Flags" },
    { type: "p", text: "Some behaviours are serious warning signs and should not be explained away:" },
    { type: "ul", items: [
      "Declaring love within days (love bombing)",
      "Consistently refusing video calls",
      "Asking for money or financial details",
      "Controlling behaviour, such as constantly asking where you are",
      "Telling inconsistent stories about their past",
      "Having no social media presence at all, or only brand-new accounts",
      "Repeatedly changing the meeting place, or steering you toward isolated ones",
    ] },

    { type: "h2", text: "10. Use the App's Safety Features" },
    { type: "p", text: "Trustworthy dating apps give you tools: blocking, reporting, and a way to reach a human moderator. Use them without hesitation the moment something feels off — a report costs you nothing, and it is the only way anyone finds out. On Qulo, block and report sit in the three-dot menu on every profile and every chat, and each report lands in a moderation panel where a person reads it." },

    { type: "h2", text: "Qulo's Safety Features" },
    { type: "p", text: "Qulo is built so that the safety tools are where you need them, and so that the claims we make about them are true. Here is exactly what the app does — no more:" },
    { type: "ul", items: [
      "**Encrypted storage:** your account data and messages are stored encrypted",
      "**Email verification:** your profile becomes visible to other people only after you confirm your email address",
      "**Block and report:** available from the three-dot menu on every profile and every chat, in one step",
      "**Human review:** every report goes into a moderation panel and is read by a person",
      "**Question-based matching:** matching on Qulo takes real effort, which makes mass-messaging and low-effort spam accounts far less worthwhile",
    ] },

    { type: "quote", text: "No app can make meeting a stranger risk-free. What an app can do is give you the tools and the time to decide for yourself — and on Qulo, that decision starts with a question." },

    { type: "h2", accent: "green", text: "Conclusion: Date Safely" },
    { type: "p", text: "With the right approach, online dating can be a safe and genuinely enjoyable experience. Keep these ten rules in mind, trust your instincts, and you will cut most of the risk down to something manageable. Remember: your safety comes before romance, every time. Meet safely on Qulo, and match through questions." },
  ],
  tr: [
    { type: "h2", text: "Online Dating Güvenliği Neden Önemli?" },
    { type: "p", text: "Online dating, milyonlarca insanın hayat arkadaşını bulmasına yardımcı oldu. Ama dijital tanışma ortamı açıkça adı konulması gereken riskler de taşıyor: sahte profiller, dolandırıcılık girişimleri ve bir yabancıyla buluşmanın kendi belirsizliği. Bunların neredeyse tamamı, bilinçli bir kullanıcı tarafından yönetilebilir. Bu rehber, online dating deneyiminizi hem güvenli hem keyifli tutmak için bilmeniz gerekenleri kapsıyor." },
    { type: "p", text: "İnsanlar bu konuda saf değil. **SSRS**'in \"The Public and Online Dating 2026\" araştırmasında — Ocak 2026'da **2.012** ABD'li yetişkinle yapıldı — katılımcıların **%57**'si bir dating uygulamasında eşleştikten sonra yüz yüze buluşmanın genel olarak güvenli olduğunu söyledi; **%43**'ü güvenli olmadığını söyledi. Aradaki fark cinsiyete göre keskinleşiyor: kadınların **%55**'i güvenli olmadığını söylerken, erkeklerde bu oran **%30**. Aşk dolandırıcılığı (romance scam), insanların dating platformlarında hedef alınmasının en yaygın yollarından biri olmayı sürdürüyor — ama doğru önlemleri aldığınızda online dating gerçekten güvenli bir deneyim olabilir." },

    { type: "h2", accent: "green", text: "10 Altın Kural" },

    { type: "h2", text: "1. Profil Fotoğraflarınızı Akıllıca Seçin" },
    { type: "p", text: "Profil fotoğraflarınız sizi tanıtırken kişisel güvenliğinizi de korumalı. Ev adresinizi, iş yerinizi ya da düzenli gittiğiniz yerleri belli eden fotoğraflardan kaçının. Arabanızın plakası, kapınızdaki isimlik veya kartvizitiniz gibi ayrıntılar hiçbir fotoğrafta görünmemeli. Anında tanınan mekânlar yerine nötr ortamları tercih edin." },

    { type: "h2", text: "2. Kişisel Bilgilerinizi Koruyun" },
    { type: "p", text: "İlk yazışmalarda tam adınızı, ev adresinizi, iş adresinizi ya da finansal bilgilerinizi paylaşmayın. Sadece soyadınız bile sosyal medya üzerinden hakkınızda çok şeye ulaşılmasının kapısını aralayabilir. Güven kurulana kadar yalnızca adınızı kullanın; ayrıntılı kişisel bilgileri yüz yüze konuşmaya saklayın." },

    { type: "h2", text: "3. Uygulama İçi Mesajlaşmayı Tercih Edin" },
    { type: "p", text: "Tanışma sürecinin başında kişisel telefon numaranızı veya sosyal medya hesaplarınızı vermekten kaçının. Dating uygulamaları genellikle sohbetin içinde raporlama ve engelleme araçları sunar; bunlar sorunlu davranışla baş etmenizi ve gerekirse karşı tarafla bağı tek hamlede kesmenizi sağlar. Kişisel iletişim bilgilerinizi ancak birkaç görüntülü görüşme veya yüz yüze bir buluşmadan sonra paylaşın." },

    { type: "h2", text: "4. İlk Buluşmada Halka Açık Yerler Seçin" },
    { type: "p", text: "İlk buluşmanız her zaman halka açık ve kalabalık bir yerde olmalı. Kafeler, restoranlar ve alışveriş merkezleri iyi seçeneklerdir. Karşı tarafın evine gitme davetini kabul etmeyin, onu kendi evinize de çağırmayın. Kendi başınıza ulaşabileceğiniz bir yer seçin — ilk buluşmada karşı tarafın arabasına binmek uygun değildir." },

    { type: "h2", text: "5. Bir Yakınınızı Bilgilendirin" },
    { type: "p", text: "Çıkmadan önce güvendiğiniz bir arkadaşınıza veya aile üyenize ayrıntıları söyleyin: nerede olacaksınız, saat kaçta ve karşı tarafın adı ne. Buluşma sırasında bir iki mesaj atın ya da önceden bir \"güvenlik kontrol\" saati kararlaştırın. Bazı uygulamalar tam bu iş için yerleşik özellikler sunuyor." },

    { type: "h2", text: "6. Görüntülü Aramayla Doğrulayın" },
    { type: "p", text: "Yüz yüze buluşmadan önce en az bir görüntülü arama yapın. Bu, karşınızdaki kişinin profil fotoğraflarıyla örtüştüğünü teyit etmenizi sağlar. Görüntülü arama, sahte bir profili ortaya çıkarmanın en basit yollarından biridir; bu yüzden görüntülü aramayı ısrarla reddeden biri ciddi bir uyarı işaretidir." },

    { type: "h2", text: "7. Alkol ve Madde Tüketimine Dikkat Edin" },
    { type: "p", text: "İlk buluşmalarda alkolü asgaride tutun ya da hiç içmeyin. Alkol muhakemenizi köreltir ve olası riskleri fark etmenizi zorlaştırır. İçeceğinizi her zaman kendiniz sipariş edin ve gözünüzün önünde hazırlandığından emin olun. İçeceğinizi asla başıboş bırakmayın." },

    { type: "h2", text: "8. Finansal Tuzaklara Düşmeyin" },
    { type: "p", text: "Daha yeni tanışırken para ya da finansal bilgi istemek, var olan en yaygın dolandırıcılık kalıplarından biridir. Yüz yüze görmediğiniz birine asla para göndermeyin, banka bilgilerinizi asla paylaşmayın ve finansal yardım tekliflerini kabul etmeyin. \"Acil durum\" kılığına sokulmuş bir para talebi, ilişkinin hangi aşamasında olursa olsun bir dur işaretidir." },

    { type: "h2", text: "9. Uyarı İşaretlerini Tanıyın" },
    { type: "p", text: "Bazı davranışlar ciddi uyarı işaretleridir ve mazeretle geçiştirilmemelidir:" },
    { type: "ul", items: [
      "Günler içinde aşk ilan etmek (love bombing)",
      "Görüntülü aramayı ısrarla reddetmek",
      "Para veya finansal bilgi istemek",
      "Sürekli nerede olduğunuzu sormak gibi kontrolcü davranışlar",
      "Geçmişi hakkında birbirini tutmayan hikâyeler anlatmak",
      "Hiç sosyal medya izi olmaması ya da yalnızca yeni açılmış hesaplar",
      "Buluşma yerini defalarca değiştirmek veya sizi tenha yerlere yönlendirmek",
    ] },

    { type: "h2", text: "10. Uygulamanın Güvenlik Özelliklerini Kullanın" },
    { type: "p", text: "Güvenilir dating uygulamaları size araç verir: engelleme, raporlama ve bir moderatöre ulaşmanın yolu. Bir şey ters geldiği anda tereddüt etmeden kullanın — raporlamanın size bir maliyeti yok ve durumun fark edilmesinin tek yolu bu. Qulo'da engelleme ve raporlama, her profildeki ve her sohbetteki üç nokta menüsünde duruyor; her rapor bir moderasyon paneline düşüyor ve orada bir insan tarafından okunuyor." },

    { type: "h2", text: "Qulo'nun Güvenlik Özellikleri" },
    { type: "p", text: "Qulo, güvenlik araçları ihtiyaç duyduğunuz yerde olsun ve bu araçlar hakkında söylediklerimiz doğru olsun diye kuruldu. Uygulamanın yaptığı tam olarak şu — fazlası değil:" },
    { type: "ul", items: [
      "**Şifreli saklama:** hesap verileriniz ve mesajlarınız şifrelenerek saklanır",
      "**E-posta doğrulama:** profiliniz, ancak e-posta adresinizi onayladıktan sonra diğer kullanıcılara görünür olur",
      "**Engelleme ve raporlama:** her profildeki ve her sohbetteki üç nokta menüsünden, tek adımda",
      "**İnsan incelemesi:** her rapor bir moderasyon paneline düşer ve bir kişi tarafından okunur",
      "**Soru tabanlı eşleşme:** Qulo'da eşleşmek gerçek bir efor ister; bu da toplu mesaj atmayı ve düşük çabalı spam hesaplarını çok daha zahmetli hale getirir",
    ] },

    { type: "quote", text: "Hiçbir uygulama bir yabancıyla buluşmayı risksiz kılamaz. Bir uygulamanın yapabileceği şey, kararı kendiniz verebilmeniz için size araç ve zaman vermektir — Qulo'da bu karar bir soruyla başlar." },

    { type: "h2", accent: "green", text: "Sonuç: Güvenle Tanışın" },
    { type: "p", text: "Doğru yaklaşımla online dating güvenli ve gerçekten keyifli bir deneyim olabilir. Bu on kuralı aklınızda tutun, sezgilerinize güvenin; riskin büyük kısmını yönetilebilir bir seviyeye indirmiş olursunuz. Unutmayın: güvenliğiniz her seferinde romantizmden önce gelir. Qulo'da güvenle tanışın, sorularla eşleşin." },
  ],
  de: [
    { type: "h2", text: "Warum ist Sicherheit beim Online-Dating wichtig?" },
    { type: "p", text: "Online-Dating hat Millionen Menschen dabei geholfen, ihre Partnerin oder ihren Partner zu finden. Es bringt aber auch Risiken mit sich, die man klar benennen sollte: gefälschte Profile, Betrugsversuche und die ganz normale Unsicherheit, sich mit einer fremden Person zu treffen. Fast alles davon lässt sich mit etwas Wissen beherrschen. Dieser Leitfaden zeigt, was Sie wissen müssen, damit Online-Dating sicher und angenehm bleibt." },
    { type: "p", text: "Die Menschen sind dabei keineswegs naiv. In der Umfrage \"The Public and Online Dating 2026\" von **SSRS**, im Januar 2026 unter **2.012** Erwachsenen in den USA durchgeführt, sagten **57%**, ein persönliches Treffen nach einem Match in einer Dating-App sei grundsätzlich sicher, **43%** hielten es für nicht sicher. Nach Geschlecht klafft die Einschätzung weit auseinander: **55%** der Frauen halten es für nicht sicher, bei den Männern sind es **30%**. Romance Scams gehören weiterhin zu den häufigsten Maschen, mit denen Menschen auf Dating-Plattformen ins Visier genommen werden — mit den richtigen Vorsichtsmaßnahmen kann Online-Dating aber wirklich sicher sein." },

    { type: "h2", accent: "green", text: "10 goldene Regeln" },

    { type: "h2", text: "1. Wählen Sie Ihre Profilfotos klug" },
    { type: "p", text: "Ihre Profilfotos sollen Sie zeigen und zugleich Ihre persönliche Sicherheit schützen. Vermeiden Sie Bilder, die Ihre Wohnadresse, Ihren Arbeitsplatz oder Orte verraten, an denen Sie regelmäßig sind. Details wie das Kennzeichen Ihres Autos, ein Namensschild an der Tür oder eine Visitenkarte gehören auf kein Foto. Bevorzugen Sie neutrale Umgebungen statt sofort wiedererkennbarer Orte." },

    { type: "h2", text: "2. Schützen Sie Ihre persönlichen Daten" },
    { type: "p", text: "Geben Sie in den ersten Gesprächen weder Ihren vollständigen Namen noch Ihre Wohn- oder Arbeitsadresse oder irgendwelche Finanzdaten preis. Schon Ihr Nachname kann über soziale Netzwerke sehr viel über Sie zugänglich machen. Nutzen Sie nur Ihren Vornamen, bis Vertrauen entstanden ist, und heben Sie persönliche Details für ein Gespräch von Angesicht zu Angesicht auf." },

    { type: "h2", text: "3. Bleiben Sie im App-Chat" },
    { type: "p", text: "Geben Sie Ihre private Telefonnummer oder Ihre Social-Media-Profile nicht schon zu Beginn des Kennenlernens heraus. Dating-Apps bieten in der Regel Melde- und Blockierfunktionen direkt im Chat; damit können Sie auf problematisches Verhalten reagieren und den Kontakt bei Bedarf sofort abbrechen. Persönliche Kontaktdaten sollten Sie erst nach mehreren Videoanrufen oder einem persönlichen Treffen teilen." },

    { type: "h2", text: "4. Treffen Sie sich beim ersten Date an öffentlichen Orten" },
    { type: "p", text: "Ihr erstes Date sollte immer an einem öffentlichen, belebten Ort stattfinden. Cafés, Restaurants und Einkaufszentren sind gute Optionen. Nehmen Sie keine Einladung in die Wohnung der anderen Person an und laden Sie sie auch nicht zu sich ein. Wählen Sie einen Ort, den Sie selbst erreichen können — beim ersten Treffen ins Auto der anderen Person zu steigen, ist keine gute Idee." },

    { type: "h2", text: "5. Informieren Sie eine Vertrauensperson" },
    { type: "p", text: "Sagen Sie einer Freundin, einem Freund oder einem Familienmitglied vorher Bescheid: wo Sie sein werden, wann und wie die andere Person heißt. Schicken Sie während des Dates ein, zwei Nachrichten oder vereinbaren Sie vorab eine feste \"Sicherheits-Check-in\"-Zeit. Manche Apps bieten genau dafür eingebaute Funktionen." },

    { type: "h2", text: "6. Bestätigen Sie per Videoanruf" },
    { type: "p", text: "Führen Sie mindestens einen Videoanruf, bevor Sie sich persönlich treffen. So können Sie prüfen, ob die Person zu ihren Profilfotos passt. Ein Videoanruf ist eine der einfachsten Möglichkeiten, ein gefälschtes Profil auffliegen zu lassen — genau deshalb ist jemand, der ihn beharrlich verweigert, ein ernstes Warnsignal." },

    { type: "h2", text: "7. Vorsicht mit Alkohol und anderen Substanzen" },
    { type: "p", text: "Halten Sie den Alkoholkonsum beim ersten Date gering oder verzichten Sie ganz darauf. Alkohol trübt Ihr Urteilsvermögen und erschwert es, mögliche Risiken zu erkennen. Bestellen Sie Ihre Getränke immer selbst und achten Sie darauf, dass sie in Ihrem Blickfeld zubereitet werden. Lassen Sie Ihr Getränk nie unbeaufsichtigt." },

    { type: "h2", text: "8. Fallen Sie nicht auf finanzielle Fallen herein" },
    { type: "p", text: "Um Geld oder Finanzdaten zu bitten, während man sich gerade erst kennenlernt, ist eines der verbreitetsten Betrugsmuster überhaupt. Schicken Sie niemals Geld an jemanden, den Sie noch nie persönlich getroffen haben, geben Sie keine Bankdaten weiter und nehmen Sie keine Angebote finanzieller Hilfe an. Eine als \"Notfall\" verpackte Geldforderung ist in jeder Phase einer Beziehung ein Stoppschild." },

    { type: "h2", text: "9. Erkennen Sie Warnsignale" },
    { type: "p", text: "Manche Verhaltensweisen sind ernste Warnzeichen und sollten nicht schöngeredet werden:" },
    { type: "ul", items: [
      "Liebeserklärungen schon nach wenigen Tagen (Love Bombing)",
      "Beharrliche Weigerung, einen Videoanruf zu führen",
      "Bitten um Geld oder Finanzdaten",
      "Kontrollierendes Verhalten, etwa ständige Fragen, wo Sie gerade sind",
      "Widersprüchliche Geschichten über die eigene Vergangenheit",
      "Überhaupt keine Spuren in sozialen Netzwerken oder ausschließlich brandneue Konten",
      "Wiederholt geänderte Treffpunkte oder das Drängen an abgelegene Orte",
    ] },

    { type: "h2", text: "10. Nutzen Sie die Sicherheitsfunktionen der App" },
    { type: "p", text: "Vertrauenswürdige Dating-Apps geben Ihnen Werkzeuge an die Hand: blockieren, melden und einen Weg zu einem menschlichen Moderationsteam. Nutzen Sie sie ohne Zögern, sobald sich etwas falsch anfühlt — eine Meldung kostet Sie nichts und ist der einzige Weg, über den überhaupt jemand davon erfährt. Bei Qulo stehen Blockieren und Melden im Drei-Punkte-Menü jedes Profils und jedes Chats, und jede Meldung landet in einem Moderationsbereich, in dem ein Mensch sie liest." },

    { type: "h2", text: "Die Sicherheitsfunktionen von Qulo" },
    { type: "p", text: "Qulo ist so gebaut, dass die Sicherheitswerkzeuge dort sind, wo Sie sie brauchen — und dass stimmt, was wir über sie sagen. Genau das leistet die App, nicht mehr:" },
    { type: "ul", items: [
      "**Verschlüsselte Speicherung:** Ihre Kontodaten und Nachrichten werden verschlüsselt gespeichert",
      "**E-Mail-Bestätigung:** Ihr Profil wird für andere erst sichtbar, nachdem Sie Ihre E-Mail-Adresse bestätigt haben",
      "**Blockieren und melden:** in einem Schritt über das Drei-Punkte-Menü jedes Profils und jedes Chats",
      "**Prüfung durch Menschen:** jede Meldung landet in einem Moderationsbereich und wird von einer Person gelesen",
      "**Fragenbasiertes Matching:** ein Match kostet auf Qulo echten Aufwand, was Massennachrichten und Spam-Konten mit wenig Mühe deutlich unattraktiver macht",
    ] },

    { type: "quote", text: "Keine App kann das Treffen mit einer fremden Person risikofrei machen. Was eine App tun kann, ist Ihnen die Werkzeuge und die Zeit zu geben, selbst zu entscheiden — und auf Qulo beginnt diese Entscheidung mit einer Frage." },

    { type: "h2", accent: "green", text: "Fazit: Sicher daten" },
    { type: "p", text: "Mit der richtigen Herangehensweise kann Online-Dating sicher und wirklich schön sein. Behalten Sie diese zehn Regeln im Kopf, vertrauen Sie Ihrem Bauchgefühl, und Sie reduzieren den Großteil des Risikos auf ein beherrschbares Maß. Denken Sie daran: Ihre Sicherheit kommt immer vor der Romantik. Lernen Sie sich auf Qulo sicher kennen und matchen Sie über Fragen." },
  ],
  fr: [
    { type: "h2", text: "Pourquoi la sécurité est-elle importante dans les rencontres en ligne ?" },
    { type: "p", text: "Les rencontres en ligne ont permis à des millions de personnes de trouver leur partenaire. Elles comportent aussi des risques qu'il vaut mieux nommer clairement : faux profils, tentatives d'escroquerie et l'incertitude ordinaire liée au fait de rencontrer un inconnu. La quasi-totalité de ces risques se gère quand on est informé. Ce guide couvre ce qu'il faut savoir pour que votre expérience reste sûre et agréable." },
    { type: "p", text: "Les gens ne sont pas naïfs à ce sujet. Dans l'enquête \"The Public and Online Dating 2026\" de **SSRS**, menée en janvier 2026 auprès de **2 012** adultes aux États-Unis, **57%** estiment qu'il est globalement sûr de rencontrer en personne quelqu'un avec qui on a matché sur une application, tandis que **43%** pensent le contraire. L'écart entre les sexes est marqué : **55%** des femmes jugent cela peu sûr, contre **30%** des hommes. Les arnaques sentimentales restent l'un des moyens les plus courants de cibler les gens sur les plateformes de rencontre — mais avec les bonnes précautions, les rencontres en ligne peuvent être une expérience réellement sûre." },

    { type: "h2", accent: "green", text: "10 règles d'or" },

    { type: "h2", text: "1. Choisissez vos photos de profil intelligemment" },
    { type: "p", text: "Vos photos de profil doivent vous présenter tout en protégeant votre sécurité personnelle. Évitez celles qui révèlent votre adresse, votre lieu de travail ou les endroits que vous fréquentez régulièrement. La plaque d'immatriculation de votre voiture, une étiquette de boîte aux lettres ou une carte de visite ne devraient apparaître sur aucune photo. Préférez des décors neutres à des lieux immédiatement reconnaissables." },

    { type: "h2", text: "2. Protégez vos informations personnelles" },
    { type: "p", text: "Lors des premiers échanges, ne communiquez ni votre nom complet, ni votre adresse personnelle ou professionnelle, ni la moindre information financière. Votre seul nom de famille peut déjà ouvrir la porte à énormément de choses vous concernant via les réseaux sociaux. N'utilisez que votre prénom tant que la confiance n'est pas établie, et gardez les détails personnels pour une conversation en face à face." },

    { type: "h2", text: "3. Privilégiez la messagerie de l'application" },
    { type: "p", text: "Évitez de donner votre numéro de téléphone personnel ou vos comptes de réseaux sociaux au tout début. Les applications de rencontre proposent généralement des outils de signalement et de blocage directement dans la conversation, qui vous aident à réagir à un comportement problématique et à couper court si nécessaire. Ne partagez vos coordonnées personnelles qu'après plusieurs appels vidéo ou une rencontre en personne." },

    { type: "h2", text: "4. Choisissez un lieu public pour un premier rendez-vous" },
    { type: "p", text: "Votre premier rendez-vous doit toujours avoir lieu dans un endroit public et fréquenté. Cafés, restaurants et centres commerciaux sont de bons choix. N'acceptez pas une invitation chez l'autre personne et ne l'invitez pas chez vous. Choisissez un lieu où vous pouvez vous rendre par vos propres moyens — monter dans la voiture de l'autre n'est pas approprié pour une première rencontre." },

    { type: "h2", text: "5. Prévenez un proche de confiance" },
    { type: "p", text: "Avant de partir, donnez les détails à un ami ou à un membre de votre famille en qui vous avez confiance : où vous serez, à quelle heure et le prénom de la personne. Envoyez un ou deux messages pendant le rendez-vous, ou convenez à l'avance d'une heure de \"point de sécurité\". Certaines applications proposent des fonctionnalités intégrées exactement pour cela." },

    { type: "h2", text: "6. Vérifiez par appel vidéo" },
    { type: "p", text: "Passez au moins un appel vidéo avant de vous rencontrer en personne. Cela vous permet de confirmer que la personne correspond à ses photos de profil. Un appel vidéo est l'un des moyens les plus simples de démasquer un faux profil, et c'est précisément pour cela que quelqu'un qui le refuse systématiquement constitue un sérieux signal d'alarme." },

    { type: "h2", text: "7. Soyez prudent avec l'alcool et les substances" },
    { type: "p", text: "Limitez l'alcool au minimum lors d'un premier rendez-vous, ou abstenez-vous complètement. L'alcool émousse votre jugement et rend les risques plus difficiles à percevoir. Commandez toujours vos boissons vous-même et assurez-vous qu'elles soient préparées sous vos yeux. Ne laissez jamais votre verre sans surveillance." },

    { type: "h2", text: "8. Ne tombez pas dans les pièges financiers" },
    { type: "p", text: "Demander de l'argent ou des informations financières alors que vous vous connaissez à peine est l'un des schémas d'escroquerie les plus répandus qui soient. N'envoyez jamais d'argent à quelqu'un que vous n'avez pas rencontré en personne, ne communiquez jamais vos coordonnées bancaires et n'acceptez pas d'offres d'aide financière. Une demande d'argent déguisée en \"urgence\" est un signal d'arrêt, quelle que soit l'étape de la relation." },

    { type: "h2", text: "9. Reconnaissez les signaux d'alarme" },
    { type: "p", text: "Certains comportements sont de sérieux avertissements et ne doivent pas être minimisés :" },
    { type: "ul", items: [
      "Déclarer son amour en quelques jours (love bombing)",
      "Refuser systématiquement les appels vidéo",
      "Demander de l'argent ou des informations financières",
      "Un comportement contrôlant, comme demander sans cesse où vous êtes",
      "Raconter des versions incohérentes de son passé",
      "N'avoir aucune présence sur les réseaux sociaux, ou uniquement des comptes tout neufs",
      "Changer le lieu du rendez-vous à répétition, ou orienter vers des endroits isolés",
    ] },

    { type: "h2", text: "10. Utilisez les fonctions de sécurité de l'application" },
    { type: "p", text: "Les applications de rencontre dignes de confiance vous donnent des outils : bloquer, signaler et joindre un modérateur humain. Utilisez-les sans hésiter dès que quelque chose vous met mal à l'aise — un signalement ne vous coûte rien, et c'est le seul moyen pour que quelqu'un soit au courant. Sur Qulo, le blocage et le signalement se trouvent dans le menu à trois points de chaque profil et de chaque conversation, et chaque signalement arrive dans un panneau de modération où une personne le lit." },

    { type: "h2", text: "Les fonctions de sécurité de Qulo" },
    { type: "p", text: "Qulo est conçue pour que les outils de sécurité soient là où vous en avez besoin, et pour que ce que nous en disons soit vrai. Voici exactement ce que fait l'application — rien de plus :" },
    { type: "ul", items: [
      "**Stockage chiffré :** vos données de compte et vos messages sont stockés de façon chiffrée",
      "**Vérification de l'e-mail :** votre profil ne devient visible par les autres qu'après confirmation de votre adresse e-mail",
      "**Blocage et signalement :** en une étape, depuis le menu à trois points de chaque profil et de chaque conversation",
      "**Relecture humaine :** chaque signalement arrive dans un panneau de modération et est lu par une personne",
      "**Matching par questions :** matcher sur Qulo demande un effort réel, ce qui rend les messages envoyés en masse et les comptes de spam bien moins rentables",
    ] },

    { type: "quote", text: "Aucune application ne peut rendre sans risque une rencontre avec un inconnu. Ce qu'une application peut faire, c'est vous donner les outils et le temps de décider par vous-même — et sur Qulo, cette décision commence par une question." },

    { type: "h2", accent: "green", text: "Conclusion : rencontrez en toute sécurité" },
    { type: "p", text: "Avec la bonne approche, les rencontres en ligne peuvent être sûres et réellement agréables. Gardez ces dix règles en tête, faites confiance à votre instinct, et vous ramènerez l'essentiel du risque à quelque chose de gérable. N'oubliez pas : votre sécurité passe avant la romance, à chaque fois. Rencontrez en toute sécurité sur Qulo, et matchez grâce aux questions." },
  ],
  es: [
    { type: "h2", text: "¿Por qué importa la seguridad en las citas online?" },
    { type: "p", text: "Las citas online han ayudado a millones de personas a encontrar pareja. También conllevan riesgos que conviene nombrar sin rodeos: perfiles falsos, intentos de estafa y la incertidumbre normal de quedar con un desconocido. Casi todos ellos se pueden manejar si vas informado. Esta guía cubre lo que necesitas saber para que tu experiencia sea segura y agradable." },
    { type: "p", text: "La gente no es ingenua al respecto. En la encuesta \"The Public and Online Dating 2026\" de **SSRS**, realizada en enero de 2026 entre **2.012** adultos de Estados Unidos, el **57%** afirmó que quedar en persona con alguien tras hacer match en una app de citas es en general seguro, mientras que el **43%** dijo que no lo es. La brecha por género es notable: el **55%** de las mujeres lo considera inseguro, frente al **30%** de los hombres. Las estafas románticas siguen siendo una de las formas más habituales de atacar a las personas en las plataformas de citas, pero con las precauciones adecuadas las citas online pueden ser una experiencia realmente segura." },

    { type: "h2", accent: "green", text: "10 reglas de oro" },

    { type: "h2", text: "1. Elige tus fotos de perfil con cabeza" },
    { type: "p", text: "Tus fotos de perfil deben presentarte y, a la vez, proteger tu seguridad personal. Evita imágenes que revelen tu domicilio, tu lugar de trabajo o los sitios a los que vas habitualmente. Detalles como la matrícula de tu coche, el buzón con tu apellido o una tarjeta de visita no deberían aparecer en ninguna foto. Prefiere entornos neutros antes que lugares reconocibles al instante." },

    { type: "h2", text: "2. Protege tu información personal" },
    { type: "p", text: "En las primeras conversaciones no compartas tu nombre completo, tu dirección, la de tu trabajo ni ningún dato financiero. Solo con tu apellido se puede llegar a saber muchísimo de ti a través de las redes sociales. Usa únicamente tu nombre de pila hasta que exista confianza, y deja los datos personales detallados para una conversación cara a cara." },

    { type: "h2", text: "3. Prioriza el chat dentro de la app" },
    { type: "p", text: "Evita dar tu número de teléfono personal o tus redes sociales al principio del proceso de conocerse. Las apps de citas suelen ofrecer herramientas de denuncia y bloqueo dentro del propio chat, que te ayudan a responder ante un comportamiento problemático y a cortar el contacto si hace falta. Comparte tus datos personales solo después de varias videollamadas o de un encuentro presencial." },

    { type: "h2", text: "4. Elige lugares públicos para la primera cita" },
    { type: "p", text: "Tu primera cita debe ser siempre en un sitio público y concurrido. Cafeterías, restaurantes y centros comerciales son buenas opciones. No aceptes una invitación a su casa ni la invites a la tuya. Elige un lugar al que puedas llegar por tu cuenta: subirte al coche de la otra persona no es apropiado para un primer encuentro." },

    { type: "h2", text: "5. Avisa a alguien de confianza" },
    { type: "p", text: "Antes de salir, cuéntale los detalles a una amiga, un amigo o un familiar de confianza: dónde estarás, a qué hora y el nombre de la otra persona. Manda un par de mensajes durante la cita o acuerda de antemano una hora de \"control de seguridad\". Algunas apps ofrecen funciones integradas justo para esto." },

    { type: "h2", text: "6. Verifica con una videollamada" },
    { type: "p", text: "Haz al menos una videollamada antes de quedar en persona. Te permite confirmar que la persona coincide con sus fotos de perfil. Una videollamada es una de las formas más sencillas de destapar un perfil falso, y por eso alguien que la rechaza una y otra vez es una señal de alarma seria." },

    { type: "h2", text: "7. Ten cuidado con el alcohol y otras sustancias" },
    { type: "p", text: "Reduce el alcohol al mínimo en una primera cita, o prescinde de él. El alcohol nubla tu criterio y hace más difícil detectar posibles riesgos. Pide siempre tus propias bebidas y asegúrate de que las preparen a la vista. Nunca dejes tu copa sin vigilancia." },

    { type: "h2", text: "8. No caigas en trampas financieras" },
    { type: "p", text: "Pedir dinero o datos financieros cuando apenas os estáis conociendo es uno de los patrones de estafa más extendidos que existen. No envíes nunca dinero a alguien a quien no has visto en persona, no compartas datos bancarios y no aceptes ofertas de ayuda económica. Una petición de dinero disfrazada de \"emergencia\" es una señal de stop en cualquier etapa de la relación." },

    { type: "h2", text: "9. Reconoce las señales de alarma" },
    { type: "p", text: "Algunos comportamientos son avisos serios y no deberían justificarse:" },
    { type: "ul", items: [
      "Declarar amor en cuestión de días (love bombing)",
      "Rechazar sistemáticamente las videollamadas",
      "Pedir dinero o datos financieros",
      "Conductas controladoras, como preguntar constantemente dónde estás",
      "Contar versiones incoherentes sobre su pasado",
      "No tener ninguna presencia en redes sociales, o solo cuentas recién creadas",
      "Cambiar el lugar de la cita una y otra vez, o dirigirte hacia sitios aislados",
    ] },

    { type: "h2", text: "10. Usa las funciones de seguridad de la app" },
    { type: "p", text: "Las apps de citas fiables te dan herramientas: bloquear, denunciar y una vía para llegar a una persona de moderación. Úsalas sin dudar en cuanto algo no te encaje: denunciar no te cuesta nada y es la única manera de que alguien se entere. En Qulo, bloquear y denunciar están en el menú de tres puntos de cada perfil y de cada chat, y cada denuncia llega a un panel de moderación donde una persona la lee." },

    { type: "h2", text: "Las funciones de seguridad de Qulo" },
    { type: "p", text: "Qulo está hecha para que las herramientas de seguridad estén donde las necesitas y para que lo que decimos sobre ellas sea cierto. Esto es exactamente lo que hace la app, ni más ni menos:" },
    { type: "ul", items: [
      "**Almacenamiento cifrado:** los datos de tu cuenta y tus mensajes se guardan cifrados",
      "**Verificación por email:** tu perfil solo se vuelve visible para los demás después de confirmar tu dirección de correo",
      "**Bloquear y denunciar:** en un solo paso, desde el menú de tres puntos de cada perfil y cada chat",
      "**Revisión humana:** cada denuncia llega a un panel de moderación y la lee una persona",
      "**Emparejamiento por preguntas:** hacer match en Qulo exige esfuerzo real, lo que hace mucho menos rentables los mensajes masivos y las cuentas de spam",
    ] },

    { type: "quote", text: "Ninguna app puede eliminar el riesgo de quedar con un desconocido. Lo que sí puede hacer es darte las herramientas y el tiempo para decidir por ti mismo, y en Qulo esa decisión empieza con una pregunta." },

    { type: "h2", accent: "green", text: "Conclusión: queda con seguridad" },
    { type: "p", text: "Con el enfoque adecuado, las citas online pueden ser seguras y realmente disfrutables. Ten presentes estas diez reglas, fíate de tu instinto y reducirás la mayor parte del riesgo a algo manejable. Recuerda: tu seguridad va antes que el romanticismo, siempre. Conoce gente con seguridad en Qulo y haz match a través de preguntas." },
  ],
  ar: [
    { type: "h2", text: "لماذا تهمّ السلامة في المواعدة عبر الإنترنت؟" },
    { type: "p", text: "ساعدت المواعدة عبر الإنترنت ملايين الأشخاص على العثور على شريك حياتهم. لكنها تحمل أيضًا مخاطر يجدر تسميتها بوضوح: حسابات مزيّفة، ومحاولات احتيال، وحالة عدم اليقين الطبيعية المصاحبة للقاء شخص غريب. ويمكن التعامل مع معظم ذلك إذا كنت على دراية. يغطي هذا الدليل ما تحتاج إلى معرفته كي تبقى تجربتك آمنة وممتعة في آن واحد." },
    { type: "p", text: "الناس ليسوا سُذّجًا في هذا الأمر. ففي استطلاع **SSRS** بعنوان \"The Public and Online Dating 2026\"، الذي أُجري في يناير 2026 على **2,012** بالغًا في الولايات المتحدة، قال **57%** إن لقاء شخص وجهًا لوجه بعد التوافق معه على تطبيق مواعدة آمن عمومًا، بينما قال **43%** إنه ليس آمنًا. والفجوة بين الجنسين واسعة: **55%** من النساء يرين أنه غير آمن، مقابل **30%** من الرجال. ولا تزال عمليات الاحتيال العاطفي من أكثر الطرق شيوعًا لاستهداف الناس على منصات المواعدة — لكن مع الاحتياطات الصحيحة يمكن أن تكون المواعدة عبر الإنترنت تجربة آمنة فعلًا." },

    { type: "h2", accent: "green", text: "10 قواعد ذهبية" },

    { type: "h2", text: "1. اختر صور ملفك الشخصي بذكاء" },
    { type: "p", text: "ينبغي لصور ملفك الشخصي أن تعرّف بك وتحمي سلامتك الشخصية في الوقت نفسه. تجنّب الصور التي تكشف عنوان منزلك أو مكان عملك أو الأماكن التي ترتادها بانتظام. تفاصيل مثل لوحة سيارتك أو لافتة الاسم على بابك أو بطاقة عملك يجب ألّا تظهر في أي صورة. فضّل الخلفيات المحايدة على الأماكن التي يسهل التعرّف عليها فورًا." },

    { type: "h2", text: "2. احمِ معلوماتك الشخصية" },
    { type: "p", text: "في المحادثات الأولى، لا تشارك اسمك الكامل ولا عنوان منزلك أو عملك ولا أي معلومات مالية. حتى اسم عائلتك وحده قد يفتح الباب لمعرفة الكثير عنك عبر وسائل التواصل الاجتماعي. استخدم اسمك الأول فقط إلى أن تُبنى الثقة، واترك التفاصيل الشخصية لحديث وجهًا لوجه." },

    { type: "h2", text: "3. فضّل المراسلة داخل التطبيق" },
    { type: "p", text: "تجنّب إعطاء رقم هاتفك الشخصي أو حساباتك على وسائل التواصل في بداية التعارف. تتيح تطبيقات المواعدة عادةً أدوات للإبلاغ والحظر داخل المحادثة نفسها، وهي تساعدك على التعامل مع السلوك المزعج وقطع التواصل عند الحاجة. لا تشارك بيانات تواصلك الشخصية إلا بعد عدة مكالمات مرئية أو لقاء وجهًا لوجه." },

    { type: "h2", text: "4. اختر الأماكن العامة للقاء الأول" },
    { type: "p", text: "يجب أن يكون لقاؤك الأول دائمًا في مكان عام ومزدحم. المقاهي والمطاعم ومراكز التسوق خيارات جيدة. لا تقبل دعوة إلى منزل الطرف الآخر ولا تدعُه إلى منزلك. اختر مكانًا يمكنك الوصول إليه بنفسك — فركوب سيارة الطرف الآخر ليس مناسبًا في اللقاء الأول." },

    { type: "h2", text: "5. أخبر شخصًا تثق به" },
    { type: "p", text: "قبل أن تذهب، أخبر صديقًا أو أحد أفراد عائلتك ممّن تثق بهم بالتفاصيل: أين ستكون، وفي أي ساعة، وما اسم الطرف الآخر. أرسل رسالة أو رسالتين أثناء اللقاء، أو اتفقوا مسبقًا على موعد \"تحقّق أمان\". وتوفّر بعض التطبيقات ميزات مدمجة لهذا الغرض تحديدًا." },

    { type: "h2", text: "6. تحقّق عبر مكالمة مرئية" },
    { type: "p", text: "أجرِ مكالمة مرئية واحدة على الأقل قبل اللقاء المباشر. فهي تتيح لك التأكد من أن الشخص يطابق صور ملفه الشخصي. المكالمة المرئية من أبسط الطرق لكشف حساب مزيّف، ولهذا السبب بالذات فإن من يرفضها باستمرار يمثّل إشارة تحذير خطيرة." },

    { type: "h2", text: "7. انتبه للكحول والمواد المخدّرة" },
    { type: "p", text: "قلّل الكحول إلى أدنى حد في اللقاء الأول أو امتنع عنه تمامًا. الكحول يُضعف قدرتك على الحكم ويجعل ملاحظة المخاطر المحتملة أصعب. اطلب مشروبك بنفسك دائمًا وتأكد من تحضيره أمام ناظريك. ولا تترك كأسك من دون مراقبة أبدًا." },

    { type: "h2", text: "8. لا تقع في الفخاخ المالية" },
    { type: "p", text: "طلب المال أو المعلومات المالية بينما لا تزالان في بداية التعارف من أكثر أنماط الاحتيال انتشارًا على الإطلاق. لا ترسل مالًا أبدًا إلى شخص لم تلتقِ به وجهًا لوجه، ولا تشارك بيانات حسابك المصرفي، ولا تقبل عروض المساعدة المالية. وطلب المال المغلّف بحجة \"حالة طارئة\" علامة توقف في أي مرحلة من مراحل العلاقة." },

    { type: "h2", text: "9. تعرّف على العلامات التحذيرية" },
    { type: "p", text: "بعض السلوكيات إشارات تحذير جدية ولا ينبغي التماس الأعذار لها:" },
    { type: "ul", items: [
      "إعلان الحب خلال أيام قليلة (القصف العاطفي)",
      "رفض المكالمات المرئية باستمرار",
      "طلب المال أو المعلومات المالية",
      "السلوك المُسيطِر، مثل السؤال الدائم عن مكانك",
      "رواية قصص متناقضة عن ماضيه",
      "غياب أي أثر له على وسائل التواصل الاجتماعي، أو وجود حسابات حديثة جدًا فقط",
      "تغيير مكان اللقاء مرارًا، أو توجيهك نحو أماكن منعزلة",
    ] },

    { type: "h2", text: "10. استخدم ميزات الأمان في التطبيق" },
    { type: "p", text: "تمنحك تطبيقات المواعدة الموثوقة أدوات: الحظر والإبلاغ وطريقة للوصول إلى مشرف بشري. استخدمها من دون تردّد فور شعورك بأن شيئًا ما ليس على ما يرام — فالإبلاغ لا يكلّفك شيئًا، وهو السبيل الوحيد ليعلم أحد بالأمر. في Qulo، يوجد الحظر والإبلاغ في قائمة النقاط الثلاث على كل ملف شخصي وكل محادثة، وكل بلاغ يصل إلى لوحة إشراف يقرأه فيها شخص حقيقي." },

    { type: "h2", text: "ميزات الأمان في Qulo" },
    { type: "p", text: "بُني Qulo بحيث تكون أدوات الأمان في المكان الذي تحتاجها فيه، وبحيث يكون ما نقوله عنها صحيحًا. وهذا بالضبط ما يفعله التطبيق، لا أكثر:" },
    { type: "ul", items: [
      "**تخزين مشفّر:** تُخزَّن بيانات حسابك ورسائلك بصيغة مشفّرة",
      "**تأكيد البريد الإلكتروني:** لا يصبح ملفك مرئيًا للآخرين إلا بعد تأكيد عنوان بريدك الإلكتروني",
      "**الحظر والإبلاغ:** بخطوة واحدة من قائمة النقاط الثلاث على كل ملف شخصي وكل محادثة",
      "**مراجعة بشرية:** كل بلاغ يصل إلى لوحة إشراف ويقرأه شخص حقيقي",
      "**التوافق القائم على الأسئلة:** التوافق في Qulo يتطلب جهدًا حقيقيًا، ما يجعل الرسائل الجماعية وحسابات السبام قليلة الجهد أقل جدوى بكثير",
    ] },

    { type: "quote", text: "لا يستطيع أي تطبيق أن يجعل لقاء شخص غريب خاليًا من المخاطر. ما يستطيع التطبيق فعله هو أن يمنحك الأدوات والوقت لتقرّر بنفسك — وفي Qulo يبدأ هذا القرار بسؤال." },

    { type: "h2", accent: "green", text: "الخلاصة: تواعد بأمان" },
    { type: "p", text: "بالنهج الصحيح يمكن أن تكون المواعدة عبر الإنترنت تجربة آمنة وممتعة حقًا. تذكّر هذه القواعد العشر، وثِق بحدسك، وستُقلّص معظم المخاطر إلى حدّ يمكن التحكم فيه. وتذكّر: سلامتك تأتي قبل الرومانسية في كل مرة. تعرّف على الناس بأمان عبر Qulo، وتوافق من خلال الأسئلة." },
  ],
  ru: [
    { type: "h2", text: "Почему безопасность в онлайн-знакомствах так важна?" },
    { type: "p", text: "Онлайн-знакомства помогли миллионам людей найти свою пару. Но они несут и риски, которые стоит называть прямо: фальшивые анкеты, попытки мошенничества и обычная неопределённость встречи с незнакомым человеком. Почти со всем этим можно справиться, если знать, на что смотреть. Это руководство собирает то, что нужно знать, чтобы опыт знакомств оставался безопасным и приятным." },
    { type: "p", text: "Люди не наивны на этот счёт. В опросе **SSRS** «The Public and Online Dating 2026», проведённом в январе 2026 года среди **2 012** взрослых жителей США, **57%** ответили, что встреча вживую после совпадения в приложении для знакомств в целом безопасна, а **43%** — что нет. Разрыв между мужчинами и женщинами велик: **55%** женщин считают такую встречу небезопасной против **30%** мужчин. Романтическое мошенничество остаётся одним из самых распространённых способов охоты на людей на платформах знакомств — но при правильных мерах предосторожности онлайн-знакомства действительно могут быть безопасными." },

    { type: "h2", accent: "green", text: "10 золотых правил" },

    { type: "h2", text: "1. Выбирайте фотографии профиля с умом" },
    { type: "p", text: "Фотографии в профиле должны представлять вас и при этом беречь вашу личную безопасность. Избегайте кадров, по которым можно определить ваш домашний адрес, место работы или места, где вы бываете регулярно. Номер вашей машины, табличка с фамилией на двери или визитка не должны попадать ни на один снимок. Нейтральный фон лучше мгновенно узнаваемых мест." },

    { type: "h2", text: "2. Берегите личные данные" },
    { type: "p", text: "В первых переписках не сообщайте полное имя, домашний или рабочий адрес и никакую финансовую информацию. Даже одна фамилия способна открыть о вас очень многое через социальные сети. Пока не появилось доверие, используйте только имя, а подробности оставьте для разговора при личной встрече." },

    { type: "h2", text: "3. Общайтесь внутри приложения" },
    { type: "p", text: "Не спешите давать личный номер телефона или ссылки на соцсети в самом начале знакомства. Приложения для знакомств обычно предлагают инструменты жалобы и блокировки прямо в переписке: они помогают отреагировать на неприятное поведение и при необходимости прекратить общение. Личные контакты стоит давать только после нескольких видеозвонков или встречи вживую." },

    { type: "h2", text: "4. Первое свидание — только в людном месте" },
    { type: "p", text: "Первая встреча всегда должна проходить в публичном, оживлённом месте. Кафе, рестораны и торговые центры — хороший выбор. Не соглашайтесь на приглашение домой и не зовите к себе. Выбирайте место, до которого доберётесь сами: садиться в машину к малознакомому человеку на первой встрече не стоит." },

    { type: "h2", text: "5. Предупредите близкого человека" },
    { type: "p", text: "Перед выходом расскажите подробности другу или родственнику, которому доверяете: где вы будете, во сколько и как зовут вашего собеседника. Напишите пару сообщений во время встречи или заранее договоритесь о времени «проверки безопасности». В некоторых приложениях для этого есть встроенные функции." },

    { type: "h2", text: "6. Проверьте человека по видеосвязи" },
    { type: "p", text: "До личной встречи сделайте хотя бы один видеозвонок. Так вы убедитесь, что человек совпадает со своими фотографиями. Видеозвонок — один из простейших способов раскрыть фальшивую анкету, и именно поэтому тот, кто настойчиво его избегает, — серьёзный тревожный сигнал." },

    { type: "h2", text: "7. Осторожнее с алкоголем и веществами" },
    { type: "p", text: "На первом свидании сведите алкоголь к минимуму или откажитесь от него совсем. Алкоголь притупляет способность трезво оценивать происходящее и мешает заметить возможную опасность. Заказывайте напитки сами и следите, чтобы их готовили у вас на глазах. Никогда не оставляйте свой бокал без присмотра." },

    { type: "h2", text: "8. Не попадайтесь на финансовые ловушки" },
    { type: "p", text: "Просьба о деньгах или финансовых данных, когда вы только знакомитесь, — одна из самых распространённых мошеннических схем вообще. Никогда не переводите деньги человеку, которого не видели вживую, не сообщайте банковские реквизиты и не принимайте предложений финансовой помощи. Просьба о деньгах под видом «срочного случая» — стоп-сигнал на любом этапе отношений." },

    { type: "h2", text: "9. Распознавайте тревожные признаки" },
    { type: "p", text: "Некоторые модели поведения — серьёзные предупреждения, и им не стоит искать оправданий:" },
    { type: "ul", items: [
      "Признания в любви уже через несколько дней (лав-бомбинг)",
      "Постоянный отказ от видеозвонков",
      "Просьбы о деньгах или финансовых данных",
      "Контролирующее поведение — например, постоянные вопросы, где вы находитесь",
      "Противоречивые рассказы о собственном прошлом",
      "Полное отсутствие следов в соцсетях или только что созданные аккаунты",
      "Многократная смена места встречи или попытки увести вас в безлюдные места",
    ] },

    { type: "h2", text: "10. Пользуйтесь функциями безопасности приложения" },
    { type: "p", text: "Надёжные приложения для знакомств дают вам инструменты: блокировку, жалобу и способ достучаться до живого модератора. Используйте их без колебаний, как только что-то настораживает: жалоба ничего вам не стоит и остаётся единственным способом хоть кому-то об этом сообщить. В Qulo блокировка и жалоба находятся в меню из трёх точек в каждой анкете и в каждом чате, а каждая жалоба попадает в панель модерации, где её читает человек." },

    { type: "h2", text: "Функции безопасности Qulo" },
    { type: "p", text: "Qulo сделан так, чтобы инструменты безопасности были там, где они нужны, и чтобы сказанное о них было правдой. Вот что приложение делает — и ничего сверх того:" },
    { type: "ul", items: [
      "**Шифрованное хранение:** данные вашего аккаунта и сообщения хранятся в зашифрованном виде",
      "**Подтверждение почты:** ваш профиль становится виден другим только после подтверждения адреса электронной почты",
      "**Блокировка и жалоба:** в одно действие из меню трёх точек в любой анкете и в любом чате",
      "**Проверка человеком:** каждая жалоба попадает в панель модерации, и её читает человек",
      "**Совпадение через вопросы:** совпадение в Qulo требует реальных усилий, поэтому массовые рассылки и спам-аккаунты становятся куда менее выгодными",
    ] },

    { type: "quote", text: "Ни одно приложение не сделает встречу с незнакомцем безрисковой. Что приложение может — дать вам инструменты и время, чтобы решить самостоятельно. В Qulo это решение начинается с вопроса." },

    { type: "h2", accent: "green", text: "Вывод: знакомьтесь безопасно" },
    { type: "p", text: "При правильном подходе онлайн-знакомства могут быть безопасными и по-настоящему приятными. Держите в голове эти десять правил, доверяйте своей интуиции — и большую часть рисков вы сведёте к управляемому уровню. Помните: безопасность всегда идёт впереди романтики. Знакомьтесь безопасно в Qulo и находите совпадения через вопросы." },
  ],
  pt: [
    { type: "h2", text: "Por que a segurança importa no namoro online?" },
    { type: "p", text: "O namoro online já ajudou milhões de pessoas a encontrar quem procuravam. Também traz riscos que vale nomear sem rodeios: perfis falsos, tentativas de golpe e a incerteza natural de encontrar um desconhecido. Quase tudo isso é gerenciável por quem está bem informado. Este guia reúne o que você precisa saber para manter a experiência segura e agradável." },
    { type: "p", text: "As pessoas não são ingênuas quanto a isso. Na pesquisa \"The Public and Online Dating 2026\", da **SSRS**, realizada em janeiro de 2026 com **2.012** adultos nos Estados Unidos, **57%** disseram que encontrar pessoalmente alguém com quem deram match em um aplicativo de namoro é geralmente seguro, enquanto **43%** disseram que não é. A diferença entre os gêneros é acentuada: **55%** das mulheres consideram inseguro, contra **30%** dos homens. Os golpes amorosos continuam sendo uma das formas mais comuns de atingir pessoas em plataformas de relacionamento — mas, com as precauções certas, o namoro online pode ser uma experiência realmente segura." },

    { type: "h2", accent: "green", text: "10 regras de ouro" },

    { type: "h2", text: "1. Escolha suas fotos de perfil com cuidado" },
    { type: "p", text: "Suas fotos de perfil devem apresentar você e, ao mesmo tempo, proteger sua segurança pessoal. Evite imagens que revelem seu endereço, seu local de trabalho ou os lugares que você frequenta com regularidade. Detalhes como a placa do seu carro, a plaqueta de nome na porta ou um cartão de visita não deveriam aparecer em foto alguma. Prefira cenários neutros a lugares imediatamente reconhecíveis." },

    { type: "h2", text: "2. Proteja suas informações pessoais" },
    { type: "p", text: "Nas primeiras conversas, não compartilhe seu nome completo, seu endereço residencial ou de trabalho, nem qualquer informação financeira. Só o sobrenome já pode abrir a porta para muita coisa sobre você nas redes sociais. Use apenas o primeiro nome até que exista confiança e guarde os detalhes pessoais para uma conversa cara a cara." },

    { type: "h2", text: "3. Prefira as mensagens dentro do aplicativo" },
    { type: "p", text: "Evite passar seu telefone pessoal ou suas redes sociais logo no começo do processo de se conhecerem. Aplicativos de namoro normalmente oferecem ferramentas de denúncia e bloqueio dentro da própria conversa, que ajudam a lidar com comportamentos problemáticos e a encerrar o contato se for preciso. Compartilhe dados pessoais apenas depois de algumas chamadas de vídeo ou de um encontro presencial." },

    { type: "h2", text: "4. Escolha lugares públicos para o primeiro encontro" },
    { type: "p", text: "Seu primeiro encontro deve sempre acontecer em um lugar público e movimentado. Cafés, restaurantes e shoppings são boas opções. Não aceite convites para a casa da outra pessoa e não a convide para a sua. Escolha um local aonde você consiga chegar sozinho — entrar no carro da outra pessoa não é apropriado para um primeiro encontro." },

    { type: "h2", text: "5. Avise alguém de confiança" },
    { type: "p", text: "Antes de sair, conte os detalhes a um amigo ou familiar de confiança: onde você vai estar, a que horas e o nome da outra pessoa. Mande uma ou duas mensagens durante o encontro ou combine antes um horário de \"check-in de segurança\". Alguns aplicativos oferecem recursos integrados exatamente para isso." },

    { type: "h2", text: "6. Confirme por chamada de vídeo" },
    { type: "p", text: "Faça pelo menos uma chamada de vídeo antes de se encontrarem pessoalmente. Assim você confirma que a pessoa corresponde às fotos do perfil. Uma chamada de vídeo é uma das maneiras mais simples de expor um perfil falso — e é justamente por isso que alguém que recusa insistentemente é um sinal de alerta sério." },

    { type: "h2", text: "7. Tenha cuidado com álcool e outras substâncias" },
    { type: "p", text: "Mantenha o álcool no mínimo em um primeiro encontro, ou dispense por completo. O álcool embota seu julgamento e dificulta perceber riscos. Peça sempre a sua própria bebida e garanta que ela seja preparada no seu campo de visão. Nunca deixe seu copo sem vigilância." },

    { type: "h2", text: "8. Não caia em armadilhas financeiras" },
    { type: "p", text: "Pedir dinheiro ou dados financeiros enquanto vocês ainda estão se conhecendo é um dos padrões de golpe mais difundidos que existem. Nunca envie dinheiro a quem você não encontrou pessoalmente, nunca compartilhe dados bancários e não aceite ofertas de ajuda financeira. Um pedido de dinheiro disfarçado de \"emergência\" é um sinal de parada em qualquer fase de uma relação." },

    { type: "h2", text: "9. Reconheça os sinais de alerta" },
    { type: "p", text: "Alguns comportamentos são avisos sérios e não devem ser relevados:" },
    { type: "ul", items: [
      "Declarar amor em poucos dias (love bombing)",
      "Recusar chamadas de vídeo de forma sistemática",
      "Pedir dinheiro ou dados financeiros",
      "Comportamento controlador, como perguntar o tempo todo onde você está",
      "Contar versões inconsistentes sobre o próprio passado",
      "Não ter presença alguma em redes sociais, ou apenas contas recém-criadas",
      "Mudar o local do encontro repetidamente ou empurrar você para lugares isolados",
    ] },

    { type: "h2", text: "10. Use os recursos de segurança do aplicativo" },
    { type: "p", text: "Aplicativos de namoro confiáveis colocam ferramentas na sua mão: bloquear, denunciar e um caminho até um moderador humano. Use-as sem hesitar assim que algo parecer errado — uma denúncia não custa nada a você e é a única forma de alguém ficar sabendo. No Qulo, bloquear e denunciar ficam no menu de três pontos de cada perfil e de cada conversa, e cada denúncia chega a um painel de moderação onde uma pessoa a lê." },

    { type: "h2", text: "Os recursos de segurança do Qulo" },
    { type: "p", text: "O Qulo foi construído para que as ferramentas de segurança estejam onde você precisa delas e para que o que dizemos sobre elas seja verdade. É exatamente isto que o aplicativo faz — nada além:" },
    { type: "ul", items: [
      "**Armazenamento criptografado:** os dados da sua conta e suas mensagens são guardados de forma criptografada",
      "**Verificação de e-mail:** seu perfil só fica visível para outras pessoas depois que você confirma seu endereço de e-mail",
      "**Bloquear e denunciar:** em um passo, pelo menu de três pontos de qualquer perfil e de qualquer conversa",
      "**Revisão humana:** toda denúncia vai para um painel de moderação e é lida por uma pessoa",
      "**Match por perguntas:** dar match no Qulo exige esforço real, o que torna mensagens em massa e contas de spam bem menos vantajosas",
    ] },

    { type: "quote", text: "Nenhum aplicativo consegue tornar sem risco o encontro com um desconhecido. O que um aplicativo pode fazer é dar a você as ferramentas e o tempo para decidir por conta própria — e, no Qulo, essa decisão começa com uma pergunta." },

    { type: "h2", accent: "green", text: "Conclusão: encontre com segurança" },
    { type: "p", text: "Com a abordagem certa, o namoro online pode ser seguro e realmente prazeroso. Guarde estas dez regras, confie no seu instinto e você reduzirá a maior parte do risco a algo administrável. Lembre-se: sua segurança vem antes do romance, sempre. Conheça pessoas com segurança no Qulo e dê match através de perguntas." },
  ],
  it: [
    { type: "h2", text: "Perché la sicurezza conta negli incontri online?" },
    { type: "p", text: "Gli incontri online hanno aiutato milioni di persone a trovare un partner. Portano però con sé rischi che conviene nominare senza giri di parole: profili falsi, tentativi di truffa e la normale incertezza di incontrare uno sconosciuto. Quasi tutto è gestibile da chi è informato. Questa guida raccoglie ciò che serve sapere per mantenere l'esperienza sicura e piacevole." },
    { type: "p", text: "Le persone non sono affatto ingenue su questo. Nel sondaggio \"The Public and Online Dating 2026\" di **SSRS**, condotto a gennaio 2026 su **2.012** adulti negli Stati Uniti, il **57%** ha dichiarato che incontrare di persona qualcuno dopo un match su un'app di incontri è in generale sicuro, mentre il **43%** ha risposto il contrario. Il divario di genere è netto: il **55%** delle donne lo considera non sicuro, contro il **30%** degli uomini. Le truffe romantiche restano uno dei modi più diffusi per colpire le persone sulle piattaforme di incontri — ma con le giuste precauzioni gli incontri online possono essere un'esperienza davvero sicura." },

    { type: "h2", accent: "green", text: "10 regole d'oro" },

    { type: "h2", text: "1. Scegli le foto del profilo con criterio" },
    { type: "p", text: "Le foto del profilo devono presentarti e allo stesso tempo proteggere la tua sicurezza personale. Evita immagini che rivelino il tuo indirizzo di casa, il posto di lavoro o i luoghi che frequenti abitualmente. Dettagli come la targa dell'auto, la targhetta sul campanello o un biglietto da visita non dovrebbero comparire in nessuna foto. Meglio ambienti neutri che luoghi immediatamente riconoscibili." },

    { type: "h2", text: "2. Proteggi le tue informazioni personali" },
    { type: "p", text: "Nelle prime conversazioni non condividere nome completo, indirizzo di casa o di lavoro, né alcuna informazione finanziaria. Anche solo il cognome può aprire la porta a moltissime informazioni su di te attraverso i social. Usa solo il nome di battesimo finché non si è costruita una fiducia, e lascia i dettagli personali a una conversazione dal vivo." },

    { type: "h2", text: "3. Preferisci la chat dentro l'app" },
    { type: "p", text: "Evita di dare il tuo numero di telefono personale o i tuoi profili social all'inizio della conoscenza. Le app di incontri offrono di norma strumenti di segnalazione e blocco dentro la conversazione stessa: aiutano a gestire un comportamento problematico e a interrompere il contatto se serve. Condividi i tuoi recapiti solo dopo diverse videochiamate o un incontro di persona." },

    { type: "h2", text: "4. Scegli luoghi pubblici per il primo appuntamento" },
    { type: "p", text: "Il primo appuntamento deve svolgersi sempre in un posto pubblico e frequentato. Bar, ristoranti e centri commerciali sono buone scelte. Non accettare inviti a casa dell'altra persona e non invitarla a casa tua. Scegli un luogo che puoi raggiungere da solo: salire in auto con l'altra persona non è adatto a un primo incontro." },

    { type: "h2", text: "5. Avvisa una persona di fiducia" },
    { type: "p", text: "Prima di uscire, racconta i dettagli a un amico o a un familiare di cui ti fidi: dove sarai, a che ora e il nome dell'altra persona. Manda un paio di messaggi durante l'appuntamento oppure concordate in anticipo un orario di \"check-in di sicurezza\". Alcune app offrono funzioni integrate proprio per questo." },

    { type: "h2", text: "6. Verifica con una videochiamata" },
    { type: "p", text: "Fai almeno una videochiamata prima di incontrarvi di persona. Ti permette di confermare che la persona corrisponda alle foto del profilo. Una videochiamata è uno dei modi più semplici per smascherare un profilo falso, ed è proprio per questo che chi la rifiuta con insistenza è un campanello d'allarme serio." },

    { type: "h2", text: "7. Attenzione ad alcol e sostanze" },
    { type: "p", text: "Al primo appuntamento riduci l'alcol al minimo, o rinuncia del tutto. L'alcol offusca il giudizio e rende più difficile accorgersi dei rischi. Ordina sempre da bere per conto tuo e assicurati che la bevanda venga preparata sotto i tuoi occhi. Non lasciare mai il bicchiere incustodito." },

    { type: "h2", text: "8. Non cadere nelle trappole finanziarie" },
    { type: "p", text: "Chiedere denaro o dati finanziari quando ci si sta appena conoscendo è uno degli schemi di truffa più diffusi in assoluto. Non inviare mai denaro a qualcuno che non hai incontrato di persona, non condividere le coordinate bancarie e non accettare offerte di aiuto economico. Una richiesta di soldi mascherata da \"emergenza\" è un segnale di stop in qualunque fase di una relazione." },

    { type: "h2", text: "9. Riconosci i segnali d'allarme" },
    { type: "p", text: "Alcuni comportamenti sono avvertimenti seri e non vanno giustificati:" },
    { type: "ul", items: [
      "Dichiarazioni d'amore nel giro di pochi giorni (love bombing)",
      "Rifiuto sistematico delle videochiamate",
      "Richieste di denaro o di dati finanziari",
      "Comportamenti controllanti, come chiedere di continuo dove ti trovi",
      "Racconti incoerenti sul proprio passato",
      "Nessuna traccia sui social, oppure soltanto account creati da poco",
      "Cambi ripetuti del luogo dell'incontro, o spinte verso posti isolati",
    ] },

    { type: "h2", text: "10. Usa le funzioni di sicurezza dell'app" },
    { type: "p", text: "Le app di incontri affidabili ti danno strumenti: blocco, segnalazione e un modo per raggiungere un moderatore in carne e ossa. Usali senza esitare appena qualcosa non ti torna: una segnalazione non ti costa nulla ed è l'unico modo perché qualcuno lo venga a sapere. Su Qulo, blocco e segnalazione si trovano nel menu a tre puntini di ogni profilo e di ogni chat, e ogni segnalazione arriva in un pannello di moderazione dove una persona la legge." },

    { type: "h2", text: "Le funzioni di sicurezza di Qulo" },
    { type: "p", text: "Qulo è costruita perché gli strumenti di sicurezza siano dove servono e perché ciò che diciamo su di essi sia vero. Ecco esattamente cosa fa l'app — niente di più:" },
    { type: "ul", items: [
      "**Archiviazione cifrata:** i dati del tuo account e i tuoi messaggi vengono conservati in forma cifrata",
      "**Verifica dell'email:** il tuo profilo diventa visibile agli altri solo dopo che hai confermato il tuo indirizzo email",
      "**Blocca e segnala:** in un passaggio, dal menu a tre puntini di ogni profilo e di ogni chat",
      "**Revisione umana:** ogni segnalazione finisce in un pannello di moderazione e viene letta da una persona",
      "**Match basato sulle domande:** su Qulo un match richiede impegno reale, il che rende i messaggi di massa e gli account spam molto meno convenienti",
    ] },

    { type: "quote", text: "Nessuna app può rendere privo di rischi l'incontro con uno sconosciuto. Quello che un'app può fare è darti gli strumenti e il tempo per decidere da solo — e su Qulo quella decisione comincia con una domanda." },

    { type: "h2", accent: "green", text: "Conclusione: incontra in sicurezza" },
    { type: "p", text: "Con l'approccio giusto, gli incontri online possono essere sicuri e davvero piacevoli. Tieni a mente queste dieci regole, fidati del tuo istinto e ridurrai gran parte del rischio a qualcosa di gestibile. Ricorda: la tua sicurezza viene prima del romanticismo, sempre. Conosci persone in sicurezza su Qulo, e trova il match attraverso le domande." },
  ],
  ja: [
    { type: "h2", text: "オンラインデートで安全対策が欠かせない理由" },
    { type: "p", text: "オンラインデートは、何百万もの人がパートナーと出会うきっかけになってきました。同時に、はっきり名前を挙げておくべきリスクもあります。偽のプロフィール、詐欺の試み、そして見知らぬ相手と会うことに伴う当たり前の不確かさです。その大半は、知識のある利用者なら十分に管理できます。このガイドでは、オンラインデートを安全かつ楽しいものに保つために知っておきたいことをまとめます。" },
    { type: "p", text: "人々はこの点について決して無防備ではありません。**SSRS** の調査「The Public and Online Dating 2026」（2026年1月実施、米国の成人**2,012**人が対象）では、マッチングアプリで出会った相手と実際に会うことは「おおむね安全だ」と答えた人が**57%**、「安全ではない」と答えた人が**43%**でした。男女差は大きく、女性の**55%**が安全ではないと答えたのに対し、男性は**30%**にとどまります。ロマンス詐欺は、いまもデートプラットフォーム上で人が狙われる代表的な手口のひとつです。とはいえ、適切な備えがあれば、オンラインデートは本当に安全な体験になり得ます。" },

    { type: "h2", accent: "green", text: "10の黄金ルール" },

    { type: "h2", text: "1. プロフィール写真は賢く選ぶ" },
    { type: "p", text: "プロフィール写真は自分を紹介すると同時に、身の安全も守るものであるべきです。自宅の場所、勤務先、日常的に通う場所が特定できる写真は避けましょう。車のナンバープレート、玄関の表札、名刺といった細部は、どの写真にも写り込ませないでください。すぐに場所が分かる背景よりも、特徴のない場所を選ぶのが安全です。" },

    { type: "h2", text: "2. 個人情報を守る" },
    { type: "p", text: "最初のやり取りでは、フルネーム、自宅の住所、勤務先の住所、金融関連の情報を伝えないでください。名字だけでも、SNSを通じてあなたについて非常に多くのことが分かってしまう入り口になり得ます。信頼が築けるまでは下の名前だけを使い、細かい個人的な話は直接会ったときに取っておきましょう。" },

    { type: "h2", text: "3. やり取りはアプリ内で" },
    { type: "p", text: "知り合って間もない段階で、個人の電話番号やSNSアカウントを渡すのは避けましょう。マッチングアプリには通常、チャット内に通報とブロックの機能が備わっており、問題のある振る舞いに対処し、必要なら関係を断つ助けになります。個人の連絡先を教えるのは、何度かビデオ通話をしたあと、あるいは実際に会ったあとにしてください。" },

    { type: "h2", text: "4. 初回は必ず人の多い公共の場所で" },
    { type: "p", text: "初めて会う場所は、常に人通りのある公共の場所にしましょう。カフェ、レストラン、商業施設などが適しています。相手の家に招かれても応じず、自宅にも招かないでください。自分ひとりで行ける場所を選ぶこと。初対面で相手の車に乗るのは適切ではありません。" },

    { type: "h2", text: "5. 信頼できる人に伝えておく" },
    { type: "p", text: "出かける前に、信頼できる友人か家族に詳細を伝えておきましょう。どこにいるか、何時か、相手の名前は何か。会っている間に一言二言メッセージを送るか、あらかじめ「安否確認」の時間を決めておくのも有効です。こうした用途のための機能を備えたアプリもあります。" },

    { type: "h2", text: "6. ビデオ通話で確認する" },
    { type: "p", text: "実際に会う前に、少なくとも一度はビデオ通話をしてください。相手がプロフィール写真と一致するかを確かめられます。ビデオ通話は偽のプロフィールを見抜く最も簡単な方法のひとつであり、だからこそ、繰り返し拒む相手は重大な警告サインです。" },

    { type: "h2", text: "7. アルコールや薬物に注意する" },
    { type: "p", text: "初対面ではアルコールを最小限にとどめるか、まったく飲まないようにしましょう。アルコールは判断力を鈍らせ、危険の兆候に気づきにくくします。飲み物は必ず自分で注文し、自分の目の前で用意してもらってください。グラスから目を離したまま席を立たないこと。" },

    { type: "h2", text: "8. 金銭のわなにはまらない" },
    { type: "p", text: "知り合って間もない段階でお金や金融情報を求めるのは、最も広く使われている詐欺の手口のひとつです。直接会ったことのない相手に送金してはいけません。銀行口座の情報も渡さず、金銭的な援助の申し出も受けないでください。「緊急事態」を装った金銭の要求は、関係がどの段階にあろうと立ち止まるべき合図です。" },

    { type: "h2", text: "9. 危険信号を見分ける" },
    { type: "p", text: "次のような振る舞いは深刻な警告サインであり、無理に良い方へ解釈すべきではありません。" },
    { type: "ul", items: [
      "数日のうちに愛を告白する（ラブボミング）",
      "ビデオ通話を一貫して拒む",
      "お金や金融情報を求めてくる",
      "常に居場所を尋ねるなど、支配的な振る舞い",
      "自分の過去について、話のつじつまが合わない",
      "SNSの痕跡がまったくない、または作られたばかりのアカウントしかない",
      "待ち合わせ場所を何度も変える、人けのない場所へ誘導しようとする",
    ] },

    { type: "h2", text: "10. アプリの安全機能を使う" },
    { type: "p", text: "信頼できるマッチングアプリは道具を用意しています。ブロック、通報、そして人間の運営に届く経路です。何か引っかかると感じたら、ためらわず使ってください。通報にコストはかからず、誰かがその事実を知る唯一の手段です。Qulo では、ブロックと通報はすべてのプロフィールとすべてのチャットの三点メニューにあり、通報は運営パネルに届いて、人が目を通します。" },

    { type: "h2", text: "Qulo の安全機能" },
    { type: "p", text: "Qulo は、安全のための機能が必要な場所にあること、そしてその機能について語る内容が事実であることを大切にして作られています。アプリがしているのは、以下がすべてです。" },
    { type: "ul", items: [
      "**暗号化された保管：** アカウント情報とメッセージは暗号化した状態で保存されます",
      "**メール認証：** メールアドレスを確認したあとにはじめて、プロフィールが他の利用者に表示されます",
      "**ブロックと通報：** すべてのプロフィールとすべてのチャットの三点メニューから、一手で実行できます",
      "**人による確認：** すべての通報は運営パネルに届き、人が目を通します",
      "**質問によるマッチング：** Qulo でのマッチングには実際の手間がかかるため、一斉送信や手抜きのスパムアカウントは割に合わなくなります",
    ] },

    { type: "quote", text: "見知らぬ相手と会うことをリスクゼロにできるアプリはありません。アプリにできるのは、自分で判断するための道具と時間を渡すことです。Qulo では、その判断はひとつの質問から始まります。" },

    { type: "h2", accent: "green", text: "まとめ：安全に出会う" },
    { type: "p", text: "正しい向き合い方をすれば、オンラインデートは安全で、本当に楽しい体験になります。この10のルールを覚えておき、自分の直感を信じてください。それだけでリスクの大半は扱える範囲に収まります。忘れないでください。安全は、いつだってロマンスより先に来ます。Qulo で安全に出会い、質問を通してマッチングしましょう。" },
  ],
  ko: [
    { type: "h2", text: "온라인 데이팅에서 안전이 중요한 이유" },
    { type: "p", text: "온라인 데이팅은 수백만 명이 인연을 만나는 데 도움을 주었습니다. 동시에 분명히 짚어야 할 위험도 함께 옵니다. 가짜 프로필, 사기 시도, 그리고 낯선 사람을 만난다는 데서 오는 자연스러운 불확실성입니다. 이 가운데 거의 대부분은 아는 사람이라면 충분히 관리할 수 있습니다. 이 가이드는 온라인 데이팅을 안전하면서도 즐겁게 이어가기 위해 알아야 할 것들을 정리합니다." },
    { type: "p", text: "사람들이 이 문제에 순진한 것은 아닙니다. **SSRS**의 조사 \"The Public and Online Dating 2026\"(2026년 1월 실시, 미국 성인 **2,012**명 대상)에서 데이팅 앱으로 매칭된 상대를 실제로 만나는 것이 대체로 안전하다고 답한 사람은 **57%**, 안전하지 않다고 답한 사람은 **43%**였습니다. 성별 차이는 뚜렷합니다. 여성의 **55%**가 안전하지 않다고 답한 반면 남성은 **30%**였습니다. 로맨스 스캠은 여전히 데이팅 플랫폼에서 사람들을 노리는 가장 흔한 방식 가운데 하나입니다. 다만 적절한 대비가 있다면 온라인 데이팅은 실제로 안전한 경험이 될 수 있습니다." },

    { type: "h2", accent: "green", text: "10가지 황금률" },

    { type: "h2", text: "1. 프로필 사진을 현명하게 고르세요" },
    { type: "p", text: "프로필 사진은 자신을 소개하는 동시에 개인의 안전도 지켜야 합니다. 집 주소, 직장, 자주 가는 장소가 드러나는 사진은 피하세요. 자동차 번호판, 현관 문패, 명함 같은 세부 정보는 어떤 사진에도 담기지 않아야 합니다. 한눈에 위치를 알 수 있는 장소보다는 특징 없는 배경을 고르는 편이 안전합니다." },

    { type: "h2", text: "2. 개인정보를 보호하세요" },
    { type: "p", text: "처음 나누는 대화에서는 이름 전체, 집 주소, 직장 주소, 금융 정보를 알려주지 마세요. 성(姓) 하나만으로도 소셜미디어를 통해 당신에 대한 아주 많은 정보가 열릴 수 있습니다. 신뢰가 쌓이기 전까지는 이름만 쓰고, 구체적인 개인 정보는 직접 만나 이야기할 때로 미뤄두세요." },

    { type: "h2", text: "3. 앱 안에서 대화하세요" },
    { type: "p", text: "알아가는 초반에 개인 전화번호나 소셜미디어 계정을 건네지 마세요. 데이팅 앱은 보통 대화창 안에 신고와 차단 기능을 제공하며, 이는 문제되는 행동에 대응하고 필요하면 관계를 끊는 데 도움이 됩니다. 개인 연락처는 여러 차례 영상 통화를 하거나 직접 만난 뒤에 공유하세요." },

    { type: "h2", text: "4. 첫 만남은 사람이 많은 공공장소에서" },
    { type: "p", text: "첫 만남은 언제나 사람이 오가는 공공장소여야 합니다. 카페, 식당, 쇼핑몰이 좋은 선택입니다. 상대의 집으로 오라는 초대를 받아들이지 말고, 집으로 부르지도 마세요. 혼자 힘으로 갈 수 있는 장소를 고르세요. 첫 만남에 상대의 차에 타는 것은 적절하지 않습니다." },

    { type: "h2", text: "5. 믿을 만한 사람에게 알려두세요" },
    { type: "p", text: "나가기 전에 믿을 수 있는 친구나 가족에게 세부 사항을 알려두세요. 어디에 있을지, 몇 시인지, 상대의 이름은 무엇인지. 만나는 동안 메시지를 한두 번 보내거나, 미리 \"안전 확인\" 시간을 정해두는 것도 좋습니다. 일부 앱은 바로 이런 용도의 기능을 갖추고 있습니다." },

    { type: "h2", text: "6. 영상 통화로 확인하세요" },
    { type: "p", text: "직접 만나기 전에 최소한 한 번은 영상 통화를 하세요. 상대가 프로필 사진과 일치하는지 확인할 수 있습니다. 영상 통화는 가짜 프로필을 드러내는 가장 간단한 방법 가운데 하나이며, 그래서 계속 거부하는 사람은 심각한 위험 신호입니다." },

    { type: "h2", text: "7. 술과 약물에 주의하세요" },
    { type: "p", text: "첫 만남에서는 술을 최소한으로 줄이거나 아예 마시지 마세요. 술은 판단력을 무디게 하고 잠재적인 위험을 알아차리기 어렵게 만듭니다. 마실 것은 언제나 직접 주문하고, 눈앞에서 만들어지는지 확인하세요. 잔을 자리에 두고 자리를 비우지 마세요." },

    { type: "h2", text: "8. 금전적 함정에 빠지지 마세요" },
    { type: "p", text: "아직 알아가는 단계에서 돈이나 금융 정보를 요구하는 것은 가장 흔한 사기 수법 가운데 하나입니다. 직접 만난 적 없는 사람에게 절대 송금하지 말고, 은행 정보를 알려주지 말고, 금전적 도움을 주겠다는 제안도 받아들이지 마세요. \"급한 일\"로 포장된 돈 요구는 관계의 어느 단계에서든 멈춰야 한다는 신호입니다." },

    { type: "h2", text: "9. 위험 신호를 알아채세요" },
    { type: "p", text: "다음과 같은 행동은 심각한 경고이며, 좋게 넘겨서는 안 됩니다." },
    { type: "ul", items: [
      "며칠 만에 사랑을 고백하는 행동(러브 바밍)",
      "영상 통화를 계속 거부하는 태도",
      "돈이나 금융 정보를 요구하는 행동",
      "지금 어디 있는지 계속 묻는 등 통제하려는 태도",
      "자신의 과거에 대해 앞뒤가 맞지 않는 이야기",
      "소셜미디어 흔적이 전혀 없거나 만든 지 얼마 안 된 계정뿐인 경우",
      "약속 장소를 반복해서 바꾸거나 외진 곳으로 유도하는 행동",
    ] },

    { type: "h2", text: "10. 앱의 안전 기능을 사용하세요" },
    { type: "p", text: "믿을 만한 데이팅 앱은 도구를 제공합니다. 차단, 신고, 그리고 사람에게 닿는 경로입니다. 무언가 이상하다고 느끼는 순간 망설이지 말고 쓰세요. 신고는 아무 비용도 들지 않으며, 누군가가 그 사실을 알게 되는 유일한 방법입니다. Qulo에서는 차단과 신고가 모든 프로필과 모든 대화의 점 세 개 메뉴에 있고, 모든 신고는 운영 패널로 들어가 사람이 직접 읽습니다." },

    { type: "h2", text: "Qulo의 안전 기능" },
    { type: "p", text: "Qulo는 안전을 위한 도구가 필요한 자리에 있도록, 그리고 그 도구에 대해 하는 말이 사실이도록 만들어졌습니다. 앱이 하는 일은 정확히 다음이 전부입니다." },
    { type: "ul", items: [
      "**암호화 저장:** 계정 데이터와 메시지는 암호화된 상태로 저장됩니다",
      "**이메일 인증:** 이메일 주소를 확인한 뒤에야 프로필이 다른 사람에게 보입니다",
      "**차단과 신고:** 모든 프로필과 모든 대화의 점 세 개 메뉴에서 한 번에 실행할 수 있습니다",
      "**사람의 검토:** 모든 신고는 운영 패널로 들어가 사람이 직접 읽습니다",
      "**질문 기반 매칭:** Qulo에서 매칭하려면 실제로 품이 들기 때문에, 대량 메시지와 성의 없는 스팸 계정은 훨씬 수지가 맞지 않게 됩니다",
    ] },

    { type: "quote", text: "낯선 사람을 만나는 일을 위험 없는 일로 만들 수 있는 앱은 없습니다. 앱이 할 수 있는 일은 스스로 판단할 도구와 시간을 주는 것입니다. Qulo에서 그 판단은 하나의 질문에서 시작됩니다." },

    { type: "h2", accent: "green", text: "결론: 안전하게 만나세요" },
    { type: "p", text: "올바른 방식으로 접근한다면 온라인 데이팅은 안전하고 정말로 즐거운 경험이 될 수 있습니다. 이 열 가지 규칙을 기억하고 자신의 직감을 믿으세요. 그것만으로도 위험의 대부분은 감당할 수 있는 수준으로 줄어듭니다. 기억하세요. 안전은 언제나 로맨스보다 앞섭니다. Qulo에서 안전하게 만나고, 질문으로 매칭하세요." },
  ],
  zh: [
    { type: "h2", text: "网络交友为什么必须重视安全？" },
    { type: "p", text: "网络交友让数百万人遇见了自己的伴侣，但它同样带来一些值得直说的风险：虚假资料、诈骗企图，以及与陌生人见面本身自带的不确定性。对一个心里有数的人来说，这些几乎都能被管理好。这份指南整理了你需要知道的事，好让网络交友既安全又愉快。" },
    { type: "p", text: "人们对此并不天真。在 **SSRS** 的调查《The Public and Online Dating 2026》中（2026年1月执行，访问美国成年人 **2,012** 位），**57%** 的人认为在交友软件上配对后与对方见面总体上是安全的，**43%** 认为并不安全。性别差异相当明显：**55%** 的女性认为不安全，男性则为 **30%**。感情诈骗仍然是交友平台上针对用户最常见的手法之一——但只要做好该做的准备，网络交友确实可以是一段安全的体验。" },

    { type: "h2", accent: "green", text: "十条黄金法则" },

    { type: "h2", text: "1. 聪明地挑选头像和照片" },
    { type: "p", text: "个人资料照片既要展示你，也要保护你的人身安全。避免使用会暴露住址、工作地点或你经常出入场所的照片。车牌、家门口的名牌、名片这类细节，不应该出现在任何一张照片里。比起一眼就能认出的地标，中性的背景更稳妥。" },

    { type: "h2", text: "2. 保护个人信息" },
    { type: "p", text: "最初几轮聊天里，不要透露全名、住址、工作地址或任何财务信息。仅凭一个姓氏，就可能通过社交媒体挖出关于你的大量内容。在信任建立起来之前只用名字称呼自己，把具体的个人信息留到面对面时再说。" },

    { type: "h2", text: "3. 优先在应用内聊天" },
    { type: "p", text: "在刚开始了解对方的阶段，先别急着交出私人电话号码或社交账号。交友软件通常在聊天界面内就提供举报和拉黑功能，帮助你应对不当行为，必要时干脆断开联系。私人联系方式，等到几次视频通话之后或线下见过面再给。" },

    { type: "h2", text: "4. 第一次见面选在公共场所" },
    { type: "p", text: "第一次见面永远应该安排在人多的公共场所。咖啡馆、餐厅和商场都是不错的选择。不要接受去对方家里的邀请，也不要请对方来你家。选一个你能自己抵达的地方——第一次见面就坐进对方的车里并不合适。" },

    { type: "h2", text: "5. 告诉一位信得过的人" },
    { type: "p", text: "出门前，把细节告诉一位信得过的朋友或家人：你会在哪里、几点、对方叫什么。见面过程中发一两条消息，或者事先约好一个「安全报平安」的时间。有些应用就为此内置了相应功能。" },

    { type: "h2", text: "6. 用视频通话核实" },
    { type: "p", text: "线下见面前，至少进行一次视频通话。这能让你确认对方与资料照片是否一致。视频通话是揭穿虚假资料最简单的方式之一，正因如此，一再拒绝视频的人是一个严重的警示信号。" },

    { type: "h2", text: "7. 谨慎对待酒精和其他物质" },
    { type: "p", text: "第一次见面把酒量压到最低，或者干脆不喝。酒精会削弱你的判断力，让你更难察觉潜在风险。饮料永远自己点，并确认它是在你视线范围内调制的。绝不要让自己的杯子离开视线。" },

    { type: "h2", text: "8. 别掉进金钱陷阱" },
    { type: "p", text: "在你们才刚开始认识时就开口要钱或索取财务信息，是最常见的诈骗套路之一。绝不要给素未谋面的人转账，不要提供银行信息，也不要接受对方提供的经济援助。以「紧急情况」包装的要钱请求，无论关系走到哪一步，都是一个停止信号。" },

    { type: "h2", text: "9. 识别危险信号" },
    { type: "p", text: "有些行为是严肃的警告，不该被替对方找借口带过：" },
    { type: "ul", items: [
      "认识几天就表白爱意（爱情轰炸）",
      "始终拒绝视频通话",
      "开口索要金钱或财务信息",
      "控制欲强的行为，比如不停追问你在哪里",
      "关于自己过去的说法前后矛盾",
      "完全没有社交媒体痕迹，或者只有刚注册的账号",
      "反复更改见面地点，或者把你往偏僻的地方带",
    ] },

    { type: "h2", text: "10. 使用应用的安全功能" },
    { type: "p", text: "值得信赖的交友软件会给你工具：拉黑、举报，以及联系到真人审核的途径。一旦感觉不对劲，就毫不犹豫地使用——举报对你没有任何成本，而且这是让别人知情的唯一方式。在 Qulo，拉黑和举报就在每个资料页与每个聊天的三点菜单里，每一条举报都会进入审核面板，由真人阅读。" },

    { type: "h2", text: "Qulo 的安全功能" },
    { type: "p", text: "Qulo 的设计目标是：安全工具就在你需要它的地方，而我们对这些工具的说法都属实。应用所做的正是以下这些，没有更多：" },
    { type: "ul", items: [
      "**加密存储：** 你的账号数据和消息以加密形式保存",
      "**邮箱验证：** 只有在你确认电子邮箱地址之后，你的资料才会对其他人可见",
      "**拉黑与举报：** 在任意资料页和任意聊天的三点菜单里一步完成",
      "**真人审核：** 每一条举报都会进入审核面板，由真人阅读",
      "**基于问题的配对：** 在 Qulo 配对需要实打实的投入，这让群发消息和敷衍的垃圾账号变得非常不划算",
    ] },

    { type: "quote", text: "没有任何一款应用能让与陌生人见面变成零风险。应用能做的，是把工具和时间交到你手里，让你自己判断——在 Qulo，这个判断从一个问题开始。" },

    { type: "h2", accent: "green", text: "结语：安全地相遇" },
    { type: "p", text: "只要方式得当，网络交友可以既安全又真正令人愉快。记住这十条法则，相信自己的直觉，你就能把大部分风险压到可控范围内。请记得：安全永远排在浪漫前面。在 Qulo 安全地相遇，用问题去配对。" },
  ],
  nl: [
    { type: "h2", text: "Waarom is veiligheid bij online daten belangrijk?" },
    { type: "p", text: "Online daten heeft miljoenen mensen geholpen hun partner te vinden. Het brengt ook risico's mee die je maar beter gewoon benoemt: nepprofielen, oplichtingspogingen en de gewone onzekerheid van een afspraak met een onbekende. Bijna alles daarvan is beheersbaar als je weet waar je op moet letten. Deze gids behandelt wat je moet weten om online daten veilig én prettig te houden." },
    { type: "p", text: "Mensen zijn hier bepaald niet naïef in. In het onderzoek \"The Public and Online Dating 2026\" van **SSRS**, in januari 2026 uitgevoerd onder **2.012** volwassenen in de Verenigde Staten, zei **57%** dat iemand in het echt ontmoeten na een match op een datingapp over het algemeen veilig is, terwijl **43%** vindt van niet. Het verschil tussen mannen en vrouwen is groot: **55%** van de vrouwen noemt het onveilig, tegenover **30%** van de mannen. Datingfraude blijft een van de meest voorkomende manieren waarop mensen op datingplatforms worden aangepakt — maar met de juiste voorzorgsmaatregelen kan online daten echt veilig zijn." },

    { type: "h2", accent: "green", text: "10 gouden regels" },

    { type: "h2", text: "1. Kies je profielfoto's verstandig" },
    { type: "p", text: "Je profielfoto's moeten je laten zien én je persoonlijke veiligheid beschermen. Vermijd foto's waaruit je woonadres, je werkplek of de plekken waar je regelmatig komt af te leiden zijn. Details als je kenteken, een naambordje bij de voordeur of een visitekaartje horen op geen enkele foto thuis. Kies liever neutrale omgevingen dan direct herkenbare plekken." },

    { type: "h2", text: "2. Bescherm je persoonlijke gegevens" },
    { type: "p", text: "Deel in de eerste gesprekken niet je volledige naam, je woon- of werkadres of financiële gegevens. Alleen al je achternaam kan via sociale media de deur openzetten naar heel veel informatie over jou. Gebruik alleen je voornaam tot er vertrouwen is, en bewaar persoonlijke details voor een gesprek van mens tot mens." },

    { type: "h2", text: "3. Blijf voorlopig in de chat van de app" },
    { type: "p", text: "Geef je privételefoonnummer of je socialemedia-accounts niet meteen aan het begin van het kennismaken. Datingapps bieden meestal meld- en blokkeerfuncties in het gesprek zelf; die helpen je omgaan met vervelend gedrag en het contact te verbreken als dat nodig is. Deel persoonlijke contactgegevens pas na een paar videogesprekken of na een ontmoeting in het echt." },

    { type: "h2", text: "4. Spreek de eerste keer af op een openbare plek" },
    { type: "p", text: "Je eerste date hoort altijd op een openbare, drukke plek plaats te vinden. Cafés, restaurants en winkelcentra zijn goede keuzes. Ga niet in op een uitnodiging bij de ander thuis en nodig hem of haar ook niet bij jou uit. Kies een plek waar je zelf naartoe kunt — bij een eerste ontmoeting bij iemand in de auto stappen is geen goed idee." },

    { type: "h2", text: "5. Licht iemand in die je vertrouwt" },
    { type: "p", text: "Vertel voor je vertrekt de details aan een vriend of familielid dat je vertrouwt: waar je bent, hoe laat, en hoe de ander heet. Stuur tijdens de date een berichtje of twee, of spreek van tevoren een vast \"veiligheidscheck\"-moment af. Sommige apps hebben daar ingebouwde functies voor." },

    { type: "h2", text: "6. Verifieer met een videogesprek" },
    { type: "p", text: "Voer minstens één videogesprek voordat je iemand in het echt ontmoet. Zo kun je vaststellen of de persoon overeenkomt met de profielfoto's. Een videogesprek is een van de eenvoudigste manieren om een nepprofiel te ontmaskeren, en juist daarom is iemand die het steeds weigert een serieus alarmsignaal." },

    { type: "h2", text: "7. Wees voorzichtig met alcohol en middelen" },
    { type: "p", text: "Houd alcohol bij een eerste date tot een minimum beperkt, of sla het helemaal over. Alcohol vertroebelt je oordeel en maakt het lastiger om risico's op te merken. Bestel je drankjes altijd zelf en zorg dat ze in je zicht worden bereid. Laat je glas nooit onbeheerd achter." },

    { type: "h2", text: "8. Trap niet in financiële vallen" },
    { type: "p", text: "Om geld of financiële gegevens vragen terwijl jullie elkaar nog maar net leren kennen, is een van de meest voorkomende oplichtingspatronen die er zijn. Stuur nooit geld naar iemand die je niet in het echt hebt ontmoet, deel geen bankgegevens en ga niet in op aanbiedingen van financiële hulp. Een geldverzoek verpakt als \"noodgeval\" is een stopteken, in welke fase van een relatie dan ook." },

    { type: "h2", text: "9. Herken alarmsignalen" },
    { type: "p", text: "Sommige gedragingen zijn serieuze waarschuwingen en horen niet weggeredeneerd te worden:" },
    { type: "ul", items: [
      "Binnen een paar dagen zijn liefde verklaren (love bombing)",
      "Consequent videogesprekken weigeren",
      "Om geld of financiële gegevens vragen",
      "Controlerend gedrag, zoals steeds vragen waar je bent",
      "Tegenstrijdige verhalen over het eigen verleden",
      "Geen enkel spoor op sociale media, of uitsluitend gloednieuwe accounts",
      "Steeds de afspraakplek wijzigen of aansturen op afgelegen plekken",
    ] },

    { type: "h2", text: "10. Gebruik de veiligheidsfuncties van de app" },
    { type: "p", text: "Betrouwbare datingapps geven je gereedschap: blokkeren, melden en een route naar een menselijke moderator. Gebruik het zonder aarzelen zodra iets niet klopt — een melding kost jou niets en is de enige manier waarop iemand het te weten komt. Bij Qulo staan blokkeren en melden in het menu met drie puntjes op elk profiel en in elke chat, en elke melding komt terecht in een moderatiepaneel waar een mens hem leest." },

    { type: "h2", text: "De veiligheidsfuncties van Qulo" },
    { type: "p", text: "Qulo is zo gebouwd dat de veiligheidsfuncties zijn waar je ze nodig hebt, en dat klopt wat we erover zeggen. Dit is precies wat de app doet — niet meer:" },
    { type: "ul", items: [
      "**Versleutelde opslag:** je accountgegevens en berichten worden versleuteld bewaard",
      "**E-mailverificatie:** je profiel wordt pas zichtbaar voor anderen nadat je je e-mailadres hebt bevestigd",
      "**Blokkeren en melden:** in één stap, via het menu met drie puntjes op elk profiel en in elke chat",
      "**Menselijke beoordeling:** elke melding komt in een moderatiepaneel en wordt door een persoon gelezen",
      "**Matchen via vragen:** matchen op Qulo kost echte moeite, waardoor massaberichten en spamaccounts een stuk minder lonend worden",
    ] },

    { type: "quote", text: "Geen enkele app kan het ontmoeten van een onbekende risicoloos maken. Wat een app wél kan, is je het gereedschap en de tijd geven om zelf te beslissen — en op Qulo begint die beslissing met een vraag." },

    { type: "h2", accent: "green", text: "Conclusie: date veilig" },
    { type: "p", text: "Met de juiste aanpak kan online daten veilig en echt leuk zijn. Houd deze tien regels in gedachten, vertrouw op je gevoel, en je brengt het grootste deel van het risico terug tot iets hanteerbaars. Onthoud: je veiligheid gaat altijd voor romantiek. Ontmoet veilig op Qulo, en match via vragen." },
  ],
  pl: [
    { type: "h2", text: "Dlaczego bezpieczeństwo w randkach online jest ważne?" },
    { type: "p", text: "Randki online pomogły milionom ludzi znaleźć partnera. Niosą też ryzyka, które warto nazwać wprost: fałszywe profile, próby oszustwa i zwykłą niepewność związaną ze spotkaniem z nieznajomym. Niemal wszystkim da się zarządzić, jeśli wie się, na co uważać. Ten przewodnik zbiera to, co trzeba wiedzieć, żeby randkowanie online pozostało bezpieczne i przyjemne." },
    { type: "p", text: "Ludzie wcale nie są w tej sprawie naiwni. W badaniu \"The Public and Online Dating 2026\" firmy **SSRS**, przeprowadzonym w styczniu 2026 roku na próbie **2012** dorosłych mieszkańców USA, **57%** uznało, że spotkanie na żywo z osobą poznaną przez aplikację randkową jest ogólnie bezpieczne, a **43%** — że nie jest. Różnica między płciami jest wyraźna: **55%** kobiet uważa takie spotkanie za niebezpieczne, wobec **30%** mężczyzn. Oszustwa matrymonialne pozostają jednym z najczęstszych sposobów atakowania ludzi na platformach randkowych — ale przy odpowiednich środkach ostrożności randki online mogą być naprawdę bezpiecznym doświadczeniem." },

    { type: "h2", accent: "green", text: "10 złotych zasad" },

    { type: "h2", text: "1. Mądrze dobieraj zdjęcia profilowe" },
    { type: "p", text: "Zdjęcia profilowe mają cię przedstawiać, a jednocześnie chronić twoje bezpieczeństwo. Unikaj kadrów, z których da się odczytać twój adres, miejsce pracy albo miejsca, w których bywasz regularnie. Szczegóły takie jak tablica rejestracyjna, tabliczka z nazwiskiem na drzwiach czy wizytówka nie powinny pojawić się na żadnym zdjęciu. Neutralne tło jest lepsze niż natychmiast rozpoznawalne miejsce." },

    { type: "h2", text: "2. Chroń swoje dane osobowe" },
    { type: "p", text: "W pierwszych rozmowach nie podawaj pełnego imienia i nazwiska, adresu domowego ani służbowego, ani żadnych informacji finansowych. Samo nazwisko potrafi otworzyć drogę do bardzo wielu informacji o tobie przez media społecznościowe. Do czasu zbudowania zaufania używaj tylko imienia, a szczegóły osobiste zostaw na rozmowę twarzą w twarz." },

    { type: "h2", text: "3. Rozmawiaj w aplikacji" },
    { type: "p", text: "Nie oddawaj prywatnego numeru telefonu ani kont w mediach społecznościowych na samym początku poznawania się. Aplikacje randkowe zwykle udostępniają narzędzia zgłaszania i blokowania w samej rozmowie; pomagają one poradzić sobie z niepokojącym zachowaniem i w razie potrzeby uciąć kontakt. Prywatne dane kontaktowe podawaj dopiero po kilku rozmowach wideo albo po spotkaniu na żywo." },

    { type: "h2", text: "4. Pierwsza randka tylko w miejscu publicznym" },
    { type: "p", text: "Pierwsza randka powinna zawsze odbyć się w publicznym, ruchliwym miejscu. Kawiarnie, restauracje i galerie handlowe to dobre wybory. Nie przyjmuj zaproszenia do mieszkania drugiej osoby i sam nie zapraszaj jej do siebie. Wybierz miejsce, do którego dotrzesz o własnych siłach — wsiadanie do cudzego samochodu przy pierwszym spotkaniu nie jest dobrym pomysłem." },

    { type: "h2", text: "5. Poinformuj kogoś zaufanego" },
    { type: "p", text: "Zanim wyjdziesz, przekaż szczegóły zaufanemu znajomemu albo komuś z rodziny: gdzie będziesz, o której godzinie i jak nazywa się druga osoba. W trakcie randki wyślij jedną czy dwie wiadomości albo umówcie się wcześniej na godzinę \"kontrolnego sprawdzenia\". Niektóre aplikacje mają wbudowane funkcje właśnie do tego." },

    { type: "h2", text: "6. Zweryfikuj przez rozmowę wideo" },
    { type: "p", text: "Zanim spotkasz się na żywo, odbądź przynajmniej jedną rozmowę wideo. Pozwala to potwierdzić, że osoba zgadza się ze swoimi zdjęciami profilowymi. Rozmowa wideo to jeden z najprostszych sposobów zdemaskowania fałszywego profilu — i właśnie dlatego ktoś, kto uporczywie jej odmawia, jest poważnym sygnałem ostrzegawczym." },

    { type: "h2", text: "7. Uważaj na alkohol i inne substancje" },
    { type: "p", text: "Na pierwszej randce ogranicz alkohol do minimum albo zrezygnuj z niego całkowicie. Alkohol osłabia zdolność oceny sytuacji i utrudnia dostrzeżenie zagrożeń. Napoje zawsze zamawiaj sam i dopilnuj, żeby były przygotowywane w twoim polu widzenia. Nigdy nie zostawiaj swojego drinka bez opieki." },

    { type: "h2", text: "8. Nie daj się złapać w pułapki finansowe" },
    { type: "p", text: "Prośba o pieniądze albo dane finansowe, gdy dopiero się poznajecie, to jeden z najpowszechniejszych schematów oszustwa w ogóle. Nigdy nie wysyłaj pieniędzy komuś, kogo nie spotkałeś osobiście, nie udostępniaj danych bankowych i nie przyjmuj ofert pomocy finansowej. Prośba o pieniądze opakowana w \"nagły wypadek\" to znak stopu na każdym etapie relacji." },

    { type: "h2", text: "9. Rozpoznawaj sygnały ostrzegawcze" },
    { type: "p", text: "Niektóre zachowania są poważnym ostrzeżeniem i nie należy ich tłumaczyć:" },
    { type: "ul", items: [
      "Wyznania miłosne po kilku dniach (love bombing)",
      "Konsekwentne odmawianie rozmów wideo",
      "Prośby o pieniądze lub dane finansowe",
      "Zachowania kontrolujące, na przykład ciągłe pytanie, gdzie jesteś",
      "Niespójne opowieści o własnej przeszłości",
      "Całkowity brak śladów w mediach społecznościowych albo wyłącznie świeżo założone konta",
      "Wielokrotne zmienianie miejsca spotkania lub kierowanie cię w ustronne miejsca",
    ] },

    { type: "h2", text: "10. Korzystaj z funkcji bezpieczeństwa aplikacji" },
    { type: "p", text: "Godne zaufania aplikacje randkowe dają ci narzędzia: blokowanie, zgłaszanie i drogę do żywego moderatora. Używaj ich bez wahania, gdy tylko coś wyda ci się nie tak — zgłoszenie nic cię nie kosztuje, a jest jedynym sposobem, żeby ktokolwiek się o tym dowiedział. W Qulo blokowanie i zgłaszanie znajdują się w menu z trzema kropkami przy każdym profilu i w każdej rozmowie, a każde zgłoszenie trafia do panelu moderacji, gdzie czyta je człowiek." },

    { type: "h2", text: "Funkcje bezpieczeństwa Qulo" },
    { type: "p", text: "Qulo jest zbudowane tak, żeby narzędzia bezpieczeństwa były tam, gdzie ich potrzebujesz, i żeby to, co o nich mówimy, było prawdą. Oto dokładnie to, co robi aplikacja — nic ponad to:" },
    { type: "ul", items: [
      "**Szyfrowane przechowywanie:** dane twojego konta i wiadomości są przechowywane w postaci zaszyfrowanej",
      "**Weryfikacja e-maila:** twój profil staje się widoczny dla innych dopiero po potwierdzeniu adresu e-mail",
      "**Blokowanie i zgłaszanie:** w jednym kroku, z menu z trzema kropkami przy każdym profilu i w każdej rozmowie",
      "**Weryfikacja przez człowieka:** każde zgłoszenie trafia do panelu moderacji i jest czytane przez osobę",
      "**Dopasowanie oparte na pytaniach:** dopasowanie w Qulo wymaga realnego wysiłku, przez co masowe wiadomości i konta spamowe stają się dużo mniej opłacalne",
    ] },

    { type: "quote", text: "Żadna aplikacja nie sprawi, że spotkanie z nieznajomym będzie pozbawione ryzyka. To, co aplikacja może zrobić, to dać ci narzędzia i czas, żebyś zdecydował sam — a w Qulo ta decyzja zaczyna się od pytania." },

    { type: "h2", accent: "green", text: "Podsumowanie: randkuj bezpiecznie" },
    { type: "p", text: "Przy właściwym podejściu randki online mogą być bezpieczne i naprawdę przyjemne. Pamiętaj o tych dziesięciu zasadach, zaufaj intuicji, a większość ryzyka sprowadzisz do poziomu, którym da się zarządzić. Pamiętaj: twoje bezpieczeństwo za każdym razem wyprzedza romantyzm. Poznawaj ludzi bezpiecznie w Qulo i dopasowuj się przez pytania." },
  ],
  sv: [
    { type: "h2", text: "Varför är säkerhet viktigt vid nätdejting?" },
    { type: "p", text: "Nätdejting har hjälpt miljontals människor att hitta sin partner. Den för också med sig risker som är värda att sätta ord på: falska profiler, bedrägeriförsök och den vanliga osäkerheten i att träffa någon man inte känner. Nästan allt går att hantera om man vet vad man ska hålla utkik efter. Den här guiden går igenom vad du behöver veta för att nätdejtandet ska förbli både tryggt och trevligt." },
    { type: "p", text: "Folk är knappast naiva i frågan. I **SSRS**:s undersökning \"The Public and Online Dating 2026\", genomförd i januari 2026 bland **2 012** vuxna i USA, svarade **57%** att det generellt är säkert att träffa någon i verkligheten efter en matchning i en dejtingapp, medan **43%** svarade att det inte är det. Skillnaden mellan könen är stor: **55%** av kvinnorna tycker att det är osäkert, mot **30%** av männen. Kärleksbedrägerier är fortfarande ett av de vanligaste sätten att rikta in sig på människor på dejtingplattformar — men med rätt försiktighetsåtgärder kan nätdejting vara en genuint trygg upplevelse." },

    { type: "h2", accent: "green", text: "10 gyllene regler" },

    { type: "h2", text: "1. Välj dina profilbilder klokt" },
    { type: "p", text: "Dina profilbilder ska presentera dig och samtidigt skydda din personliga säkerhet. Undvik bilder som avslöjar din hemadress, din arbetsplats eller platser du besöker regelbundet. Detaljer som bilens registreringsskylt, namnskylten vid dörren eller ett visitkort hör inte hemma på någon bild. Välj hellre neutrala miljöer än platser som känns igen direkt." },

    { type: "h2", text: "2. Skydda dina personuppgifter" },
    { type: "p", text: "Dela inte ditt fullständiga namn, din hemadress, din arbetsadress eller några ekonomiska uppgifter i de första samtalen. Redan ditt efternamn kan öppna dörren till väldigt mycket om dig via sociala medier. Använd bara ditt förnamn tills förtroende har byggts upp, och spara personliga detaljer till ett samtal ansikte mot ansikte." },

    { type: "h2", text: "3. Håll dig till appens chatt" },
    { type: "p", text: "Undvik att lämna ut ditt privata telefonnummer eller dina konton på sociala medier tidigt i bekantskapen. Dejtingappar erbjuder i regel verktyg för att anmäla och blockera direkt i konversationen, vilket hjälper dig att hantera problematiskt beteende och bryta kontakten om det behövs. Dela personliga kontaktuppgifter först efter flera videosamtal eller en träff i verkligheten." },

    { type: "h2", text: "4. Välj offentliga platser för första dejten" },
    { type: "p", text: "Din första dejt bör alltid ske på en offentlig och välbesökt plats. Kaféer, restauranger och gallerior är bra val. Tacka nej till inbjudningar hem till den andra personen och bjud inte hem hen till dig. Välj en plats du kan ta dig till på egen hand — att sätta sig i någon annans bil vid en första träff är ingen bra idé." },

    { type: "h2", text: "5. Berätta för någon du litar på" },
    { type: "p", text: "Innan du går, berätta detaljerna för en vän eller familjemedlem du litar på: var du kommer att vara, vilken tid och vad den andra personen heter. Skicka ett par meddelanden under dejten, eller kom överens om en tid för en \"säkerhetsavstämning\" i förväg. Vissa appar har inbyggda funktioner för just detta." },

    { type: "h2", text: "6. Bekräfta med ett videosamtal" },
    { type: "p", text: "Ha minst ett videosamtal innan ni ses i verkligheten. Då kan du bekräfta att personen stämmer med sina profilbilder. Ett videosamtal är ett av de enklaste sätten att avslöja en falsk profil, och det är just därför någon som envist vägrar är en allvarlig varningssignal." },

    { type: "h2", text: "7. Var försiktig med alkohol och droger" },
    { type: "p", text: "Håll alkoholen på ett minimum vid en första dejt, eller hoppa över den helt. Alkohol slöar ditt omdöme och gör det svårare att märka risker. Beställ alltid din egen dryck och se till att den bereds inom synhåll. Lämna aldrig ditt glas utan uppsikt." },

    { type: "h2", text: "8. Gå inte i de ekonomiska fällorna" },
    { type: "p", text: "Att be om pengar eller ekonomiska uppgifter medan ni fortfarande håller på att lära känna varandra är ett av de mest utbredda bedrägerimönster som finns. Skicka aldrig pengar till någon du inte har träffat i verkligheten, dela aldrig bankuppgifter och tacka nej till erbjudanden om ekonomisk hjälp. En förfrågan om pengar förklädd till en \"nödsituation\" är en stoppskylt, oavsett var i relationen ni befinner er." },

    { type: "h2", text: "9. Känn igen varningssignalerna" },
    { type: "p", text: "Vissa beteenden är allvarliga varningar och ska inte bortförklaras:" },
    { type: "ul", items: [
      "Kärleksförklaringar redan efter några dagar (love bombing)",
      "Att konsekvent vägra videosamtal",
      "Att be om pengar eller ekonomiska uppgifter",
      "Kontrollerande beteende, som att ständigt fråga var du är",
      "Motsägelsefulla berättelser om det egna förflutna",
      "Ingen närvaro alls på sociala medier, eller enbart alldeles nya konton",
      "Att gång på gång byta mötesplats, eller styra dig mot avskilda platser",
    ] },

    { type: "h2", text: "10. Använd appens säkerhetsfunktioner" },
    { type: "p", text: "Pålitliga dejtingappar ger dig verktyg: blockera, anmäla och en väg fram till en mänsklig moderator. Använd dem utan att tveka så fort något känns fel — en anmälan kostar dig ingenting, och det är det enda sättet för någon att få reda på det. I Qulo ligger blockera och anmäl i trepunktsmenyn på varje profil och i varje chatt, och varje anmälan hamnar i en modereringspanel där en människa läser den." },

    { type: "h2", text: "Qulos säkerhetsfunktioner" },
    { type: "p", text: "Qulo är byggt så att säkerhetsverktygen finns där du behöver dem, och så att det vi säger om dem är sant. Det här är precis vad appen gör — inte mer:" },
    { type: "ul", items: [
      "**Krypterad lagring:** dina kontouppgifter och meddelanden lagras krypterade",
      "**E-postverifiering:** din profil blir synlig för andra först när du har bekräftat din e-postadress",
      "**Blockera och anmäla:** i ett steg, från trepunktsmenyn på varje profil och i varje chatt",
      "**Mänsklig granskning:** varje anmälan hamnar i en modereringspanel och läses av en människa",
      "**Matchning genom frågor:** att matcha på Qulo kräver verklig ansträngning, vilket gör massutskick och slarviga spamkonton betydligt mindre lönsamma",
    ] },

    { type: "quote", text: "Ingen app kan göra ett möte med en främling riskfritt. Det en app kan göra är att ge dig verktygen och tiden att avgöra själv — och på Qulo börjar det avgörandet med en fråga." },

    { type: "h2", accent: "green", text: "Slutsats: dejta tryggt" },
    { type: "p", text: "Med rätt inställning kan nätdejting vara tryggt och verkligt trevligt. Håll de här tio reglerna i minnet, lita på din magkänsla, så får du ner det mesta av risken till något hanterbart. Kom ihåg: din säkerhet går före romantiken, varje gång. Träffas tryggt på Qulo, och matcha genom frågor." },
  ],
  hi: [
    { type: "h2", text: "ऑनलाइन डेटिंग में सुरक्षा क्यों ज़रूरी है?" },
    { type: "p", text: "ऑनलाइन डेटिंग ने लाखों लोगों को अपना साथी ढूँढ़ने में मदद की है। इसके साथ कुछ जोखिम भी आते हैं, जिन्हें साफ़-साफ़ नाम देना बेहतर है: नकली प्रोफ़ाइल, ठगी की कोशिशें, और किसी अजनबी से मिलने में रहने वाली आम अनिश्चितता। इनमें से लगभग सब कुछ एक जानकार उपयोगकर्ता सँभाल सकता है। यह गाइड वही बताती है जो आपके ऑनलाइन डेटिंग अनुभव को सुरक्षित और सुखद बनाए रखने के लिए ज़रूरी है।" },
    { type: "p", text: "लोग इस मामले में भोले नहीं हैं। **SSRS** के सर्वेक्षण \"The Public and Online Dating 2026\" में — जनवरी 2026 में अमेरिका के **2,012** वयस्कों के बीच किया गया — **57%** ने कहा कि किसी डेटिंग ऐप पर मैच होने के बाद उस व्यक्ति से आमने-सामने मिलना आम तौर पर सुरक्षित है, जबकि **43%** ने कहा कि नहीं। लिंग के हिसाब से फ़र्क़ बड़ा है: **55%** महिलाओं ने इसे असुरक्षित बताया, जबकि पुरुषों में यह आँकड़ा **30%** रहा। रोमांस स्कैम आज भी डेटिंग प्लेटफ़ॉर्म पर लोगों को निशाना बनाने के सबसे आम तरीक़ों में से एक है — लेकिन सही एहतियात के साथ ऑनलाइन डेटिंग सचमुच सुरक्षित अनुभव हो सकती है।" },

    { type: "h2", accent: "green", text: "10 सुनहरे नियम" },

    { type: "h2", text: "1. प्रोफ़ाइल तस्वीरें समझदारी से चुनें" },
    { type: "p", text: "आपकी प्रोफ़ाइल तस्वीरें आपका परिचय दें, साथ ही आपकी निजी सुरक्षा की भी हिफ़ाज़त करें। ऐसी तस्वीरों से बचें जिनसे आपका घर का पता, दफ़्तर या वे जगहें ज़ाहिर हों जहाँ आप नियमित रूप से जाते हैं। गाड़ी की नंबर प्लेट, दरवाज़े पर लगी नेमप्लेट या विज़िटिंग कार्ड जैसी चीज़ें किसी भी तस्वीर में नहीं दिखनी चाहिए। तुरंत पहचान में आने वाली जगहों के बजाय तटस्थ पृष्ठभूमि चुनें।" },

    { type: "h2", text: "2. अपनी निजी जानकारी बचाकर रखें" },
    { type: "p", text: "शुरुआती बातचीत में अपना पूरा नाम, घर का पता, दफ़्तर का पता या कोई भी वित्तीय जानकारी साझा न करें। सिर्फ़ आपके उपनाम से ही सोशल मीडिया के ज़रिए आपके बारे में बहुत कुछ निकाला जा सकता है। भरोसा बनने तक सिर्फ़ अपना पहला नाम इस्तेमाल करें, और निजी ब्योरे आमने-सामने की बातचीत के लिए बचाकर रखें।" },

    { type: "h2", text: "3. बातचीत ऐप के भीतर ही रखें" },
    { type: "p", text: "एक-दूसरे को जानने की शुरुआत में ही अपना निजी फ़ोन नंबर या सोशल मीडिया अकाउंट देने से बचें। डेटिंग ऐप्स आम तौर पर चैट के भीतर ही रिपोर्ट और ब्लॉक करने के साधन देते हैं, जो परेशान करने वाले व्यवहार से निपटने और ज़रूरत पड़ने पर संपर्क तोड़ने में मदद करते हैं। निजी संपर्क जानकारी कई वीडियो कॉल या आमने-सामने की मुलाक़ात के बाद ही साझा करें।" },

    { type: "h2", text: "4. पहली मुलाक़ात सार्वजनिक जगह पर रखें" },
    { type: "p", text: "आपकी पहली मुलाक़ात हमेशा किसी सार्वजनिक और भीड़-भाड़ वाली जगह पर होनी चाहिए। कैफ़े, रेस्तराँ और शॉपिंग सेंटर अच्छे विकल्प हैं। सामने वाले के घर आने का न्योता स्वीकार न करें और उन्हें अपने घर भी न बुलाएँ। ऐसी जगह चुनें जहाँ आप ख़ुद पहुँच सकें — पहली मुलाक़ात में किसी और की गाड़ी में बैठना ठीक नहीं है।" },

    { type: "h2", text: "5. किसी भरोसेमंद व्यक्ति को बता दें" },
    { type: "p", text: "निकलने से पहले किसी भरोसेमंद दोस्त या परिवार के सदस्य को ब्योरा बता दें: आप कहाँ होंगे, कितने बजे, और सामने वाले का नाम क्या है। मुलाक़ात के दौरान एक-दो संदेश भेजें, या पहले से ही \"सुरक्षा जाँच\" का समय तय कर लें। कुछ ऐप्स में ठीक इसी काम के लिए अलग सुविधाएँ होती हैं।" },

    { type: "h2", text: "6. वीडियो कॉल से पुष्टि करें" },
    { type: "p", text: "आमने-सामने मिलने से पहले कम से कम एक वीडियो कॉल ज़रूर करें। इससे आप पुष्टि कर पाते हैं कि सामने वाला व्यक्ति अपनी प्रोफ़ाइल तस्वीरों से मेल खाता है। नकली प्रोफ़ाइल को पकड़ने के सबसे आसान तरीक़ों में से एक वीडियो कॉल ही है — इसीलिए जो लगातार इससे बचता रहे, वह एक गंभीर चेतावनी है।" },

    { type: "h2", text: "7. शराब और नशीले पदार्थों से सावधान रहें" },
    { type: "p", text: "पहली मुलाक़ात में शराब कम से कम रखें, या पूरी तरह टाल दें। शराब आपकी परखने की क्षमता को कुंद कर देती है और संभावित जोखिमों को पहचानना मुश्किल बना देती है। अपना पेय हमेशा ख़ुद ऑर्डर करें और ध्यान रखें कि वह आपकी नज़रों के सामने तैयार हो। अपना गिलास कभी भी बिना निगरानी न छोड़ें।" },

    { type: "h2", text: "8. पैसों के जाल में न फँसें" },
    { type: "p", text: "जब आप एक-दूसरे को जानना ही शुरू कर रहे हों, तभी पैसे या वित्तीय जानकारी माँगना सबसे आम ठगी के तरीक़ों में से एक है। जिससे आप कभी आमने-सामने नहीं मिले, उसे कभी पैसे न भेजें, बैंक की जानकारी साझा न करें और आर्थिक मदद के प्रस्ताव स्वीकार न करें। \"आपात स्थिति\" के नाम पर आई पैसों की माँग रिश्ते के किसी भी पड़ाव पर रुक जाने का संकेत है।" },

    { type: "h2", text: "9. ख़तरे के संकेत पहचानें" },
    { type: "p", text: "कुछ व्यवहार गंभीर चेतावनी हैं और उन्हें बहाने बनाकर टाला नहीं जाना चाहिए:" },
    { type: "ul", items: [
      "कुछ ही दिनों में प्यार का इज़हार कर देना (लव बॉम्बिंग)",
      "वीडियो कॉल से लगातार बचते रहना",
      "पैसे या वित्तीय जानकारी माँगना",
      "नियंत्रण करने वाला व्यवहार, जैसे बार-बार पूछना कि आप कहाँ हैं",
      "अपने अतीत के बारे में आपस में न मिलने वाली बातें बताना",
      "सोशल मीडिया पर कोई निशान न होना, या सिर्फ़ बिल्कुल नए अकाउंट होना",
      "मिलने की जगह बार-बार बदलना, या आपको सुनसान जगहों की ओर ले जाना",
    ] },

    { type: "h2", text: "10. ऐप की सुरक्षा सुविधाओं का इस्तेमाल करें" },
    { type: "p", text: "भरोसेमंद डेटिंग ऐप्स आपको साधन देते हैं: ब्लॉक करना, रिपोर्ट करना, और किसी असली व्यक्ति तक पहुँचने का रास्ता। जैसे ही कुछ खटके, बिना झिझक इनका इस्तेमाल करें — रिपोर्ट करने में आपका कुछ नहीं जाता, और किसी को पता चलने का यही एकमात्र रास्ता है। Qulo में ब्लॉक और रिपोर्ट हर प्रोफ़ाइल और हर चैट के तीन-बिंदु मेन्यू में मौजूद हैं, और हर रिपोर्ट एक मॉडरेशन पैनल में पहुँचती है जहाँ उसे एक व्यक्ति पढ़ता है।" },

    { type: "h2", text: "Qulo की सुरक्षा सुविधाएँ" },
    { type: "p", text: "Qulo इस तरह बनाया गया है कि सुरक्षा के साधन वहीं मिलें जहाँ आपको उनकी ज़रूरत है, और उनके बारे में हम जो कहते हैं वह सच हो। ऐप ठीक यही करता है — इससे ज़्यादा कुछ नहीं:" },
    { type: "ul", items: [
      "**एन्क्रिप्टेड भंडारण:** आपके खाते का डेटा और संदेश एन्क्रिप्टेड रूप में संग्रहित होते हैं",
      "**ईमेल सत्यापन:** आपकी प्रोफ़ाइल दूसरों को तभी दिखती है जब आप अपना ईमेल पता पुष्ट कर देते हैं",
      "**ब्लॉक और रिपोर्ट:** हर प्रोफ़ाइल और हर चैट के तीन-बिंदु मेन्यू से, एक ही क़दम में",
      "**इंसानी समीक्षा:** हर रिपोर्ट मॉडरेशन पैनल में पहुँचती है और उसे एक व्यक्ति पढ़ता है",
      "**सवालों पर आधारित मैचिंग:** Qulo पर मैच होने में असली मेहनत लगती है, जिससे थोक में संदेश भेजना और कम मेहनत वाले स्पैम अकाउंट काफ़ी हद तक बेकार हो जाते हैं",
    ] },

    { type: "quote", text: "कोई भी ऐप किसी अजनबी से मिलने को जोखिम-मुक्त नहीं बना सकता। ऐप जो कर सकता है, वह है आपको ख़ुद फ़ैसला करने के लिए साधन और समय देना — और Qulo पर वह फ़ैसला एक सवाल से शुरू होता है।" },

    { type: "h2", accent: "green", text: "निष्कर्ष: सुरक्षित रहकर मिलें" },
    { type: "p", text: "सही तरीक़े के साथ ऑनलाइन डेटिंग सुरक्षित और सचमुच आनंददायक अनुभव हो सकती है। इन दस नियमों को याद रखें, अपनी अंतर्दृष्टि पर भरोसा करें, और आप ज़्यादातर जोखिम को सँभालने लायक़ बना लेंगे। याद रखें: आपकी सुरक्षा हर बार रोमांस से पहले आती है। Qulo पर सुरक्षित रहकर मिलें, और सवालों के ज़रिए मैच करें।" },
  ],
};
