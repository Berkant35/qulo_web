import Link from "next/link";

export function RedFlagsContent({ locale }: { locale: string }) {
  if (locale === "tr") {
    return (
      <>
        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Giriş: Red Flag Nedir?</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          &quot;Red flag&quot; yani kırmızı bayrak, ilişkinin başında fark edilebilen ve ileride büyük
          sorunlara yol açabilecek uyarı işaretlerini ifade eder. Online dating bağlamında red
          flag&apos;ler, dolandırıcılıktan manipülatif davranışlara, emotional abuse&apos;dan fiziksel
          güvenlik tehditlerine kadar geniş bir yelpazeye yayılır.
        </p>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Norton&apos;un 2024 araştırmasına göre online dating kullanıcılarının <strong className="text-white">%52&apos;si</strong>
          bir dolandırıcılık girişimiyle karşılaştı. FBI raporları, &quot;romance scam&quot;lerin yıllık 1
          milyar doların üzerinde zarara yol açtığını belirtiyor. İyi haber: çoğu red flag
          öğrenilebilir ve tanındığında kaçınılabilir. Bu rehberde online dating&apos;de karşılaşacağınız
          15 yaygın red flag&apos;i detaylı açıklayacağız.
        </p>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">15 Red Flag: Detaylı Rehber</h2>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">1. Love Bombing</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Tanıştığınızın ilk haftasında &quot;seni seviyorum&quot;, &quot;sen hayatımın aşkısın&quot;, &quot;bu hissi
          hiç yaşamadım&quot; tarzı aşırı duygusal açıklamalar. Normalde bir ilişkinin gelişmesi haftalar
          alır. Love bombing narsist veya manipülatif kişilerin klasik taktiğidir — hedefi bağımlılık
          yaratmaktır.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">2. Görüntülü Arama Reddi</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Haftalarca mesajlaşmanıza rağmen görüntülü aramaya çıkmıyorsa, bu çok büyük bir uyarı
          işareti. &quot;Kamera bozuk&quot;, &quot;kendimi iyi hissetmiyorum&quot;, &quot;utanıyorum&quot; gibi bahaneler kullanabilir.
          Muhtemelen profilindeki fotoğraflar sahte (catfish) veya gerçek kimliği gizliyor.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">3. Para İstemek (Romance Scam)</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Bu <strong className="text-white">en tehlikeli red flag</strong>&apos;dir. &quot;Acil bir
          durum var&quot;, &quot;kartım bloke oldu&quot;, &quot;sadece bu sefer&quot; — asla tanımadığınız birine para
          göndermeyin. Hediye kartı, kripto para veya banka transferi talepleri mutlaka
          dolandırıcılıktır. Kurbanlar genellikle aylarca emotional investment sonrası para isteklerini
          kabul eder.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">4. Hızlı Yakınlık ve Baskı</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          &quot;Hemen taşınalım&quot;, &quot;ailenle tanışmak istiyorum&quot; (haftalar içinde), &quot;evlilik düşünüyorum&quot; —
          sağlıklı ilişkiler doğal bir tempoda gelişir. Hızlı yakınlık baskısı genellikle bağımlılık
          yaratma veya sizi izole etme girişimidir.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">5. Sosyal Medya Yok ya da Çok Yeni</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Sosyal medyada hiçbir iz yok veya tüm hesaplar son 1-2 ayda açılmış. Bu, sahte bir kimlik
          kullandığına işaret edebilir. Gerçek hayatta 25-45 yaşında biri için sosyal medya
          geçmişinin olmaması anormal. Instagram, Facebook veya LinkedIn profilini isteyin.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">6. Tutarsız Hikayeler</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          İki hafta önce &quot;doktor&quot; olduğunu söyledi, şimdi &quot;mühendis&quot;; geçmişte &quot;New York&apos;ta yaşıyorum&quot;
          dedi, sonra &quot;Los Angeles&quot;. Ufak tutarsızlıkları yakalayın — yalan söyleyenlerin hikayeleri
          asla uzun süre tutarlı kalmaz.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">7. Kontrol Davranışı</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          &quot;Nerede olduğunu her zaman bilmeliyim&quot;, &quot;kimlerle konuştuğunu göster&quot;, &quot;o arkadaşını
          istemiyorum&quot;. Bu davranış ilk tanışmada küçük kaygılar olarak görünebilir, ancak giderek
          büyür ve emotional abuse&apos;a dönüşür. Kontrol, sevgi değildir.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">8. Geçmişi Hakkında Sır Saklamak</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Geçmiş ilişkileri, ailesi, işi veya geçmişte yaşadığı yerler hakkında kesinlikle konuşmuyor
          ya da bilgi kıt. İnsanlar normal bir şekilde geçmişlerinden bahseder. Aşırı gizlilik genellikle
          bir şey sakladığına işaret eder.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">9. Aşırı Kıskançlık</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          &quot;Bu fotoğrafta kim?&quot;, &quot;o mesaj neydi?&quot;, &quot;neden bu kadar geç cevap veriyorsun?&quot;. Sağlıklı bir
          ilişkide güven esastır. Aşırı kıskançlık insecurity&apos;den gelir ve zamanla bunaltıcı,
          psikolojik olarak yıpratıcı bir hale gelir.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">10. Saygısız Mesajlar</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Tanıştıktan hemen sonra cinsel içerikli mesajlar, istenmeden çıplak fotoğraf gönderme,
          konuşmayı her zaman cinselliğe çekme — bunlar açık red flag&apos;lerdir. Saygı, her aşamada bir
          ilişkinin temelidir.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">11. Fotoğrafları Reverse Search&apos;te Çıkıyor</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Google Images veya TinEye ile profil fotoğraflarını arama yapın. Eğer fotoğraflar başka
          bir kişinin sosyal medya hesabında, model ajansı sayfasında veya stok foto sitelerinde
          çıkıyorsa kesin catfish. Bu 30 saniyelik kontrol çok değerli.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">12. Her Şey İçin Mazeret Üretme</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Planlar sürekli iptal, &quot;iş çıktı&quot;, &quot;ailem hastalandı&quot;, &quot;trafik&quot; — her şey için bir bahane.
          Birkaç kez olması normal, ama sürekli olursa bu bir örüntüdür. Bu kişi muhtemelen evli,
          başka bir ilişkide veya taahhüde hazır değil.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">13. Buluşmayı Sürekli Erteleme</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          2-3 haftalık mesajlaşma sonrası hala buluşma tarihi belirlenmiyorsa, bu genellikle
          catfish veya çevrimiçi &quot;dating&quot; için kullananların işaretidir. Gerçek insanlar tanışmak
          ister.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">14. Basit Soruları Yanıtsız Bırakma</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          &quot;Hangi mahalleli yaşıyorsun?&quot;, &quot;nerede çalışıyorsun?&quot; gibi basit sorulara cevap vermekten
          kaçınıyor ya da konuyu değiştiriyor. Çoğu zaman cevaptan kaçış, yanlış bilgi vermeden daha
          belirgin bir red flag&apos;dir.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">15. &quot;Çok Özelsin&quot; Abartması (Gaslighting Başlangıcı)</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          &quot;Sen tanıştığım en özel kişisin&quot;, &quot;benim ruh eşimsin&quot;, &quot;senin gibi biriyle hiç
          tanışmadım&quot; — tanışma aşamasında bu tarz açıklamalar gaslighting ve love bombing&apos;in
          karışımıdır. Sizi özel hissettirerek, daha sonraki manipülatif davranışları göze batmaz
          hale getirirler.
        </p>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Red Flag Görünce Ne Yapılmalı?</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Red flag gördüğünüzde panik yapmayın, ama göz ardı da etmeyin. İşte adım adım yol:
        </p>
        <ol className="list-decimal list-inside text-qulo-text-secondary space-y-2 mb-4">
          <li><strong className="text-white">Not edin:</strong> Davranışı yazın, net görebilirsiniz.</li>
          <li><strong className="text-white">Sorgulayın:</strong> Güvendiğiniz bir arkadaşa anlatın, tepkisine bakın.</li>
          <li><strong className="text-white">Sınır koyun:</strong> Rahatsız eden davranışı direkt adlandırın.</li>
          <li><strong className="text-white">Tepkiyi gözlemleyin:</strong> Sağlıklı bir insan özür diler, öğrenir. Manipülatör savunmaya geçer.</li>
          <li><strong className="text-white">Gerekirse sonlandırın:</strong> Duraksamadan. İlişkinin tehlikeli hale gelmesini beklemeyin.</li>
          <li><strong className="text-white">Rapor edin:</strong> Dating uygulamalarında &quot;report&quot; özelliğini kullanın — başkalarını da korumuş olursunuz.</li>
        </ol>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Güvenlik İpuçları: İlk Buluşmadan Önce</h2>
        <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
          <li>Bir arkadaşınıza kiminle, nerede ve kaçta buluşacağınızı söyleyin</li>
          <li>Konum paylaşımı yapın (WhatsApp, iMessage)</li>
          <li>İlk buluşmayı halka açık bir yerde yapın</li>
          <li>Alkol alımını sınırlayın</li>
          <li>Kendi arabanız veya Uber&apos;inizle gelip gidin</li>
          <li>Gerekiyorsa güvenlik kelimesi belirleyin (arkadaşa mesaj: &quot;Mavi&quot; = beni çıkart)</li>
        </ul>

        <h2 className="text-2xl font-bold text-qulo-green mb-4 mt-10">Qulo&apos;nun Güvenlik Özellikleri</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          <Link href={`/${locale}`} className="text-qulo-purple hover:underline">Qulo</Link> soru-cevap
          tabanlı sistemi sayesinde birçok red flag&apos;i dolaylı olarak filtreler:
        </p>
        <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
          <li><strong className="text-white">Bot filtreleme:</strong> Soru cevaplamak AI bot&apos;lar için zordur</li>
          <li><strong className="text-white">Catfish koruma:</strong> Gerçek insanın gerçek kişiliğini yansıtan sorular</li>
          <li><strong className="text-white">Email doğrulama:</strong> Tüm kullanıcılar email ile doğrulanır</li>
          <li><strong className="text-white">Blok ve rapor:</strong> İstenmeyen kullanıcıları tek tıklamayla bloklayın</li>
          <li><strong className="text-white">Güvenli mesajlaşma:</strong> Uçtan uca şifreli</li>
          <li><strong className="text-white">Sınırlı coğrafya:</strong> Buluşmadan önce yakınlık kontrolü</li>
        </ul>

        <blockquote className="border-l-4 border-qulo-purple pl-4 my-8 italic text-qulo-text-secondary">
          &quot;Güven zamanla kazanılır. Güvenlik ise baştan kurulur.&quot;
        </blockquote>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">İstatistiklerle Online Dating Güvenliği</h2>
        <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
          <li>Online dating kullanıcılarının <strong className="text-white">%56&apos;sı</strong> bir şekilde catfish ile karşılaştı</li>
          <li>Romance scam mağdurlarının ortalama kaybı: <strong className="text-white">$4,400</strong></li>
          <li>Kadın kullanıcıların <strong className="text-white">%60&apos;ı</strong> istenmeyen cinsel içerikli mesaj aldı</li>
          <li>Dating uygulamalarındaki profillerin <strong className="text-white">%10&apos;u</strong> sahte veya inaktif</li>
          <li>İlk buluşma öncesi görüntülü arama yapmak risk oranını <strong className="text-white">%73</strong> azaltıyor</li>
        </ul>

        <h2 className="text-2xl font-bold text-qulo-green mb-4 mt-10">Sonuç</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Online dating güvenli olabilir — eğer doğru işaretleri tanırsanız. Bu 15 red flag&apos;i bilmek,
          sizi potansiyel zararlardan korur ve gerçek, sağlıklı bağlantılar kurmanıza olanak tanır.
          Unutmayın: sezgilerinize güvenin. İçinizde &quot;bir şey doğru değil&quot; hissi varsa, muhtemelen
          doğru değildir.
        </p>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Daha güvenli bir dating deneyimi için <Link href={`/${locale}/blog/online-dating-safety-tips`} className="text-qulo-purple hover:underline">online dating güvenlik rehberimizi</Link> ve
          <Link href={`/${locale}/glossary`} className="text-qulo-purple hover:underline"> dating sözlüğümüzü</Link> okuyun.
          Ayrıca <Link href={`/${locale}/advice/first-date-tips`} className="text-qulo-purple hover:underline">ilk buluşma tavsiyelerimiz</Link> de
          güvenlik ipuçları içeriyor.
        </p>
      </>
    );
  }

  // English (default fallback)
  return (
    <>
      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Introduction: What is a Red Flag?</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        A &quot;red flag&quot; refers to warning signs that can be noticed early in a relationship and may
        lead to serious problems later. In online dating context, red flags span a wide spectrum
        from scams to manipulative behavior, emotional abuse to physical safety threats.
      </p>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        According to Norton&apos;s 2024 research, <strong className="text-white">52%</strong> of online
        dating users have encountered a scam attempt. FBI reports indicate that &quot;romance scams&quot;
        cause over $1 billion in annual losses. The good news: most red flags are learnable and
        avoidable once recognized. In this guide, we&apos;ll explain 15 common red flags you&apos;ll
        encounter in online dating in detail.
      </p>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">15 Red Flags: Detailed Guide</h2>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">1. Love Bombing</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Intense emotional declarations in the first week of meeting: &quot;I love you,&quot; &quot;you&apos;re the
        love of my life,&quot; &quot;I&apos;ve never felt this way.&quot; Normally, relationship development takes
        weeks. Love bombing is a classic tactic of narcissistic or manipulative individuals —
        the goal is to create dependency.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">2. Refusing Video Calls</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        If they won&apos;t video call despite messaging for weeks, this is a huge warning sign. They
        may use excuses like &quot;camera is broken,&quot; &quot;not feeling well,&quot; &quot;too shy.&quot; Likely their
        profile photos are fake (catfish) or they&apos;re hiding their real identity.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">3. Asking for Money (Romance Scam)</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        This is <strong className="text-white">the most dangerous red flag</strong>. &quot;There&apos;s an
        emergency,&quot; &quot;my card is frozen,&quot; &quot;just this once&quot; — never send money to someone you don&apos;t
        know. Gift cards, cryptocurrency, or bank transfer requests are definitely scams. Victims
        usually accept money requests after months of emotional investment.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">4. Fast Intimacy and Pressure</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        &quot;Let&apos;s move in together,&quot; &quot;I want to meet your family&quot; (within weeks), &quot;thinking about
        marriage&quot; — healthy relationships develop at a natural pace. Pressure for fast intimacy is
        usually an attempt to create dependency or isolate you.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">5. No Social Media or Very New Accounts</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        No trace on social media or all accounts opened in the last 1-2 months. This can indicate
        a fake identity. It&apos;s abnormal for someone 25-45 years old in real life to have no social
        media history. Ask for Instagram, Facebook, or LinkedIn profile.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">6. Inconsistent Stories</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Two weeks ago they said they were a &quot;doctor,&quot; now &quot;engineer&quot;; previously &quot;I live in New
        York,&quot; then &quot;Los Angeles.&quot; Catch small inconsistencies — liars&apos; stories never stay
        consistent for long.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">7. Controlling Behavior</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        &quot;I should always know where you are,&quot; &quot;show me who you&apos;re talking to,&quot; &quot;I don&apos;t want that
        friend of yours.&quot; This behavior may seem like minor anxiety in the first meeting, but grows
        and turns into emotional abuse. Control isn&apos;t love.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">8. Hiding About Their Past</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Won&apos;t talk at all about past relationships, family, work, or places lived. People normally
        share bits of their past. Excessive secrecy usually indicates they&apos;re hiding something.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">9. Excessive Jealousy</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        &quot;Who is in that photo?&quot;, &quot;what was that message?&quot;, &quot;why are you responding so late?&quot;. Trust
        is essential in a healthy relationship. Excessive jealousy stems from insecurity and
        becomes suffocating, psychologically wearing over time.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">10. Disrespectful Messages</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Sexually explicit messages right after meeting, unsolicited nude photos, always steering
        conversation to sex — these are clear red flags. Respect is the foundation of a
        relationship at every stage.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">11. Photos Appear in Reverse Search</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Search profile photos with Google Images or TinEye. If photos appear on another person&apos;s
        social media, model agency pages, or stock photo sites, it&apos;s definitely catfish. This
        30-second check is invaluable.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">12. Making Excuses for Everything</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Plans constantly canceled, &quot;work came up,&quot; &quot;family got sick,&quot; &quot;traffic&quot; — excuse for
        everything. A few times is normal, but constant pattern is indicative. This person is
        probably married, in another relationship, or not ready for commitment.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">13. Constantly Postponing Meetings</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        If 2-3 weeks of messaging haven&apos;t resulted in setting a meeting date, this often signals
        catfish or someone using online &quot;dating&quot; for other reasons. Real people want to meet.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">14. Leaving Simple Questions Unanswered</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Avoiding or changing subject on simple questions like &quot;what neighborhood do you live in?&quot;,
        &quot;where do you work?&quot;. Often, avoiding the answer is a more telling red flag than giving
        wrong information.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">15. Exaggerated &quot;You&apos;re So Special&quot; (Gaslighting Beginnings)</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        &quot;You&apos;re the most special person I&apos;ve met,&quot; &quot;you&apos;re my soulmate,&quot; &quot;I&apos;ve never met someone
        like you&quot; — at the acquaintance stage, these kinds of statements are a mix of gaslighting
        and love bombing. They make you feel special to make later manipulative behavior less
        noticeable.
      </p>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">What to Do When You See a Red Flag?</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        When you see a red flag, don&apos;t panic, but don&apos;t ignore it either. Here&apos;s a step-by-step
        path:
      </p>
      <ol className="list-decimal list-inside text-qulo-text-secondary space-y-2 mb-4">
        <li><strong className="text-white">Document it:</strong> Write down the behavior, see it clearly.</li>
        <li><strong className="text-white">Validate:</strong> Tell a trusted friend, watch their reaction.</li>
        <li><strong className="text-white">Set boundaries:</strong> Directly name the disturbing behavior.</li>
        <li><strong className="text-white">Observe response:</strong> A healthy person apologizes and learns. A manipulator goes on the defensive.</li>
        <li><strong className="text-white">End it if needed:</strong> Without hesitation. Don&apos;t wait for the relationship to become dangerous.</li>
        <li><strong className="text-white">Report:</strong> Use the &quot;report&quot; feature on dating apps — you protect others too.</li>
      </ol>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Safety Tips: Before the First Date</h2>
      <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
        <li>Tell a friend who you&apos;re meeting, where, and at what time</li>
        <li>Share location (WhatsApp, iMessage)</li>
        <li>Meet in a public place for the first date</li>
        <li>Limit alcohol intake</li>
        <li>Use your own car or Uber</li>
        <li>Set a safety word if needed (text friend: &quot;Blue&quot; = pull me out)</li>
      </ul>

      <h2 className="text-2xl font-bold text-qulo-green mb-4 mt-10">Qulo&apos;s Safety Features</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        <Link href={`/${locale}`} className="text-qulo-purple hover:underline">Qulo</Link>&apos;s
        question-based system indirectly filters many red flags:
      </p>
      <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
        <li><strong className="text-white">Bot filtering:</strong> Answering questions is hard for AI bots</li>
        <li><strong className="text-white">Catfish protection:</strong> Questions reflect a real person&apos;s real personality</li>
        <li><strong className="text-white">Email verification:</strong> All users are email-verified</li>
        <li><strong className="text-white">Block and report:</strong> Block unwanted users with one tap</li>
        <li><strong className="text-white">Secure messaging:</strong> End-to-end encrypted</li>
        <li><strong className="text-white">Geolocation limits:</strong> Proximity check before meeting</li>
      </ul>

      <blockquote className="border-l-4 border-qulo-purple pl-4 my-8 italic text-qulo-text-secondary">
        &quot;Trust is earned over time. Safety is set from the start.&quot;
      </blockquote>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Online Dating Safety by the Numbers</h2>
      <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
        <li><strong className="text-white">56%</strong> of online dating users have encountered a catfish in some form</li>
        <li>Average romance scam victim loss: <strong className="text-white">$4,400</strong></li>
        <li><strong className="text-white">60%</strong> of female users have received unwanted sexual messages</li>
        <li><strong className="text-white">10%</strong> of dating app profiles are fake or inactive</li>
        <li>Video calling before the first date reduces risk by <strong className="text-white">73%</strong></li>
      </ul>

      <h2 className="text-2xl font-bold text-qulo-green mb-4 mt-10">Conclusion</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Online dating can be safe — if you recognize the right signs. Knowing these 15 red flags
        protects you from potential harm and lets you build real, healthy connections. Remember:
        trust your instincts. If something feels &quot;off,&quot; it usually is.
      </p>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        For a safer dating experience, read our <Link href={`/${locale}/blog/online-dating-safety-tips`} className="text-qulo-purple hover:underline">online dating safety guide</Link> and
        <Link href={`/${locale}/glossary`} className="text-qulo-purple hover:underline"> dating glossary</Link>.
        Our <Link href={`/${locale}/advice/first-date-tips`} className="text-qulo-purple hover:underline">first date tips</Link> also
        include safety pointers.
      </p>
    </>
  );
}
