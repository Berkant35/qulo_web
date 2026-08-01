# Faz 2 — Eşleşme Motoru (Quiz Geçilebilirliği) → v2.0.7

> Tasarım spec'i · 2026-08-01
> Kaynak: `docs/roadmap/2026-07-19-retention-onboarding-phases.md` → "Ortak Bağlam" + "FAZ 2"
> Önceki faz: Faz 1 (v2.0.6) yayında, 1.5 haftalık ölçüm yapıldı

---

## 1. Neden bu faz

Faz 1 sonrası prod ölçümü sırayı değiştirdi:

- **Onboarding çözüldü.** `app_confusing` silme nedeni 3 → 0. Aktivasyon %44 → %70.
- **Yeni 1 numaralı silme nedeni: `few_matches`** (son 11 günün 5 geri bildiriminin 4'ü).
- **Cevap doğruluk oranı %35** (106 cevabın 37'si) — 4 şıkta rastgele tahmin %25. 2 soruluk
  quizde eşleşme şansı ~%12; gerçekleşen: 83 oturumda 8 COMPLETED = **%9.6**.
- **67/67 FAILED yanlış cevaptan** — timeout kaynaklı fail yok (ortalama 11 sn).
- **Güç kullanımı 0 oturum.** Kasada 2000+ mor elmas atıl.

Darboğaz quiz'e kaydı. Bu faz quizi *kolaylaştırmıyor* — quizi **geçilebilir** kılan
araçların (güçler) kilidini açıyor ve fiyatlarını dürüst hale getiriyor.

---

## 2. Kapsam

### Dahil

| # | Madde |
|---|---|
| 2.1 | Güç kilidini aç — quiz + chat, envanter yoksa doğrudan elmasla kullan |
| 2.1b | Starter güç paketi — yeni kullanıcıya 2× ORACLE |
| 2.1c | **Çift-ücretlendirme koruması** (chat-flow-guard BLOCKER'ı — 2.1'in ön koşulu) |
| 2.2 | Güç fiyatının tek kaynağa indirilmesi (UI'da 2× gösterme bug'ı) |
| 2.2b | SKIP_ALL dürüstlük kuralı |
| 2.4 | Soru zorluk rehberliği + şık kalite kontrolü |
| 2.5 | Güç hunisi analytics event'leri |

### Hariç

- **2.3 (FAILED sonrası ikinci şans) — İPTAL.** Kullanıcı kararı (2026-08-01):
  *"başarısızsa başarısızdır, bunu bozmak istemiyorum."* Mekaniğin özü korunuyor.
  Ertelenmedi, iptal edildi.
- **Terk vakası** (quiz'e girip hiç cevap vermeden çıkma → profil yine yanar) —
  kullanıcı kararı: dokunulmuyor. Quiz'e dokunduğun an taahhüt sayılıyor.
- Düşük başarı oranlı **mevcut** sorulara proaktif uyarı → backlog.
- HALF fiyat inversiyonu → backlog (chat ekonomisini de etkiliyor, ayrı karar).

---

## 3. Keşif bulguları (koddan doğrulanmış, 2026-08-01)

Roadmap'teki üç dayanak yanlış/eksik çıktı. Tasarım düzeltilmiş hâle dayanıyor.

### 3.1 Chat "doğru yapan referans" DEĞİL

`chat_question_power_bar.dart:65-67` fiyatı doğru **gösteriyor**, ama
`solve_chat_question_screen_mixin.dart:169-189` tap'i aynı envanter kapısıyla
**engelliyor** ve `PowerPurchaseSheet` açıyor. Yani chat quiz'den iyi değil, daha kötü:
butonun altında fiyat yazıyor, basınca ücret alınmıyor — tutulmayan bir söz.

**Sonuç:** sunucudaki "envanter yoksa elmasla öde" yolu
(`quiz.service.ts:276-302`, `chat-question.service.ts:651`) prod'da **hiç execute
edilmemiş**. "Server hazır" doğru, "server denenmiş" değil.

### 3.2 2.2 tek değil, çift bug

| Katman | Kaynak | Çarpan |
|---|---|---|
| UI (`quiz_screen_mixin.dart:390-397`) | `rates.powers[].purpleCost` | **uygulanmıyor** |
| Normal güç (`quiz.service.ts:281`) | `config.powerCosts[X].purpleCost` | uygulanıyor |
| Rescue (`quiz.service.ts:756`) | `powers.base_cost` (DB kolonu) | uygulanıyor |

`questionCountMultipliers[2] = 0.5` → 2 soruluk quizde UI tam olarak **2× yüksek**
gösteriyor. Ayrıca rescue ile normal kullanım **farklı kaynaktan** okuyor;
`exchange.service.ts:200`'deki `?? p.base_cost` fallback'i bu ayrışmayı itiraf ediyor.

Migration 021 "purple_cost = base_cost" diyor ve SKIP (20) / SKIP_ALL (60) için hâlâ
doğru → **rescue'yu config'e taşımak bugün fiyat-nötr.** (POWER_BLOCK/UNBLOCK'ta drift
zaten olmuş: 019'da 40/50, 021'de 15/15 → backlog.)

### 3.3 Envanter kapısı bir çift-ücretlendirme deliğini kapatıyormuş

Hiçbir katmanda "bu güç bu soruda zaten kullanıldı" kontrolü yok:

- **Server:** `chat-question.service.ts:734-740` `powers_used` dizisine sadece append
  yapıyor, kontrol yok. Quiz'de ORACLE/HALF/HINT/TIME_EXTEND `quiz_answers`'a satır
  bile yazmıyor (`awaiting_answer: true` dönüp çıkıyor) → hiç kayıt yok.
- **Client (chat):** `solve_question_body.dart:151-155` seti sadece ORACLE/HALF/HINT
  içeriyor — **TIME_EXTEND korumasız**, sınırsız tekrar ücretlendirilebilir.
- **Client (quiz):** `disabledPowers` kavramı **hiç yok**. `usePower` yalnızca
  `isSubmitting` ile eşzamanlı tap'i engelliyor; ardışık tekrar tap serbest.

Bugün üst sınır envanter; kapı kalkınca üst sınır kullanıcının bakiyesi olur.
**2.1 bu düzeltilmeden gönderilemez.**

### 3.4 Yanlış alarmlar (kayda geçsin diye)

- `DIAMOND_COOLDOWN` (sosyal kayıtta 24s elmas kilidi) Faz 1 sonrası sosyal-first
  kohortu vurabilirdi — ama `diamond.service.ts:10-12` `checkSocialCooldown` boş stub
  (`return;`). Hiç fırlamıyor.
- `NO_INVENTORY` `errors.ts`'te tanımlı bile değil; `tryUseInventory` sessizce `false`
  dönüp `spendPurple`'a düşüyor.
- **Bu yolda üretilebilen tek kaynak hatası `INSUFFICIENT_DIAMONDS`** (403).

### 3.5 2.4'ün dosyasında pre-existing bug

`question_create_bottom_bar.dart` ve `question_step_answers.dart` controller'ları build
sırasında okuyor ama **hiçbir yerde listener yok**. Yazarken ne önizleme kartı ne
"İleri" butonu güncelleniyor; doğru cevap radio'suna basınca (`setState`) tazeleniyor.
Bu düzelmeden inline şık hatası da çalışmaz.

---

## 4. Mimari karar — tek fiyat kaynağı

2.1 ve 2.2 aynı kökten çıkıyor: *client fiyatı kendi hesaplıyor.* Kökü kesiyoruz.

### Server

`quiz.service.ts` içine tek yardımcı:

```ts
private async sessionPowerCosts(totalQuestions: number) {
  const config = await economyConfigService.getConfig();
  const m = config.core.questionCountMultipliers;
  // her güç için: purple = calculatePowerCost(config.powerCosts[X].purpleCost, totalQuestions, m)
  //               green  = calculateGreenReward(purple, config.core.greenDiamondRewardRatio)
}
```

Üç çağrı noktası buraya bağlanır:

1. `answerQuestion` (:281) — mevcut hesap yerine
2. `rescueWithSkip` (:756) — `powers.base_cost` yerine **config** (fiyat-nötr)
3. `POST /quiz/start` yanıtı — yeni `power_costs` alanı

`startSession` **her iki dalda** da döndürür: yeni oturum (:154) ve mevcut oturum (:124).

### Mobile

Client hiç hesap yapmaz. `getPowerCost()` (`quiz_screen_mixin.dart:390-397`) **silinir**.

- `QuizStartResponse.powerCosts` (yeni alan)
- `QuizState.powerCosts` (yeni alan)
- `QuizQuestionModel.usedPowers` + `QuizState.usedPowers` (yeni alan, §5.3)
- `PowerBar` ve `AnswerFeedbackOverlay` bu tek kaynaktan okur

Bu, 2.2'nin iki bug'ını da **yapısal olarak** kapatır — çarpan kaybı ve kaynak
ayrışması bir daha oluşamaz.

---

## 5. Detaylı tasarım

### 5.1 Güç kilidini açma

**Quiz `power_bar.dart`** — chat'in *görsel* dilini alır, chat'in *aksiyonunu* almaz
(o da bozuk):

- Envanter koşulu (`hasInventory`, `isDisabled`, gri görünüm) kalkar
- Her buton aktif. Tek istisna `HINT` — `hasHint == false` ise güç gerçekten yok
- Kullanılmış güçler (5.3) `isUsed` görünümüne geçer: tik ikonu, soluk
- Altına `power_bar_*` etiketi + envanter yoksa mor/yeşil fiyat
- Tap → doğrudan `onPowerUsed(type.apiName)`
- `_onEmptyPowerTap` ve `power_purchase_sheet.dart` importu quiz'den çıkar
  (sheet chat'te ve `power_inventory_grid.dart:68`'de kaldığı için dosya silinmez)

**Chat `solve_chat_question_screen_mixin.dart:169-189`** — envanter guard'ı silinir,
satır 13'teki artık kullanılmayan import kaldırılır (`dart analyze` sıfır hata kuralı).

**Ortak hata yolu** — `_handleRescueFailure`'daki mantık ortak bir yardımcıya çıkar ve
üç yerde kullanılır (quiz güç, quiz rescue, chat güç):

```dart
// Sunucuda üretilebilen tek kaynak hatası bu (bkz. §3.4).
final isPaywallFailure = f is ServerFailure && f.code == 'INSUFFICIENT_DIAMONDS';
```

- `INSUFFICIENT_DIAMONDS` → paywall → **1500 ms** RevenueCat webhook tamponu →
  `exchangeProvider.fetchAll()` + `diamondProvider.fetchBalance()` + `userProvider.fetchMe()`
- `VALIDATION_ERROR` (power block) → **çevrilmiş** mesaj. Ham İngilizce sunucu mesajı
  (`"Power block is active. Use POWER_UNBLOCK first."`) kullanıcıya basılmaz
- Diğerleri → snackbar

**Bakiye tazeleme** — güç kullanımı başarılı olduğunda:

- `ref.invalidate(diamondProvider)` **yanlış**: `DiamondNotifier.build()` sabit
  `DiamondBalance(0, 0)` dönüyor, yani invalidate refetch değil **sıfırlama**.
  `ref.read(diamondProvider.notifier).fetchBalance()` kullanılır
- Chat AppBar bakiyesi `userProvider`'dan okuyor (`solve_chat_question_screen.dart:71`)
  → `fetchMe()` de çağrılır. Bugüne kadar chat sorusunda mor elmas hiç hareket etmediği
  için başlık hep doğruydu; artık olmayacak

### 5.2 Starter güç paketi

**Ne:** yeni kullanıcıya **2× ORACLE** envantere.

**Neden ORACLE, neden 2:**

| Güç | Değerlendirme |
|---|---|
| TIME_EXTEND | **Anlamsız** — 67/67 fail yanlış cevaptan, timeout kaynaklı fail yok |
| HINT | **Koşullu** — yalnızca `hint_text` girilmiş sorularda çalışır |
| SKIP / SKIP_ALL | **Eşleşmeyi hediye eder** — 2 soruluk quizde yarısını/tamamını çözer |
| ORACLE / HALF | Sadece şansı yükseltir |
| ORACLE | %70 isabet, en ucuz yeniden alım (3 mor) → ödemeye geçiş rampası en kısa |
| HALF | Fiyatı ters (10 mora %50 vs ORACLE 5 mora %70) — bedava tanıtıp pahalıya satmak kötü |

2 adet = soru sayısı simetrisi. Geçme şansı %12 → **~%49** (0.7²). Yazı tura —
eşleşme satın alınmıyor.

**Neden envanter, neden elmas değil:** envanter gücü fungible değil. Başka şeye
harcanamaz, kullanılınca yok olur, mor elmas ekonomisini **hiç** değiştirmez.
Kapalı uçlu bir arz. Ayrıca butondaki "2" rozeti tam olarak öğretmek istediğimiz
davranışı öğretir; bedava bitince buton aktif kalır ve altında fiyat çıkar.

**Nerede:** `auth.service.ts:42` (e-posta kaydı) ve `:456` (sosyal login yeni kullanıcı)
— iki gerçek `insert` noktası. Soft-delete kurtarma `:447` dalından geçtiği için
tekrar hediye vermez. Flag kolonu gerekmez; oluşturma anına bağlı tek atış.

**Mevcut kullanıcılara backfill YOK** (kullanıcı kararı).

**Refactor:** `exchange.service.ts`'te envanter upsert'i `buyPower` içine gömülü
(:98-135). `grantPower(userId, powerName, quantity)` olarak çıkarılır, `buyPower` de
onu kullanır. Loop-refactor kuralı.

### 5.3 Çift-ücretlendirme koruması (2.1c)

**Karar:** server otorite + client UX. Para güvenliği sunucuda, görsel geri bildirim
client'ta.

#### Server

**Chat** — `chat-question.service.ts`, `tryUseOrSpend`'den (:653) **önce**:

```ts
if ((question.powers_used ?? []).includes(powerName)) throw Errors.POWER_ALREADY_USED();
```

**Quiz** — migration 036:

```sql
ALTER TABLE quiz_sessions
  ADD COLUMN IF NOT EXISTS current_q_powers text[] NOT NULL DEFAULT '{}';
```

- `answerQuestion` güç dalında, ücretlendirmeden önce membership kontrolü
- Kullanım sonrası diziye eklenir
- `incrementCurrentQ` (:717) sıfırlar — bu **tek** ilerletme noktası, hem cevap hem
  rescue yolu oradan geçiyor (doğrulandı: `rescueWithSkip:848`)
- `getCurrentQuestion` yanıtına `used_powers: string[]` eklenir → uygulama yeniden
  başlatılsa da client doğru durumu geri kurar

Yeni hata kodu: `POWER_ALREADY_USED` (409). Client tarafında bu **savunma hattı** —
buton zaten kapalı olduğu için normal akışta görülmemeli. Görülürse snackbar
(paywall değil) ve ilgili güç `usedPowers`'a eklenir (durum senkronizasyonu).

**TIME_EXTEND soru başına 1 kez.** Bugün chat'te sınırsız ama envanter kapısı yüzünden
erişilemez durumda — regresyon değil. Yığmalı süre uzatma istenirse ileride kasıtlı
bir özellik olarak tasarlanır.

#### Client

- **Quiz `PowerBar`**: `usedPowers` seti parametresi (yeni) — `QuizState`'ten gelir
- **Chat `solve_question_body.dart:151-155`**: sete `TIME_EXTEND` ve `SKIP` eklenir
- **ORACLE sessiz ücretlendirme fix'i**
  (`solve_chat_question_screen_mixin.dart:213-217`): HALF ile elenmiş bir şık ORACLE
  tarafından önerilirse bugün `setState` hiç çağrılmıyor → buton açık kalıyor,
  kullanıcı tekrar ödüyor. Öneri elenmiş olsa bile güç "kullanıldı" işaretlenir.
  (Server dedupe parayı zaten korur; bu UX tarafı.)

#### Sunucu hardening (aynı PR)

- `chat-question.service.ts` `usePower` guard'ı (:577-580) yalnızca
  `answered_option != null` bakıyor; `rescueQuestion` (:500-501) ise `is_abandoned`'ı da
  kontrol ediyor. **Terk edilmiş soruya güç kullanılıp elmas harcanabiliyor**, `SKIP` ise
  soruyu diriltip `is_correct: true` yapıyor. Guard `answered_option != null || is_abandoned`
  hâline getirilir (iki fonksiyonda simetrik).
- `chatLimiter` (`middleware/rateLimit.ts:23-29`) 30 req/dk ve **IP bazlı**
  (`keyGenerator` yok, `index.ts:40` `trust proxy 1`). Her güç tap'i artık bir API
  çağrısı → NAT/CGNAT arkasında kullanıcılar birbirini 429'lar.
  `keyGenerator: (req) => req.user?.userId ?? req.ip` + limit 60.

### 5.4 SKIP_ALL dürüstlük kuralı (2.2b)

2 soruluk quizde 2× SKIP = **20**, SKIP_ALL = **30**. Aynı sonuç, %50 daha pahalı.
Çarpan ikisine de uygulandığı için sadeleşir: SKIP_ALL yalnızca 4+ soruda kazanıyor,
3 soruda başabaş. Ve rescue dialogu tam olarak bu ikisini yan yana gösteriyor.

Sabit eşik yerine gerçek kural:

```
SKIP_ALL göster  ⟺  skipAllCost < kalanSoruSayısı × skipCost
```

| Senaryo | Hesap | Sonuç |
|---|---|---|
| 2 soru, 1 kalan | 30 < 10 | gizli |
| 4 soru, 3 kalan | 60 < 60 | gizli (eşit, fayda yok) |
| 6 soru, 5 kalan | 90 < 150 | görünür |

Hem `PowerBar`'da hem `AnswerFeedbackOverlay` rescue dialogunda aynı kural.
**Config fiyatına dokunulmuyor.**

### 5.5 Soru kalitesi (2.4)

**Şık tekilliği** — 4 şıkkın hepsi birbirinden farklı olmalı (trim + case-insensitive):

- Mobil: `question_create_screen_mixin.canGoNext()` case 1'e eklenir + `AppTextField`
  `errorText` ile inline hata (proje kuralı: hatalar inline)
- Server: `question.validator.ts`'e Zod `.refine()` — client'a güvenilmez
  (server-review kuralı). Create ve update şemalarının ikisine de

**Listener fix (loop refactor, §3.5):** `initMixin`'de 5 controller'a listener eklenir
(`setState` tetikler), `disposeMixin`'de kaldırılır. Önizleme kartı ve "İleri" butonu
canlanır; inline hata bu olmadan çalışmaz.

**Copy — zorluk teşviki kaldırılır.** 3 key, 16 dilde:

| Key | Bugün (tr) |
|---|---|
| `question_create_motto` | "Seni anlatan sorular sor — cevabı Google'da bulunmasın" |
| `onboarding_questions_slide2_desc` | "Google'da bulunamayacak, sana özel sorular sor…" |
| `onboarding_v2_page2_desc` | "…Kişisel, eğlenceli, Google'lanamayan sorular sor…" |

Yeni yön: *"seni tanıyan birinin bilebileceği"* — kişisel ama tahmin edilebilir.
"Google'da bulunmasın" ifadesi kaldırılır; yerine "çok zor sorular eşleşmeni engeller"
tonunda bir rehberlik satırı.

**Kapsam dışı:** mevcut 186 soruya retroaktif uygulama ve düşük başarı oranı proaktif
uyarısı (kullanıcı kararı: sadece yeni/düzenlenen sorular).

### 5.6 Analytics (2.5)

`analytics_events.dart`'a eklenecek sabitler:

| Event | Parametreler |
|---|---|
| `quiz_power_tap` | power, has_inventory, cost |
| `quiz_power_used` | power, source (`inventory`\|`diamond`), purple_spent |
| `quiz_power_failed` | power, error_code |
| `quiz_rescue_shown` | — |
| `quiz_rescue_accepted` | power |
| `quiz_rescue_declined` | — |

Paywall: mevcut `paywall_shown` event'i `trigger: 'quiz_power'` ile.

Chat tarafında **aynı altı event** `chat_power_tap` / `chat_power_used` /
`chat_power_failed` / `chat_rescue_shown` / `chat_rescue_accepted` /
`chat_rescue_declined` olarak eklenir — aynı sunucu yolu, ayrı huni. Chat 2.1
kapsamına girdiği için ölçümsüz bırakılmıyor.

**Loop refactor:** `quiz_complete` (non-first) `onRescue` ve `_handleSessionTransition`
COMPLETED yollarında fire etmiyor (Faz 1 backlog'u). `first_quiz_complete` tüm yollara
yayılmıştı, `quiz_complete` yayılmamıştı → düzeltilir.

---

## 6. Chat Impact Analysis

`chat-flow-guard` sonucu: **BLOCKER** — mesaj akışı güvenli, ekonomi tarafında değil.

### Sağlam kalan invariant'lar

`usePower` `messages` tablosuna yazmıyor, FCM tetiklemiyor, realtime broadcast
yapmıyor. Dolayısıyla etkilenmeyenler: chat lock + `__QUESTION__:` prefix · medya
bilateral consent · soft delete · pagination 50 · optimistic UI rollback ·
`chat:{matchId}` / `typing:{matchId}` / `media:{matchId}` kanalları ·
`correct_option` sanitization · unmatch risk · günlük soru limitleri.

**POWER_BLOCK invariant'ı sağlam:** `chat-question.service.ts:642-646` POWER_UNBLOCK
dışındaki her güç için `hasPowerBlock` ise `VALIDATION_ERROR` fırlatıyor — ve bu kontrol
`tryUseOrSpend`'den (:653) **önce** çalışıyor, para kaybı yok. Client'taki disable
tamamen kozmetik. (Hata mesajının çevrilmesi §5.1'de.)

**Timer zombi riski yok (bu değişiklikten):** chat sorularında sunucu tarafında duvar
saati hiç yok; `handleTimeout` (:753-760) sadece okuma yapıyor. `pause()` yalnızca
bayrak set ediyor, `Timer.periodic` çalışmaya devam ediyor → drift yok.

### Bozulan invariant'lar (bu spec'te düzeltiliyor)

| Invariant | Durum | Düzeltme |
|---|---|---|
| Güç maliyeti bir kez düşer | **Bozuluyor** | §5.3 |
| Client bakiye = server bakiye | **Bozuluyor** | §5.1 bakiye tazeleme |

### Bu değişiklikle yeni giriş yolu açılan mevcut sorun

`submitGiveUp` → `handleTimeout` DB'ye hiçbir şey yazmıyor → `has_chat_lock` sorusu
sonsuza dek `answered_option IS NULL` kalıyor → sohbet kilitli (`chat.service.ts:155-163`).
Bu değişiklik yeni bir giriş yolu ekliyor: bakiyesiz kullanıcı POWER_UNBLOCK'a basar →
`INSUFFICIENT_DIAMONDS` → paywall → satın alamaz → "Pes et" → **chat kalıcı kilitli**.

→ Backlog'a kritik olarak yazılır. Bu fazda çözülmüyor ama cihaz testinde bu senaryo
özellikle denenecek (bkz. §9).

---

## 7. Ekonomi Etki Analizi

**Seviye: YÜKSEK (8)**

| Kategori | Puan | Not |
|---|---|---|
| Elmas Akışı | +1 | Var olan ama erişilemeyen harcama noktası açılıyor |
| Güç Sistemi | +1 | Envanter kapısı kalkıyor |
| IAP / Monetizasyon | +2 | Çoğu kullanıcı için ilk gerçek mor elmas gideri |
| Boost / Görünürlük | +1 | Harcanan morun %30'u hedefe yeşil |
| Ödül Sistemi | +1 | Starter paket — **envanter, fungible değil** |
| Deflasyon riski | +2 | 2000+ atıl elmas drene olur |
| Geri alınamaz | 0 | Config değişmiyor; revert edilebilir |

**2 soruluk quizde efektif fiyatlar (×0.5):**
ORACLE 3 · TIME_EXTEND 3 · HINT 4 · HALF 5 · SKIP 10 · SKIP_ALL 30

**Satın alınmış eşleşme değerlendirmesi:** %100 profil = 100 PD → ~3 SKIP_ALL veya
5 tam-SKIP quiz. Kaçak sayılmıyor: prod'da 8 eşleşmenin sadece 1'i sohbete döndü —
para eşleşmeyi alıyor, ilişkiyi almıyor. D1 dönüşü %0 iken aha-moment enjeksiyonu
daha değerli. Ucuz olan ORACLE (3 mor) zaten eşleşmeyi satın almıyor, şansı yükseltiyor.

**Tespit edilen dengesizlikler → `economy_suggestions.md`:**

1. **HALF, ORACLE'ın altında.** 10 mora %50 vs 5 mora %70. Rasyonel oyuncu HALF almaz.
2. **Ucuz güçlerde yeşil ödül 0'a yuvarlanıyor.** `floor(3 × 0.30) = 0` → ORACLE ve
   TIME_EXTEND kullanıldığında hedef **hiç** yeşil kazanmıyor. "Sorularım çözülürse
   kazanırım" vaadi 2 soruluk quizde fiilen çalışmıyor.
3. **Yeşil sink daralması.** `PowerPurchaseSheet` quiz ve chat'ten çıkıyor; o sheet
   yeşilin ana harcama kanalı (`buyPower` + `diamondType: GREEN`). Aynı anda yeşil
   üretimi artıyor. Kalan sink: profil envanteri + 3:1 dönüşüm.
   **Karar: şimdilik not düş, 2.5 event'leri gerçek hacmi ölçtükten sonra bak.**
4. **POWER_BLOCK/UNBLOCK config drift'i.** 019: base_cost 40/50, 021: purpleCost 15/15.

**Skill drift'i:** `economy-impact.md` "25 cevap → 5 PD" diyor; gerçekte milestone'lar
**profil tamamlama yüzdesi** (25/50/75/100%) → 5/15/30/50 PD, %100'de ayrıca 24s boost
(`user.service.ts:506-529`). Skill güncellenecek.

---

## 8. Dokunulan dosyalarda temizlik (CLAUDE.md loop refactor)

| Ne | Neden |
|---|---|
| `quiz_result_dialog.dart` (290 satır) sil | **0 import** — ölü dosya |
| `quiz_no_power` 16 dilde sil | Boş-güç durumu artık yok |
| `quiz.service.ts:671` `powerStatMap`: `COPY` → `ORACLE` | Kâhin kullanımı bugüne kadar **hiç sayılmamış**. Kolon adı `stats_copy_used` legacy kalır (yeniden adlandırma → backlog) |
| `exchange.service.ts` envanter upsert'ini `grantPower()` olarak çıkar | `buyPower` içine gömülü, starter paket de aynısına ihtiyaç duyuyor |
| `quiz_screen_mixin.dart` 488 satır → 4 mixin | Limit 300, ayrıca ~60 satır daha ekliyoruz |

**Mixin bölümü:**

```
QuizScreenStateMixin on ConsumerState<QuizScreen>   → alanlar, timer, _resetQuestionState,
                                                       _showGamifiedResult, _handleSessionTransition
QuizAnswerMixin      on QuizScreenStateMixin        → selectAnswer, submitAnswer,
                                                       _handleAnswerResponse, onFeedbackComplete, onTimeout
QuizPowerMixin       on QuizScreenStateMixin        → usePower, onRescue, onDeclineRescue,
                                                       ortak hata yolu, güç analytics
QuizFlowMixin        on QuizScreenStateMixin        → confirmExit, onStartChat, onGoBack,
                                                       _maybeShowFirstMatchPaywall
```

---

## 9. Doğrulama

### DoD

- `dart analyze` sıfır hata · `npm run build` temiz
- `/flutter-review` + `/server-review` + `chat-flow-guard` (yeniden) temiz
- `i18n-guardian`: yeni/değişen key'ler 16 dilde
- Migration 036 Supabase MCP ile uygulandı
- 2.0.7 TestFlight'ta

### Cihaz testi — kanıtlanması gerekenler

1. **Envanter 0 + bakiye var → güç kullanıldı.** Elmas gerçekten düştü, hedefe yeşil
   gitti. *Bu sunucu yolu bugüne kadar hiç çalışmadı — en kritik test.*
2. **Aynı güce iki kez bas** → ikinci seferde ücret **alınmıyor**, buton kullanılmış
   görünüyor. Quiz ve chat ayrı ayrı. TIME_EXTEND dahil.
3. **Uygulamayı öldür, quize geri dön** → kullanılmış güçler hâlâ kullanılmış görünüyor
   (`used_powers` restore).
4. **Rescue fiyatı UI = server.** 2 soruluk quizde SKIP 10 gösteriyor, 10 düşüyor.
5. **2 soruluk quizde SKIP_ALL görünmüyor**; 6 soruluk quizde görünüyor.
6. **Yeni kullanıcı** (hem e-posta hem sosyal) ilk quizde ORACLE'da "2" rozeti görüyor.
   **Mevcut kullanıcıda rozet yok.** Soft-delete'ten dönen kullanıcı **tekrar almıyor**.
7. **Bakiye tazeleme:** güç kullanımı sonrası hem quiz hem chat başlığındaki bakiye
   doğru.
8. **Bakiyesiz kullanıcı** → güç tap → paywall → iptal → oyun devam ediyor, kilitlenme
   yok. Chat'te POWER_UNBLOCK + "Pes et" senaryosu (§6) denenip sonucu raporlanacak.
9. **Şık tekilliği:** aynı iki şık girilince mobilde inline hata + "İleri" kapalı;
   API'ye doğrudan gönderilirse server reddediyor.
10. **Listener fix:** soru yazarken önizleme kartı ve buton anında güncelleniyor.
11. **Event'ler Firebase'e düştü:** `quiz_power_tap`, `quiz_power_used` (source ayrımıyla),
    `quiz_rescue_*`.

---

## 10. Backlog'a giden

- **KRİTİK:** `submitGiveUp` → `handleTimeout` DB'ye yazmıyor → chat kalıcı kilitlenebilir
  (§6). Bu faz yeni bir giriş yolu ekliyor.
- HALF fiyat inversiyonu (chat ekonomisini de etkiler)
- POWER_BLOCK/UNBLOCK config drift'i (019: 40/50 vs 021: 15/15)
- Ucuz güçlerde yeşil ödülün 0'a yuvarlanması
- Yeşil sink daralması — 2.5 verisiyle yeniden değerlendir
- `stats_copy_used` kolon adının `stats_oracle_used` olarak yeniden adlandırılması
- Server `expires_at` duvar saati (oturum bütçesi client pause'larını durdurmuyor,
  `TIME_EXTEND` `expires_at`'i uzatmıyor) — güç kullanımı artınca patlar
- Mobilde `TIME_UP` / `SESSION_NOT_FOUND` / `ALREADY_ANSWERED` ele alınmıyor
- Zombi quiz oturumları (`confirmExit` `fail()` çağırmıyor; prod'da 8 adet)
- `AnswerFeedbackOverlay.correctAnswerText` hiç geçirilmiyor — kullanıcı doğru cevabı
  hiç görmüyor
- `_handleRescueFailure`'daki ölü kodlar (`NO_INVENTORY`, `DIAMOND_COOLDOWN`)
- Mevcut sorulara düşük başarı oranı proaktif uyarısı
