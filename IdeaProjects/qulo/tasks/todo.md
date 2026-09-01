# Test Altyapısı — Kampanya Hazırlığı (2026-09-01)

## Kısıtlar (kullanıcıdan)
- Supabase'de **sadece prod branch** var — ücretli branch YOK → **DB'ye vuran entegrasyon testi yazılamaz**
- İçeride kullanıcı yok → prod'a dokunan işlerde risk düşük ama yine de dokunulmayacak
- Kampanya **en az 1 ay sonra**
- Kullanıcı için manuel test **çok maliyetli** → testler benim doğrulama mekanizmam olacak
- **Mevcut durum korunacak** — additive değişiklik, riskli refactor yok

## Tasarım kararı
Testler "coverage" için değil, **kullanıcı elle test etmek zorunda kalmasın** diye yazılıyor.
Bu yüzden hepsi **offline** çalışacak: DB yok, network yok, emülatör yok. `flutter test` + `vitest`.

---

## Faz 0 — Kanamayı durdur
- [x] 2 kırık testi teşhis et → ikisi de bayat test, kod doğru
- [x] `test/models/user_model_test.dart` → `genderPrefSetAt` koşulunu ekle (2→7 test)
- [x] `src/__tests__/page-message.validator.test.ts` → "en az 1 dil" kuralına güncelle (7→15 test)
- [x] Tautoloji testler: 4 dosya/16 test (11 değil — düzeltildi). 3'ü silindi,
      `ai-suggest` gerçek `scoreAndPick`'i test edecek şekilde yeniden yazıldı (10 test)
- [~] `src/__tests__` + `tests/` birleştirme — **ATLANDI**: kozmetik, sıfır fayda,
      50+ relatif import'u kırma riski. Konvansiyon: yeni testler `src/__tests__`'e.
- [x] GitHub Actions: qulo-server (tsc + vitest + build), qulov2 (analyze + test)

## Faz 1 — i18n parity (en ucuz, en yüksek getiri)
- [x] Server: locale + email JSON parity (10 test) — **temiz çıktı**
- [x] Mobile: 16 dil parity (5 test) — **14 dilde 6 eksik key bulundu, tamamlandı**

## Faz 2 — Server para yolları (offline) ✅
- [x] `tests/helpers/fake-supabase.ts` — bellek içi tablo deposu (cevap script'i değil),
      `failAfter` ile çok adımlı akışın ortası bozulabiliyor
- [x] `tests/helpers/economy-config.fixture.ts` — gerçek zod parse'ından geçen config
- [x] diamond: 23 test | exchange: 25 test
- [x] Atomiklik sınırı 2 testle donduruldu (fix ayrı iş, migration 037 deseni izlenmeli)
- [x] `tsconfig.test.json` — `tests/` tip kontrolüne dahil edildi (CI'da da)

## Faz 3 — Mobile
- [ ] `mocktail` dev dependency
- [ ] Repository testleri (Result<T> success/failure mapping)
- [ ] Kritik provider testleri

## Faz 4 — Funnel smoke script
- [ ] Kampanya öncesi tek komut: kayıt → doğrula → profil → discover → paywall

---

## Bulgular (analiz)
- Server'da 42 servisin 39'u `config/supabase`'i doğrudan import ediyor → DI yok
- `exchange.service.ts:20-31` ve `:81-96` — çok adımlı elmas harcaması **transaction'sız**,
  ara adım patlarsa kullanıcı elmasını kaybediyor. **Kod fix'i, test fix'i değil.**
- Supabase: 26 tabloda RLS kapalı, 23 tabloda policy yok → ayrı karar gerekiyor
- Migration'lar 3 dizine dağılmış (qulo-server/migrations 16, supabase/migrations 6, qulov2 19)

## Review — Faz 0 + Faz 1 (2026-09-01)

### Sonuç
| | Önce | Sonra |
|---|---|---|
| Server | 25 dosya / 131 test, **1 kırmızı**, 16'sı sahte | 23 dosya / **143 test**, hepsi gerçek |
| Mobile | 11 dosya / 39 test, **1 kırmızı** | 12 dosya / **47 test** |
| CI | yok | iki repoda da GitHub Actions |
| `dart analyze` | 2 uyarı | 1 uyarı (kalan: dead code, aşağıda) |

### Kırık testlerin teşhisi — ikisi de bayat test, kod doğruydu
- Flutter: `a6b78d3` `setupComplete`'e 3. koşul (`genderPrefSetAt`) eklemiş, test 2 koşulda kalmış
- Server: validator bilinçli gevşetilmiş ("en az 1 dil"), test hâlâ 16 dil zorunlu sanıyordu

### 🔴 Bulunan gerçek bug — 14 dilde 6 eksik key
`sub_terms_of_use`, `sub_privacy_policy` (paywall yasal linkleri — Apple/Google zorunlu),
`camera/photo_permission_denied_title/message` (fotoğraf yükleme izin dialogu).
Sadece tr+en vardı; 14 dil İngilizce fallback'e düşüyordu. **İkisi de kampanya funnel'ının içinde:**
`subscription_legal_links.dart:32` ve `image_picker_permission_dialog.dart:17`.
14 dile çevrildi, parity testi artık koruyor.

### Karar kayıtları
- Test dizini birleştirme atlandı (risk > fayda)
- `scoreAndPick` production'da `private` bırakıldı; test runtime cast ile erişiyor →
  sıfır production değişikliği ("mevcut durumu koru")
- `dart analyze --no-fatal-warnings` geçici; `_openStoreUrl` temizlenince kaldırılacak

### Faz 2 sonucu (aynı gün)
Server: **191 test / 25 dosya** (Faz 0 sonrası 143'tü). Build temiz, `tests/` dist'e girmiyor.

Faz 2'de bir testi yanlış yazdım ve yakaladım: "mor elmas eklenemezse" testi
`users.update`'i komple bozuyordu, o yüzden ilk harcama da patlıyor ve ikinci
adım hiç test edilmiyordu — doğru sebepten değil, yanlış sebepten geçiyordu.
Helper'a `failAfter` eklenip düzeltildi.

### Açık kalanlar
- `app_review_manager.dart:109` `_openStoreUrl` ölü kod — hiç çağrılmıyor
- `ai-suggest.service.ts:142` `sort(() => Math.random() - 0.5)` — yanlı shuffle,
  tutarsız comparator ile `Array.sort` davranışı implementation-defined. Düşük öncelik.
- **`banned_screen.dart` bu session sırasında dışarıdan değişti** (support@quloapp.com →
  info@socrepho.com). Bana ait değil, dokunulmadı, commit'lenmedi. Teyit bekliyor.
- `src/__tests__` derlenip **dist'e giriyor** → test kodu Railway'e deploy oluyor.
  Yeni testler `tests/` altında (dist'e girmiyor). Eskilerin taşınması ayrı iş.
- Commit'ler `test/ci-foundation` branch'inde (iki repoda da), push edilmedi.
  Başka session'ların değişikliklerine (banned_screen, 038 RLS migration'ları) dokunulmadı.
