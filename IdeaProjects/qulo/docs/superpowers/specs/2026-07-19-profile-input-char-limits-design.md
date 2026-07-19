# Profil Input Karakter Limitleri + "Kalan Karakter" Göstergesi — Tasarım

**Tarih:** 2026-07-19
**Kapsam:** qulov2 (Flutter mobile) — profil düzenleme input'ları
**Branch:** qulov2 `main`

## Problem

Profil düzenleme ekranındaki serbest metin alanları (job, school, pets, music,
personality, city) uzun metin girildiğinde `DetailChips` içinde chip'leri şişiriyor
ve tasarımsal kaymalara yol açıyor. Ayrıca:

- Limitler zaten var ama **hardcoded** (`maxLength: 100/200/300` widget içinde) —
  `qulov2/CLAUDE.md` "hardcoded değer YASAK" kuralına aykırı, tek yerden yönetilemiyor.
- Merkezi bir karakter limiti config'i **yok**.
- Chip metni ([detail_chips.dart:161](../../../qulov2/lib/features/profile/widgets/detail_chips.dart))
  `maxLines`/`overflow` içermiyor → `Row(mainAxisSize: min)` içinde sınırsız genişliyor.
- Flutter'ın yerleşik "12/300" sayacı sadece çok satırlı alanda görünüyor; kullanıcı
  toplam sayıyı DEĞİL, yalnızca limite yaklaşınca "son X karakter kaldı" uyarısını istiyor.

## Hedef

1. Profil input limitlerini tek bir **config dosyasından** yönet (kolay değiştirilebilir).
2. Input'larda toplam maksimum sayıyı gösterme; yalnızca **kalan ≤ eşik** olunca
   "Son X karakter kaldı" göster (varsayılan eşik: 5).
3. Chip kaymasını iki katmanlı çöz: (a) limiti düşür, (b) chip metnini ellipsis ile clamp'le.
4. Dokunulan dosyalardaki kural ihlallerini (hardcoded değerler) düzelt.

## Çözüm

### 1. Merkezi config — `lib/core/constants/profile_field_limits.dart`

Mevcut `AppConstants` konvansiyonu (`abstract final class` + `static const int`)
birebir izlenir.

```dart
/// Profil düzenleme input'larının maksimum karakter limitleri.
/// Tek yerden değiştirilebilir — değerler chip tasarımının bozulmayacağı
/// şekilde ayarlanmıştır.
abstract final class ProfileFieldLimits {
  // Serbest metin (DetailChips'e dönüşen) — chip taşmasın diye kısa tutulur
  static const int city = 40;
  static const int job = 40;
  static const int school = 40;
  static const int pets = 30;
  static const int music = 40;
  static const int personality = 60;

  // Uzun metin
  static const int bio = 300;
  static const int name = 50;

  // Sayısal (rakam)
  static const int height = 3;
  static const int weight = 3;

  /// "Son X karakter kaldı" uyarısının görüneceği kalan-karakter eşiği.
  static const int remainingWarningThreshold = 5;
}
```

**Değer gerekçesi:** Chip alanları 30–60 aralığında; ortalama telefon genişliğinde
tek chip satırı taşırmaz. `personality` biraz daha uzun (60) çünkü serbest ifade alanı.
`bio` (300) ve `name` (50) mevcut değerleriyle korunur.

### 2. `AppTextField` — "kalan karakter" göstergesi

`lib/core/widgets/app_text_field.dart`. StatefulWidget'a gerek yok; Flutter'ın yerleşik
`TextFormField.buildCounter` callback'i kullanılır (idiomatic, tek + çok satır hepsinde çalışır).

- Mevcut `counterText: maxLines > 1 ? null : ''` satırı **kaldırılır**.
- `buildCounter` eklenir:
  - `maxLength == null` → `null` yerine gizli: `const SizedBox.shrink()` döner
    (not: `null` dönerse Flutter varsayılan sayacı gösterir; bu yüzden boş widget döneriz).
  - `remaining = maxLength - currentLength`.
  - `remaining <= ProfileFieldLimits.remainingWarningThreshold && remaining >= 0` →
    küçük uyarı metni (`context.tr('chars_remaining').replaceAll('{count}', '$remaining')`),
    theme'den `bodySmall` + `colorScheme.onSurfaceVariant` (sakin hint tonu — alarm
    değil; hardcoded renk yok).
  - Aksi halde `const SizedBox.shrink()`.
