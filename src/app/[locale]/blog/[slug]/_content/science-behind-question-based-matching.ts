import type { LocalizedArticle } from "@/components/blog/ArticleBlocks";

/**
 * "The Science Behind Question-Based Matching" — migrated from inline per-locale
 * JSX. This was the LAST legacy post: the component shipped `tr` plus an English
 * fallback, so 14 locales were served the English body under an `hreflang` that
 * promised their own language. Canonical source is `en`; all 16 locales are full
 * translations. `**bold**` renders as <strong>.
 *
 * Accents: the legacy markup put `text-qulo-green` on exactly two headings —
 * the Qulo section and the closing section — so the green count is 2, at block
 * indices 18 and 25. Every other h2 is purple. (The blockquote's green border is
 * house style in `ArticleBlocks`, not an accent.) The legacy markup used only
 * `<h2>`, so no h3 conversion was needed here.
 *
 * ---------------------------------------------------------------------------
 * Source policy — this post is *about* science, so the bar is higher, not lower.
 *
 * KEPT, with inline attribution in all 16 locales:
 *  - Aron, Melinat, Aron, Vallone & Bator, Personality and Social Psychology
 *    Bulletin 23(4), 1997. What it actually shows: escalating **mutual**
 *    self-disclosure between strangers generates closeness in a session of about
 *    **45 minutes**, against a small-talk control. Popularised as "36 questions".
 *  - Sprecher, Treger, Wondra, Hilaire & Wallpe, Journal of Experimental Social
 *    Psychology, 2013. Reciprocal turn-taking produces more liking than
 *    one-sided disclosure. No number attached.
 *  - Huang, Yeomans, Brooks, Minson & Gino, Journal of Personality and Social
 *    Psychology, September 2017 (`HUANG_JPSP_2017` in `src/lib/constants/stats.ts`):
 *    **110** speed daters, **1,961** second-date decisions, follow-up questions
 *    predict being asked back. Thousand separators follow local convention
 *    (1,961 / 1.961 / 1 961 / 1961), matching the sibling articles; the value
 *    never changes.
 *
 * DELETED:
 *  - "4 minutes" of eye contact, presented as part of Aron's finding. The paper's
 *    result is about escalating mutual disclosure over ~45 minutes; the popular
 *    version has drifted, and nobody showed that strangers fall in love in four
 *    minutes. The figure is gone and the post now says explicitly what the study
 *    did not show.
 *  - "photos misrepresent a person's actual attractiveness by 20-30%" — no study,
 *    no publisher, not checkable.
 *  - "people adapt to physical attractiveness within 6-18 months" — same.
 *  - "after 2 years, the correlation between physical attractiveness and
 *    relationship quality drops to nearly zero" — same. All three claims survive
 *    qualitatively, without invented precision.
 *  - The entire "neuroscience" section (prefrontal cortex / limbic system /
 *    "cognitive-emotional integration", against swiping as an occipital-lobe,
 *    amygdala "fight or flight" response). Unsourced and not a real finding; the
 *    section is now about the shape of an exchange, which the cited work covers.
 *  - Sidney Jourard's name, which carried the claim that self-disclosure is "the
 *    most important factor determining relationship depth". Jourard's work is
 *    real, that framing of it is not his result — so the name goes and the
 *    substance stays, sourced to Sprecher et al. instead.
 *
 * REFRAMED:
 *  - Sternberg's triangular theory of love (intimacy, passion, commitment) is
 *    kept strictly as a framework being described. No statistic is attached to
 *    it, and it is no longer used as evidence that questions beat photos.
 *  - Bowlby's attachment theory is likewise framework-only, with the caveat that
 *    no one has shown an app changes an adult's attachment style.
 *  - "The most scientifically proven effective method of building connections"
 *    and "science proves questions build stronger connections than photos" are
 *    gone. The honest framing, used across this site: research shows
 *    question-asking and reciprocal disclosure are how strangers start to like
 *    each other; Qulo makes that exchange the entry point instead of a photo. It
 *    is not validated matching, and the post now says so in two places.
 *
 * Product claims describe the real mechanic: 2-4 multiple-choice questions on a
 * free account (up to 10 on a paid plan), four options each, marking the answer
 * that is true of you; a match requires every answer right; the optional powers
 * (hint, halve the options, skip) cost in-app diamonds and are never required.
 *
 * Brand rule: Qulo is the only dating app nameable on this site. Everything else
 * is "dating apps" / "photo-first apps".
 */
