# Qulo Workspace — Root Kurallar

## Projeye Ozel Skill Sistemi (businessCaseSkills)
- **Konum:** `.claude/skills/businessCaseSkills/` altindaki tum skill dosyalari projeye ozel is kurallaridir
- **KURAL:** Her session basinda ve her yeni task oncesinde, bu dizindeki skill'leri kontrol et
- **KURAL:** Bir task baslatildiginda, ilgili businessCaseSkills skill'i varsa OTOMATIK calistir — kullaniciya sorma
- **KURAL:** Yeni skill eklendikce bu dizini tara ve ilgili tetikleyicileri ogre
- Bu skill'ler hem mobile (qulov2) hem server (qulo-server) hem de DB (Supabase) katmanlarini kapsayan monorepo seviyesinde calisir

## Alt Proje CLAUDE.md Dosyalari
- `qulov2/CLAUDE.md` — Flutter mobile kurallari (review, conventions, patterns)
- Alt proje kurallari bu root kurallara ek olarak gecerlidir

## Dokunulan Dosya Temizligi + Loop Refactor (ZORUNLU)
- **KURAL:** Bir task icin bir dosyaya dokundugunda, o dosyada (veya degistirdigin kod
  cevresinde) kod tabaninin kural setine (CLAUDE.md, SOLID, hardcoded yasagi,
  `Widget _build*` yasagi, naming/convention) uyulmayan bir yer ya da refactor
  edilecek/temizlenecek bir sey varsa **mutlaka duzelt** — ayri task'a birakma.
- **KURAL (loop refactor):** Buldugun cozumu/refactoru **kendin uygula** — oneri yapip
  bekleme. Coz → dogrula (`dart analyze` sifir hata + ilgili review skill) → duzgunse
  gerceklestir. Bu dongu her gelistirmenin dogal parcasi.
- **Kapsam disiplini:** Sadece dokundugun dosya/cevresi. Alakasiz genis refactor icin
  backlog'a not birak, PR'i sismele.
- Amac: teknik borc biriktirmemek; her dongude "logic temizligi" (MVP odak +
  surdurulebilirlik felsefesi).

## Test Disiplini (ZORUNLU — her gelistirmede)

Hizli gelistirme yapiyoruz; tek koruma test suite'i. Bu yuzden test yazmak
"sonra yapilacak is" DEGIL, gelistirmenin parcasi.

### Her task'ta, istisnasiz
1. **Once calistir:** ilgili katmanin testini calistir, **baseline yesil mi** gor.
   Kirmizi ile baslama — once onu coz veya sebebini raporla.
   - server: `npx vitest run`  |  mobile: `flutter test`
2. **Gelistir.**
3. **Yeni davranis = yeni test.** Yeni endpoint/servis/repository/model/kural
   eklediysen VEYA mevcut davranisi degistirdiysen, test case'ini **ayni PR'da** yaz.
   Test yoksa is bitmemistir.
4. **Sonra calistir:** suite tekrar yesil olmali + `npx tsc -p tsconfig.test.json`
   (server) / `dart analyze` (mobile) sifir hata.
5. **Kirilan test = once teshis.** Otomatik "testi guncelle" YAPMA. Once sor:
   *kod mu yanlis, test mi bayat?* Cevabi commit mesajina yaz.
   (Gecmis ornek: `setupComplete`'e ucuncu kosul eklenmisti — test bayatti, kod dogruydu.)

### Test case kataloğu
`tasks/test-cases.md` tum katmanlarin case envanteri. **Her task'ta:**
- Ilgili bolumu ac, o alanin case'lerini kontrol et
- Yeni case gerekiyorsa katalogu guncelle (kod ile ayni PR'da)
- Yazilan case'i `[ ]` → `[x]` isaretle

### Neyin testi yazilir, neyin yazilmaz
- **Yazilir:** para (elmas/IAP/abonelik), quiz+eslesme kurallari, auth/yetki,
  idempotency, i18n parity, validator/schema, veri sizintisi (kullanici izolasyonu)
- **Yazilmaz:** salt UI dizilimi, tek satirlik getter, ucuncu parti kutuphane davranisi

### Testin kendisi icin kurallar
- **Tautoloji YASAK.** Test, uretim kodunu **import edip cagirmali**. Formulu/filtreyi
  test dosyasinda yeniden tanimlayip onu dogrulamak test degildir — asla kirmiziya donmez.
- **Dogru sebepten gecsin.** Hata enjekte ederken akisin **hedeflenen adimini** boz;
  hepsini birden bozarsan test erken patlar ve asil iddiayi hic dogrulamaz
  (bkz. `fake-supabase` icindeki `failAfter`).
- **Offline.** DB/network/emulator YOK. Supabase'de sadece prod branch var, test
  branch'i ucretli — entegrasyon testi yazma, `tests/helpers/fake-supabase.ts` kullan.
- **Mevcut helper'i kullan**, yeni mock mimarisi icat etme.

## Guvenlik Migration'lari — Kanit Temelli Adim Adim Kural (ZORUNLU)

RLS, GRANT/REVOKE, policy veya erisim yetkisini degistiren HER islem icin gecerli.
Toplu uygulama YASAK — tablo tablo, adim adim ilerlenir.

### Test siniflandirmasi (en kritik kural)
Her migration oncesi test senaryolari IKI sinifa ayrilir:
- **YESIL (bozulmamali):** uygulamanin gercek yollari — qulo-server API endpoint'leri
  (service_role), Realtime teslimati, mobil akislar. Bunlarda `success -> fail`
  regresyonu **derhal geri alma** sebebidir.
- **KIRMIZI (bozulmali):** saldirgan yolu — anon/publishable key ile dogrudan
  PostgREST/Realtime erisimi. Migration sonrasi HALA calisiyorsa duzeltme tutmamistir.

`success -> fail` tek basina geri alma sebebi DEGILDIR. Kirmizi testlerde
`success -> fail` zaten hedeftir. Geri alma SADECE yesil regresyonunda yapilir.

### Zorunlu dongu (her tablo icin ayri ayri)
1. **Baseline:** curl ile yesil + kirmizi testleri calistir, HTTP kodlarini kaydet.
   Baseline alinmadan migration uygulanmaz.
2. **Tek degisiklik:** bir migration = bir tablo (veya bir mantiksal grup).
   Her migration'in yaninda `*_rollback.sql` dosyasi ONCEDEN yazilir.
3. **Uygula:** once Supabase branch'inde, sonra prod'a.
4. **Re-test:** ayni testleri tekrar calistir, baseline ile diff'le.
5. **Karar:** yesil regresyon varsa rollback'i CALISTIR ve dur, sebebini raporla.
   Yesiller saglam + kirmizilar kapandiysa bir sonraki tabloya gec.
6. **Kaydet:** sonucu ilgili log dosyasina isle.

### Ek kurallar
- Anon key / service_role key komut satirina GOMULMEZ — scratchpad'de dosyada
  tutulur, `$(cat ...)` ile okunur (hem gizlilik hem classifier blogu icin).
- Realtime yayinindaki (`supabase_realtime` publication) tablolar en riskli grup;
  policy'siz RLS acmak teslimati tamamen keser. Bunlar en SONA birakilir.
- `dogruladim` demek icin somut HTTP kodu / SQL ciktisi gerekir; varsayim yeterli degil.