- Uyarı metni stili theme'den gelir (spacing `AppSpacing`, renk `colorScheme`).

Bu sayede **tüm** `AppTextField` kullanan input'lar (profil + diğer) otomatik olarak
aynı davranışı kazanır ve toplam sayaç hiçbir yerde görünmez.

### 3. Localization — `chars_remaining` key'i

16 dile eklenir (i18n-guardian ile senkron). Placeholder pattern mevcut
`{count}` konvansiyonunu izler (örn. `questions_count`, `min_questions`).

| Dil | Değer |
|-----|-------|
| tr | `Son {count} karakter kaldı` |
| en | `{count} characters left` |
| (diğer 14) | doğal çeviri |

Tüketim: `context.tr('chars_remaining').replaceAll('{count}', '$remaining')`.

### 4. Chip sertleştirme — `detail_chips.dart`

`_DetailChipItem` içindeki `Text` ([detail_chips.dart:161-164](../../../qulov2/lib/features/profile/widgets/detail_chips.dart)):

- `maxLines: 1`
- `overflow: TextOverflow.ellipsis`
- `Text`'i `ConstrainedBox(maxWidth: ...)` veya `Flexible` ile sarıp taşmayı kes.
  `Row` `mainAxisSize.min` olduğundan `Flexible` tek başına yetmez; ekran genişliğine
  oranlı bir `maxWidth` clamp (örn. `MediaQuery.sizeOf(context).width * 0.6`) uygulanır.

İki katmanlı koruma: limit düşük + chip metni her koşulda clamp'li → tasarım asla kaymaz.

### 5. Hardcoded değerlerin config'e taşınması (kural ihlali düzeltmesi)

Aşağıdaki dosyalarda hardcoded `maxLength` değerleri `ProfileFieldLimits`'e bağlanır:

- `edit_profile_details_section.dart`: job/school/pets/music (100→`ProfileFieldLimits.job` vb.),
  personality (200→60).
- `edit_profile_basic_info_section.dart`: city (100→40), height/weight (3→config).
- `edit_profile_bio_section.dart`: bio (300→`ProfileFieldLimits.bio`).

## Etkilenen Dosyalar

| Dosya | Değişiklik |
|-------|-----------|
| `lib/core/constants/profile_field_limits.dart` | **YENİ** — limit config |
| `lib/core/widgets/app_text_field.dart` | `buildCounter` ekle, `counterText` kaldır |
| `lib/core/l10n/translations/*.dart` (16) | `chars_remaining` key |
| `lib/features/profile/widgets/detail_chips.dart` | chip Text clamp + ellipsis |
| `lib/features/profile/widgets/edit_profile_details_section.dart` | limitler config'ten |
| `lib/features/profile/widgets/edit_profile_basic_info_section.dart` | limitler config'ten |
| `lib/features/profile/widgets/edit_profile_bio_section.dart` | limit config'ten |

## Kapsam Dışı (backlog)

- `onboarding/widgets/setup_ai_preview_sheet.dart` — AI soru önizleme input'larında
  `maxLength` YOK (sınırsız girdi). Chip-driving değil, ayrı dokunulmayan dosya →
  backlog'a not, bu PR'a dahil değil.
- Chat/quiz/question input limitleri (500/200/2000) — profil kapsamı dışında, dokunulmuyor.

## Doğrulama

- `flutter analyze` → sıfır hata (CLAUDE.md zorunlu).
- Chip alanlarına limit kadar uzun metin girip chip'lerin taşmadığını gör.
- Bir input'a limitin son 5 karakterine gel → "Son X karakter kaldı" görünmeli;
  daha az doluyken görünmemeli; toplam sayaç hiç görünmemeli.
- 16 dilde `chars_remaining` key'inin var olduğunu i18n-guardian ile doğrula.
- `/flutter-review` skill'i (CLAUDE.md commit öncesi zorunlu).

## businessCaseSkills Kontrolü

- **chat-flow-guard:** SAFE — chat provider/route/migration'a dokunulmuyor.
- **economy-impact:** N/A — elmas/güç/abonelik/IAP ekonomisine etki yok.
- **i18n-guardian:** Tetiklenir — yeni `chars_remaining` key'i 16 dile yayılacak.
