import Link from "next/link";

export function FirstDateTipsContent({ locale }: { locale: string }) {
  if (locale === "tr") {
    return (
      <>
        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Giriş: İlk Buluşma Neden Stres Yaratır?</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          İlk buluşma, insan ilişkilerinin en heyecan verici ama aynı zamanda en stresli anlarından biridir.
          Psikoloji araştırmaları, ilk buluşma öncesi yaşanan kaygının &quot;performans kaygısı&quot; ile benzer
          nörolojik tepkiler ürettiğini gösteriyor. Beyin, bilinmeyen bir durum karşısında aşırı tetikte
          kalarak kortizol salgılar ve bu durum hem fiziksel hem de duygusal tükenmeye yol açabilir.
        </p>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Ancak iyi haber şu: İlk buluşma stresini yönetmek, doğru hazırlık ve doğru zihinsel yaklaşımla
          mümkün. Bu rehberde size ilk buluşmada rahat olmanızı, anlamlı bir bağlantı kurmanızı ve hem
          kendinizin hem de karşınızdakinin güvende hissetmesini sağlayacak kanıtlanmış ipuçlarını
          paylaşacağız. Özellikle <strong className="text-white">quiz dating</strong> gibi yeni nesil
          eşleşme yöntemleri, ilk buluşmayı çok daha rahat hale getiriyor — çünkü karşınızdaki kişiyi
          zaten biraz tanıyorsunuz.
        </p>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Hazırlık Aşaması</h2>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">1. Doğru Mekan Seçimi</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Mekan, buluşmanın atmosferini belirleyen en önemli faktördür. İlk buluşmalar için kalabalık
          olmayan, sakin ve dinlenebileceğiniz bir ortam seçin. Kafe veya sakin bir bar, akşam yemeği
          planından çok daha iyi bir başlangıçtır. Çünkü uzun süreli bir yemek, kötü geçtiğinde kaçış
          zor olur. Kafe buluşması 45-60 dakika sürerken, yemek 2-3 saate uzayabilir.
        </p>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Güvenlik açısından ilk buluşmanın halka açık bir yerde olması çok önemlidir. Evler ya da
          özel mekanlar ilk buluşma için uygun değildir. Ayrıca mekanın sizin için rahat olması,
          özgüveninizi artırır. Sevdiğiniz bir kafe, favori caddeniz, tanıdık olduğunuz bir bölge —
          bunlar hepsi &quot;ev avantajı&quot; yaratır.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">2. Kıyafet Seçimi</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Kıyafet seçiminde altın kural: kendiniz olun, ama en iyi versiyonunuz. Sıra dışı giyinmeye
          çalışmak, alışkın olmadığınız kıyafetleri denemek stres yaratır. Bunun yerine daha önce
          kendinizi iyi hissettiğiniz bir kıyafeti tercih edin. Mekana uygun, rahat ve size güven
          veren kıyafetler en iyi seçimdir. Parfüm veya koku kullanacaksanız hafif tutun — ağır kokular
          kapalı mekanlarda rahatsızlık yaratabilir.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">3. Mindset (Zihinsel Hazırlık)</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          En büyük hata ilk buluşmayı &quot;iş görüşmesi&quot; gibi görmektir. Bu bir test değil, iki insanın
          birbirini tanıma fırsatı. &quot;Bu insanla eşleşebilir miyim?&quot; diye düşünmek yerine, &quot;Bu insanı
          tanımak istiyor muyum?&quot; diye sorun. Bu küçük zihinsel değişiklik, baskıyı azaltır ve
          buluşmayı çok daha keyifli hale getirir. Kendinize hatırlatın: Karşınızdaki kişi de muhtemelen
          sizden daha az gergin değildir.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">4. Telefon ve Teknoloji</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Telefonu sessize alın ve masanın üzerine koymayın. Araştırmalar, sadece telefonun görünür
          olmasının bile konuşma kalitesini düşürdüğünü gösteriyor. Buluşma süresince telefona
          dokunmamaya çalışın. Acil bir durum yoksa bildirimler bekleyebilir. Bu küçük detay, karşı
          tarafa &quot;şu anda senin için buradayım&quot; mesajı verir.
        </p>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Görüşme Sırasında</h2>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">Ne Konuşulur? 10 Harika Soru Önerisi</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          İlk buluşmalar için en iyi sorular, kısa cevaplar değil hikayeler gerektirendir. Aşağıdaki
          10 soru, kanıtlanmış şekilde daha derin sohbetler başlatır:
        </p>
        <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
          <li>Son zamanlarda seni en çok ne mutlu etti?</li>
          <li>Çocukken ne olmak istiyordun ve nasıl değişti?</li>
          <li>Hafta sonunun ideal hali nasıl görünür?</li>
          <li>En çok bağlı hissettiğin şehir ya da yer neresi?</li>
          <li>Hayatta en tuhaf ama en iyi kararın neydi?</li>
          <li>Bir şey öğrenmek için bir saatin olsa, ne olurdu?</li>
          <li>Son zamanlarda seni şaşırtan bir şey ne?</li>
          <li>Sadece 3 kişi için yemek pişirebilsen, kimler için pişirirdin?</li>
          <li>Yeni bir şeye başladığında en çok korktuğun şey nedir?</li>
          <li>5 yıl sonra nerede olmak istediğini biliyor musun?</li>
        </ul>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Bu sorular <strong className="text-white">açık uçlu</strong>dur — yani &quot;evet/hayır&quot; yanıtı
          alınmaz. Cevaplar hikayelere dönüşür ve siz de kendinizden parçalar paylaşabilirsiniz. En
          önemlisi: gerçek ilgi gösterin. Aktif dinleme, soru sormaktan daha önemlidir.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">Ne Konuşulmaz? 5 Yasak Konu</h3>
        <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
          <li><strong className="text-white">Eski ilişkiler hakkında detay:</strong> Eksi hakkında konuşmak &quot;eski üzerinde durduğunuz&quot; sinyali verir.</li>
          <li><strong className="text-white">Maaş ve finansal durum:</strong> Kaba ve samimiyetsiz görünür. Bunlar ilerleyen buluşmalar için.</li>
          <li><strong className="text-white">Derin siyasi tartışmalar:</strong> Önemli konular, ama ilk buluşma ortamı çok çekişmeli olabilir.</li>
          <li><strong className="text-white">Evlilik ve çocuk planları:</strong> Henüz birbirinizi tanımıyorsunuz. Bu baskı yaratır.</li>
          <li><strong className="text-white">Aşırı negatif hikayeler:</strong> İş yerinden şikayetler, aile sorunları — pozitif bir giriş için beklensin.</li>
        </ul>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">Beden Dili İpuçları</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Sözsüz iletişim, konuştuğunuz kelimelerin yaklaşık %70&apos;i kadar önemlidir. Araştırmalar,
          ilk buluşmalarda karşı tarafın sempati kurma kararını ilk 4 dakikada verdiğini gösteriyor.
          Beden dilinizle bu algıyı nasıl yönetebilirsiniz?
        </p>
        <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
          <li><strong className="text-white">Göz teması:</strong> Aşırı değil, doğal. 60-70% oranında göz teması idealdir.</li>
          <li><strong className="text-white">Açık duruş:</strong> Kollarınızı çaprazlamayın. Açık kollar güven işaretidir.</li>
          <li><strong className="text-white">Öne doğru eğilme:</strong> Hafif öne eğilmek &quot;seni dinliyorum&quot; mesajı verir.</li>
          <li><strong className="text-white">Gülümseme:</strong> Gerçek gülümseme (gözleri de kapsayan) en güçlü bağlantı aracıdır.</li>
          <li><strong className="text-white">Aynalama:</strong> Karşınızdakinin duruşunu doğal olarak yansıtmak uyumu artırır.</li>
        </ul>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">İlk Buluşma Kırmızı Bayrakları</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          İlk buluşmada fark edilen bazı davranışlar, ileride büyük sorunlara dönüşebilir. Dikkat
          edilmesi gereken uyarı işaretleri için <Link href={`/${locale}/advice/red-flags-online-dating`} className="text-qulo-purple hover:underline">red flag rehberimize</Link> göz atın. İşte kısa bir özet:
        </p>
        <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
          <li>Çalışanlara (garson, barmen vb.) saygısız davranmak</li>
          <li>Sürekli eski ilişkisinden bahsetmek</li>
          <li>Telefonu sürekli kontrol etmek veya çalıştırmak</li>
          <li>Sizi dinlemeden sürekli kendinden bahsetmek</li>
          <li>Alkol konusunda aşırıya kaçmak</li>
          <li>Hakkınızda kaba şakalar veya beklenmedik fiziksel temas</li>
        </ul>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Sonrası: İkinci Buluşma Sinyalleri</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Buluşma iyi geçtiyse ne yapmalısınız? İki kural var: açık olun ve beklemeyin. Karşınızdaki
          kişiyle tekrar görüşmek istiyorsanız, buluşmadan sonra 24 saat içinde mesaj atın. &quot;3 gün
          kuralı&quot; modası geçti — insanlar artık gerçekten ilgilenenleri takdir ediyor. Mesajınız özgün
          olsun: buluşmadan bir detaya atıfta bulunun (&quot;o kafedeki kahve gerçekten harika&apos;ydı&quot;).
        </p>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Eğer karşı taraf ilgi göstermediyse, alma. Dating dünyasında &quot;uyum&quot; iki yönlüdür.
          Reddedilmek, kişisel bir eksiklik değil — sadece iki insanın birbiriyle uyumlu olmadığının
          kanıtıdır. Başka fırsatlar var.
        </p>

        <h2 className="text-2xl font-bold text-qulo-green mb-4 mt-10">Qulo&apos;nun Avantajı: Quiz Dating ile Rahat İlk Buluşmalar</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Geleneksel dating uygulamalarında ilk buluşma bir bilinmezdir. Ama <strong className="text-white">Qulo</strong> gibi
          <Link href={`/${locale}/blog/quiz-dating-future-of-matching`} className="text-qulo-purple hover:underline"> quiz dating </Link>
          sistemlerinde karşınızdaki kişi zaten sorularınızı cevapladı — yani değerleriniz, mizahınız
          ve düşünce yapınız hakkında bir şeyler biliyor. Bu sayede:
        </p>
        <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
          <li><strong className="text-white">İlk konuşma daha rahat:</strong> Konuşma başlatıcısı sorular zaten hazır.</li>
          <li><strong className="text-white">Daha az stres:</strong> Temel uyum zaten var, ispatlamaya gerek yok.</li>
          <li><strong className="text-white">Derin sohbet hızı:</strong> Yüzeysel soru-cevaba vakit kaybetmeden gerçek konulara geçebilirsiniz.</li>
          <li><strong className="text-white">Güvenlik:</strong> Karşı taraf hakkında soruları sayesinde zaten bilgi sahibisiniz.</li>
        </ul>

        <blockquote className="border-l-4 border-qulo-purple pl-4 my-8 italic text-qulo-text-secondary">
          &quot;En iyi ilk buluşmalar, iki yabancının buluştuğu değil, iki meraklının tanıştığı buluşmalardır.&quot;
        </blockquote>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">10 Pratik İpucu: Hızlı Özet</h2>
        <ol className="list-decimal list-inside text-qulo-text-secondary space-y-2 mb-4">
          <li>Buluşma öncesi yeterince uyuyun ve iyi beslenin.</li>
          <li>Mekana 5-10 dakika erken gidin, sakinleşin.</li>
          <li>Telefonu sessize alın ve çantaya koyun.</li>
          <li>İlk 5 dakika: sıcak karşılama, gülümseme, küçük muhabbet.</li>
          <li>Açık uçlu sorular sorun, kendi hikayelerinizi paylaşın.</li>
          <li>Aktif dinleyin — göz teması ve hafif tepki gösterin.</li>
          <li>Samimi olun, kendinizi olmadığınız biri gibi göstermeyin.</li>
          <li>Buluşma sonunda ne hissettiğiniz hakkında dürüst olun.</li>
          <li>Hesabı nasıl paylaşacağınızı rahatça konuşun.</li>
          <li>Eğer iyi geçtiyse — 24 saat içinde mesaj atın.</li>
        </ol>

        <h2 className="text-2xl font-bold text-qulo-green mb-4 mt-10">Sonuç</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          İlk buluşma kusursuz olmak zorunda değil. Mükemmel geçmesini beklemek zaten başarısızlığın
          kaynağı. En iyi ilk buluşmalar, iki insanın kendi olmasına izin verdiği, meraklı olduğu ve
          dürüst olduğu buluşmalardır. Hazırlığınızı yapın, ama beklentilerinizi düşük tutun — sadece
          yeni birini tanıyın. Kim bilir, belki ilk buluşmanız son ilk buluşmanız olur.
        </p>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Daha derin bağlantılar için <Link href={`/${locale}/features`} className="text-qulo-purple hover:underline">Qulo&apos;nun quiz dating özelliklerini</Link> keşfedin
          ve <Link href={`/${locale}/advice/dating-profile-guide`} className="text-qulo-purple hover:underline">harika bir dating profili nasıl yazılır</Link> rehberimizi okuyun.
        </p>
      </>
    );
  }

  // English (default fallback)
  return (
    <>
      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Introduction: Why Are First Dates Stressful?</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        The first date is one of the most exciting yet also most stressful moments in human
        relationships. Psychology research shows that pre-date anxiety produces neurological
        responses similar to &quot;performance anxiety.&quot; The brain stays hyper-alert in unfamiliar
        situations and releases cortisol, which can lead to both physical and emotional exhaustion.
      </p>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        But the good news is: managing first-date stress is possible with proper preparation and
        the right mindset. In this guide, we&apos;ll share proven tips that will help you feel relaxed,
        build a meaningful connection, and ensure both you and your date feel safe. Especially
        new-generation matching methods like <strong className="text-white">quiz dating</strong> make
        first dates much more comfortable — because you already know a bit about the person
        you&apos;re meeting.
      </p>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Preparation Phase</h2>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">1. Choosing the Right Venue</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        The venue is the most important factor that sets the atmosphere of the date. For first
        dates, choose a non-crowded, calm place where you can relax. A café or a quiet bar is much
        better than a dinner plan. Because long dinners are hard to escape if things go badly. A
        café meeting lasts 45-60 minutes, while dinner can extend to 2-3 hours.
      </p>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        For safety, it&apos;s essential that the first date takes place in a public location. Homes or
        private venues are not suitable for first dates. Also, the venue being comfortable for you
        boosts your confidence. A favorite café, your go-to street, a familiar neighborhood — all
        of these create a &quot;home advantage.&quot;
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">2. Outfit Selection</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Golden rule for dressing: be yourself, but your best version. Trying to dress unusually or
        wearing clothes you&apos;re not used to creates stress. Instead, choose an outfit you&apos;ve felt
        good in before. Venue-appropriate, comfortable clothes that make you confident are the best
        choice. If you wear perfume or cologne, keep it light — heavy scents can be overwhelming in
        enclosed spaces.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">3. Mindset (Mental Preparation)</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        The biggest mistake is seeing the first date as a &quot;job interview.&quot; It&apos;s not a test — it&apos;s
        an opportunity for two people to get to know each other. Instead of thinking &quot;Can I match
        with this person?&quot; ask yourself &quot;Do I want to get to know this person?&quot; This small mental
        shift reduces pressure and makes the date much more enjoyable. Remind yourself: the person
        across from you is probably no less nervous than you are.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">4. Phone and Technology</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Put your phone on silent and don&apos;t place it on the table. Research shows that even the
        mere visible presence of a phone reduces conversation quality. Try not to touch your phone
        during the date. Unless there&apos;s an emergency, notifications can wait. This small detail
        sends the message &quot;I&apos;m here for you right now.&quot;
      </p>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">During the Date</h2>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">What to Talk About: 10 Great Question Suggestions</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        The best questions for first dates require stories, not short answers. The following 10
        questions are proven to start deeper conversations:
      </p>
      <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
        <li>What has made you happiest recently?</li>
        <li>What did you want to be as a kid and how did it change?</li>
        <li>What does your ideal weekend look like?</li>
        <li>Where is the city or place you feel most connected to?</li>
        <li>What was the weirdest but best decision of your life?</li>
        <li>If you had one hour to learn something, what would it be?</li>
        <li>What has surprised you recently?</li>
        <li>If you could cook for only 3 people, who would they be?</li>
        <li>What scares you most when starting something new?</li>
        <li>Do you know where you want to be in 5 years?</li>
      </ul>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        These questions are <strong className="text-white">open-ended</strong> — they don&apos;t get
        &quot;yes/no&quot; answers. Answers become stories and you can share pieces of yourself too. Most
        importantly: show genuine interest. Active listening is more important than asking questions.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">What Not to Discuss: 5 Forbidden Topics</h3>
      <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
        <li><strong className="text-white">Details about ex-relationships:</strong> Talking about exes signals &quot;you&apos;re dwelling on the past.&quot;</li>
        <li><strong className="text-white">Salary and financial status:</strong> Seems rude and insincere. Save these for later dates.</li>
        <li><strong className="text-white">Deep political debates:</strong> Important topics, but the first-date setting can become too contentious.</li>
        <li><strong className="text-white">Marriage and kids plans:</strong> You don&apos;t even know each other yet. This creates pressure.</li>
        <li><strong className="text-white">Overly negative stories:</strong> Work complaints, family issues — wait for a positive start.</li>
      </ul>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">Body Language Tips</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Nonverbal communication is nearly 70% as important as the words you speak. Research shows
        that people make sympathy decisions within the first 4 minutes of a date. How can you manage
        that perception with body language?
      </p>
      <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
        <li><strong className="text-white">Eye contact:</strong> Not excessive, natural. 60-70% eye contact is ideal.</li>
        <li><strong className="text-white">Open posture:</strong> Don&apos;t cross your arms. Open arms signal trust.</li>
        <li><strong className="text-white">Leaning forward:</strong> Slightly leaning in sends the message &quot;I&apos;m listening.&quot;</li>
        <li><strong className="text-white">Smiling:</strong> A genuine smile (one that reaches the eyes) is the strongest bonding tool.</li>
        <li><strong className="text-white">Mirroring:</strong> Naturally reflecting the other person&apos;s posture increases rapport.</li>
      </ul>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">First Date Red Flags</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Some behaviors noticed on the first date can evolve into larger problems later. For warning
        signs to watch for, check our <Link href={`/${locale}/advice/red-flags-online-dating`} className="text-qulo-purple hover:underline">red flag guide</Link>. Here&apos;s a quick summary:
      </p>
      <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
        <li>Disrespectful behavior toward service staff (waiters, bartenders, etc.)</li>
        <li>Constantly talking about an ex</li>
        <li>Constantly checking or using their phone</li>
        <li>Only talking about themselves without listening</li>
        <li>Excessive alcohol consumption</li>
        <li>Rude jokes about you or unexpected physical contact</li>
      </ul>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">After: Second Date Signals</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        What should you do if the date went well? Two rules: be clear and don&apos;t wait. If you want
        to see the person again, message within 24 hours of the date. The &quot;3-day rule&quot; is outdated —
        people now appreciate those who genuinely show interest. Your message should be authentic:
        reference a detail from the date (&quot;that café&apos;s coffee was really great&quot;).
      </p>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        If the other side isn&apos;t interested, don&apos;t take it personally. In the dating world,
        &quot;compatibility&quot; is two-way. Rejection isn&apos;t a personal flaw — it&apos;s just evidence that two
        people aren&apos;t compatible. There are other opportunities.
      </p>

      <h2 className="text-2xl font-bold text-qulo-green mb-4 mt-10">Qulo&apos;s Advantage: Relaxed First Dates Through Quiz Dating</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        In traditional dating apps, the first date is a mystery. But in systems like <strong className="text-white">Qulo</strong> that use
        <Link href={`/${locale}/blog/quiz-dating-future-of-matching`} className="text-qulo-purple hover:underline"> quiz dating</Link>,
        the person in front of you has already answered your questions — meaning they know something
        about your values, humor and mindset. This results in:
      </p>
      <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
        <li><strong className="text-white">Easier first conversation:</strong> Conversation starters are already prepared.</li>
        <li><strong className="text-white">Less stress:</strong> Baseline compatibility already exists, no need to prove it.</li>
        <li><strong className="text-white">Faster deep-dive:</strong> You can skip shallow Q&amp;A and dive into real topics.</li>
        <li><strong className="text-white">Safety:</strong> You already have information about the other person through their answers.</li>
      </ul>

      <blockquote className="border-l-4 border-qulo-purple pl-4 my-8 italic text-qulo-text-secondary">
        &quot;The best first dates aren&apos;t where two strangers meet — they&apos;re where two curious people get introduced.&quot;
      </blockquote>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">10 Practical Tips: Quick Summary</h2>
      <ol className="list-decimal list-inside text-qulo-text-secondary space-y-2 mb-4">
        <li>Get enough sleep and eat well before the date.</li>
        <li>Arrive 5-10 minutes early to the venue, calm down.</li>
        <li>Put your phone on silent and in your bag.</li>
        <li>First 5 minutes: warm greeting, smile, small talk.</li>
        <li>Ask open-ended questions, share your own stories.</li>
        <li>Actively listen — maintain eye contact and show subtle reactions.</li>
        <li>Be genuine, don&apos;t pretend to be someone you&apos;re not.</li>
        <li>Be honest about how you felt at the end of the date.</li>
        <li>Comfortably discuss how to split the check.</li>
        <li>If it went well — message within 24 hours.</li>
      </ol>

      <h2 className="text-2xl font-bold text-qulo-green mb-4 mt-10">Conclusion</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        The first date doesn&apos;t have to be perfect. Expecting it to be is the very source of
        failure. The best first dates are ones where two people allow themselves to be themselves,
        are curious, and are honest. Do your prep, but keep your expectations low — just meet
        someone new. Who knows, maybe your first date will be your last first date.
      </p>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        For deeper connections, discover <Link href={`/${locale}/features`} className="text-qulo-purple hover:underline">Qulo&apos;s quiz dating features</Link> and
        read our <Link href={`/${locale}/advice/dating-profile-guide`} className="text-qulo-purple hover:underline">how to write a great dating profile</Link> guide.
      </p>
    </>
  );
}