export const scienceBehindQuestionBasedMatching: LocalizedArticle = {
  en: [
    { type: "h2", text: "What Aron's 36 Questions Study Actually Showed" },
    { type: "p", text: "In 1997, Arthur Aron, Edward Melinat, Elaine Aron, Robert Vallone and Renee Bator published a procedure in **Personality and Social Psychology Bulletin** that has been quoted, misquoted and turned into a listicle ever since. Two strangers sat down together and worked through three sets of questions that grew steadily more personal, taking turns to answer every one. The session ran about **45 minutes**. Afterwards the pairs reported feeling markedly closer to each other than strangers who had spent the same 45 minutes on small talk." },
    { type: "p", text: "It is worth being precise about what that study did and did not show, because the popular version has drifted a long way from the paper. It showed that **escalating, mutual self-disclosure** — both people answering, each answer a little more personal than the last — generates closeness between strangers, and that it can happen surprisingly fast. It did not show that anyone falls in love in a handful of minutes, and it was never a matching algorithm: nobody was paired by their answers, and the questions were not a compatibility test. **Mutual** is the load-bearing word in the whole finding." },
    { type: "p", text: "That is the real reason questions are interesting for dating, and it is a narrower reason than the internet usually gives. What the research supports is that asking and answering is how two strangers begin to like each other. Whether the person you come to like turns out to be a good partner is a separate question that no set of prompts can answer. What Qulo takes from this is the sequence, not a prediction: the exchange happens first, and the face comes after." },

    { type: "h2", text: "Reciprocity Is the Part That Does the Work" },
    { type: "p", text: "Sprecher, Treger, Wondra, Hilaire and Wallpe tested exactly this in the **Journal of Experimental Social Psychology** in 2013. Pairs of strangers either took turns disclosing — both asking, both answering — or split the roles, one person talking while the other listened, and then swapped. Taking turns produced more liking and more closeness. The same amount of information passed between the same two people; only the shape of the exchange changed." },
    { type: "p", text: "Huang, Yeomans, Brooks, Minson and Gino found the dating-relevant version of that in the **Journal of Personality and Social Psychology** in September 2017. Across **110** speed daters and **1,961** second-date decisions, the people who asked more questions — **follow-up questions** above all, the kind that show you actually heard the previous answer — were more likely to be asked back. Not the most attractive, not the wittiest. The ones who asked." },
    { type: "p", text: "A photo and two lines of bio cannot do any of that. They travel in one direction, they ask nothing of you, and there is nothing there to respond to. A question is the smallest object that makes both people put something down." },

    { type: "h2", text: "Attachment Theory: A Framework, Not a Verdict" },
    { type: "p", text: "John Bowlby's attachment theory is the standard vocabulary for how people behave in close relationships — secure, anxious, avoidant — and it is a real framework, worth naming as one. It is also worth saying what it is not. Bowlby was writing about children and caregivers decades before anyone swiped on anything, and nobody has shown that a dating app moves an adult's attachment style in either direction. Anyone telling you an app can fix or ruin how you attach is selling something." },
    { type: "p", text: "What the design of an app can change is narrower and more mundane: what a no means. Where matching runs on photos, not matching reads as a verdict on your face, because your face was the whole of what was on offer. Where matching runs through someone's questions, a miss reads as a miss — you did not get the answers right. That is a difference in framing, not a therapeutic claim, and framing is the honest size of it." },

    { type: "h2", text: "Cognitive Compatibility and Sternberg's Triangle" },
    { type: "p", text: "Cognitive compatibility is a plain idea in an academic coat: two people whose thinking runs along similar lines — how they approach a problem, what they take for granted, what they find funny. Questions surface it early, because the way somebody frames a question tells you as much as the answer does. What nobody has shown, and what this article will not claim, is that getting a stranger's questions right predicts a relationship. It predicts that you paid attention." },
    { type: "p", text: "Robert Sternberg's triangular theory of love is useful here as a description rather than as evidence. It splits lasting love into three components: intimacy, passion and commitment. A photograph speaks to one corner of that triangle at most, and it speaks to it before you know anything else. The other two corners get built in conversation, if they get built at all. That is a way of thinking about what a photo-first first impression leaves out — not a measurement of anything, and no number belongs to it." },

    { type: "h2", text: "Why a Photo Tells You Less Than It Seems To" },
    { type: "p", text: "None of this makes attraction unimportant. It makes a photo a poor container for it. Four familiar problems, none of which need a statistic to be obvious:" },
    { type: "ul", items: [
      "**The halo effect:** we quietly assume that someone we find attractive is also kinder, funnier and more competent. It is one of the oldest documented biases in social psychology, and it is wrong roughly as often as it is right.",
      "**A photo is chosen:** it is the best of a few hundred, taken in good light, at the angle that works, on a day that went well. An honest picture of a face and an unreliable one about everything else.",
      "**Looks stop being new information:** the first impression is most of what a face has to tell you, and after that it repeats. What someone is like to talk to does not run out that way.",
      "**A photo cannot answer:** nothing you learn from it arrived in response to anything you offered — which is precisely the reciprocity the studies above say matters.",
    ] },
    { type: "p", text: "That is a limit on what photo-first matching can tell you. It is not evidence that questions predict who you should be with. Only that a photo was never going to, and that an exchange leaves you with something to go on that a face cannot give you." },

    { type: "h2", text: "What Qulo Actually Does With This", accent: "green" },
    { type: "p", text: "Qulo does not claim to run scientifically validated matching, because no such thing exists in dating. What it does is put the exchange first, mechanically, so that it cannot be skipped:" },
    { type: "ul", items: [
      "**You write 2 to 4 questions about yourself** — multiple choice, four options each — and mark the option that is true of you. A paid plan raises the ceiling to 10.",
      "**Someone matches by getting every one right.** A single wrong answer means no match, so nobody arrives by tapping through.",
      "**The questions come before the face,** which reverses the usual order of a first impression.",
      "**Solving takes attention.** Effort is a weak guarantee of anything, but it is real evidence that the other person read what you wrote.",
      "**The optional powers — a hint, halving the options, skipping a question — cost in-app diamonds and are never required to match.** Every question is solvable without spending anything.",
    ] },

    { type: "h2", text: "How to Write Questions Worth Answering" },
    { type: "p", text: "Because your answer has to be findable, writing good questions is a specific skill. The work above suggests what to aim for: personal enough to be worth disclosing, and answerable by someone paying attention rather than guessing." },
    { type: "ul", items: [
      "**Be specific about yourself:** \"the city I would move to tomorrow\" beats \"my favourite city\". One is a fact about you; the other is small talk.",
      "**Make it findable, not psychic:** the right answer should be reachable from your profile, your photos and a little thought. A question only your sister could answer is not a filter, it is a wall.",
      "**Avoid decorative options:** four plausible options with one true one is a question. One true option and three jokes is a formality.",
      "**Ask about choices, not trivia:** what you would do, what you would give up, where you would go. Choices show a person; facts about them mostly do not.",
      "**Vary the depth:** open with something light and put the one that actually matters to you third or fourth. That escalation is the part the 1997 study was really about.",
    ] },

    { type: "quote", text: "The shortest route to knowing someone is a question you both have to answer. That is not a discovery — it is just what a conversation is." },

    { type: "h2", text: "The Honest Version", accent: "green" },
    { type: "p", text: "Question-based matching is not a proven route to a relationship, and this article is not going to pretend otherwise. What the research supports is smaller and still worth building on: asking questions, and answering them in turn, is how strangers begin to like each other — Aron and colleagues in 1997, Sprecher and colleagues in 2013, Huang and colleagues in 2017 all point the same way. A photo is not that. Qulo's only real claim is a claim about design: it makes the exchange the entry point instead of an afterthought, and leaves it to you to decide what the answers mean." },
  ],
  tr: [
    { type: "h2", text: "Aron'un 36 Soru Çalışması Gerçekte Ne Gösterdi?" },
    { type: "p", text: "1997'de Arthur Aron, Edward Melinat, Elaine Aron, Robert Vallone ve Renee Bator, **Personality and Social Psychology Bulletin** dergisinde o gün bugündür alıntılanan, yanlış alıntılanan ve internet listelerine çevrilen bir yöntem yayımladı. İki yabancı karşılıklı oturdu ve giderek kişiselleşen üç soru setini, her soruyu sırayla cevaplayarak baştan sona çalıştı. Oturum yaklaşık **45 dakika** sürdü. Sonrasında bu çiftler, aynı 45 dakikayı havadan sudan sohbetle geçiren yabancılara kıyasla birbirlerine belirgin biçimde daha yakın hissettiklerini bildirdi." },
    { type: "p", text: "Bu çalışmanın ne gösterdiği ve ne göstermediği konusunda net olmakta fayda var; çünkü popüler anlatı makaleden epeyce uzaklaştı. Çalışma, **giderek derinleşen karşılıklı kendini açmanın** — iki tarafın da cevap vermesi, her cevabın bir öncekinden biraz daha kişisel olması — yabancılar arasında yakınlık ürettiğini ve bunun şaşırtıcı ölçüde hızlı olabildiğini gösterdi. Kimsenin birkaç dakikada âşık olduğunu göstermedi ve hiçbir zaman bir eşleşme algoritması olmadı: kimse cevaplarına göre eşleştirilmedi, sorular bir uyumluluk testi değildi. Bulgunun tamamında yükü taşıyan kelime **karşılıklı**." },
    { type: "p", text: "Soruların flört açısından ilgi çekici olmasının gerçek sebebi bu ve internetin genelde verdiğinden daha dar bir sebep. Araştırmanın desteklediği şey şu: sormak ve cevaplamak, iki yabancının birbirinden hoşlanmaya başlama biçimidir. Hoşlandığınız kişinin iyi bir partner çıkıp çıkmayacağı ise hiçbir soru setinin cevaplayamayacağı ayrı bir soru. Qulo'nun buradan aldığı şey bir öngörü değil, sıralama: önce alışveriş oluyor, yüz sonra geliyor." },

    { type: "h2", text: "Asıl İşi Yapan Kısım Karşılıklılık" },
    { type: "p", text: "Sprecher, Treger, Wondra, Hilaire ve Wallpe tam da bunu 2013'te **Journal of Experimental Social Psychology** dergisinde sınadı. Yabancı çiftler ya sırayla kendini açtı — ikisi de sordu, ikisi de cevapladı — ya da rolleri böldü: biri anlatırken diğeri dinledi, sonra yer değiştirdiler. Sıra almak daha çok beğeni ve daha çok yakınlık üretti. Aynı iki kişi arasında aynı miktarda bilgi geçti; değişen tek şey alışverişin biçimiydi." },
    { type: "p", text: "Huang, Yeomans, Brooks, Minson ve Gino bunun flörtle doğrudan ilgili halini Eylül 2017'de **Journal of Personality and Social Psychology** dergisinde buldu. **110** hızlı tanışma katılımcısı ve **1.961** ikinci buluşma kararı boyunca, daha çok soru soranların — özellikle de **takip sorusu** soranların, yani bir önceki cevabı gerçekten duyduğunuzu gösteren türden soru soranların — tekrar davet edilme olasılığı daha yüksekti. En çekici olanların değil, en esprili olanların da değil. Soranların." },
    { type: "p", text: "Bir fotoğraf ve iki satırlık biyografi bunların hiçbirini yapamaz. Tek yönde ilerler, sizden bir şey istemez ve karşılık verilecek bir şey bırakmaz. Soru, iki tarafın da ortaya bir şey koymasını sağlayan en küçük nesnedir." },

    { type: "h2", text: "Bağlanma Kuramı: Bir Çerçeve, Bir Hüküm Değil" },
    { type: "p", text: "John Bowlby'nin bağlanma kuramı, insanların yakın ilişkilerde nasıl davrandığını anlatan standart sözlüktür — güvenli, kaygılı, kaçıngan — ve gerçek bir çerçevedir, adını anmaya değer. Ne olmadığını söylemek de aynı ölçüde değerli. Bowlby, kimse hiçbir şeyi kaydırmadan onlarca yıl önce çocuklar ve bakım verenler üzerine yazıyordu; bir flört uygulamasının yetişkin bir insanın bağlanma stilini şu ya da bu yöne oynattığını ise kimse göstermedi. Size bir uygulamanın bağlanma biçiminizi düzeltebileceğini ya da bozabileceğini söyleyen herkes bir şey satıyordur." },
    { type: "p", text: "Bir uygulamanın tasarımının değiştirebileceği şey daha dar ve daha sıradan: hayırın ne anlama geldiği. Eşleşme fotoğraf üzerinden yürüdüğünde, eşleşmemek yüzünüz hakkında bir hüküm gibi okunur; çünkü ortada olan tek şey yüzünüzdü. Eşleşme karşı tarafın soruları üzerinden yürüdüğünde, ıskalamak ıskalamak olarak okunur: cevapları doğru bilemediniz. Bu, terapötik bir iddia değil, bir çerçeveleme farkı — ve dürüst boyutu da bu kadar." },

    { type: "h2", text: "Bilişsel Uyumluluk ve Sternberg'in Üçgeni" },
    { type: "p", text: "Bilişsel uyumluluk, akademik bir palto giymiş sade bir fikirdir: düşüncesi benzer hatlarda ilerleyen iki insan — bir soruna nasıl yaklaştıkları, neyi apaçık saydıkları, neye güldükleri. Sorular bunu erkenden görünür kılar; çünkü birinin soruyu kurma biçimi size en az cevabı kadar şey söyler. Kimsenin göstermediği ve bu yazının da iddia etmeyeceği şey ise şu: bir yabancının sorularını doğru bilmek bir ilişkiyi öngörmez. Yalnızca dikkat ettiğinizi gösterir." },
    { type: "p", text: "Robert Sternberg'in aşkın üçgen kuramı burada kanıt olarak değil, bir tarif olarak işe yarar. Kalıcı aşkı üç bileşene ayırır: yakınlık, tutku ve bağlılık. Bir fotoğraf bu üçgenin olsa olsa tek köşesine seslenir ve siz başka hiçbir şey bilmeden seslenir. Diğer iki köşe, kurulacaksa, konuşmanın içinde kurulur. Bu, fotoğrafla başlayan bir ilk izlenimin neyi dışarıda bıraktığını düşünmenin bir yolu — bir ölçüm değil ve ona hiçbir sayı ait değil." },

    { type: "h2", text: "Fotoğraf Neden Göründüğünden Az Şey Anlatır?" },
    { type: "p", text: "Bunların hiçbiri çekiciliği önemsiz kılmıyor. Yalnızca fotoğrafı onun için kötü bir kap yapıyor. Anlaşılmak için istatistiğe ihtiyaç duymayan dört tanıdık sorun:" },
    { type: "ul", items: [
      "**Hâle etkisi:** Çekici bulduğumuz birinin aynı zamanda daha iyi kalpli, daha komik ve daha yetkin olduğunu sessizce varsayarız. Sosyal psikolojide belgelenmiş en eski önyargılardan biridir ve aşağı yukarı doğru olduğu kadar yanlıştır.",
      "**Fotoğraf seçilmiştir:** Birkaç yüz kare arasından, iyi ışıkta, işe yarayan açıdan, iyi geçen bir günde çekilmiş olanıdır. Bir yüz hakkında dürüst, geri kalan her şey hakkında güvenilmez bir belgedir.",
      "**Görüntü bir süre sonra yeni bilgi olmaktan çıkar:** Bir yüzün size söyleyeceğinin çoğu ilk izlenimdedir, ondan sonrası tekrardır. Biriyle konuşmanın nasıl bir şey olduğu böyle tükenmez.",
      "**Fotoğraf cevap veremez:** Ondan öğrendiğiniz hiçbir şey sizin ortaya koyduğunuz bir şeye karşılık gelmez — ki yukarıdaki çalışmaların önemli dediği şey tam da bu karşılıklılıktır.",
    ] },
    { type: "p", text: "Bu, fotoğrafla başlayan eşleşmenin size ne kadarını anlatabileceğine dair bir sınır. Soruların kiminle olmanız gerektiğini öngördüğüne dair bir kanıt değil. Yalnızca bir fotoğrafın bunu zaten hiç yapamayacağına ve bir alışverişin, bir yüzün veremeyeceği bir şeyi elinizde bıraktığına dair." },

    { type: "h2", text: "Qulo Bununla Gerçekte Ne Yapıyor?", accent: "green" },
    { type: "p", text: "Qulo, bilimsel olarak doğrulanmış bir eşleştirme yaptığını iddia etmiyor; çünkü flört alanında böyle bir şey yok. Yaptığı şey, alışverişi mekanik olarak öne almak — atlanamayacak biçimde:" },
    { type: "ul", items: [
      "**Kendinizle ilgili 2 ila 4 soru yazarsınız** — çoktan seçmeli, her biri dört seçenekli — ve sizin için doğru olan seçeneği işaretlersiniz. Ücretli planda bu sınır 10 soruya çıkar.",
      "**Karşı taraf hepsini doğru bilerek eşleşir.** Tek bir yanlış cevap eşleşme olmaması demek; yani kimse öylesine dokunarak gelmiyor.",
      "**Sorular yüzden önce gelir;** bu da ilk izlenimin alışılmış sırasını tersine çevirir.",
      "**Çözmek dikkat ister.** Emek hiçbir şeyin güçlü garantisi değildir ama karşı tarafın yazdığınızı okuduğuna dair gerçek bir kanıttır.",
      "**İsteğe bağlı güçler — ipucu, seçenekleri yarıya indirme, soru atlama — uygulama içi elmasa mal olur ve eşleşmek için asla zorunlu değildir.** Her soru hiçbir şey harcamadan çözülebilir.",
    ] },

    { type: "h2", text: "Cevaplanmaya Değer Sorular Nasıl Yazılır?" },
    { type: "p", text: "Cevabınızın bulunabilir olması gerektiği için iyi soru yazmak ayrı bir beceri. Yukarıdaki çalışmalar neyi hedeflemek gerektiğini söylüyor: paylaşmaya değecek kadar kişisel, tahmin eden değil dikkat eden birinin bilebileceği kadar da erişilebilir." },
    { type: "ul", items: [
      "**Kendinizle ilgili spesifik olun:** \"yarın taşınacağım şehir\", \"en sevdiğim şehir\"i döver. Biri sizinle ilgili bir olgu, diğeri havadan sudan.",
      "**Bulunabilir olsun, medyumluk istemesin:** Doğru cevap profilinizden, fotoğraflarınızdan ve biraz düşünmekten çıkabilmeli. Yalnızca kardeşinizin bilebileceği bir soru filtre değil, duvardır.",
      "**Süs seçeneklerden kaçının:** Biri doğru dört makul seçenek bir sorudur. Bir doğru ve üç şaka bir formalitedir.",
      "**Bilgi değil tercih sorun:** Ne yapardınız, neyden vazgeçerdiniz, nereye giderdiniz. Tercihler insanı gösterir; insan hakkındaki bilgiler çoğunlukla göstermez.",
      "**Derinliği değiştirin:** Hafif bir soruyla açın, sizin için asıl önemli olanı üçüncü ya da dördüncü sıraya koyun. 1997 çalışmasının asıl meselesi de bu kademelenmeydi.",
    ] },

    { type: "quote", text: "Birini tanımanın en kısa yolu, ikinizin de cevaplaması gereken bir sorudur. Bu bir keşif değil — konuşma dediğimiz şey zaten bu." },

    { type: "h2", text: "Dürüst Hali", accent: "green" },
    { type: "p", text: "Soru tabanlı eşleşme, ilişkiye giden kanıtlanmış bir yol değil ve bu yazı aksini iddia etmeyecek. Araştırmanın desteklediği şey daha küçük ama üzerine bir şey kurmaya yine de değer: soru sormak ve sırayla cevaplamak, yabancıların birbirinden hoşlanmaya başlama biçimidir — 1997'de Aron ve arkadaşları, 2013'te Sprecher ve arkadaşları, 2017'de Huang ve arkadaşları hep aynı yöne işaret ediyor. Fotoğraf bu değil. Qulo'nun tek gerçek iddiası bir tasarım iddiası: alışverişi sonradan gelen bir şey olmaktan çıkarıp giriş kapısı yapıyor ve cevapların ne anlama geldiğine karar vermeyi size bırakıyor." },
  ],
  de: [
    { type: "h2", text: "Was Arons 36-Fragen-Studie wirklich gezeigt hat" },
    { type: "p", text: "1997 veröffentlichten Arthur Aron, Edward Melinat, Elaine Aron, Robert Vallone und Renee Bator im **Personality and Social Psychology Bulletin** ein Verfahren, das seither zitiert, falsch zitiert und in Listen verwandelt worden ist. Zwei Fremde setzten sich zusammen und arbeiteten drei Fragensets durch, die immer persönlicher wurden, und beantworteten jede Frage abwechselnd. Die Sitzung dauerte etwa **45 Minuten**. Danach berichteten diese Paare, sie fühlten sich einander deutlich näher als Fremde, die dieselben 45 Minuten mit Smalltalk verbracht hatten." },
    { type: "p", text: "Es lohnt sich, genau zu sein, was diese Studie gezeigt hat und was nicht — denn die populäre Fassung hat sich weit von der Arbeit entfernt. Gezeigt hat sie, dass **schrittweise gesteigerte, gegenseitige Selbstöffnung** — beide antworten, jede Antwort etwas persönlicher als die vorige — Nähe zwischen Fremden erzeugt, und zwar erstaunlich schnell. Sie hat nicht gezeigt, dass sich jemand in wenigen Minuten verliebt, und sie war nie ein Matching-Algorithmus: Niemand wurde nach seinen Antworten zusammengebracht, und die Fragen waren kein Kompatibilitätstest. **Gegenseitig** ist das tragende Wort des ganzen Befunds." },
    { type: "p", text: "Das ist der eigentliche Grund, warum Fragen fürs Daten interessant sind, und er ist enger, als das Internet ihn üblicherweise verkauft. Belegt ist: Fragen und Antworten sind die Art, wie zwei Fremde anfangen, einander zu mögen. Ob die Person, die Sie mögen, auch zu Ihnen passt, ist eine andere Frage, die kein Fragenset beantworten kann. Was Qulo daraus übernimmt, ist die Reihenfolge, keine Prognose: Zuerst kommt der Austausch, das Gesicht danach." },

    { type: "h2", text: "Die Arbeit macht die Gegenseitigkeit" },
    { type: "p", text: "Sprecher, Treger, Wondra, Hilaire und Wallpe haben genau das 2013 im **Journal of Experimental Social Psychology** geprüft. Fremde Paare öffneten sich entweder abwechselnd — beide fragten, beide antworteten — oder teilten die Rollen: Eine Person erzählte, die andere hörte zu, dann wurde getauscht. Das Abwechseln erzeugte mehr Sympathie und mehr Nähe. Zwischen denselben zwei Menschen ging dieselbe Menge an Information hin und her; verändert hat sich nur die Form des Austauschs." },
    { type: "p", text: "Huang, Yeomans, Brooks, Minson und Gino fanden im September 2017 im **Journal of Personality and Social Psychology** die fürs Daten unmittelbar relevante Fassung davon. Über **110** Speed-Dating-Teilnehmende und **1.961** Zweitdate-Entscheidungen hinweg wurden diejenigen, die mehr Fragen stellten — vor allem **Anschlussfragen**, also solche, die zeigen, dass man die vorige Antwort wirklich gehört hat —, häufiger ein zweites Mal gefragt. Nicht die Attraktivsten, nicht die Witzigsten. Die, die fragten." },
    { type: "p", text: "Ein Foto und zwei Zeilen Profiltext können nichts davon leisten. Sie laufen in eine Richtung, verlangen nichts von Ihnen und lassen nichts übrig, worauf man antworten könnte. Eine Frage ist das kleinste Ding, das beide Seiten dazu bringt, etwas hinzulegen." },

    { type: "h2", text: "Bindungstheorie: ein Rahmen, kein Urteil" },
    { type: "p", text: "John Bowlbys Bindungstheorie ist das Standardvokabular dafür, wie Menschen sich in engen Beziehungen verhalten — sicher, ängstlich, vermeidend — und sie ist ein echter Rahmen, den man beim Namen nennen darf. Genauso wichtig ist, was sie nicht ist. Bowlby schrieb über Kinder und Bezugspersonen, Jahrzehnte bevor irgendjemand irgendwo gewischt hat, und niemand hat gezeigt, dass eine Dating-App den Bindungsstil eines Erwachsenen in die eine oder andere Richtung verschiebt. Wer Ihnen erzählt, eine App könne Ihr Bindungsverhalten reparieren oder ruinieren, verkauft Ihnen etwas." },
    { type: "p", text: "Was das Design einer App verändern kann, ist enger und banaler: was ein Nein bedeutet. Läuft das Matching über Fotos, liest sich ein ausbleibendes Match wie ein Urteil über Ihr Gesicht — denn Ihr Gesicht war alles, was im Angebot stand. Läuft das Matching über die Fragen der anderen Person, liest sich ein Fehlversuch als Fehlversuch: Sie haben die Antworten nicht getroffen. Das ist ein Unterschied im Rahmen, keine therapeutische Behauptung — und der Rahmen ist die ehrliche Größenordnung." },

    { type: "h2", text: "Kognitive Passung und Sternbergs Dreieck" },
    { type: "p", text: "Kognitive Passung ist eine schlichte Idee im akademischen Mantel: zwei Menschen, deren Denken in ähnlichen Bahnen läuft — wie sie ein Problem angehen, was sie für selbstverständlich halten, worüber sie lachen. Fragen machen das früh sichtbar, denn wie jemand eine Frage stellt, sagt so viel wie die Antwort. Was niemand gezeigt hat und was dieser Text nicht behaupten wird: Die Fragen eines fremden Menschen richtig zu beantworten sagt keine Beziehung voraus. Es sagt aus, dass Sie aufmerksam waren." },
    { type: "p", text: "Robert Sternbergs Dreieckstheorie der Liebe hilft hier als Beschreibung, nicht als Beleg. Sie teilt dauerhafte Liebe in drei Komponenten: Intimität, Leidenschaft und Bindung. Ein Foto spricht höchstens eine Ecke dieses Dreiecks an, und es tut das, bevor Sie sonst irgendetwas wissen. Die anderen beiden Ecken entstehen im Gespräch, wenn sie überhaupt entstehen. Das ist eine Art, darüber nachzudenken, was ein fotogetriebener erster Eindruck auslässt — keine Messung, und keine Zahl gehört dazu." },

    { type: "h2", text: "Warum ein Foto weniger sagt, als es scheint" },
    { type: "p", text: "Nichts davon macht Anziehung unwichtig. Es macht das Foto zu einem schlechten Behälter dafür. Vier vertraute Probleme, für die es keine Statistik braucht:" },
    { type: "ul", items: [
      "**Der Halo-Effekt:** Wir nehmen stillschweigend an, dass jemand, den wir attraktiv finden, auch freundlicher, witziger und kompetenter ist. Das ist eine der ältesten dokumentierten Verzerrungen der Sozialpsychologie — und ungefähr so oft falsch wie richtig.",
      "**Ein Foto ist ausgewählt:** das beste aus ein paar hundert, bei gutem Licht, im richtigen Winkel, an einem Tag, der gut lief. Ehrlich über ein Gesicht und unzuverlässig über alles andere.",
      "**Aussehen hört auf, neue Information zu sein:** Das meiste, was ein Gesicht zu sagen hat, steckt im ersten Eindruck, danach wiederholt es sich. Wie es ist, mit jemandem zu reden, geht so nicht aus.",
      "**Ein Foto kann nicht antworten:** Nichts, was Sie daraus lernen, kam als Reaktion auf etwas, das Sie angeboten haben — und genau diese Gegenseitigkeit ist es, auf die die Studien oben zeigen.",
    ] },
    { type: "p", text: "Das ist eine Grenze dessen, was fotogetriebenes Matching Ihnen sagen kann. Es ist kein Beleg dafür, dass Fragen vorhersagen, mit wem Sie zusammen sein sollten. Nur dafür, dass ein Foto das ohnehin nie konnte — und dass ein Austausch Ihnen etwas in die Hand gibt, was ein Gesicht nicht hergibt." },

    { type: "h2", text: "Was Qulo tatsächlich daraus macht", accent: "green" },
    { type: "p", text: "Qulo behauptet nicht, wissenschaftlich validiertes Matching zu betreiben, denn so etwas gibt es beim Daten nicht. Was es tut: den Austausch mechanisch nach vorn holen, so dass er sich nicht überspringen lässt:" },
    { type: "ul", items: [
      "**Sie schreiben 2 bis 4 Fragen über sich** — Multiple Choice, je vier Optionen — und markieren die Option, die auf Sie zutrifft. Im kostenpflichtigen Tarif steigt die Grenze auf 10 Fragen.",
      "**Ein Match entsteht nur, wenn jemand alle richtig beantwortet.** Eine einzige falsche Antwort heißt kein Match; niemand kommt also durch bloßes Durchtippen an.",
      "**Die Fragen kommen vor dem Gesicht,** was die übliche Reihenfolge eines ersten Eindrucks umdreht.",
      "**Lösen kostet Aufmerksamkeit.** Aufwand garantiert wenig, ist aber ein echter Beleg dafür, dass die andere Person gelesen hat, was Sie geschrieben haben.",
      "**Die optionalen Hilfen — ein Hinweis, das Halbieren der Optionen, das Überspringen einer Frage — kosten In-App-Diamanten und sind für ein Match nie erforderlich.** Jede Frage ist lösbar, ohne etwas auszugeben.",
    ] },

    { type: "h2", text: "Wie man Fragen schreibt, die eine Antwort wert sind" },
    { type: "p", text: "Weil Ihre Antwort auffindbar sein muss, ist gutes Fragenschreiben eine eigene Fertigkeit. Die Arbeiten oben legen nahe, worauf es ankommt: persönlich genug, dass es sich zu teilen lohnt, und erreichbar für jemanden, der aufmerksam ist, statt zu raten." },
    { type: "ul", items: [
      "**Werden Sie konkret über sich:** „die Stadt, in die ich morgen ziehen würde“ schlägt „meine Lieblingsstadt“. Das eine ist eine Tatsache über Sie, das andere ist Smalltalk.",
      "**Auffindbar, nicht hellseherisch:** Die richtige Antwort sollte sich aus Ihrem Profil, Ihren Fotos und ein wenig Nachdenken ergeben. Eine Frage, die nur Ihre Schwester beantworten könnte, ist kein Filter, sondern eine Mauer.",
      "**Keine Deko-Optionen:** Vier plausible Optionen, von denen eine stimmt, sind eine Frage. Eine richtige und drei Witze sind eine Formalität.",
      "**Fragen Sie nach Entscheidungen, nicht nach Trivia:** was Sie tun würden, worauf Sie verzichten würden, wohin Sie gehen würden. Entscheidungen zeigen einen Menschen; Fakten über ihn meistens nicht.",
      "**Variieren Sie die Tiefe:** Fangen Sie leicht an und setzen Sie die Frage, die Ihnen wirklich wichtig ist, an dritte oder vierte Stelle. Genau um diese Steigerung ging es in der Studie von 1997.",
    ] },

    { type: "quote", text: "Der kürzeste Weg, jemanden kennenzulernen, ist eine Frage, die Sie beide beantworten müssen. Das ist keine Entdeckung — das ist einfach das, was ein Gespräch ist." },

    { type: "h2", text: "Die ehrliche Fassung", accent: "green" },
    { type: "p", text: "Fragenbasiertes Matching ist kein belegter Weg in eine Beziehung, und dieser Text tut nicht so, als wäre er einer. Was die Forschung stützt, ist kleiner und trotzdem tragfähig: Fragen zu stellen und sie abwechselnd zu beantworten, ist die Art, wie Fremde anfangen, einander zu mögen — Aron und Kolleginnen 1997, Sprecher und Kolleginnen 2013, Huang und Kolleginnen 2017 zeigen alle in dieselbe Richtung. Ein Foto tut das nicht. Qulos einzige echte Behauptung ist eine über Design: Es macht den Austausch zum Eingang statt zum Nachgedanken und überlässt Ihnen die Entscheidung, was die Antworten bedeuten." },
  ],
  fr: [
    { type: "h2", text: "Ce que l'étude des 36 questions d'Aron a réellement montré" },
    { type: "p", text: "En 1997, Arthur Aron, Edward Melinat, Elaine Aron, Robert Vallone et Renee Bator ont publié dans **Personality and Social Psychology Bulletin** un protocole qui n'a cessé depuis d'être cité, mal cité et transformé en liste d'articles. Deux inconnus s'asseyaient ensemble et parcouraient trois séries de questions de plus en plus personnelles, en répondant chacun à son tour. La séance durait environ **45 minutes**. Ensuite, ces binômes se déclaraient nettement plus proches l'un de l'autre que des inconnus ayant passé les mêmes 45 minutes à bavarder de tout et de rien." },
    { type: "p", text: "Il vaut la peine d'être précis sur ce que cette étude a montré et sur ce qu'elle n'a pas montré, car la version populaire s'est beaucoup éloignée de l'article. Elle a montré que **l'auto-révélation mutuelle et progressive** — les deux personnes répondent, chaque réponse un peu plus personnelle que la précédente — crée de la proximité entre inconnus, et que cela peut aller étonnamment vite. Elle n'a pas montré que l'on tombe amoureux en quelques minutes, et elle n'a jamais été un algorithme de matching : personne n'était apparié d'après ses réponses, et les questions n'étaient pas un test de compatibilité. **Mutuelle** est le mot qui porte tout le résultat." },
    { type: "p", text: "C'est la vraie raison pour laquelle les questions sont intéressantes en matière de rencontres, et elle est plus étroite que ce qu'en dit Internet. Ce que la recherche soutient, c'est que demander et répondre est la manière dont deux inconnus commencent à s'apprécier. Savoir si la personne que vous appréciez fera une bonne partenaire est une autre question, à laquelle aucune série de questions ne répond. Ce que Qulo en retient, c'est l'ordre, pas une prédiction : l'échange d'abord, le visage ensuite." },

    { type: "h2", text: "C'est la réciprocité qui fait le travail" },
    { type: "p", text: "Sprecher, Treger, Wondra, Hilaire et Wallpe ont testé exactement cela en 2013 dans le **Journal of Experimental Social Psychology**. Des paires d'inconnus se livraient soit à tour de rôle — les deux posant des questions, les deux répondant — soit en se répartissant les rôles : l'un parlait, l'autre écoutait, puis ils inversaient. L'alternance a produit plus de sympathie et plus de proximité. La même quantité d'informations circulait entre les deux mêmes personnes ; seule la forme de l'échange changeait." },
    { type: "p", text: "Huang, Yeomans, Brooks, Minson et Gino en ont trouvé la version directement pertinente pour les rencontres, en septembre 2017 dans le **Journal of Personality and Social Psychology**. Sur **110** participants au speed dating et **1 961** décisions de second rendez-vous, celles et ceux qui posaient le plus de questions — surtout des **questions de relance**, celles qui montrent qu'on a vraiment entendu la réponse précédente — étaient plus souvent recontactés. Pas les plus séduisants, pas les plus drôles. Ceux qui demandaient." },
    { type: "p", text: "Une photo et deux lignes de description ne font rien de tout cela. Elles vont dans un seul sens, ne vous demandent rien et ne laissent rien à quoi répondre. Une question est le plus petit objet qui oblige les deux personnes à poser quelque chose sur la table." },

    { type: "h2", text: "La théorie de l'attachement : un cadre, pas un verdict" },
    { type: "p", text: "La théorie de l'attachement de John Bowlby est le vocabulaire standard pour décrire la façon dont les gens se comportent dans les relations proches — sécure, anxieux, évitant — et c'est un vrai cadre, que l'on peut nommer comme tel. Il vaut tout autant la peine de dire ce qu'elle n'est pas. Bowlby écrivait sur les enfants et leurs figures d'attachement des décennies avant que quiconque ne balaie un écran, et personne n'a montré qu'une application de rencontre déplaçait le style d'attachement d'un adulte dans un sens ou dans l'autre. Quiconque vous dit qu'une application peut réparer ou abîmer votre façon de vous attacher vous vend quelque chose." },
    { type: "p", text: "Ce que la conception d'une application peut changer est plus étroit et plus prosaïque : ce que signifie un non. Quand le matching passe par des photos, l'absence de match se lit comme un verdict sur votre visage, puisque votre visage était tout ce qui était proposé. Quand il passe par les questions de l'autre, un échec se lit comme un échec : vous n'avez pas trouvé les bonnes réponses. C'est une différence de cadrage, pas une promesse thérapeutique — et le cadrage, c'est la taille honnête de la chose." },

    { type: "h2", text: "Compatibilité cognitive et triangle de Sternberg" },
    { type: "p", text: "La compatibilité cognitive est une idée simple en habit universitaire : deux personnes dont la pensée suit des chemins voisins — comment elles abordent un problème, ce qu'elles tiennent pour évident, ce qui les fait rire. Les questions la font apparaître tôt, car la manière dont quelqu'un formule une question en dit autant que la réponse. Ce que personne n'a montré, et que cet article ne prétendra pas : trouver les bonnes réponses aux questions d'un inconnu ne prédit pas une relation. Cela prédit que vous avez été attentif." },
    { type: "p", text: "La théorie triangulaire de l'amour de Robert Sternberg est utile ici comme description, pas comme preuve. Elle découpe l'amour durable en trois composantes : l'intimité, la passion et l'engagement. Une photo s'adresse au mieux à un seul sommet de ce triangle, et elle le fait avant que vous ne sachiez quoi que ce soit d'autre. Les deux autres sommets se construisent dans la conversation, s'ils se construisent. C'est une façon de penser ce qu'une première impression fondée sur la photo laisse de côté — pas une mesure, et aucun chiffre ne lui appartient." },

    { type: "h2", text: "Pourquoi une photo en dit moins qu'il n'y paraît" },
    { type: "p", text: "Rien de tout cela ne rend l'attirance sans importance. Cela fait simplement de la photo un mauvais contenant. Quatre problèmes familiers, dont aucun n'a besoin d'une statistique pour sauter aux yeux :" },
    { type: "ul", items: [
      "**L'effet de halo :** nous supposons discrètement que quelqu'un que nous trouvons séduisant est aussi plus gentil, plus drôle et plus compétent. C'est l'un des biais les plus anciennement documentés en psychologie sociale, et il se trompe à peu près aussi souvent qu'il a raison.",
      "**Une photo est choisie :** la meilleure de quelques centaines, prise sous une bonne lumière, sous l'angle qui marche, un jour qui s'est bien passé. Honnête sur un visage, peu fiable sur tout le reste.",
      "**L'apparence cesse d'être une information nouvelle :** l'essentiel de ce qu'un visage a à dire tient dans la première impression, ensuite cela se répète. Ce que quelqu'un est en conversation ne s'épuise pas ainsi.",
      "**Une photo ne peut pas répondre :** rien de ce que vous en apprenez n'est venu en réponse à quelque chose que vous aviez offert — or c'est précisément la réciprocité que pointent les études ci-dessus.",
    ] },
    { type: "p", text: "C'est une limite de ce que le matching par photo peut vous apprendre. Ce n'est pas une preuve que les questions prédisent avec qui vous devriez être. Seulement qu'une photo n'allait jamais le faire, et qu'un échange vous laisse quelque chose sur quoi vous appuyer qu'un visage ne donne pas." },

    { type: "h2", text: "Ce que Qulo en fait concrètement", accent: "green" },
    { type: "p", text: "Qulo ne prétend pas faire du matching scientifiquement validé, car cela n'existe pas dans la rencontre en ligne. Ce qu'il fait, c'est placer l'échange en premier, mécaniquement, de sorte qu'on ne puisse pas le sauter :" },
    { type: "ul", items: [
      "**Vous écrivez 2 à 4 questions sur vous** — à choix multiple, quatre options chacune — et vous cochez celle qui est vraie pour vous. Avec un abonnement payant, la limite monte à 10 questions.",
      "**On ne matche qu'en trouvant toutes les bonnes réponses.** Une seule erreur et il n'y a pas de match : personne n'arrive en tapotant au hasard.",
      "**Les questions viennent avant le visage,** ce qui inverse l'ordre habituel d'une première impression.",
      "**Résoudre demande de l'attention.** L'effort ne garantit pas grand-chose, mais c'est une preuve réelle que l'autre a lu ce que vous avez écrit.",
      "**Les pouvoirs optionnels — un indice, réduire les options de moitié, passer une question — coûtent des diamants dans l'application et ne sont jamais nécessaires pour matcher.** Chaque question se résout sans rien dépenser.",
    ] },

    { type: "h2", text: "Comment écrire des questions qui méritent une réponse" },
    { type: "p", text: "Comme votre réponse doit pouvoir être trouvée, écrire de bonnes questions est un savoir-faire à part. Les travaux ci-dessus indiquent la cible : assez personnel pour valoir la peine d'être partagé, et accessible à quelqu'un qui fait attention plutôt qu'à quelqu'un qui devine." },
    { type: "ul", items: [
      "**Soyez précis sur vous :** « la ville où je déménagerais demain » vaut mieux que « ma ville préférée ». L'un est un fait vous concernant, l'autre est une conversation de circonstance.",
      "**Trouvable, pas médiumnique :** la bonne réponse doit être accessible depuis votre profil, vos photos et un peu de réflexion. Une question que seule votre sœur pourrait résoudre n'est pas un filtre, c'est un mur.",
      "**Évitez les options décoratives :** quatre options plausibles dont une vraie, c'est une question. Une vraie et trois blagues, c'est une formalité.",
      "**Interrogez des choix, pas des anecdotes :** ce que vous feriez, ce à quoi vous renonceriez, où vous iriez. Les choix montrent une personne ; les faits à son sujet, rarement.",
      "**Variez la profondeur :** commencez léger et placez celle qui compte vraiment pour vous en troisième ou quatrième position. Cette montée en intensité est exactement ce dont parlait l'étude de 1997.",
    ] },

    { type: "quote", text: "Le chemin le plus court pour connaître quelqu'un est une question à laquelle vous devez répondre tous les deux. Ce n'est pas une découverte — c'est simplement ce qu'est une conversation." },

    { type: "h2", text: "La version honnête", accent: "green" },
    { type: "p", text: "Le matching par questions n'est pas une voie démontrée vers une relation, et cet article ne fera pas semblant du contraire. Ce que la recherche soutient est plus modeste et vaut quand même la peine : poser des questions et y répondre à tour de rôle, c'est ainsi que des inconnus commencent à s'apprécier — Aron et ses collègues en 1997, Sprecher et ses collègues en 2013, Huang et ses collègues en 2017 pointent tous dans la même direction. Une photo ne fait pas cela. La seule vraie revendication de Qulo est une revendication de conception : faire de l'échange la porte d'entrée plutôt qu'un supplément, et vous laisser décider de ce que signifient les réponses." },
  ],
  es: [
    { type: "h2", text: "Qué mostró realmente el estudio de las 36 preguntas de Aron" },
    { type: "p", text: "En 1997, Arthur Aron, Edward Melinat, Elaine Aron, Robert Vallone y Renee Bator publicaron en **Personality and Social Psychology Bulletin** un procedimiento que desde entonces se ha citado, se ha citado mal y se ha convertido en lista de internet. Dos desconocidos se sentaban juntos y recorrían tres series de preguntas cada vez más personales, respondiendo por turnos a todas ellas. La sesión duraba unos **45 minutos**. Después, esas parejas decían sentirse mucho más cerca la una de la otra que quienes habían pasado los mismos 45 minutos charlando de cosas sin importancia." },
    { type: "p", text: "Conviene ser precisos sobre lo que ese estudio mostró y lo que no, porque la versión popular se ha alejado bastante del artículo. Mostró que **la autorrevelación mutua y creciente** —los dos responden, cada respuesta un poco más personal que la anterior— genera cercanía entre desconocidos, y que puede ocurrir sorprendentemente rápido. No mostró que nadie se enamore en unos minutos, y nunca fue un algoritmo de emparejamiento: a nadie se le emparejó por sus respuestas, y las preguntas no eran un test de compatibilidad. **Mutua** es la palabra que sostiene todo el hallazgo." },
    { type: "p", text: "Esa es la verdadera razón por la que las preguntas resultan interesantes para las citas, y es más estrecha que la que suele dar internet. Lo que la investigación respalda es que preguntar y responder es la forma en que dos desconocidos empiezan a caerse bien. Si la persona que te cae bien será una buena pareja es otra pregunta, y ningún conjunto de preguntas la responde. Lo que Qulo toma de aquí es el orden, no una predicción: primero el intercambio, después la cara." },

    { type: "h2", text: "El trabajo lo hace la reciprocidad" },
    { type: "p", text: "Sprecher, Treger, Wondra, Hilaire y Wallpe probaron exactamente esto en 2013 en el **Journal of Experimental Social Psychology**. Parejas de desconocidos se abrían por turnos —los dos preguntaban, los dos respondían— o repartían los papeles: uno hablaba y el otro escuchaba, y luego cambiaban. Turnarse produjo más simpatía y más cercanía. Entre las mismas dos personas circulaba la misma cantidad de información; lo único que cambiaba era la forma del intercambio." },
    { type: "p", text: "Huang, Yeomans, Brooks, Minson y Gino encontraron la versión directamente relevante para las citas en septiembre de 2017, en el **Journal of Personality and Social Psychology**. En **110** participantes de speed dating y **1.961** decisiones de segunda cita, quienes hacían más preguntas —sobre todo **preguntas de seguimiento**, las que demuestran que has escuchado la respuesta anterior— tenían más probabilidades de ser invitados de nuevo. No los más atractivos, no los más ingeniosos. Los que preguntaban." },
    { type: "p", text: "Una foto y dos líneas de biografía no pueden hacer nada de eso. Van en una sola dirección, no te piden nada y no dejan nada a lo que responder. Una pregunta es el objeto más pequeño que obliga a las dos personas a poner algo sobre la mesa." },

    { type: "h2", text: "Teoría del apego: un marco, no un veredicto" },
    { type: "p", text: "La teoría del apego de John Bowlby es el vocabulario estándar para describir cómo se comportan las personas en las relaciones cercanas —seguro, ansioso, evitativo— y es un marco real, que merece nombrarse como tal. Vale la pena decir también lo que no es. Bowlby escribía sobre niños y cuidadores décadas antes de que nadie deslizara nada, y nadie ha demostrado que una app de citas mueva el estilo de apego de un adulto en un sentido o en otro. Quien te diga que una app puede arreglar o arruinar tu manera de vincularte te está vendiendo algo." },
    { type: "p", text: "Lo que el diseño de una app sí puede cambiar es más estrecho y más prosaico: qué significa un no. Cuando el emparejamiento va por fotos, no hacer match se lee como un veredicto sobre tu cara, porque tu cara era todo lo que había. Cuando va por las preguntas de la otra persona, fallar se lee como fallar: no acertaste las respuestas. Es una diferencia de encuadre, no una promesa terapéutica, y el encuadre es su tamaño honesto." },

    { type: "h2", text: "Compatibilidad cognitiva y el triángulo de Sternberg" },
    { type: "p", text: "La compatibilidad cognitiva es una idea sencilla con abrigo académico: dos personas cuyo pensamiento discurre por caminos parecidos, en cómo abordan un problema, en qué dan por obvio, en de qué se ríen. Las preguntas la sacan a la luz pronto, porque cómo alguien formula una pregunta dice tanto como la respuesta. Lo que nadie ha demostrado, y este artículo no va a afirmar, es que acertar las preguntas de un desconocido prediga una relación. Predice que prestaste atención." },
    { type: "p", text: "La teoría triangular del amor de Robert Sternberg sirve aquí como descripción, no como prueba. Divide el amor duradero en tres componentes: intimidad, pasión y compromiso. Una foto le habla como mucho a un vértice de ese triángulo, y le habla antes de que sepas nada más. Los otros dos vértices se construyen en la conversación, si es que se construyen. Es una manera de pensar qué deja fuera una primera impresión hecha de fotos: no es una medición, y ninguna cifra le pertenece." },

    { type: "h2", text: "Por qué una foto dice menos de lo que parece" },
    { type: "p", text: "Nada de esto vuelve irrelevante la atracción. Vuelve la foto un mal recipiente para ella. Cuatro problemas conocidos, ninguno de los cuales necesita una estadística para verse:" },
    { type: "ul", items: [
      "**El efecto halo:** damos por hecho, sin decirlo, que alguien que nos parece atractivo también es más amable, más divertido y más competente. Es uno de los sesgos más antiguos documentados en psicología social, y se equivoca más o menos tantas veces como acierta.",
      "**Una foto está elegida:** es la mejor de unos cientos, con buena luz, en el ángulo que funciona, un día que salió bien. Honesta sobre una cara y poco fiable sobre todo lo demás.",
      "**El aspecto deja de ser información nueva:** casi todo lo que una cara tiene que decir está en la primera impresión; después se repite. Cómo es hablar con alguien no se agota así.",
      "**Una foto no puede responder:** nada de lo que aprendes en ella llegó como respuesta a algo que tú ofreciste, que es justo la reciprocidad que señalan los estudios de arriba.",
    ] },
    { type: "p", text: "Eso es un límite de lo que el emparejamiento por fotos puede contarte. No es una prueba de que las preguntas predigan con quién deberías estar. Solo de que una foto nunca iba a hacerlo, y de que un intercambio te deja algo en la mano que una cara no da." },

    { type: "h2", text: "Qué hace Qulo realmente con esto", accent: "green" },
    { type: "p", text: "Qulo no afirma tener un emparejamiento validado científicamente, porque en las citas eso no existe. Lo que hace es poner el intercambio primero, de forma mecánica, para que no pueda saltarse:" },
    { type: "ul", items: [
      "**Escribes de 2 a 4 preguntas sobre ti** —de opción múltiple, cuatro opciones cada una— y marcas la que es cierta en tu caso. Con un plan de pago el límite sube a 10 preguntas.",
      "**Alguien hace match acertándolas todas.** Una sola respuesta mal significa que no hay match: nadie llega pulsando al azar.",
      "**Las preguntas van antes que la cara,** lo que invierte el orden habitual de una primera impresión.",
      "**Resolver exige atención.** El esfuerzo garantiza poco, pero es una prueba real de que la otra persona leyó lo que escribiste.",
      "**Los poderes opcionales —una pista, reducir las opciones a la mitad, saltar una pregunta— cuestan diamantes dentro de la app y nunca son necesarios para hacer match.** Cada pregunta se puede resolver sin gastar nada.",
    ] },

    { type: "h2", text: "Cómo escribir preguntas que merezcan respuesta" },
    { type: "p", text: "Como tu respuesta tiene que poder encontrarse, escribir buenas preguntas es una habilidad propia. Los trabajos de arriba indican hacia dónde apuntar: lo bastante personal como para que valga la pena compartirlo, y al alcance de quien presta atención en lugar de adivinar." },
    { type: "ul", items: [
      "**Sé concreto sobre ti:** «la ciudad a la que me mudaría mañana» le gana a «mi ciudad favorita». Una es un hecho sobre ti; la otra es conversación de ascensor.",
      "**Que se pueda encontrar, no adivinar:** la respuesta correcta debería salir de tu perfil, tus fotos y un poco de reflexión. Una pregunta que solo tu hermana podría acertar no es un filtro, es un muro.",
      "**Evita las opciones decorativas:** cuatro opciones plausibles con una verdadera son una pregunta. Una verdadera y tres bromas son un trámite.",
      "**Pregunta por decisiones, no por datos:** qué harías, a qué renunciarías, adónde irías. Las decisiones muestran a una persona; los datos sobre ella casi nunca.",
      "**Varía la profundidad:** empieza con algo ligero y coloca la que de verdad te importa en tercer o cuarto lugar. Esa escalada es justo de lo que iba el estudio de 1997.",
    ] },

    { type: "quote", text: "El camino más corto para conocer a alguien es una pregunta que los dos tienen que responder. No es un descubrimiento: es sencillamente lo que es una conversación." },

    { type: "h2", text: "La versión honesta", accent: "green" },
    { type: "p", text: "El emparejamiento por preguntas no es una vía demostrada hacia una relación, y este artículo no va a fingir lo contrario. Lo que la investigación respalda es más pequeño y aun así vale la pena: preguntar y responder por turnos es la forma en que los desconocidos empiezan a caerse bien —Aron y sus colegas en 1997, Sprecher y sus colegas en 2013, Huang y sus colegas en 2017 apuntan en la misma dirección—. Una foto no hace eso. La única afirmación real de Qulo es de diseño: convierte el intercambio en la puerta de entrada en vez de en un añadido, y te deja a ti decidir qué significan las respuestas." },
  ],
  ar: [
    { type: "h2", text: "ماذا أظهرت فعلًا دراسة آرون ذات الـ36 سؤالًا؟" },
    { type: "p", text: "في عام 1997 نشر آرثر آرون وإدوارد ميلينات وإيلين آرون وروبرت فالون ورينيه باتور في **Personality and Social Psychology Bulletin** إجراءً ظلّ منذ ذلك الحين يُقتبس ويُساء اقتباسه ويتحوّل إلى قوائم على الإنترنت. كان غريبان يجلسان معًا ويمرّان على ثلاث مجموعات من الأسئلة تزداد خصوصية شيئًا فشيئًا، ويجيب كلٌّ منهما بالتناوب عن كل سؤال. استغرقت الجلسة نحو **45 دقيقة**. وبعدها قال هؤلاء إنهم يشعرون بقرب أكبر بكثير مما شعر به غرباء أمضوا الـ45 دقيقة نفسها في حديث عابر." },
    { type: "p", text: "من المفيد أن نكون دقيقين في ما أظهرته تلك الدراسة وما لم تُظهره، لأن النسخة الشائعة ابتعدت كثيرًا عن البحث نفسه. أظهرت الدراسة أن **البوح المتبادل المتصاعد** — أن يجيب الطرفان، وأن يكون كل جواب أكثر خصوصية من سابقه — يولّد قربًا بين الغرباء، وأن ذلك قد يحدث بسرعة مدهشة. لكنها لم تُظهر أن أحدًا يقع في الحب خلال دقائق، ولم تكن يومًا خوارزمية مطابقة: لم يُقرن أحد بأحد بناءً على إجاباته، ولم تكن الأسئلة اختبار توافق. والكلمة التي تحمل النتيجة كلها هي **المتبادل**." },
    { type: "p", text: "هذا هو السبب الحقيقي لأهمية الأسئلة في التعارف، وهو سبب أضيق مما يقوله الإنترنت عادة. ما تسنده الأبحاث هو أن السؤال والجواب هما الطريقة التي يبدأ بها غريبان في الإعجاب ببعضهما. أما إن كان من أعجبك سيصير شريكًا جيدًا فهذا سؤال آخر لا تجيب عنه أي مجموعة أسئلة. ما تأخذه Qulo من هذا هو الترتيب لا التنبؤ: التبادل أولًا، والوجه بعده." },

    { type: "h2", text: "الجزء الذي يقوم بالعمل هو التبادل" },
    { type: "p", text: "اختبر سبريتشر وتريغر وووندرا وهيلير ووالب هذا بالضبط عام 2013 في **Journal of Experimental Social Psychology**. كان الغرباء إمّا يبوحون بالتناوب — يسأل الاثنان ويجيب الاثنان — أو يقتسمون الأدوار: يتحدث أحدهما ويستمع الآخر ثم يتبادلان. التناوب أنتج إعجابًا أكبر وقربًا أكبر. المقدار نفسه من المعلومات انتقل بين الشخصين نفسيهما؛ والشيء الوحيد الذي تغيّر هو شكل التبادل." },
    { type: "p", text: "ووجد هوانغ ويومانز وبروكس ومينسون وجينو النسخة الأوثق صلة بالتعارف في سبتمبر 2017 في **Journal of Personality and Social Psychology**. فعبر **110** مشاركين في التعارف السريع و**1,961** قرار موعد ثانٍ، كان من طرحوا أسئلة أكثر — وخصوصًا **أسئلة المتابعة**، تلك التي تُظهر أنك سمعت الجواب السابق فعلًا — أوفر حظًا في تلقّي دعوة ثانية. لا الأكثر جاذبية ولا الأكثر ظرفًا. بل من سألوا." },
    { type: "p", text: "لا تستطيع صورة وسطران من نبذة تعريفية أن تفعل شيئًا من هذا. إنها تسير في اتجاه واحد، ولا تطلب منك شيئًا، ولا تترك ما يمكن الردّ عليه. السؤال هو أصغر شيء يدفع الطرفين معًا إلى وضع شيء على الطاولة." },

    { type: "h2", text: "نظرية التعلّق: إطار، لا حكم" },
    { type: "p", text: "نظرية التعلّق عند جون بولبي هي المفردات المعتادة لوصف سلوك الناس في العلاقات القريبة — آمن، قلِق، متجنّب — وهي إطار حقيقي يستحق أن يُسمّى. ومن المفيد بالقدر نفسه قول ما ليست هي. كان بولبي يكتب عن الأطفال ومقدّمي الرعاية قبل عقود من أن يمرّر أحد إصبعه على شاشة، ولم يُظهر أحد أن تطبيق تعارف يحرّك نمط تعلّق شخص بالغ في هذا الاتجاه أو ذاك. ومن يقول لك إن تطبيقًا قادر على إصلاح طريقتك في التعلّق أو إفسادها فهو يبيعك شيئًا." },
    { type: "p", text: "ما يمكن لتصميم التطبيق أن يغيّره أضيق وأكثر بساطة: معنى الرفض. حين تجري المطابقة عبر الصور، يُقرأ غياب التطابق كحكم على وجهك، لأن وجهك كان كل المعروض. وحين تجري عبر أسئلة الطرف الآخر، يُقرأ الإخفاق إخفاقًا: لم تُصب الإجابات. هذا فارق في التأطير لا وعد علاجي — والتأطير هو حجمه الصادق." },

    { type: "h2", text: "التوافق المعرفي ومثلث ستيرنبرغ" },
    { type: "p", text: "التوافق المعرفي فكرة بسيطة ترتدي معطفًا أكاديميًا: شخصان يسير تفكيرهما في مسارات متقاربة — كيف يقاربان مشكلة، وما الذي يعدّانه بديهيًا، وما الذي يضحكهما. والأسئلة تُظهر ذلك مبكرًا، لأن طريقة صياغة السؤال تقول عن صاحبها بقدر ما يقوله الجواب. أما ما لم يُظهره أحد، وما لن يدّعيه هذا المقال، فهو أن إصابة أسئلة شخص غريب تتنبأ بعلاقة. إنها تتنبأ بأنك انتبهت." },
    { type: "p", text: "ونظرية روبرت ستيرنبرغ المثلثية في الحب مفيدة هنا كوصف لا كدليل. فهي تقسّم الحب الدائم إلى ثلاثة مكوّنات: الألفة والشغف والالتزام. والصورة تخاطب زاوية واحدة من هذا المثلث في أحسن الأحوال، وتخاطبها قبل أن تعرف أي شيء آخر. أما الزاويتان الأخريان فتُبنيان في الحديث، إن بُنيتا أصلًا. هذه طريقة للتفكير في ما يُسقطه الانطباع الأول القائم على الصورة — لا قياس، ولا رقم يخصّها." },

    { type: "h2", text: "لماذا تقول الصورة أقل مما تبدو؟" },
    { type: "p", text: "لا شيء من هذا يجعل الانجذاب بلا أهمية. إنه فقط يجعل الصورة وعاءً رديئًا له. أربع مشكلات مألوفة، لا تحتاج أي منها إلى إحصاء لتكون واضحة:" },
    { type: "ul", items: [
      "**أثر الهالة:** نفترض بصمت أن من نجده جذابًا هو أيضًا ألطف وأطرف وأكفأ. وهذا من أقدم التحيّزات الموثّقة في علم النفس الاجتماعي، ويخطئ تقريبًا بقدر ما يصيب.",
      "**الصورة مُنتقاة:** هي الأفضل بين بضع مئات، في ضوء جيد، ومن الزاوية التي تنجح، في يوم سار على ما يرام. صادقة عن وجه، وغير موثوقة عن كل ما عداه.",
      "**المظهر يتوقف عن كونه معلومة جديدة:** معظم ما يقوله الوجه موجود في الانطباع الأول، وما بعده تكرار. أما كيف يكون الحديث مع شخص فلا ينفد هكذا.",
      "**الصورة لا تستطيع الإجابة:** لا شيء تتعلّمه منها جاء ردًّا على شيء قدّمته أنت — وهذا بالضبط التبادل الذي تشير إليه الدراسات أعلاه.",
    ] },
    { type: "p", text: "هذا حدّ لما تستطيع المطابقة القائمة على الصور أن تخبرك به. وليس دليلًا على أن الأسئلة تتنبأ بمن ينبغي أن تكون معه. بل فقط على أن الصورة لم تكن ستفعل ذلك أصلًا، وأن التبادل يترك في يدك شيئًا لا يمنحه وجه." },

    { type: "h2", text: "ماذا تفعل Qulo بهذا فعليًا؟", accent: "green" },
    { type: "p", text: "لا تدّعي Qulo أنها تدير مطابقة موثّقة علميًا، لأن هذا الشيء غير موجود في التعارف. ما تفعله هو تقديم التبادل ميكانيكيًا إلى المقدّمة، بحيث لا يمكن تخطّيه:" },
    { type: "ul", items: [
      "**تكتب من سؤالين إلى أربعة أسئلة عن نفسك** — اختيار من متعدد، بأربعة خيارات لكل سؤال — وتحدّد الخيار الصحيح بالنسبة إليك. وفي الخطة المدفوعة يرتفع الحد إلى عشرة أسئلة.",
      "**يحدث التطابق فقط بإصابتها كلها.** إجابة خاطئة واحدة تعني ألا تطابق؛ فلا أحد يصل بمجرد النقر العشوائي.",
      "**الأسئلة تأتي قبل الوجه،** وهذا يقلب الترتيب المعتاد للانطباع الأول.",
      "**الحل يتطلب انتباهًا.** الجهد ضمانة ضعيفة لأي شيء، لكنه دليل حقيقي على أن الطرف الآخر قرأ ما كتبته.",
      "**القدرات الاختيارية — تلميح، أو تنصيف الخيارات، أو تخطّي سؤال — تكلّف ألماسًا داخل التطبيق ولا تُشترط أبدًا للتطابق.** كل سؤال قابل للحل دون إنفاق أي شيء.",
    ] },

    { type: "h2", text: "كيف تكتب أسئلة تستحق الإجابة؟" },
    { type: "p", text: "لأن إجابتك يجب أن تكون قابلة للاكتشاف، فإن كتابة أسئلة جيدة مهارة قائمة بذاتها. والأعمال المذكورة أعلاه تشير إلى الهدف: شخصية بما يكفي ليستحق الأمر البوح بها، وفي متناول من ينتبه لا من يخمّن." },
    { type: "ul", items: [
      "**كن محددًا عن نفسك:** «المدينة التي سأنتقل إليها غدًا» أفضل من «مدينتي المفضلة». الأولى واقعة تخصّك، والثانية حديث مجاملة.",
      "**اجعلها قابلة للاكتشاف لا للتنجيم:** ينبغي أن يكون الجواب الصحيح متاحًا من ملفك وصورك وقليل من التفكير. سؤال لا تعرف جوابه إلا أختك ليس مرشّحًا، بل جدار.",
      "**تجنّب الخيارات الزخرفية:** أربعة خيارات معقولة أحدها صحيح تصنع سؤالًا. خيار صحيح وثلاث نكات تصنع شكليّة.",
      "**اسأل عن الاختيارات لا عن المعلومات:** ماذا كنت ستفعل، وعمّ كنت ستتنازل، وإلى أين كنت ستذهب. الاختيارات تُظهر الإنسان؛ أما المعلومات عنه فنادرًا.",
      "**نوّع العمق:** ابدأ بسؤال خفيف، وضع السؤال الذي يهمّك فعلًا في المرتبة الثالثة أو الرابعة. هذا التصاعد هو ما كانت دراسة 1997 تدور حوله حقًا.",
    ] },

    { type: "quote", text: "أقصر طريق إلى معرفة إنسان هو سؤال عليكما أن تجيبا عنه معًا. وهذا ليس اكتشافًا — هذا ببساطة ما يعنيه الحديث." },

    { type: "h2", text: "النسخة الصادقة", accent: "green" },
    { type: "p", text: "المطابقة القائمة على الأسئلة ليست طريقًا مثبتًا إلى علاقة، ولن يتظاهر هذا المقال بغير ذلك. ما تسنده الأبحاث أصغر ويستحق البناء عليه رغم ذلك: أن تسأل وأن تجيب بالتناوب هو الطريقة التي يبدأ بها الغرباء في الإعجاب ببعضهم — آرون وزملاؤه عام 1997، وسبريتشر وزملاؤه عام 2013، وهوانغ وزملاؤه عام 2017 يشيرون جميعًا إلى الاتجاه نفسه. والصورة ليست ذلك. وادّعاء Qulo الوحيد الحقيقي ادّعاء تصميمي: تجعل التبادل باب الدخول بدل أن يكون فكرة لاحقة، وتترك لك أن تقرّر ماذا تعني الإجابات." },
  ],
  ru: [
    { type: "h2", text: "Что на самом деле показало исследование Арона с 36 вопросами" },
    { type: "p", text: "В 1997 году Артур Арон, Эдвард Мелинат, Элейн Арон, Роберт Валлоне и Рене Батор опубликовали в **Personality and Social Psychology Bulletin** процедуру, которую с тех пор цитируют, перевирают и превращают в списки для соцсетей. Двое незнакомых людей садились друг напротив друга и проходили три набора вопросов, которые становились всё более личными, отвечая на каждый по очереди. Сессия длилась около **45 минут**. После неё пары сообщали, что чувствуют себя заметно ближе друг к другу, чем незнакомцы, потратившие те же 45 минут на светскую болтовню." },
    { type: "p", text: "Стоит быть точным в том, что это исследование показало, а что нет: популярная версия ушла далеко от самой работы. Оно показало, что **нарастающее взаимное самораскрытие** — отвечают оба, и каждый ответ чуть личнее предыдущего — создаёт близость между незнакомцами, и происходит это удивительно быстро. Оно не показало, что кто-то влюбляется за несколько минут, и никогда не было алгоритмом подбора: никого не сводили по ответам, и вопросы не были тестом на совместимость. Слово, которое держит весь результат, — **взаимное**." },
    { type: "p", text: "Вот настоящая причина, почему вопросы интересны для знакомств, и она уже, чем обычно рассказывает интернет. Исследования подтверждают одно: спрашивать и отвечать — это то, как двое незнакомых людей начинают нравиться друг другу. А окажется ли человек, который вам понравился, хорошим партнёром, — отдельный вопрос, и на него не отвечает ни один набор вопросов. Qulo берёт отсюда порядок, а не прогноз: сначала обмен, потом лицо." },

    { type: "h2", text: "Работу делает взаимность" },
    { type: "p", text: "Спрехер, Трегер, Вондра, Хилер и Уолпи проверили именно это в 2013 году в **Journal of Experimental Social Psychology**. Пары незнакомцев либо раскрывались по очереди — оба спрашивали и оба отвечали, — либо делили роли: один рассказывал, другой слушал, потом менялись. Очерёдность дала больше симпатии и больше близости. Между теми же двумя людьми проходил тот же объём информации; менялась только форма обмена." },
    { type: "p", text: "Хуанг, Йоманс, Брукс, Минсон и Джино нашли прямо относящуюся к знакомствам версию этого в сентябре 2017 года в **Journal of Personality and Social Psychology**. На **110** участниках спид-дейтинга и **1 961** решении о втором свидании те, кто задавал больше вопросов — прежде всего **уточняющих**, тех, что показывают: предыдущий ответ вы действительно услышали, — чаще получали приглашение снова. Не самые привлекательные и не самые остроумные. Те, кто спрашивал." },
    { type: "p", text: "Фотография и две строки описания ничего этого не умеют. Они идут в одну сторону, ничего у вас не просят и не оставляют того, на что можно ответить. Вопрос — самый маленький предмет, который заставляет обоих что-то выложить на стол." },

    { type: "h2", text: "Теория привязанности: рамка, а не приговор" },
    { type: "p", text: "Теория привязанности Джона Боулби — стандартный словарь для описания того, как люди ведут себя в близких отношениях: надёжный, тревожный, избегающий тип. Это настоящая рамка, и её стоит называть по имени. Не менее важно сказать, чем она не является. Боулби писал о детях и о тех, кто о них заботится, за десятилетия до того, как кто-то начал листать анкеты, и никто не показал, что приложение для знакомств сдвигает стиль привязанности взрослого человека в ту или иную сторону. Тот, кто обещает, что приложение починит или испортит вашу привязанность, что-то вам продаёт." },
    { type: "p", text: "Что дизайн приложения действительно может изменить — вещь более узкая и будничная: значение отказа. Когда подбор идёт по фотографиям, отсутствие взаимности читается как приговор вашему лицу, потому что лицо и было всем, что предлагалось. Когда подбор идёт через вопросы другого человека, промах читается как промах: вы не угадали ответы. Это разница в рамке, а не терапевтическое обещание, — и рамка и есть честный размер этого." },

    { type: "h2", text: "Когнитивная совместимость и треугольник Стернберга" },
    { type: "p", text: "Когнитивная совместимость — простая идея в академическом пальто: два человека, чьё мышление идёт похожими путями — как они подходят к задаче, что считают очевидным, над чем смеются. Вопросы проявляют это рано, потому что то, как человек формулирует вопрос, говорит не меньше самого ответа. Чего никто не показал и чего эта статья утверждать не станет: правильные ответы на вопросы незнакомца не предсказывают отношений. Они предсказывают, что вы были внимательны." },
    { type: "p", text: "Треугольная теория любви Роберта Стернберга полезна здесь как описание, а не как доказательство. Она делит длительную любовь на три составляющие: близость, страсть и обязательство. Фотография обращается в лучшем случае к одному углу этого треугольника — и обращается до того, как вы узнали что-либо ещё. Два других угла строятся в разговоре, если строятся вообще. Это способ подумать о том, что упускает первое впечатление, построенное на фотографии, — не измерение, и никакой цифры за ним нет." },

    { type: "h2", text: "Почему фотография говорит меньше, чем кажется" },
    { type: "p", text: "Ничто из этого не делает влечение неважным. Оно делает фотографию плохим сосудом для него. Четыре знакомые проблемы, ни одной из которых не нужна статистика, чтобы быть очевидной:" },
    { type: "ul", items: [
      "**Эффект ореола:** мы молча допускаем, что человек, который кажется нам привлекательным, ещё и добрее, остроумнее и компетентнее. Это одно из самых давно описанных искажений в социальной психологии, и ошибается оно примерно так же часто, как оказывается право.",
      "**Фотография выбрана:** лучшая из пары сотен, при хорошем свете, с работающего ракурса, в удачный день. Честная про лицо и ненадёжная про всё остальное.",
      "**Внешность перестаёт быть новой информацией:** почти всё, что лицо может сказать, содержится в первом впечатлении, дальше идёт повтор. А то, каково с человеком разговаривать, так не заканчивается.",
      "**Фотография не может ответить:** ничто из того, что вы из неё узнаёте, не пришло в ответ на то, что предложили вы, — а это ровно та взаимность, на которую указывают исследования выше.",
    ] },
    { type: "p", text: "Это предел того, что подбор по фотографиям может вам сообщить. Это не доказательство, что вопросы предсказывают, с кем вам быть. Только то, что фотография этого и не могла, а обмен оставляет в руках то, чего лицо не даёт." },

    { type: "h2", text: "Что Qulo с этим на самом деле делает", accent: "green" },
    { type: "p", text: "Qulo не утверждает, что у неё научно подтверждённый подбор: в знакомствах такого не существует. Она делает другое — механически ставит обмен первым, так что его нельзя пропустить:" },
    { type: "ul", items: [
      "**Вы пишете от 2 до 4 вопросов о себе** — с выбором из четырёх вариантов — и отмечаете тот вариант, который верен для вас. На платном тарифе предел поднимается до 10 вопросов.",
      "**Совпадение случается, только если человек ответил верно на все.** Один неверный ответ — совпадения нет, так что случайным тыканьем сюда не попасть.",
      "**Вопросы идут раньше лица,** и это переворачивает привычный порядок первого впечатления.",
      "**Решать — значит быть внимательным.** Усилие мало что гарантирует, но это реальное свидетельство того, что человек прочитал написанное вами.",
      "**Необязательные силы — подсказка, сокращение вариантов вдвое, пропуск вопроса — стоят внутриигровых алмазов и никогда не требуются для совпадения.** Любой вопрос решается, ничего не потратив.",
    ] },

    { type: "h2", text: "Как писать вопросы, на которые стоит отвечать" },
    { type: "p", text: "Поскольку ваш ответ должен быть находимым, писать хорошие вопросы — отдельное умение. Работы выше подсказывают цель: достаточно личное, чтобы этим стоило поделиться, и доступное тому, кто внимателен, а не тому, кто угадывает." },
    { type: "ul", items: [
      "**Будьте конкретны о себе:** «город, в который я перееду завтра» лучше, чем «мой любимый город». Первое — факт о вас, второе — светская беседа.",
      "**Находимое, а не телепатия:** правильный ответ должен выводиться из вашего профиля, ваших фотографий и небольшого размышления. Вопрос, ответ на который знает только ваша сестра, — не фильтр, а стена.",
      "**Избегайте декоративных вариантов:** четыре правдоподобных варианта, один из которых верен, — это вопрос. Один верный и три шутки — формальность.",
      "**Спрашивайте о выборе, а не о мелочах:** что бы вы сделали, от чего отказались, куда поехали. Выбор показывает человека; факты о нём — почти никогда.",
      "**Меняйте глубину:** начните с лёгкого, а тот вопрос, который вам действительно важен, поставьте третьим или четвёртым. Именно об этом нарастании и было исследование 1997 года.",
    ] },

    { type: "quote", text: "Самый короткий путь узнать человека — вопрос, на который придётся ответить вам обоим. Это не открытие — это просто то, чем является разговор." },

    { type: "h2", text: "Честная версия", accent: "green" },
    { type: "p", text: "Подбор по вопросам — не доказанный путь к отношениям, и эта статья не будет делать вид, будто он им является. То, что подтверждает наука, скромнее и всё равно стоит того, чтобы на этом строить: задавать вопросы и отвечать на них по очереди — это то, как незнакомцы начинают нравиться друг другу; Арон с коллегами в 1997-м, Спрехер с коллегами в 2013-м и Хуанг с коллегами в 2017-м указывают в одну сторону. Фотография этого не делает. Единственное настоящее утверждение Qulo — про дизайн: обмен становится входной дверью, а не дополнением, и решать, что означают ответы, остаётся вам." },
  ],
  pt: [
    { type: "h2", text: "O que o estudo das 36 perguntas de Aron mostrou de fato" },
    { type: "p", text: "Em 1997, Arthur Aron, Edward Melinat, Elaine Aron, Robert Vallone e Renee Bator publicaram na **Personality and Social Psychology Bulletin** um procedimento que desde então vem sendo citado, mal citado e transformado em lista de internet. Dois desconhecidos sentavam-se juntos e percorriam três conjuntos de perguntas cada vez mais pessoais, respondendo a todas elas alternadamente. A sessão durava cerca de **45 minutos**. Depois, essas duplas relatavam sentir-se bem mais próximas uma da outra do que desconhecidos que haviam passado os mesmos 45 minutos em conversa fiada." },
    { type: "p", text: "Vale ser preciso sobre o que esse estudo mostrou e o que não mostrou, porque a versão popular se afastou muito do artigo. Ele mostrou que **a autorrevelação mútua e crescente** — os dois respondendo, cada resposta um pouco mais pessoal do que a anterior — gera proximidade entre desconhecidos, e que isso pode acontecer surpreendentemente rápido. Não mostrou que alguém se apaixona em poucos minutos, e nunca foi um algoritmo de matching: ninguém foi pareado pelas respostas, e as perguntas não eram um teste de compatibilidade. **Mútua** é a palavra que sustenta o achado inteiro." },
    { type: "p", text: "Essa é a razão real pela qual perguntas interessam no namoro, e ela é mais estreita do que a internet costuma vender. O que a pesquisa sustenta é que perguntar e responder é como dois desconhecidos começam a gostar um do outro. Se a pessoa de quem você gostou dará um bom par é outra pergunta, e nenhum conjunto de perguntas responde a ela. O que a Qulo tira daqui é a ordem, não uma previsão: primeiro a troca, o rosto depois." },

    { type: "h2", text: "Quem faz o trabalho é a reciprocidade" },
    { type: "p", text: "Sprecher, Treger, Wondra, Hilaire e Wallpe testaram exatamente isso em 2013 no **Journal of Experimental Social Psychology**. Duplas de desconhecidos se abriam alternadamente — os dois perguntando, os dois respondendo — ou dividiam os papéis: um falava, o outro ouvia, e depois trocavam. Revezar produziu mais simpatia e mais proximidade. Entre as mesmas duas pessoas circulou a mesma quantidade de informação; só mudou o formato da troca." },
    { type: "p", text: "Huang, Yeomans, Brooks, Minson e Gino encontraram a versão diretamente relevante para o namoro em setembro de 2017, no **Journal of Personality and Social Psychology**. Em **110** participantes de speed dating e **1.961** decisões de segundo encontro, quem fazia mais perguntas — sobretudo **perguntas de acompanhamento**, aquelas que mostram que você realmente ouviu a resposta anterior — tinha mais chance de ser chamado de novo. Não os mais atraentes, não os mais espirituosos. Os que perguntavam." },
    { type: "p", text: "Uma foto e duas linhas de descrição não fazem nada disso. Vão em uma direção só, não pedem nada de você e não deixam a que responder. A pergunta é o menor objeto que obriga as duas pessoas a colocar algo na mesa." },

    { type: "h2", text: "Teoria do apego: um quadro, não um veredito" },
    { type: "p", text: "A teoria do apego de John Bowlby é o vocabulário padrão para descrever como as pessoas se comportam em relações próximas — seguro, ansioso, evitativo — e é um quadro real, que merece ser nomeado como tal. Vale igualmente dizer o que ela não é. Bowlby escrevia sobre crianças e cuidadores décadas antes de alguém deslizar o dedo em qualquer tela, e ninguém mostrou que um app de namoro desloca o estilo de apego de um adulto para um lado ou para o outro. Quem lhe disser que um app pode consertar ou estragar o seu jeito de se apegar está lhe vendendo alguma coisa." },
    { type: "p", text: "O que o design de um app pode mudar é mais estreito e mais banal: o que significa um não. Quando o matching corre por fotos, não dar match se lê como um veredito sobre o seu rosto, porque o seu rosto era tudo o que estava em oferta. Quando corre pelas perguntas da outra pessoa, errar se lê como errar: você não acertou as respostas. É uma diferença de enquadramento, não uma promessa terapêutica — e o enquadramento é o tamanho honesto disso." },

    { type: "h2", text: "Compatibilidade cognitiva e o triângulo de Sternberg" },
    { type: "p", text: "Compatibilidade cognitiva é uma ideia simples de casaco acadêmico: duas pessoas cujo pensamento corre por linhas parecidas — como abordam um problema, o que tomam por óbvio, do que riem. As perguntas trazem isso à tona cedo, porque o modo como alguém formula uma pergunta diz tanto quanto a resposta. O que ninguém mostrou, e o que este artigo não vai afirmar, é que acertar as perguntas de um desconhecido preveja um relacionamento. Prevê que você prestou atenção." },
    { type: "p", text: "A teoria triangular do amor de Robert Sternberg serve aqui como descrição, não como prova. Ela divide o amor duradouro em três componentes: intimidade, paixão e compromisso. Uma foto fala, no máximo, a um vértice desse triângulo, e fala antes que você saiba qualquer outra coisa. Os outros dois vértices se constroem na conversa, se é que se constroem. É um jeito de pensar o que uma primeira impressão feita de fotos deixa de fora — não é uma medição, e nenhum número pertence a ela." },

    { type: "h2", text: "Por que uma foto diz menos do que parece" },
    { type: "p", text: "Nada disso torna a atração irrelevante. Torna a foto um recipiente ruim para ela. Quatro problemas conhecidos, e nenhum deles precisa de estatística para ficar evidente:" },
    { type: "ul", items: [
      "**O efeito halo:** presumimos calados que alguém que achamos atraente também é mais gentil, mais engraçado e mais competente. É um dos vieses mais antigos documentados na psicologia social, e erra mais ou menos tantas vezes quanto acerta.",
      "**Uma foto é escolhida:** é a melhor entre algumas centenas, com boa luz, no ângulo que funciona, num dia que deu certo. Honesta sobre um rosto e pouco confiável sobre todo o resto.",
      "**A aparência deixa de ser informação nova:** quase tudo o que um rosto tem a dizer está na primeira impressão; depois disso, repete. Como é conversar com alguém não se esgota assim.",
      "**Uma foto não pode responder:** nada do que você aprende nela veio como resposta a algo que você ofereceu — que é exatamente a reciprocidade apontada pelos estudos acima.",
    ] },
    { type: "p", text: "Isso é um limite do que o matching por foto pode lhe contar. Não é prova de que perguntas prevejam com quem você deveria estar. Só de que uma foto nunca iria fazer isso, e de que uma troca deixa na sua mão algo que um rosto não dá." },

    { type: "h2", text: "O que a Qulo realmente faz com isso", accent: "green" },
    { type: "p", text: "A Qulo não afirma ter matching cientificamente validado, porque isso não existe no namoro. O que ela faz é colocar a troca em primeiro lugar, mecanicamente, de modo que não dê para pular:" },
    { type: "ul", items: [
      "**Você escreve de 2 a 4 perguntas sobre si** — de múltipla escolha, quatro opções cada — e marca a opção que é verdadeira no seu caso. Num plano pago o limite sobe para 10 perguntas.",
      "**Alguém dá match acertando todas.** Uma única resposta errada significa nenhum match: ninguém chega tocando na tela ao acaso.",
      "**As perguntas vêm antes do rosto,** o que inverte a ordem habitual de uma primeira impressão.",
      "**Resolver exige atenção.** Esforço garante pouco, mas é prova real de que a outra pessoa leu o que você escreveu.",
      "**Os poderes opcionais — uma dica, cortar as opções pela metade, pular uma pergunta — custam diamantes dentro do app e nunca são exigidos para dar match.** Toda pergunta é resolvível sem gastar nada.",
    ] },

    { type: "h2", text: "Como escrever perguntas que valham uma resposta" },
    { type: "p", text: "Como a sua resposta precisa ser descobrível, escrever boas perguntas é uma habilidade própria. Os trabalhos acima indicam o alvo: pessoal o bastante para valer a pena partilhar, e ao alcance de quem presta atenção em vez de chutar." },
    { type: "ul", items: [
      "**Seja específico sobre você:** “a cidade para onde eu me mudaria amanhã” ganha de “minha cidade favorita”. Uma é um fato sobre você; a outra é conversa de elevador.",
      "**Descobrível, não telepático:** a resposta certa deve sair do seu perfil, das suas fotos e de um pouco de reflexão. Uma pergunta que só a sua irmã acertaria não é filtro, é muro.",
      "**Evite opções decorativas:** quatro opções plausíveis com uma verdadeira formam uma pergunta. Uma verdadeira e três piadas formam uma formalidade.",
      "**Pergunte sobre escolhas, não sobre curiosidades:** o que você faria, do que abriria mão, para onde iria. Escolhas mostram uma pessoa; fatos sobre ela quase nunca.",
      "**Varie a profundidade:** comece leve e ponha a que importa de verdade em terceiro ou quarto lugar. Era exatamente dessa escalada que o estudo de 1997 tratava.",
    ] },

    { type: "quote", text: "O caminho mais curto para conhecer alguém é uma pergunta que os dois têm de responder. Isso não é uma descoberta — é simplesmente o que uma conversa é." },

    { type: "h2", text: "A versão honesta", accent: "green" },
    { type: "p", text: "Matching por perguntas não é um caminho comprovado para um relacionamento, e este artigo não vai fingir o contrário. O que a pesquisa sustenta é menor e ainda assim vale a pena: perguntar e responder alternadamente é como desconhecidos começam a gostar um do outro — Aron e colegas em 1997, Sprecher e colegas em 2013, Huang e colegas em 2017 apontam todos na mesma direção. Uma foto não faz isso. A única afirmação real da Qulo é de design: ela transforma a troca na porta de entrada em vez de um detalhe posterior, e deixa você decidir o que as respostas significam." },
  ],
  it: [
    { type: "h2", text: "Che cosa ha mostrato davvero lo studio delle 36 domande di Aron" },
    { type: "p", text: "Nel 1997 Arthur Aron, Edward Melinat, Elaine Aron, Robert Vallone e Renee Bator pubblicarono sul **Personality and Social Psychology Bulletin** una procedura che da allora viene citata, citata male e trasformata in liste da internet. Due sconosciuti si sedevano insieme e attraversavano tre serie di domande via via più personali, rispondendo a ciascuna a turno. La sessione durava circa **45 minuti**. Dopo, quelle coppie dichiaravano di sentirsi molto più vicine tra loro rispetto a sconosciuti che avevano passato gli stessi 45 minuti a fare conversazione di circostanza." },
    { type: "p", text: "Vale la pena essere precisi su ciò che quello studio ha mostrato e su ciò che non ha mostrato, perché la versione popolare si è allontanata parecchio dall'articolo. Ha mostrato che **l'apertura reciproca e crescente** — rispondono entrambi, ogni risposta un po' più personale della precedente — genera vicinanza tra sconosciuti, e che può avvenire sorprendentemente in fretta. Non ha mostrato che qualcuno si innamora in pochi minuti, e non è mai stato un algoritmo di matching: nessuno veniva abbinato in base alle risposte, e le domande non erano un test di compatibilità. **Reciproca** è la parola che regge tutto il risultato." },
    { type: "p", text: "È questa la vera ragione per cui le domande contano negli incontri, ed è più stretta di quella che di solito racconta internet. Ciò che la ricerca sostiene è che chiedere e rispondere è il modo in cui due sconosciuti cominciano a piacersi. Se la persona che ti piace sarà un buon compagno è un'altra domanda, e nessuna serie di domande vi risponde. Ciò che Qulo prende da qui è l'ordine, non una previsione: prima lo scambio, il volto dopo." },

    { type: "h2", text: "Il lavoro lo fa la reciprocità" },
    { type: "p", text: "Sprecher, Treger, Wondra, Hilaire e Wallpe hanno testato esattamente questo nel 2013 sul **Journal of Experimental Social Psychology**. Coppie di sconosciuti si aprivano a turno — entrambi chiedevano, entrambi rispondevano — oppure si dividevano i ruoli: uno raccontava, l'altro ascoltava, poi si invertivano. Alternarsi ha prodotto più simpatia e più vicinanza. Tra le stesse due persone passava la stessa quantità di informazioni; a cambiare era solo la forma dello scambio." },
    { type: "p", text: "Huang, Yeomans, Brooks, Minson e Gino ne hanno trovato la versione più direttamente utile agli incontri nel settembre 2017, sul **Journal of Personality and Social Psychology**. Su **110** partecipanti allo speed dating e **1.961** decisioni sul secondo appuntamento, chi faceva più domande — soprattutto **domande di approfondimento**, quelle che mostrano di aver davvero ascoltato la risposta precedente — veniva richiamato più spesso. Non i più attraenti, non i più spiritosi. Quelli che chiedevano." },
    { type: "p", text: "Una foto e due righe di descrizione non fanno nulla di tutto ciò. Vanno in una direzione sola, non ti chiedono niente e non lasciano nulla a cui rispondere. Una domanda è l'oggetto più piccolo che costringe entrambe le persone a mettere qualcosa sul tavolo." },

    { type: "h2", text: "Teoria dell'attaccamento: una cornice, non un verdetto" },
    { type: "p", text: "La teoria dell'attaccamento di John Bowlby è il vocabolario standard per descrivere come ci si comporta nelle relazioni strette — sicuro, ansioso, evitante — ed è una cornice vera, che vale la pena nominare come tale. Vale altrettanto dire che cosa non è. Bowlby scriveva di bambini e di chi se ne prende cura decenni prima che qualcuno scorresse un profilo, e nessuno ha mostrato che un'app di incontri sposti lo stile di attaccamento di un adulto in una direzione o nell'altra. Chi ti dice che un'app può aggiustare o rovinare il tuo modo di legarti ti sta vendendo qualcosa." },
    { type: "p", text: "Ciò che il design di un'app può cambiare è più stretto e più banale: che cosa significa un no. Quando il matching passa dalle foto, non trovare corrispondenza si legge come un verdetto sul tuo viso, perché il tuo viso era tutto ciò che era in offerta. Quando passa dalle domande dell'altra persona, sbagliare si legge come sbagliare: non hai indovinato le risposte. È una differenza di inquadratura, non una promessa terapeutica — e l'inquadratura è la sua misura onesta." },

    { type: "h2", text: "Compatibilità cognitiva e il triangolo di Sternberg" },
    { type: "p", text: "La compatibilità cognitiva è un'idea semplice in cappotto accademico: due persone il cui pensiero corre su linee simili — come affrontano un problema, che cosa danno per scontato, di che cosa ridono. Le domande la fanno emergere presto, perché il modo in cui qualcuno formula una domanda dice quanto la risposta. Ciò che nessuno ha mostrato, e che questo articolo non sosterrà, è che indovinare le domande di uno sconosciuto predica una relazione. Predice che hai fatto attenzione." },
    { type: "p", text: "La teoria triangolare dell'amore di Robert Sternberg qui serve come descrizione, non come prova. Divide l'amore duraturo in tre componenti: intimità, passione e impegno. Una foto parla al massimo a un vertice di quel triangolo, e ci parla prima che tu sappia qualsiasi altra cosa. Gli altri due vertici si costruiscono nella conversazione, ammesso che si costruiscano. È un modo di pensare a che cosa lascia fuori una prima impressione fatta di foto — non una misura, e nessun numero le appartiene." },

    { type: "h2", text: "Perché una foto dice meno di quanto sembri" },
    { type: "p", text: "Niente di tutto questo rende l'attrazione irrilevante. Rende la foto un contenitore scadente per l'attrazione. Quattro problemi noti, nessuno dei quali ha bisogno di una statistica per essere evidente:" },
    { type: "ul", items: [
      "**L'effetto alone:** diamo per scontato, senza dirlo, che chi troviamo attraente sia anche più gentile, più divertente e più capace. È uno dei bias documentati da più tempo in psicologia sociale, e sbaglia più o meno tante volte quante ci azzecca.",
      "**Una foto è scelta:** è la migliore tra qualche centinaio, con la luce giusta, dall'angolazione che funziona, in un giorno andato bene. Onesta su un viso e inaffidabile su tutto il resto.",
      "**L'aspetto smette di essere informazione nuova:** quasi tutto ciò che un viso ha da dire sta nella prima impressione, poi si ripete. Com'è parlare con una persona non si esaurisce così.",
      "**Una foto non può rispondere:** niente di ciò che ne impari è arrivato in risposta a qualcosa che hai offerto tu — ed è esattamente la reciprocità che gli studi qui sopra indicano.",
    ] },
    { type: "p", text: "Questo è un limite di ciò che il matching per foto può dirti. Non è una prova che le domande predicano con chi dovresti stare. Solo che una foto non lo avrebbe fatto comunque, e che uno scambio ti lascia in mano qualcosa che un volto non dà." },

    { type: "h2", text: "Che cosa ne fa davvero Qulo", accent: "green" },
    { type: "p", text: "Qulo non sostiene di avere un matching validato scientificamente, perché negli incontri una cosa simile non esiste. Quello che fa è mettere lo scambio per primo, meccanicamente, così che non si possa saltare:" },
    { type: "ul", items: [
      "**Scrivi da 2 a 4 domande su di te** — a scelta multipla, quattro opzioni ciascuna — e segni l'opzione vera per te. Con un piano a pagamento il limite sale a 10 domande.",
      "**Si combacia solo indovinandole tutte.** Una sola risposta sbagliata significa nessun match: nessuno arriva toccando a caso.",
      "**Le domande vengono prima del volto,** e questo capovolge l'ordine abituale di una prima impressione.",
      "**Risolvere richiede attenzione.** Lo sforzo garantisce poco, ma è una prova reale che l'altra persona ha letto ciò che hai scritto.",
      "**I poteri facoltativi — un indizio, dimezzare le opzioni, saltare una domanda — costano diamanti nell'app e non sono mai necessari per combaciare.** Ogni domanda è risolvibile senza spendere nulla.",
    ] },

    { type: "h2", text: "Come scrivere domande che meritano una risposta" },
    { type: "p", text: "Poiché la tua risposta deve essere trovabile, scrivere buone domande è un'abilità a sé. I lavori qui sopra indicano l'obiettivo: abbastanza personale da valere la pena condividerlo, e alla portata di chi fa attenzione invece di tirare a indovinare." },
    { type: "ul", items: [
      "**Sii specifico su di te:** «la città in cui mi trasferirei domani» batte «la mia città preferita». Una è un fatto che ti riguarda, l'altra è conversazione da ascensore.",
      "**Trovabile, non telepatica:** la risposta giusta dovrebbe uscire dal tuo profilo, dalle tue foto e da un po' di ragionamento. Una domanda che solo tua sorella indovinerebbe non è un filtro, è un muro.",
      "**Evita le opzioni decorative:** quattro opzioni plausibili con una vera sono una domanda. Una vera e tre battute sono una formalità.",
      "**Chiedi delle scelte, non delle curiosità:** che cosa faresti, a che cosa rinunceresti, dove andresti. Le scelte mostrano una persona; i dati su di lei quasi mai.",
      "**Varia la profondità:** apri con qualcosa di leggero e metti quella che ti sta davvero a cuore al terzo o quarto posto. Era proprio di questa progressione che parlava lo studio del 1997.",
    ] },

    { type: "quote", text: "La strada più breve per conoscere qualcuno è una domanda a cui dovete rispondere entrambi. Non è una scoperta — è semplicemente ciò che è una conversazione." },

    { type: "h2", text: "La versione onesta", accent: "green" },
    { type: "p", text: "Il matching basato sulle domande non è una via dimostrata verso una relazione, e questo articolo non farà finta del contrario. Ciò che la ricerca sostiene è più piccolo e vale comunque la pena costruirci sopra: fare domande e rispondere a turno è il modo in cui gli sconosciuti cominciano a piacersi — Aron e colleghi nel 1997, Sprecher e colleghi nel 2013, Huang e colleghi nel 2017 indicano tutti nella stessa direzione. Una foto non fa questo. L'unica vera affermazione di Qulo è di design: fa dello scambio la porta d'ingresso invece di un ripensamento, e lascia a te decidere che cosa significano le risposte." },
  ],
  ja: [
    { type: "h2", text: "アロンの「36の質問」研究が実際に示したこと" },
    { type: "p", text: "1997年、Arthur Aron、Edward Melinat、Elaine Aron、Robert Vallone、Renee Bator の五氏は **Personality and Social Psychology Bulletin** に、以来ずっと引用され、誤って引用され、記事リストに仕立て上げられてきた手続きを発表しました。見知らぬ二人が向かい合って座り、少しずつ個人的になっていく三組の質問を、交互に答えながら進めていきます。所要時間はおよそ **45分**。その後、参加者たちは、同じ45分を当たり障りのない雑談に費やした見知らぬ者同士よりも、互いにはっきりと近しさを感じたと報告しました。" },
    { type: "p", text: "この研究が何を示し、何を示さなかったのかは、正確に言っておく価値があります。世間に流通している話は、論文からかなり離れてしまったからです。示されたのは、**段階的に深まる相互の自己開示**——双方が答え、答えるたびに前より少しだけ個人的になっていくこと——が見知らぬ者同士のあいだに近さを生み、しかもそれが驚くほど速く起こりうる、ということです。数分で恋に落ちると示したわけではなく、そもそもマッチングのアルゴリズムでもありませんでした。答えによって誰かと誰かが組み合わされたわけではなく、質問は相性テストでもなかったのです。この知見全体を支えている語は **相互** です。" },
    { type: "p", text: "質問が出会いにおいて面白い本当の理由はここにあり、それはインターネットが語るよりも狭い理由です。研究が支えているのは、尋ね、答えることこそ、見知らぬ二人が互いを好きになり始めるやり方だ、という点です。好きになった相手が良いパートナーになるかどうかは別の問いで、どんな質問セットも答えられません。Qulo がここから受け取っているのは予測ではなく順番です。まずやり取りがあり、顔はその後に来ます。" },

    { type: "h2", text: "仕事をしているのは相互性です" },
    { type: "p", text: "Sprecher、Treger、Wondra、Hilaire、Wallpe の五氏は、まさにこれを2013年に **Journal of Experimental Social Psychology** で検証しました。見知らぬ二人組は、交互に打ち明ける——双方が尋ね、双方が答える——か、役割を分けて一方が話し他方が聞き、その後で入れ替わるかのどちらかでした。交互のほうが、より大きな好意と、より深い近さを生みました。同じ二人のあいだを同じ量の情報が行き来し、変わったのはやり取りの形だけです。" },
    { type: "p", text: "Huang、Yeomans、Brooks、Minson、Gino の五氏は、出会いに直接かかわる版を2017年9月に **Journal of Personality and Social Psychology** で見出しました。**110**人のスピードデート参加者と **1,961** 件の「もう一度会うか」の判断を通して、より多く質問した人——とりわけ直前の答えをちゃんと聞いたことが伝わる **フォローアップの質問** をした人——が、再び誘われる確率が高かったのです。最も魅力的な人でも、最も機知に富んだ人でもなく、尋ねた人でした。" },
    { type: "p", text: "写真と二行の自己紹介には、そのどれもできません。一方向に進むだけで、あなたに何も求めず、応じるべきものを何も残しません。質問は、二人ともに何かを差し出させる最小の道具です。" },

    { type: "h2", text: "愛着理論——枠組みであって、判決ではない" },
    { type: "p", text: "John Bowlby の愛着理論は、人が親密な関係でどう振る舞うかを語る標準的な語彙です——安定型、不安型、回避型。これは本物の枠組みで、名前を挙げるに値します。同じくらい、それが何ではないかを言っておく価値があります。Bowlby が子どもと養育者について書いていたのは、誰かが画面をスワイプするよりも何十年も前のことですし、出会い系アプリが大人の愛着スタイルをどちらかの方向へ動かすと示した人はいません。アプリがあなたの愛着の仕方を直せる、あるいは壊せると言う人は、何かを売っています。" },
    { type: "p", text: "アプリの設計が変えられるのは、もっと狭く、もっと平凡なことです。「ノー」の意味です。マッチングが写真で回るなら、マッチしないことはあなたの顔への判決のように読めます。差し出されていたのが顔だけだったからです。相手の質問を通して回るなら、外れは外れとして読めます。答えを当てられなかった、それだけです。これは枠づけの違いであって治療的な主張ではありません。枠づけこそが、この話の正直な大きさです。" },

    { type: "h2", text: "認知的な相性とスタンバーグの三角形" },
    { type: "p", text: "認知的な相性とは、学術的なコートを着たごく素朴な考えです。考え方が似た筋道を通る二人——問題への近づき方、当然だと思うこと、笑うところ。質問はそれを早い段階で表に出します。質問の立て方は、答えと同じくらいその人を語るからです。誰も示していないこと、そしてこの記事が主張しないことは、見知らぬ人の質問に正解することが関係を予測する、という話です。予測できるのは、あなたが注意を払ったということだけです。" },
    { type: "p", text: "Robert Sternberg の愛の三角理論は、ここでは証拠ではなく記述として役に立ちます。持続する愛を三つの要素に分けます——親密さ、情熱、コミットメント。写真はせいぜいその一つの頂点に語りかけるだけで、しかもあなたが他の何も知らないうちに語りかけます。残る二つの頂点は、築かれるとすれば会話のなかで築かれます。これは、写真から始まる第一印象が何を落としているかを考えるための枠組みであって、何かの測定ではありません。数字が付く話でもありません。" },

    { type: "h2", text: "写真が見た目ほど多くを語らない理由" },
    { type: "p", text: "これらは、惹かれることが重要でないという話ではありません。写真がその器としては貧しい、という話です。統計を持ち出すまでもない、よく知られた四つの問題があります。" },
    { type: "ul", items: [
      "**ハロー効果:** 魅力的だと感じた相手を、私たちは黙って「より優しく、より面白く、より有能だ」と見なします。社会心理学で最も古くから記録されてきたバイアスの一つで、当たるのとほぼ同じくらい外れます。",
      "**写真は選ばれたもの:** 数百枚のなかで最良の一枚、良い光、うまくいく角度、調子の良かった日。顔については正直で、それ以外のほとんどについては当てになりません。",
      "**外見はやがて新しい情報でなくなる:** 顔が語ることの大半は第一印象に収まり、その後は繰り返しです。その人と話すのがどんな感じかは、そんなふうには尽きません。",
      "**写真は答えられない:** そこから学ぶことは何ひとつ、あなたが差し出した何かへの応答として返ってきたものではありません。上に挙げた研究が重要だと指し示すのは、まさにその相互性です。",
    ] },
    { type: "p", text: "これは、写真から始まるマッチングに分かることの限界です。質問が「誰と一緒にいるべきか」を予測する証拠ではありません。写真にはもともとそれができなかったこと、そしてやり取りは顔が与えられないものを手元に残すこと——言えるのはそこまでです。" },

    { type: "h2", text: "Qulo はこれを実際にどう使っているか", accent: "green" },
    { type: "p", text: "Qulo は、科学的に検証されたマッチングを行っているとは主張しません。出会いの領域にそんなものは存在しないからです。やっているのは、やり取りを仕組みとして先に置き、飛ばせなくすることです。" },
    { type: "ul", items: [
      "**自分についての質問を2問から4問書きます。** 四択で、自分に当てはまる選択肢に印を付けます。有料プランなら上限は10問です。",
      "**相手は全問正解して初めてマッチします。** 一問でも外れればマッチはなく、適当にタップして辿り着く人はいません。",
      "**質問は顔より先に来ます。** 第一印象の通常の順番が入れ替わります。",
      "**解くには注意が要ります。** 労力は何かの強い保証にはなりませんが、相手があなたの書いたものを読んだという確かな証拠にはなります。",
      "**任意の力——ヒント、選択肢を半分にする、質問を飛ばす——はアプリ内のダイヤを消費し、マッチのために必須になることは決してありません。** どの質問も、何も使わずに解けます。",
    ] },

    { type: "h2", text: "答える価値のある質問の書き方" },
    { type: "p", text: "答えが見つけられるものでなければならないので、良い質問を書くのは独立した技術です。上の研究が示す狙いどころは、打ち明ける価値があるくらい個人的で、しかも当てずっぽうではなく注意を払う人に届く範囲にあること。" },
    { type: "ul", items: [
      "**自分について具体的に:** 「明日にでも引っ越したい街」は「好きな街」に勝ちます。前者はあなたについての事実で、後者は世間話です。",
      "**見つけられるように、超能力は要らない:** 正解はプロフィールと写真と少しの考察から辿り着けるべきです。姉妹しか答えられない質問はフィルターではなく壁です。",
      "**飾りの選択肢を避ける:** もっともらしい四つの選択肢のうち一つが本当なら、それは質問です。本当が一つと冗談が三つなら、それは形式です。",
      "**雑学ではなく選択を尋ねる:** 何をするか、何を手放すか、どこへ行くか。選択は人を見せますが、その人についての事実はたいてい見せません。",
      "**深さに緩急をつける:** 軽いもので始め、本当に大事な一問は三番目か四番目に置きます。1997年の研究が本当に扱っていたのは、その段階の付け方でした。",
    ] },

    { type: "quote", text: "誰かを知るいちばん短い道は、二人とも答えなければならない質問です。これは発見ではありません——それが会話というものだ、というだけです。" },

    { type: "h2", text: "正直な言い方をすると", accent: "green" },
    { type: "p", text: "質問によるマッチングは、関係に至る証明された道ではありませんし、この記事もそのふりをしません。研究が支えているのはもっと小さく、それでも積み上げる価値のあることです。尋ね、交互に答えることこそ、見知らぬ者同士が互いを好きになり始めるやり方だ——1997年の Aron ら、2013年の Sprecher ら、2017年の Huang ら、いずれも同じ方向を指しています。写真はそれをしません。Qulo の唯一の本当の主張は設計についての主張です。やり取りを後付けではなく入り口にし、その答えが何を意味するかの判断はあなたに委ねます。" },
  ],
  ko: [
    { type: "h2", text: "아론의 36가지 질문 연구가 실제로 보여 준 것" },
    { type: "p", text: "1997년 Arthur Aron, Edward Melinat, Elaine Aron, Robert Vallone, Renee Bator는 **Personality and Social Psychology Bulletin**에 하나의 절차를 발표했습니다. 그 뒤로 줄곧 인용되고, 잘못 인용되고, 인터넷 목록 기사로 가공되어 온 절차입니다. 낯선 두 사람이 마주 앉아 점점 더 사적으로 깊어지는 세 묶음의 질문을 번갈아 답하며 끝까지 진행합니다. 한 회기는 약 **45분** 걸렸습니다. 그 뒤 이들은, 같은 45분을 가벼운 잡담으로 보낸 낯선 사람들보다 서로에게 훨씬 더 가깝게 느꼈다고 보고했습니다." },
    { type: "p", text: "이 연구가 무엇을 보여 주었고 무엇을 보여 주지 않았는지는 정확히 짚어 둘 필요가 있습니다. 대중적으로 퍼진 이야기가 논문에서 꽤 멀어졌기 때문입니다. 연구가 보여 준 것은 **점점 깊어지는 상호 자기 개방** — 둘 다 답하고, 답할 때마다 앞선 답보다 조금 더 사적으로 — 이 낯선 사람 사이에 가까움을 만들어 내며, 그것이 놀랄 만큼 빠르게 일어날 수 있다는 사실입니다. 누군가 몇 분 만에 사랑에 빠진다는 것을 보여 주지는 않았고, 애초에 매칭 알고리즘도 아니었습니다. 답을 근거로 누구를 누구와 짝지은 것이 아니고, 질문은 궁합 테스트도 아니었습니다. 이 결과 전체를 떠받치는 단어는 **상호**입니다." },
    { type: "p", text: "질문이 연애에서 흥미로운 진짜 이유가 이것이고, 인터넷이 흔히 말하는 것보다 훨씬 좁은 이유입니다. 연구가 뒷받침하는 것은 묻고 답하는 일이 낯선 두 사람이 서로를 좋아하기 시작하는 방식이라는 점입니다. 좋아하게 된 사람이 좋은 파트너가 될지는 별개의 질문이고, 어떤 질문 묶음도 답해 주지 않습니다. Qulo가 여기서 가져오는 것은 예측이 아니라 순서입니다. 주고받음이 먼저고, 얼굴은 그다음입니다." },

    { type: "h2", text: "일을 하는 쪽은 상호성입니다" },
    { type: "p", text: "Sprecher, Treger, Wondra, Hilaire, Wallpe는 정확히 이것을 2013년 **Journal of Experimental Social Psychology**에서 검증했습니다. 낯선 두 사람은 번갈아 자신을 열거나 — 둘 다 묻고 둘 다 답하거나 — 역할을 나눠 한 사람이 이야기하고 다른 사람이 듣다가 나중에 바꾸었습니다. 번갈아 하는 쪽이 더 큰 호감과 더 깊은 가까움을 만들었습니다. 같은 두 사람 사이에 같은 양의 정보가 오갔고, 달라진 것은 주고받는 형태뿐이었습니다." },
    { type: "p", text: "Huang, Yeomans, Brooks, Minson, Gino는 연애와 곧바로 이어지는 판본을 2017년 9월 **Journal of Personality and Social Psychology**에서 찾아냈습니다. 스피드 데이팅 참가자 **110**명과 두 번째 데이트 결정 **1,961**건에 걸쳐, 질문을 더 많이 한 사람 — 특히 앞선 답을 정말로 들었다는 것을 보여 주는 **후속 질문**을 한 사람 — 이 다시 초대받을 가능성이 높았습니다. 가장 매력적인 사람도, 가장 재치 있는 사람도 아니었습니다. 물어본 사람이었습니다." },
    { type: "p", text: "사진 한 장과 두 줄짜리 소개는 그 어느 것도 하지 못합니다. 한 방향으로만 흐르고, 당신에게 아무것도 요구하지 않으며, 응답할 것도 남기지 않습니다. 질문은 두 사람 모두에게 무언가를 내놓게 만드는 가장 작은 물건입니다." },

    { type: "h2", text: "애착 이론: 판결이 아니라 틀" },
    { type: "p", text: "John Bowlby의 애착 이론은 사람들이 가까운 관계에서 어떻게 행동하는지 설명하는 표준 어휘입니다 — 안정, 불안, 회피. 진짜 틀이고, 이름을 불러 줄 만합니다. 그것이 무엇이 아닌지도 그만큼 말해 둘 가치가 있습니다. Bowlby가 아이와 양육자에 대해 쓴 것은 누군가 화면을 밀어 넘기기 수십 년 전의 일이고, 데이팅 앱이 성인의 애착 유형을 어느 쪽으로든 옮긴다는 것을 보여 준 사람은 없습니다. 앱이 당신의 애착 방식을 고치거나 망칠 수 있다고 말하는 사람은 무언가를 팔고 있는 것입니다." },
    { type: "p", text: "앱의 설계가 바꿀 수 있는 것은 더 좁고 더 평범합니다. 거절이 무엇을 뜻하는가입니다. 매칭이 사진으로 돌아가면, 매칭되지 않은 일은 당신의 얼굴에 대한 판결처럼 읽힙니다. 내놓인 것이 얼굴뿐이었으니까요. 상대의 질문을 통해 돌아가면, 빗나감은 빗나감으로 읽힙니다. 답을 맞히지 못한 것입니다. 이것은 치료적 약속이 아니라 틀 짓기의 차이이고, 그 틀 짓기가 이 이야기의 정직한 크기입니다." },

    { type: "h2", text: "인지적 궁합과 스턴버그의 삼각형" },
    { type: "p", text: "인지적 궁합은 학술적인 외투를 걸친 소박한 생각입니다. 생각이 비슷한 길로 흐르는 두 사람 — 문제에 어떻게 접근하는지, 무엇을 당연하게 여기는지, 무엇에 웃는지. 질문은 그것을 일찍 드러냅니다. 질문을 짜는 방식이 답만큼이나 그 사람을 말해 주기 때문입니다. 아무도 보여 주지 않았고 이 글도 주장하지 않을 것은, 낯선 사람의 질문을 맞히는 일이 관계를 예측한다는 이야기입니다. 그것이 예측하는 것은 당신이 주의를 기울였다는 사실뿐입니다." },
    { type: "p", text: "Robert Sternberg의 사랑의 삼각형 이론은 여기서 증거가 아니라 서술로서 쓸모가 있습니다. 지속되는 사랑을 세 요소로 나눕니다 — 친밀감, 열정, 헌신. 사진은 기껏해야 그 삼각형의 한 꼭짓점에 말을 걸고, 그것도 당신이 다른 무엇도 알기 전에 겁니다. 나머지 두 꼭짓점은 세워진다면 대화 속에서 세워집니다. 이것은 사진으로 시작하는 첫인상이 무엇을 빠뜨리는지 생각해 보는 방식이지, 무언가의 측정이 아닙니다. 여기에 붙일 숫자도 없습니다." },

    { type: "h2", text: "사진이 보이는 것보다 적게 말하는 이유" },
    { type: "p", text: "이 중 어느 것도 끌림이 중요하지 않다는 말은 아닙니다. 사진이 그것을 담기에 나쁜 그릇이라는 말입니다. 통계가 없어도 분명한, 익숙한 네 가지 문제가 있습니다." },
    { type: "ul", items: [
      "**후광 효과:** 우리는 매력적이라고 느낀 사람이 더 다정하고 더 재미있고 더 유능하다고 조용히 가정합니다. 사회심리학에서 가장 오래 기록된 편향 가운데 하나이고, 맞는 만큼이나 틀립니다.",
      "**사진은 고른 것입니다:** 수백 장 중 가장 나은 한 장, 좋은 빛, 잘 나오는 각도, 잘 풀린 하루. 얼굴에 대해서는 정직하고 나머지 거의 전부에 대해서는 믿을 수 없습니다.",
      "**외모는 곧 새로운 정보가 아니게 됩니다:** 얼굴이 해 줄 말의 대부분은 첫인상에 담기고 그다음부터는 반복입니다. 누군가와 이야기하는 일이 어떤지는 그렇게 바닥나지 않습니다.",
      "**사진은 답할 수 없습니다:** 거기서 알게 되는 어떤 것도 당신이 내놓은 무언가에 대한 응답으로 온 것이 아닙니다. 위의 연구들이 중요하다고 가리키는 것이 바로 그 상호성입니다.",
    ] },
    { type: "p", text: "이것은 사진으로 시작하는 매칭이 알려 줄 수 있는 것의 한계입니다. 질문이 당신이 누구와 있어야 하는지를 예측한다는 증거가 아닙니다. 사진은 애초에 그럴 수 없었고, 주고받음은 얼굴이 주지 못하는 무언가를 손에 남긴다는 것뿐입니다." },

    { type: "h2", text: "Qulo는 이것으로 실제로 무엇을 하나", accent: "green" },
    { type: "p", text: "Qulo는 과학적으로 검증된 매칭을 한다고 주장하지 않습니다. 데이팅에 그런 것은 존재하지 않기 때문입니다. Qulo가 하는 일은 주고받음을 구조적으로 앞에 두어 건너뛸 수 없게 만드는 것입니다." },
    { type: "ul", items: [
      "**자신에 대한 질문을 2개에서 4개까지 씁니다** — 각 문항 네 개의 선택지 — 그리고 자신에게 해당하는 선택지를 표시합니다. 유료 플랜에서는 상한이 10개로 올라갑니다.",
      "**상대는 전부 맞혀야 매칭됩니다.** 하나만 틀려도 매칭은 없고, 아무렇게나 눌러서 도달하는 사람은 없습니다.",
      "**질문이 얼굴보다 먼저 옵니다.** 첫인상의 익숙한 순서가 뒤집힙니다.",
      "**푸는 데는 주의가 듭니다.** 노력은 무엇의 강한 보증도 아니지만, 상대가 당신이 쓴 것을 읽었다는 진짜 증거는 됩니다.",
      "**선택적인 힘 — 힌트, 선택지 절반 줄이기, 질문 건너뛰기 — 은 앱 내 다이아몬드를 쓰며 매칭에 반드시 필요한 적은 없습니다.** 모든 질문은 아무것도 쓰지 않고 풀 수 있습니다.",
    ] },

    { type: "h2", text: "답할 만한 질문을 쓰는 법" },
    { type: "p", text: "답이 찾아질 수 있어야 하기 때문에, 좋은 질문을 쓰는 일은 그 자체로 하나의 기술입니다. 위의 연구들이 가리키는 지점은 이렇습니다. 털어놓을 만큼 사적이면서, 찍는 사람이 아니라 주의를 기울이는 사람이 닿을 수 있을 것." },
    { type: "ul", items: [
      "**자신에 대해 구체적으로:** “내일이라도 이사 가고 싶은 도시”가 “좋아하는 도시”를 이깁니다. 하나는 당신에 대한 사실이고, 다른 하나는 겉도는 잡담입니다.",
      "**찾을 수 있게, 독심술은 말고:** 정답은 프로필과 사진과 약간의 생각에서 닿을 수 있어야 합니다. 여동생만 맞힐 수 있는 질문은 필터가 아니라 벽입니다.",
      "**장식용 선택지는 피하기:** 그럴듯한 네 선택지 중 하나가 참이면 질문입니다. 참 하나에 농담 셋이면 형식입니다.",
      "**잡학이 아니라 선택을 묻기:** 무엇을 할지, 무엇을 포기할지, 어디로 갈지. 선택은 사람을 보여 주지만, 그 사람에 대한 사실은 대개 보여 주지 않습니다.",
      "**깊이에 변화를 주기:** 가벼운 것으로 열고, 정말 중요한 하나는 세 번째나 네 번째에 두세요. 1997년 연구가 실제로 다룬 것이 그 점층입니다.",
    ] },

    { type: "quote", text: "누군가를 아는 가장 짧은 길은 둘 다 답해야 하는 질문입니다. 이것은 발견이 아니라 — 그냥 대화라는 것이 원래 그런 것입니다." },

    { type: "h2", text: "정직한 판본", accent: "green" },
    { type: "p", text: "질문 기반 매칭은 관계로 가는 증명된 길이 아니고, 이 글도 그런 척하지 않겠습니다. 연구가 뒷받침하는 것은 더 작고, 그래도 쌓아 올릴 만합니다. 묻고 번갈아 답하는 일이 낯선 사람들이 서로를 좋아하기 시작하는 방식이라는 것 — 1997년의 Aron과 동료들, 2013년의 Sprecher와 동료들, 2017년의 Huang과 동료들이 모두 같은 방향을 가리킵니다. 사진은 그 일을 하지 않습니다. Qulo의 유일한 진짜 주장은 설계에 대한 주장입니다. 주고받음을 나중 일이 아니라 입구로 만들고, 그 답이 무엇을 뜻하는지는 당신이 정하게 둡니다." },
  ],
  zh: [
    { type: "h2", text: "阿伦的「36个问题」研究究竟说明了什么" },
    { type: "p", text: "1997年，Arthur Aron、Edward Melinat、Elaine Aron、Robert Vallone 与 Renee Bator 在 **Personality and Social Psychology Bulletin** 上发表了一套流程，此后它被反复引用、误引，并被做成一篇又一篇清单文章。两个陌生人面对面坐下，轮流回答三组越来越私人的问题。整个过程大约 **45分钟**。结束后，这些两人组表示，他们感到彼此明显更亲近——比那些用同样45分钟寒暄的陌生人更亲近。" },
    { type: "p", text: "有必要说清楚这项研究说明了什么、没有说明什么，因为流行的说法早已离原论文很远。它说明的是：**层层递进的相互自我袒露**——两个人都回答，每个答案都比上一个更私人一点——能在陌生人之间生出亲近感，而且可以快得出人意料。它没有说明谁会在几分钟内坠入爱河，它也从来不是一套匹配算法：没有人是按答案被配对的，那些问题也不是相性测验。整个结论里承重的词是 **相互**。" },
    { type: "p", text: "这才是问题在约会中真正有意思的原因，而且比互联网通常给出的理由要窄得多。研究支持的是：提问与回答，是两个陌生人开始互相喜欢的方式。你喜欢的人会不会成为合适的伴侣，是另一个问题，任何一组问题都答不了。Qulo 从中拿走的是顺序，而不是预测：先有来回，再看脸。" },

    { type: "h2", text: "真正起作用的是相互性" },
    { type: "p", text: "Sprecher、Treger、Wondra、Hilaire 与 Wallpe 在 2013 年的 **Journal of Experimental Social Psychology** 上检验的正是这一点。成对的陌生人要么轮流袒露——两个人都问、两个人都答——要么分工：一个人讲，另一个人听，然后交换。轮流的一组产生了更多好感与更深的亲近。同样两个人之间流过同样多的信息，改变的只是交流的形状。" },
    { type: "p", text: "Huang、Yeomans、Brooks、Minson 与 Gino 在 2017 年 9 月的 **Journal of Personality and Social Psychology** 上找到了与约会最直接相关的版本。在 **110** 位快速约会参与者、**1,961** 项第二次约会决定中，提问更多的人——尤其是提出 **追问** 的人，也就是让对方看出你真的听进了上一句回答的那种问题——更容易被再次邀约。不是最好看的，也不是最风趣的。是那些发问的人。" },
    { type: "p", text: "一张照片加两行简介做不到这些。它们只朝一个方向流动，不向你要求什么，也不留下任何可以回应的东西。问题是能让两个人都拿出点什么的最小单位。" },

    { type: "h2", text: "依恋理论：一个框架，不是判决" },
    { type: "p", text: "John Bowlby 的依恋理论是描述人在亲密关系中如何行动的标准词汇——安全型、焦虑型、回避型。它是真实的框架，值得被点名。同样值得说清楚的是它不是什么。Bowlby 写下孩子与照顾者的时候，离任何人在屏幕上滑动还有几十年，而且没有人证明过一个约会应用会把成年人的依恋风格往任何方向推。谁告诉你某个应用能修好或毁掉你的依恋方式，谁就是在卖东西给你。" },
    { type: "p", text: "一个应用的设计真正能改变的，是更窄也更平常的事：一个「不」意味着什么。当匹配走照片，没有配上会被读成对你这张脸的判决，因为摆出来的本来就只有脸。当匹配走对方的问题，没答对就只是没答对。这是框定方式的差别，不是治疗承诺——而框定方式，就是这件事诚实的分量。" },

    { type: "h2", text: "认知契合与斯滕伯格的三角" },
    { type: "p", text: "认知契合是一个穿着学术外套的朴素想法：两个人的思路走在相近的路上——怎么面对一个问题，把什么当作理所当然，被什么逗笑。问题会很早把它显出来，因为一个人怎么问，和他怎么答一样能说明他。没有人证明过、这篇文章也不会主张的是：答对一个陌生人的问题能预测一段关系。它能预测的只是你当时很用心。" },
    { type: "p", text: "Robert Sternberg 的爱情三角理论在这里是描述，不是证据。它把持久的爱分成三个成分：亲密、激情与承诺。一张照片顶多对着这个三角的一个顶点说话，而且是在你还什么都不知道的时候说的。另外两个顶点若要立起来，只能在对话里立。这是一种思考「以照片开场的第一印象漏掉了什么」的方式，不是任何测量，也没有数字属于它。" },

    { type: "h2", text: "为什么照片说的比看上去少" },
    { type: "p", text: "这些都不意味着吸引力不重要。它们只说明照片是个不称职的容器。四个熟悉的问题，都不需要统计数字就看得明白：" },
    { type: "ul", items: [
      "**光环效应：**我们会默默认为，自己觉得好看的人也更善良、更有趣、更能干。这是社会心理学里最早被记录的偏误之一，错的次数和对的次数差不多。",
      "**照片是被挑出来的：**几百张里最好的一张，好光线，管用的角度，顺利的一天。它对一张脸是诚实的，对其他几乎所有事都不可靠。",
      "**外表很快不再是新信息：**一张脸要说的大半都在第一印象里，之后就是重复。而和一个人聊天是什么感觉，不会这样用完。",
      "**照片不会回答：**你从它那里得到的一切，都不是对你付出的什么的回应——而上面那些研究指出重要的，恰恰是这种相互。",
    ] },
    { type: "p", text: "这是以照片开场的匹配所能告诉你的上限。它不是「问题能预测你该和谁在一起」的证据。它只说明照片本来就做不到这件事，而一次来回会在你手里留下一张脸给不了的东西。" },

    { type: "h2", text: "Qulo 实际拿它做了什么", accent: "green" },
    { type: "p", text: "Qulo 不宣称自己在做经过科学验证的匹配，因为在约会这件事上并不存在那种东西。它做的是把来回从机制上放到最前面，让它无法被跳过：" },
    { type: "ul", items: [
      "**你写下2到4个关于自己的问题**——选择题，每题四个选项——并标出对你为真的那一个。付费方案最多可以写10个。",
      "**对方必须全部答对才会配上。**错一题就没有匹配，所以没有人是随手点进来的。",
      "**问题排在脸的前面，**这就把第一印象的惯常顺序倒了过来。",
      "**解题需要注意力。**努力保证不了什么，但它是对方读过你写的东西的真实证据。",
      "**可选的能力——提示、把选项减半、跳过一题——会消耗应用内的钻石，且从不构成配对的必要条件。**每一道题都可以不花任何东西解开。",
    ] },

    { type: "h2", text: "怎样写出值得回答的问题" },
    { type: "p", text: "因为你的答案必须是能被找到的，写好问题本身就是一门手艺。上面的研究指出了方向：私人到值得说出口，同时又能被一个用心的人（而不是一个瞎猜的人）够到。" },
    { type: "ul", items: [
      "**说得具体一点：**「我明天就想搬去的城市」胜过「我最喜欢的城市」。前者是关于你的事实，后者是客套。",
      "**要能找到，而不是要通灵：**正确答案应该能从你的资料、你的照片和一点思考里推出来。只有你妹妹能答对的问题不是筛子，是墙。",
      "**别放装饰性选项：**四个都说得通、其中一个为真，那是问题；一个真的加三个玩笑，那是走过场。",
      "**问选择，别问冷知识：**你会怎么做，你愿意放弃什么，你会去哪里。选择能显出一个人；关于这个人的事实大多不能。",
      "**深浅要有变化：**用轻松的开场，把你真正在意的那一题放在第三或第四个。1997年那项研究真正讲的就是这种递进。",
    ] },

    { type: "quote", text: "认识一个人最短的路，是一个你们两个都必须回答的问题。这不是什么发现——对话本来就是这样。" },

    { type: "h2", text: "诚实的版本", accent: "green" },
    { type: "p", text: "以问题为入口的匹配不是通往一段关系的既定路径，这篇文章也不打算假装它是。研究支持的东西更小，却仍然值得在上面搭建：提问，然后轮流回答，是陌生人开始互相喜欢的方式——1997年的 Aron 等人、2013年的 Sprecher 等人、2017年的 Huang 等人，都指向同一个方向。照片做不到这件事。Qulo 唯一真实的主张是一个关于设计的主张：把来回变成入口，而不是事后补上的环节，然后把「这些答案意味着什么」留给你自己判断。" },
  ],
  nl: [
    { type: "h2", text: "Wat Arons onderzoek met de 36 vragen werkelijk liet zien" },
    { type: "p", text: "In 1997 publiceerden Arthur Aron, Edward Melinat, Elaine Aron, Robert Vallone en Renee Bator in het **Personality and Social Psychology Bulletin** een procedure die sindsdien is geciteerd, verkeerd geciteerd en tot lijstjes verwerkt. Twee vreemden gingen samen zitten en werkten drie reeksen vragen door die steeds persoonlijker werden, waarbij ze om beurten alles beantwoordden. De sessie duurde ongeveer **45 minuten**. Daarna zeiden die tweetallen zich merkbaar dichter bij elkaar te voelen dan vreemden die dezelfde 45 minuten aan koetjes en kalfjes hadden besteed." },
    { type: "p", text: "Het is de moeite waard om precies te zijn over wat dat onderzoek wel en niet liet zien, want de populaire versie is ver van het artikel af komen te staan. Het liet zien dat **oplopende, wederzijdse zelfonthulling** — allebei antwoorden, elk antwoord iets persoonlijker dan het vorige — nabijheid schept tussen vreemden, en dat dat verrassend snel kan gaan. Het liet niet zien dat iemand in een paar minuten verliefd wordt, en het was nooit een matchingalgoritme: niemand werd op basis van antwoorden gekoppeld, en de vragen waren geen compatibiliteitstest. **Wederzijds** is het woord dat de hele bevinding draagt." },
    { type: "p", text: "Dat is de echte reden waarom vragen interessant zijn bij daten, en het is een smallere reden dan het internet meestal geeft. Wat het onderzoek ondersteunt, is dat vragen en antwoorden de manier is waarop twee vreemden elkaar beginnen te mogen. Of degene die je aardig gaat vinden ook een goede partner is, is een andere vraag, en geen enkele set vragen beantwoordt die. Wat Qulo hieruit overneemt is de volgorde, niet een voorspelling: eerst de uitwisseling, het gezicht daarna." },

    { type: "h2", text: "Het werk wordt gedaan door de wederkerigheid" },
    { type: "p", text: "Sprecher, Treger, Wondra, Hilaire en Wallpe onderzochten precies dit in 2013 in het **Journal of Experimental Social Psychology**. Paren vreemden onthulden om de beurt — allebei vragen, allebei antwoorden — of verdeelden de rollen: de één vertelde, de ander luisterde, en daarna wisselden ze. Om de beurt gaan leverde meer sympathie en meer nabijheid op. Tussen dezelfde twee mensen ging dezelfde hoeveelheid informatie heen en weer; alleen de vorm van de uitwisseling veranderde." },
    { type: "p", text: "Huang, Yeomans, Brooks, Minson en Gino vonden in september 2017 in het **Journal of Personality and Social Psychology** de versie die er voor daten direct toe doet. Over **110** speeddaters en **1.961** beslissingen over een tweede date bleken de mensen die meer vragen stelden — vooral **vervolgvragen**, het soort dat laat zien dat je het vorige antwoord echt hebt gehoord — vaker opnieuw gevraagd te worden. Niet de aantrekkelijksten, niet de geestigsten. Degenen die vroegen." },
    { type: "p", text: "Een foto en twee regels bio kunnen daar niets van. Ze gaan één kant op, vragen niets van je en laten niets achter om op te reageren. Een vraag is het kleinste voorwerp dat allebei de mensen dwingt iets neer te leggen." },

    { type: "h2", text: "Hechtingstheorie: een kader, geen vonnis" },
    { type: "p", text: "John Bowlby's hechtingstheorie is het standaardvocabulaire voor hoe mensen zich in hechte relaties gedragen — veilig, angstig, vermijdend — en het is een echt kader, dat je gerust bij naam mag noemen. Het is even zinvol om te zeggen wat het niet is. Bowlby schreef over kinderen en verzorgers, decennia voordat iemand ergens over een scherm veegde, en niemand heeft laten zien dat een datingapp de hechtingsstijl van een volwassene de ene of de andere kant op duwt. Wie je vertelt dat een app je manier van hechten kan repareren of verpesten, verkoopt je iets." },
    { type: "p", text: "Wat het ontwerp van een app wél kan veranderen is smaller en alledaagser: wat een nee betekent. Loopt matchen via foto's, dan leest geen match als een oordeel over je gezicht, want je gezicht was alles wat er lag. Loopt het via de vragen van de ander, dan leest een misser als een misser: je had de antwoorden niet goed. Dat is een verschil in kadering, geen therapeutische belofte — en kadering is precies de eerlijke omvang ervan." },

    { type: "h2", text: "Cognitieve klik en de driehoek van Sternberg" },
    { type: "p", text: "Cognitieve klik is een eenvoudig idee in een academische jas: twee mensen wier denken langs vergelijkbare lijnen loopt — hoe ze een probleem aanpakken, wat ze vanzelfsprekend vinden, waar ze om lachen. Vragen brengen dat vroeg naar boven, want hoe iemand een vraag stelt, zegt net zoveel als het antwoord. Wat niemand heeft aangetoond, en wat dit artikel niet zal beweren: de vragen van een vreemde goed beantwoorden voorspelt geen relatie. Het voorspelt dat je hebt opgelet." },
    { type: "p", text: "Robert Sternbergs driehoekstheorie van de liefde helpt hier als beschrijving, niet als bewijs. Ze splitst duurzame liefde in drie componenten: intimiteit, passie en toewijding. Een foto spreekt hooguit één hoek van die driehoek aan, en doet dat voordat je iets anders weet. De andere twee hoeken worden in het gesprek gebouwd, als ze al gebouwd worden. Dat is een manier om na te denken over wat een op foto's gebouwde eerste indruk weglaat — geen meting, en er hoort geen getal bij." },

    { type: "h2", text: "Waarom een foto minder zegt dan het lijkt" },
    { type: "p", text: "Niets hiervan maakt aantrekking onbelangrijk. Het maakt de foto er een slechte houder voor. Vier bekende problemen, waarvoor geen statistiek nodig is:" },
    { type: "ul", items: [
      "**Het halo-effect:** we nemen stilzwijgend aan dat iemand die we aantrekkelijk vinden ook aardiger, grappiger en competenter is. Het is een van de langst gedocumenteerde vertekeningen in de sociale psychologie, en het zit er ongeveer even vaak naast als het klopt.",
      "**Een foto is gekozen:** de beste uit een paar honderd, bij goed licht, vanuit de hoek die werkt, op een dag die goed liep. Eerlijk over een gezicht en onbetrouwbaar over vrijwel al het andere.",
      "**Uiterlijk houdt op nieuwe informatie te zijn:** het meeste van wat een gezicht te zeggen heeft, zit in de eerste indruk; daarna herhaalt het zich. Hoe het is om met iemand te praten raakt zo niet op.",
      "**Een foto kan niet antwoorden:** niets van wat je eruit leert, kwam als reactie op iets wat jij bood — en dat is precies de wederkerigheid waar de onderzoeken hierboven op wijzen.",
    ] },
    { type: "p", text: "Dat is een grens aan wat matchen op foto's je kan vertellen. Het is geen bewijs dat vragen voorspellen met wie je zou moeten zijn. Alleen dat een foto dat sowieso nooit ging doen, en dat een uitwisseling je iets in handen geeft wat een gezicht niet geeft." },

    { type: "h2", text: "Wat Qulo hier werkelijk mee doet", accent: "green" },
    { type: "p", text: "Qulo beweert niet wetenschappelijk gevalideerd te matchen, want dat bestaat niet in daten. Wat het wel doet: de uitwisseling mechanisch vooropzetten, zodat je haar niet kunt overslaan:" },
    { type: "ul", items: [
      "**Je schrijft 2 tot 4 vragen over jezelf** — meerkeuze, vier opties per vraag — en markeert de optie die op jou klopt. Met een betaald abonnement gaat de grens naar 10 vragen.",
      "**Iemand matcht door ze allemaal goed te hebben.** Eén fout antwoord betekent geen match, dus niemand komt binnen door maar wat te tikken.",
      "**De vragen komen vóór het gezicht,** wat de gebruikelijke volgorde van een eerste indruk omdraait.",
      "**Oplossen kost aandacht.** Moeite garandeert weinig, maar het is echt bewijs dat de ander gelezen heeft wat je schreef.",
      "**De optionele hulpmiddelen — een hint, de opties halveren, een vraag overslaan — kosten diamanten in de app en zijn nooit nodig om te matchen.** Elke vraag is oplosbaar zonder iets uit te geven.",
    ] },

    { type: "h2", text: "Hoe je vragen schrijft die een antwoord waard zijn" },
    { type: "p", text: "Omdat jouw antwoord vindbaar moet zijn, is goede vragen schrijven een vak apart. Het werk hierboven wijst de richting: persoonlijk genoeg om het delen waard te zijn, en bereikbaar voor iemand die oplet in plaats van gokt." },
    { type: "ul", items: [
      "**Wees specifiek over jezelf:** „de stad waar ik morgen heen zou verhuizen” wint van „mijn favoriete stad”. Het eerste is een feit over jou, het tweede is small talk.",
      "**Vindbaar, niet paranormaal:** het juiste antwoord moet te halen zijn uit je profiel, je foto's en een beetje nadenken. Een vraag die alleen je zus zou weten is geen filter maar een muur.",
      "**Vermijd decoratieve opties:** vier plausibele opties met één ware is een vraag. Eén ware en drie grappen is een formaliteit.",
      "**Vraag naar keuzes, niet naar weetjes:** wat je zou doen, wat je zou opgeven, waar je heen zou gaan. Keuzes laten een mens zien; feiten over die mens meestal niet.",
      "**Varieer de diepte:** begin licht en zet de vraag die je echt raakt op de derde of vierde plek. Precies over die opbouw ging het onderzoek uit 1997.",
    ] },

    { type: "quote", text: "De kortste weg om iemand te leren kennen is een vraag die jullie allebei moeten beantwoorden. Dat is geen ontdekking — dat is gewoon wat een gesprek is." },

    { type: "h2", text: "De eerlijke versie", accent: "green" },
    { type: "p", text: "Matchen op vragen is geen bewezen route naar een relatie, en dit artikel gaat niet doen alsof. Wat het onderzoek wel ondersteunt is kleiner en nog steeds de moeite waard: vragen stellen en ze om de beurt beantwoorden is hoe vreemden elkaar beginnen te mogen — Aron en collega's in 1997, Sprecher en collega's in 2013, Huang en collega's in 2017 wijzen allemaal dezelfde kant op. Een foto doet dat niet. De enige echte claim van Qulo is er een over ontwerp: het maakt de uitwisseling de voordeur in plaats van een bijgedachte, en laat jou bepalen wat de antwoorden betekenen." },
  ],
  pl: [
    { type: "h2", text: "Co naprawdę pokazało badanie Arona z 36 pytaniami" },
    { type: "p", text: "W 1997 roku Arthur Aron, Edward Melinat, Elaine Aron, Robert Vallone i Renee Bator opublikowali w **Personality and Social Psychology Bulletin** procedurę, która od tamtej pory bywa cytowana, przekręcana i przerabiana na internetowe listy. Dwoje nieznajomych siadało razem i przechodziło przez trzy zestawy pytań, coraz bardziej osobistych, odpowiadając na każde na zmianę. Sesja trwała około **45 minut**. Potem te pary mówiły, że czują się wobec siebie wyraźnie bliżej niż nieznajomi, którzy te same 45 minut spędzili na rozmowie o niczym." },
    { type: "p", text: "Warto być precyzyjnym co do tego, co to badanie pokazało, a czego nie, bo popularna wersja oddaliła się od artykułu bardzo daleko. Pokazało, że **narastające, wzajemne otwieranie się** — odpowiadają oboje, każda odpowiedź odrobinę bardziej osobista niż poprzednia — buduje bliskość między obcymi ludźmi i że dzieje się to zaskakująco szybko. Nie pokazało, że ktoś zakochuje się w kilka minut, i nigdy nie było algorytmem dopasowania: nikogo nie łączono na podstawie odpowiedzi, a pytania nie były testem zgodności. Słowem, które dźwiga cały wynik, jest **wzajemne**." },
    { type: "p", text: "To jest prawdziwy powód, dla którego pytania są ciekawe w randkowaniu, i jest węższy niż ten, który podaje internet. Badania wspierają tyle: pytać i odpowiadać to sposób, w jaki dwoje obcych ludzi zaczyna się lubić. Czy osoba, którą polubisz, okaże się dobrym partnerem, to osobne pytanie i żaden zestaw pytań na nie nie odpowie. Qulo bierze stąd kolejność, nie prognozę: najpierw wymiana, twarz potem." },

    { type: "h2", text: "Robotę wykonuje wzajemność" },
    { type: "p", text: "Sprecher, Treger, Wondra, Hilaire i Wallpe sprawdzili dokładnie to w 2013 roku w **Journal of Experimental Social Psychology**. Pary nieznajomych albo otwierały się na zmianę — oboje pytali, oboje odpowiadali — albo dzieliły role: jedna osoba mówiła, druga słuchała, a potem się zamieniały. Zmienianie się dawało więcej sympatii i więcej bliskości. Między tymi samymi dwiema osobami przepływała ta sama ilość informacji; zmieniał się tylko kształt wymiany." },
    { type: "p", text: "Huang, Yeomans, Brooks, Minson i Gino znaleźli wersję najbardziej istotną dla randkowania we wrześniu 2017 roku w **Journal of Personality and Social Psychology**. Na **110** uczestnikach speed datingu i **1961** decyzjach o drugiej randce ci, którzy zadawali więcej pytań — zwłaszcza **pytań pogłębiających**, tych pokazujących, że naprawdę usłyszałeś poprzednią odpowiedź — częściej byli zapraszani ponownie. Nie najatrakcyjniejsi, nie najdowcipniejsi. Ci, którzy pytali." },
    { type: "p", text: "Zdjęcie i dwie linijki opisu nie potrafią nic z tego. Idą w jedną stronę, niczego od ciebie nie chcą i nie zostawiają nic, na co można odpowiedzieć. Pytanie to najmniejszy przedmiot, który zmusza obie osoby do położenia czegoś na stole." },

    { type: "h2", text: "Teoria przywiązania: rama, nie wyrok" },
    { type: "p", text: "Teoria przywiązania Johna Bowlby'ego to standardowy słownik opisujący, jak ludzie zachowują się w bliskich relacjach — bezpiecznie, lękowo, unikowo — i jest prawdziwą ramą, którą warto nazwać po imieniu. Równie warto powiedzieć, czym nie jest. Bowlby pisał o dzieciach i opiekunach dekady wcześniej, zanim ktokolwiek przesunął cokolwiek palcem po ekranie, i nikt nie wykazał, że aplikacja randkowa przesuwa styl przywiązania dorosłej osoby w którąkolwiek stronę. Kto mówi ci, że aplikacja naprawi albo zniszczy twój sposób przywiązywania się, coś ci sprzedaje." },
    { type: "p", text: "To, co projekt aplikacji naprawdę może zmienić, jest węższe i bardziej przyziemne: co znaczy „nie”. Gdy dopasowanie idzie przez zdjęcia, brak dopasowania czyta się jak wyrok na twoją twarz, bo twarz była wszystkim, co wystawiono. Gdy idzie przez pytania drugiej osoby, pudło czyta się jak pudło: nie trafiłeś odpowiedzi. To różnica w ramowaniu, nie obietnica terapeutyczna — i ramowanie jest uczciwą miarą tej sprawy." },

    { type: "h2", text: "Zgodność poznawcza i trójkąt Sternberga" },
    { type: "p", text: "Zgodność poznawcza to prosta myśl w akademickim płaszczu: dwoje ludzi, których myślenie biegnie podobnymi torami — jak podchodzą do problemu, co uznają za oczywiste, z czego się śmieją. Pytania pokazują to wcześnie, bo sposób, w jaki ktoś układa pytanie, mówi tyle samo co odpowiedź. Czego nikt nie wykazał i czego ten artykuł nie będzie twierdził: trafienie pytań nieznajomej osoby nie przewiduje związku. Przewiduje, że byłeś uważny." },
    { type: "p", text: "Trójkątna teoria miłości Roberta Sternberga przydaje się tu jako opis, nie jako dowód. Dzieli trwałą miłość na trzy składniki: intymność, namiętność i zaangażowanie. Zdjęcie przemawia najwyżej do jednego wierzchołka tego trójkąta i robi to, zanim wiesz cokolwiek innego. Pozostałe dwa wierzchołki budują się w rozmowie, jeśli w ogóle. To sposób myślenia o tym, co pomija pierwsze wrażenie zbudowane na zdjęciu — nie pomiar, i nie ma do niego żadnej liczby." },

    { type: "h2", text: "Dlaczego zdjęcie mówi mniej, niż się wydaje" },
    { type: "p", text: "Nic z tego nie czyni pociągu nieważnym. Czyni zdjęcie kiepskim pojemnikiem na niego. Cztery znajome problemy, z których żaden nie potrzebuje statystyki, by być oczywisty:" },
    { type: "ul", items: [
      "**Efekt aureoli:** po cichu zakładamy, że ktoś, kogo uważamy za atrakcyjnego, jest też milszy, zabawniejszy i bardziej kompetentny. To jedno z najdłużej udokumentowanych zniekształceń w psychologii społecznej i myli się mniej więcej tak samo często, jak trafia.",
      "**Zdjęcie jest wybrane:** najlepsze z kilkuset, w dobrym świetle, pod działającym kątem, w dniu, który się udał. Uczciwe wobec twarzy i niewiarygodne wobec niemal wszystkiego innego.",
      "**Wygląd przestaje być nową informacją:** większość tego, co twarz ma do powiedzenia, mieści się w pierwszym wrażeniu, potem się powtarza. To, jak się z kimś rozmawia, tak się nie kończy.",
      "**Zdjęcie nie umie odpowiedzieć:** nic, czego się z niego dowiadujesz, nie przyszło w odpowiedzi na coś, co zaoferowałeś — a to właśnie ta wzajemność, na którą wskazują powyższe badania.",
    ] },
    { type: "p", text: "To granica tego, co dopasowanie po zdjęciach może ci powiedzieć. To nie dowód, że pytania przewidują, z kim powinieneś być. Tylko tyle, że zdjęcie i tak nigdy nie miało tego zrobić, a wymiana zostawia w ręku coś, czego twarz nie daje." },

    { type: "h2", text: "Co Qulo naprawdę z tym robi", accent: "green" },
    { type: "p", text: "Qulo nie twierdzi, że prowadzi dopasowanie zweryfikowane naukowo, bo w randkowaniu coś takiego nie istnieje. Robi co innego: mechanicznie stawia wymianę na początku, tak żeby nie dało się jej pominąć:" },
    { type: "ul", items: [
      "**Piszesz od 2 do 4 pytań o sobie** — wielokrotnego wyboru, po cztery opcje — i zaznaczasz tę, która jest o tobie prawdziwa. W planie płatnym limit rośnie do 10 pytań.",
      "**Dopasowanie następuje tylko przy komplecie trafień.** Jedna zła odpowiedź to brak dopasowania, więc nikt nie dociera tu, klikając na oślep.",
      "**Pytania są przed twarzą,** co odwraca zwykłą kolejność pierwszego wrażenia.",
      "**Rozwiązywanie wymaga uwagi.** Wysiłek niewiele gwarantuje, ale jest realnym dowodem, że druga osoba przeczytała to, co napisałeś.",
      "**Opcjonalne moce — podpowiedź, zmniejszenie liczby opcji o połowę, pominięcie pytania — kosztują diamenty w aplikacji i nigdy nie są wymagane do dopasowania.** Każde pytanie da się rozwiązać, nie wydając niczego.",
    ] },

    { type: "h2", text: "Jak pisać pytania warte odpowiedzi" },
    { type: "p", text: "Ponieważ twoja odpowiedź musi być do znalezienia, pisanie dobrych pytań to osobna umiejętność. Powyższe prace podpowiadają cel: na tyle osobiste, żeby warto było je zdradzić, i w zasięgu kogoś, kto uważa, a nie zgaduje." },
    { type: "ul", items: [
      "**Bądź konkretny w sprawie siebie:** „miasto, do którego przeprowadziłbym się jutro” bije „moje ulubione miasto”. Pierwsze to fakt o tobie, drugie to rozmowa o pogodzie.",
      "**Do znalezienia, nie do wywróżenia:** poprawna odpowiedź powinna wynikać z twojego profilu, twoich zdjęć i odrobiny myślenia. Pytanie, które trafi tylko twoja siostra, to nie filtr, to mur.",
      "**Unikaj opcji ozdobnych:** cztery wiarygodne opcje, z których jedna jest prawdziwa, to pytanie. Jedna prawdziwa i trzy żarty to formalność.",
      "**Pytaj o wybory, nie o ciekawostki:** co byś zrobił, z czego byś zrezygnował, dokąd byś pojechał. Wybory pokazują człowieka; fakty o nim najczęściej nie.",
      "**Zmieniaj głębokość:** zacznij lekko, a to pytanie, na którym naprawdę ci zależy, postaw jako trzecie albo czwarte. Właśnie o to narastanie chodziło w badaniu z 1997 roku.",
    ] },

    { type: "quote", text: "Najkrótsza droga do poznania kogoś to pytanie, na które musicie odpowiedzieć oboje. To nie odkrycie — to po prostu to, czym jest rozmowa." },

    { type: "h2", text: "Uczciwa wersja", accent: "green" },
    { type: "p", text: "Dopasowanie przez pytania nie jest udowodnioną drogą do związku i ten artykuł nie będzie udawał, że jest. To, co wspierają badania, jest mniejsze i wciąż warte budowania: zadawać pytania i odpowiadać na nie na zmianę to sposób, w jaki obcy ludzie zaczynają się lubić — Aron ze współpracownikami w 1997, Sprecher ze współpracownikami w 2013 i Huang ze współpracownikami w 2017 wskazują w tę samą stronę. Zdjęcie tego nie robi. Jedyna prawdziwa deklaracja Qulo dotyczy projektu: robi z wymiany drzwi wejściowe zamiast dopisku i zostawia tobie decyzję, co te odpowiedzi znaczą." },
  ],
  sv: [
    { type: "h2", text: "Vad Arons studie med 36 frågor faktiskt visade" },
    { type: "p", text: "År 1997 publicerade Arthur Aron, Edward Melinat, Elaine Aron, Robert Vallone och Renee Bator i **Personality and Social Psychology Bulletin** en procedur som sedan dess har citerats, felciterats och gjorts om till listor. Två främlingar satte sig ner tillsammans och gick igenom tre uppsättningar frågor som blev allt mer personliga, och besvarade varje fråga turvis. Sessionen tog ungefär **45 minuter**. Efteråt uppgav paren att de kände sig märkbart närmare varandra än främlingar som ägnat samma 45 minuter åt kallprat." },
    { type: "p", text: "Det är värt att vara noggrann med vad studien visade och inte visade, för den populära versionen har hamnat långt från artikeln. Den visade att **gradvis stegrat, ömsesidigt självavslöjande** — båda svarar, varje svar en aning mer personligt än det förra — skapar närhet mellan främlingar, och att det kan gå förvånansvärt fort. Den visade inte att någon blir kär på några minuter, och den var aldrig en matchningsalgoritm: ingen parades ihop utifrån sina svar, och frågorna var inte ett kompatibilitetstest. **Ömsesidigt** är ordet som bär hela resultatet." },
    { type: "p", text: "Det är det verkliga skälet till att frågor är intressanta i dejtingsammanhang, och det är smalare än vad internet brukar påstå. Det forskningen stöder är att fråga och svara är hur två främlingar börjar tycka om varandra. Om den du börjar tycka om blir en bra partner är en annan fråga, och ingen uppsättning frågor besvarar den. Det Qulo tar med sig härifrån är ordningen, inte en förutsägelse: utbytet först, ansiktet sedan." },

    { type: "h2", text: "Det är ömsesidigheten som gör jobbet" },
    { type: "p", text: "Sprecher, Treger, Wondra, Hilaire och Wallpe testade precis detta 2013 i **Journal of Experimental Social Psychology**. Par av främlingar öppnade sig antingen turvis — båda frågade, båda svarade — eller delade upp rollerna: den ena berättade, den andra lyssnade, och sedan bytte de. Att turas om gav mer sympati och mer närhet. Samma mängd information passerade mellan samma två personer; det enda som ändrades var utbytets form." },
    { type: "p", text: "Huang, Yeomans, Brooks, Minson och Gino hittade den version som är mest direkt relevant för dejting i september 2017 i **Journal of Personality and Social Psychology**. Över **110** snabbdejtare och **1 961** beslut om en andra dejt blev de som ställde fler frågor — framför allt **följdfrågor**, den sortens fråga som visar att du verkligen hörde det förra svaret — oftare tillfrågade igen. Inte de mest attraktiva, inte de roligaste. De som frågade." },
    { type: "p", text: "Ett foto och två rader presentation klarar inget av detta. De går åt ett håll, kräver ingenting av dig och lämnar inget att svara på. En fråga är det minsta föremål som tvingar båda att lägga fram något." },

    { type: "h2", text: "Anknytningsteori: en ram, inte en dom" },
    { type: "p", text: "John Bowlbys anknytningsteori är standardvokabulären för hur människor beter sig i nära relationer — trygg, otrygg, undvikande — och det är en verklig ram, värd att nämna vid namn. Det är lika värt att säga vad den inte är. Bowlby skrev om barn och omsorgspersoner decennier innan någon svepte på en skärm, och ingen har visat att en dejtingapp flyttar en vuxen människas anknytningsstil åt något håll. Den som säger att en app kan laga eller förstöra ditt sätt att knyta an säljer något." },
    { type: "p", text: "Det en apps design faktiskt kan ändra är smalare och mer vardagligt: vad ett nej betyder. När matchningen går via foton läses en utebliven match som en dom över ditt ansikte, för ansiktet var allt som erbjöds. När den går via den andres frågor läses en miss som en miss: du prickade inte svaren. Det är en skillnad i inramning, inte ett terapeutiskt löfte — och inramningen är sakens ärliga storlek." },

    { type: "h2", text: "Kognitiv passform och Sternbergs triangel" },
    { type: "p", text: "Kognitiv passform är en enkel idé i akademisk rock: två människor vars tänkande löper längs liknande linjer — hur de närmar sig ett problem, vad de tar för givet, vad de skrattar åt. Frågor får fram det tidigt, eftersom hur någon formulerar en fråga säger lika mycket som svaret. Det ingen har visat, och som den här artikeln inte kommer att påstå, är att pricka en främlings frågor förutsäger en relation. Det förutsäger att du var uppmärksam." },
    { type: "p", text: "Robert Sternbergs triangulära kärleksteori är användbar här som beskrivning, inte som bevis. Den delar upp varaktig kärlek i tre komponenter: intimitet, passion och engagemang. Ett foto talar på sin höjd till ett hörn av den triangeln, och det gör det innan du vet något annat. De andra två hörnen byggs i samtalet, om de byggs alls. Det är ett sätt att tänka kring vad ett fotodrivet första intryck lämnar utanför — ingen mätning, och ingen siffra hör dit." },

    { type: "h2", text: "Varför ett foto säger mindre än det verkar" },
    { type: "p", text: "Inget av detta gör attraktion oviktig. Det gör fotot till ett dåligt kärl för den. Fyra välbekanta problem, inget av dem i behov av statistik för att synas:" },
    { type: "ul", items: [
      "**Haloeffekten:** vi antar tyst att någon vi tycker är attraktiv också är snällare, roligare och mer kompetent. Det är en av de äldst dokumenterade skevheterna i socialpsykologin, och den har ungefär lika ofta fel som rätt.",
      "**Ett foto är utvalt:** det bästa av ett par hundra, i bra ljus, från vinkeln som funkar, en dag som gick bra. Ärligt om ett ansikte och opålitligt om nästan allt annat.",
      "**Utseende slutar vara ny information:** det mesta ett ansikte har att säga ryms i första intrycket, sedan upprepas det. Hur det är att prata med någon tar inte slut på det sättet.",
      "**Ett foto kan inte svara:** inget du lär dig av det kom som svar på något du erbjöd — vilket är precis den ömsesidighet som studierna ovan pekar på.",
    ] },
    { type: "p", text: "Det är en gräns för vad fotodriven matchning kan berätta. Det är inget bevis för att frågor förutsäger vem du borde vara med. Bara för att ett foto ändå aldrig skulle göra det, och att ett utbyte lämnar något i handen som ett ansikte inte ger." },

    { type: "h2", text: "Vad Qulo faktiskt gör med det här", accent: "green" },
    { type: "p", text: "Qulo påstår sig inte ha vetenskapligt validerad matchning, för något sådant finns inte inom dejting. Det appen gör är att mekaniskt sätta utbytet först, så att det inte går att hoppa över:" },
    { type: "ul", items: [
      "**Du skriver 2 till 4 frågor om dig själv** — flervalsfrågor med fyra alternativ vardera — och markerar det alternativ som stämmer på dig. Med ett betalt abonnemang höjs taket till 10 frågor.",
      "**Någon matchar genom att pricka alla rätt.** Ett enda fel svar betyder ingen match, så ingen kommer in genom att trycka på måfå.",
      "**Frågorna kommer före ansiktet,** vilket vänder på den vanliga ordningen för ett första intryck.",
      "**Att lösa kräver uppmärksamhet.** Ansträngning garanterar lite, men är ett verkligt bevis på att den andra läste det du skrev.",
      "**De valfria krafterna — en ledtråd, att halvera alternativen, att hoppa över en fråga — kostar diamanter i appen och krävs aldrig för en match.** Varje fråga går att lösa utan att spendera något.",
    ] },

    { type: "h2", text: "Så skriver du frågor som är värda ett svar" },
    { type: "p", text: "Eftersom ditt svar måste gå att hitta är det en egen färdighet att skriva bra frågor. Arbetena ovan pekar ut målet: personligt nog att vara värt att dela, och inom räckhåll för någon som är uppmärksam snarare än gissar." },
    { type: "ul", items: [
      "**Var specifik om dig själv:** ”staden jag skulle flytta till i morgon” slår ”min favoritstad”. Det ena är ett faktum om dig, det andra är kallprat.",
      "**Hittbart, inte tankeläsning:** rätt svar ska gå att nå via din profil, dina bilder och lite eftertanke. En fråga som bara din syster kan pricka är inget filter, det är en vägg.",
      "**Undvik dekorativa alternativ:** fyra rimliga alternativ där ett är sant är en fråga. Ett sant och tre skämt är en formalitet.",
      "**Fråga om val, inte om trivia:** vad du skulle göra, vad du skulle avstå från, vart du skulle åka. Val visar en människa; fakta om henne gör det sällan.",
      "**Variera djupet:** börja lätt och lägg den fråga som verkligen betyder något som tredje eller fjärde. Det var precis den stegringen studien från 1997 handlade om.",
    ] },

    { type: "quote", text: "Den kortaste vägen till att lära känna någon är en fråga ni båda måste besvara. Det är ingen upptäckt — det är helt enkelt vad ett samtal är." },

    { type: "h2", text: "Den ärliga versionen", accent: "green" },
    { type: "p", text: "Frågebaserad matchning är ingen bevisad väg till en relation, och den här artikeln tänker inte låtsas annat. Det forskningen stöder är mindre och ändå värt att bygga på: att ställa frågor och besvara dem i tur och ordning är hur främlingar börjar tycka om varandra — Aron med kollegor 1997, Sprecher med kollegor 2013 och Huang med kollegor 2017 pekar åt samma håll. Ett foto gör inte det. Qulos enda verkliga anspråk handlar om design: utbytet blir ingången i stället för en eftertanke, och vad svaren betyder får du avgöra själv." },
  ],
  hi: [
    { type: "h2", text: "आरोन के 36 सवालों वाले अध्ययन ने असल में क्या दिखाया" },
    { type: "p", text: "1997 में Arthur Aron, Edward Melinat, Elaine Aron, Robert Vallone और Renee Bator ने **Personality and Social Psychology Bulletin** में एक प्रक्रिया प्रकाशित की, जिसे तब से लगातार उद्धृत किया गया, ग़लत उद्धृत किया गया और इंटरनेट की सूचियों में बदला गया। दो अजनबी साथ बैठते और तीन सेट सवालों से गुज़रते, जो धीरे-धीरे और निजी होते जाते थे, और हर सवाल का जवाब बारी-बारी से देते। यह सत्र लगभग **45 मिनट** चलता था। इसके बाद इन जोड़ों ने बताया कि वे एक-दूसरे के काफ़ी क़रीब महसूस कर रहे हैं — उन अजनबियों से कहीं ज़्यादा जिन्होंने वही 45 मिनट हल्की-फुल्की बातचीत में बिताए थे।" },
    { type: "p", text: "यह ठीक-ठीक कहना ज़रूरी है कि उस अध्ययन ने क्या दिखाया और क्या नहीं, क्योंकि लोकप्रिय कहानी शोध-पत्र से बहुत दूर जा चुकी है। उसने दिखाया कि **क्रमशः गहराता आपसी आत्म-प्रकटन** — दोनों जवाब दें, और हर जवाब पिछले से थोड़ा और निजी हो — अजनबियों के बीच नज़दीकी पैदा करता है, और यह हैरान कर देने वाली तेज़ी से हो सकता है। उसने यह नहीं दिखाया कि कोई कुछ मिनटों में प्यार में पड़ जाता है, और वह कभी मैचिंग एल्गोरिद्म था ही नहीं: किसी को उसके जवाबों के आधार पर किसी से जोड़ा नहीं गया, और वे सवाल कोई अनुकूलता परीक्षण नहीं थे। पूरे नतीजे का भार जिस शब्द पर है, वह है **आपसी**।" },
    { type: "p", text: "डेटिंग में सवाल दिलचस्प क्यों हैं, इसकी असली वजह यही है — और यह वजह इंटरनेट की बताई वजह से कहीं संकरी है। शोध जिसका समर्थन करता है वह इतना ही है: पूछना और जवाब देना ही वह तरीक़ा है जिससे दो अजनबी एक-दूसरे को पसंद करने लगते हैं। जो व्यक्ति आपको पसंद आया वह अच्छा साथी बनेगा या नहीं, यह अलग सवाल है और कोई सवाल-सूची इसका जवाब नहीं देती। Qulo यहाँ से भविष्यवाणी नहीं, क्रम लेती है: पहले आदान-प्रदान, चेहरा उसके बाद।" },

    { type: "h2", text: "काम पारस्परिकता करती है" },
    { type: "p", text: "Sprecher, Treger, Wondra, Hilaire और Wallpe ने ठीक यही 2013 में **Journal of Experimental Social Psychology** में परखा। अजनबियों की जोड़ियाँ या तो बारी-बारी से खुलती थीं — दोनों पूछते, दोनों जवाब देते — या भूमिकाएँ बाँट लेती थीं: एक बोलता, दूसरा सुनता, फिर वे बदल जाते। बारी-बारी वाले तरीक़े ने ज़्यादा पसंदगी और ज़्यादा नज़दीकी पैदा की। उन्हीं दो लोगों के बीच उतनी ही जानकारी गई; बदला सिर्फ़ आदान-प्रदान का आकार।" },
    { type: "p", text: "Huang, Yeomans, Brooks, Minson और Gino ने डेटिंग से सीधे जुड़ा रूप सितंबर 2017 में **Journal of Personality and Social Psychology** में पाया। **110** स्पीड-डेटिंग प्रतिभागियों और दूसरी डेट से जुड़े **1,961** फ़ैसलों में, जिन लोगों ने ज़्यादा सवाल पूछे — ख़ासकर **आगे बढ़ाने वाले सवाल**, यानी वे जो दिखाते हैं कि आपने पिछला जवाब सचमुच सुना — उन्हें दोबारा बुलाए जाने की संभावना ज़्यादा थी। सबसे आकर्षक नहीं, सबसे मज़ाक़िया भी नहीं। वे, जिन्होंने पूछा।" },
    { type: "p", text: "एक तस्वीर और दो लाइन का परिचय इनमें से कुछ नहीं कर सकते। वे एक ही दिशा में चलते हैं, आपसे कुछ नहीं माँगते, और जवाब देने लायक़ कुछ छोड़ते भी नहीं। सवाल वह सबसे छोटी चीज़ है जो दोनों लोगों से कुछ न कुछ रखवाती है।" },

    { type: "h2", text: "अटैचमेंट थ्योरी: एक ढाँचा, फ़ैसला नहीं" },
    { type: "p", text: "John Bowlby की अटैचमेंट थ्योरी वह मानक शब्दावली है जिससे हम बताते हैं कि लोग क़रीबी रिश्तों में कैसे बर्ताव करते हैं — सुरक्षित, चिंतित, बचने वाला। यह सचमुच एक ढाँचा है और इसे नाम लेकर पुकारना ठीक है। उतना ही ज़रूरी यह कहना है कि यह क्या नहीं है। Bowlby बच्चों और उनकी देखभाल करने वालों पर लिख रहे थे — किसी के स्क्रीन पर उँगली फेरने से कई दशक पहले — और किसी ने यह नहीं दिखाया कि कोई डेटिंग ऐप किसी वयस्क की अटैचमेंट शैली को इधर या उधर खिसका देती है। जो आपसे कहे कि कोई ऐप आपके जुड़ने के ढंग को ठीक कर देगी या बिगाड़ देगी, वह आपको कुछ बेच रहा है।" },
    { type: "p", text: "ऐप का डिज़ाइन जो बदल सकता है वह ज़्यादा संकरा और ज़्यादा साधारण है: ना का मतलब क्या है। जब मैचिंग तस्वीरों से चलती है, तो मैच न होना आपके चेहरे पर फ़ैसले की तरह पढ़ा जाता है, क्योंकि पेश तो सिर्फ़ चेहरा ही किया गया था। जब वह सामने वाले के सवालों से चलती है, तो चूक सिर्फ़ चूक की तरह पढ़ी जाती है: आपने जवाब सही नहीं किए। यह ढाँचे का फ़र्क़ है, कोई चिकित्सकीय वादा नहीं — और यही इस बात का ईमानदार आकार है।" },

    { type: "h2", text: "संज्ञानात्मक मेल और स्टर्नबर्ग का त्रिकोण" },
    { type: "p", text: "संज्ञानात्मक मेल अकादमिक कोट पहने एक सीधी-सी बात है: दो लोग जिनकी सोच मिलती-जुलती लीक पर चलती है — वे किसी समस्या को कैसे पकड़ते हैं, किसे स्वाभाविक मानते हैं, किस पर हँसते हैं। सवाल इसे जल्दी सामने ले आते हैं, क्योंकि कोई सवाल किस तरह गढ़ता है, यह जवाब जितना ही बताता है। जो किसी ने नहीं दिखाया — और यह लेख भी दावा नहीं करेगा — वह यह है कि किसी अजनबी के सवाल सही कर लेना किसी रिश्ते की भविष्यवाणी करता है। वह बस इतना बताता है कि आपने ध्यान दिया।" },
    { type: "p", text: "Robert Sternberg का प्रेम का त्रिकोणीय सिद्धांत यहाँ प्रमाण के तौर पर नहीं, विवरण के तौर पर काम आता है। यह टिकाऊ प्रेम को तीन हिस्सों में बाँटता है: आत्मीयता, आवेग और प्रतिबद्धता। एक तस्वीर उस त्रिकोण के अधिक से अधिक एक कोने से बात करती है, और तब करती है जब आप और कुछ नहीं जानते। बाक़ी दो कोने, अगर बनते हैं, तो बातचीत में बनते हैं। यह सोचने का एक तरीक़ा है कि तस्वीर से बना पहला प्रभाव क्या छोड़ देता है — यह कोई माप नहीं है, और इससे कोई आँकड़ा जुड़ा हुआ नहीं है।" },

    { type: "h2", text: "तस्वीर दिखने से कम क्यों बताती है" },
    { type: "p", text: "इनमें से कोई बात आकर्षण को ग़ैर-ज़रूरी नहीं बनाती। ये बस इतना कहती हैं कि तस्वीर उसके लिए ख़राब बर्तन है। चार जानी-पहचानी दिक़्क़तें, जिनमें से किसी को साफ़ दिखने के लिए आँकड़े की ज़रूरत नहीं:" },
    { type: "ul", items: [
      "**हेलो प्रभाव:** जिसे हम आकर्षक पाते हैं, उसे चुपचाप ज़्यादा दयालु, ज़्यादा मज़ेदार और ज़्यादा क़ाबिल भी मान लेते हैं। यह सामाजिक मनोविज्ञान के सबसे पुराने दर्ज पूर्वाग्रहों में से एक है, और यह जितनी बार सही होता है लगभग उतनी ही बार ग़लत।",
      "**तस्वीर चुनी हुई होती है:** कुछ सौ में से सबसे अच्छी, अच्छी रोशनी में, उस कोण से जो जँचता है, ऐसे दिन जो अच्छा बीता। चेहरे के बारे में ईमानदार, बाक़ी लगभग हर चीज़ के बारे में भरोसे लायक़ नहीं।",
      "**रूप जल्दी ही नई जानकारी नहीं रह जाता:** चेहरा जो कहना चाहता है उसका ज़्यादातर हिस्सा पहले प्रभाव में आ जाता है, उसके बाद वही दोहराव है। किसी से बात करना कैसा लगता है, वह इस तरह ख़त्म नहीं होता।",
      "**तस्वीर जवाब नहीं दे सकती:** उससे आप जो कुछ जानते हैं, वह आपकी दी हुई किसी चीज़ के जवाब में नहीं आया — और ऊपर के अध्ययन जिसे अहम बताते हैं, वह यही पारस्परिकता है।",
    ] },
    { type: "p", text: "यह उस सीमा की बात है जो तस्वीर से शुरू होने वाली मैचिंग आपको बता सकती है। यह इस बात का प्रमाण नहीं कि सवाल यह बता देंगे कि आपको किसके साथ होना चाहिए। बस इतना कि तस्वीर यह कभी करने ही वाली नहीं थी, और एक आदान-प्रदान आपके हाथ में वह छोड़ जाता है जो चेहरा नहीं दे पाता।" },

    { type: "h2", text: "Qulo इसका असल में क्या करती है", accent: "green" },
    { type: "p", text: "Qulo यह दावा नहीं करती कि उसकी मैचिंग वैज्ञानिक रूप से प्रमाणित है, क्योंकि डेटिंग में ऐसी कोई चीज़ है ही नहीं। वह जो करती है वह यह है कि आदान-प्रदान को व्यवस्था के स्तर पर सबसे आगे रख देती है, ताकि उसे छोड़ा न जा सके:" },
    { type: "ul", items: [
      "**आप अपने बारे में 2 से 4 सवाल लिखते हैं** — बहुविकल्पीय, हर सवाल में चार विकल्प — और वह विकल्प चुनते हैं जो आप पर सही बैठता है। भुगतान वाली योजना में यह सीमा 10 सवाल तक जाती है।",
      "**सामने वाला तभी मैच करता है जब सारे जवाब सही हों।** एक भी ग़लत जवाब का मतलब है कोई मैच नहीं; यानी यहाँ कोई यूँ ही टैप करके नहीं पहुँचता।",
      "**सवाल चेहरे से पहले आते हैं,** और इससे पहले प्रभाव का सामान्य क्रम उलट जाता है।",
      "**हल करने में ध्यान लगता है।** मेहनत किसी बात की पक्की गारंटी नहीं, पर यह असली सबूत है कि सामने वाले ने आपका लिखा पढ़ा।",
      "**वैकल्पिक शक्तियाँ — संकेत, विकल्प आधे करना, सवाल छोड़ना — ऐप के भीतर डायमंड ख़र्च करती हैं और मैच के लिए कभी ज़रूरी नहीं होतीं।** हर सवाल बिना कुछ ख़र्च किए हल हो सकता है।",
    ] },

    { type: "h2", text: "जवाब देने लायक़ सवाल कैसे लिखें" },
    { type: "p", text: "चूँकि आपका जवाब खोजा जा सकने वाला होना चाहिए, अच्छे सवाल लिखना अपने आप में एक हुनर है। ऊपर के काम बताते हैं कि निशाना कहाँ रखें: इतना निजी कि बताने लायक़ हो, और इतना पहुँच में कि अंदाज़ा लगाने वाले को नहीं, ध्यान देने वाले को मिल जाए।" },
    { type: "ul", items: [
      "**अपने बारे में ठोस रहें:** “वह शहर जहाँ मैं कल ही चला जाऊँ” “मेरा पसंदीदा शहर” से बेहतर है। पहला आपके बारे में एक तथ्य है, दूसरा औपचारिक बातचीत।",
      "**खोजा जा सके, अंतर्यामी होना न पड़े:** सही जवाब आपकी प्रोफ़ाइल, आपकी तस्वीरों और थोड़े सोचने से निकल आना चाहिए। जिस सवाल का जवाब सिर्फ़ आपकी बहन जानती हो, वह छलनी नहीं, दीवार है।",
      "**सजावटी विकल्पों से बचें:** चार भरोसेमंद विकल्प जिनमें एक सच हो — वह सवाल है। एक सच और तीन मज़ाक़ — वह औपचारिकता है।",
      "**जानकारी नहीं, चुनाव पूछें:** आप क्या करते, किसे छोड़ देते, कहाँ जाते। चुनाव इंसान को दिखाते हैं; उसके बारे में तथ्य अक्सर नहीं।",
      "**गहराई बदलते रहें:** हल्के सवाल से शुरू करें और जो सवाल आपके लिए सचमुच मायने रखता है उसे तीसरे या चौथे नंबर पर रखें। 1997 का अध्ययन असल में इसी चढ़ाव के बारे में था।",
    ] },

    { type: "quote", text: "किसी को जानने का सबसे छोटा रास्ता वह सवाल है जिसका जवाब आप दोनों को देना पड़े। यह कोई खोज नहीं — बातचीत होती ही यही है।" },

    { type: "h2", text: "ईमानदार बात", accent: "green" },
    { type: "p", text: "सवालों पर आधारित मैचिंग किसी रिश्ते तक पहुँचने का प्रमाणित रास्ता नहीं है, और यह लेख इसका दिखावा भी नहीं करेगा। शोध जिसका समर्थन करता है वह छोटा है और फिर भी उस पर कुछ बनाने लायक़ है: सवाल पूछना और बारी-बारी से जवाब देना ही वह तरीक़ा है जिससे अजनबी एक-दूसरे को पसंद करने लगते हैं — 1997 में Aron और साथी, 2013 में Sprecher और साथी, 2017 में Huang और साथी, सब एक ही दिशा की ओर इशारा करते हैं। तस्वीर यह काम नहीं करती। Qulo का इकलौता असली दावा डिज़ाइन का दावा है: वह आदान-प्रदान को बाद की बात नहीं, दाख़िले का दरवाज़ा बनाती है — और जवाबों का मतलब क्या है, यह तय करना आप पर छोड़ देती है।" },
  ],
};
