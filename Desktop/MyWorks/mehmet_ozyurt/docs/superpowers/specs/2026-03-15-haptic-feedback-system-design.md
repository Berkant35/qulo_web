# Haptic Feedback Sistemi - Tasarım Dokümanı

**Tarih:** 2026-03-15
**Proje:** tabul/ (Ana Mobil Uygulama)
**Branch:** APP-1915

---

## 1. Amaç

Uygulamadaki buton etkileşimlerinde kullanıcıya hafif titreşim geri
bildirimi sağlamak. Mevcut durumda ~11 dosyada dağınık
`HapticFeedback.*` çağrıları var. Bu tasarım:

- Merkezi bir manager ile tüm haptic çağrıları tek noktadan yönetir
- AppButton widget'ına otomatik haptic entegrasyonu sağlar
- Buton tipine göre farklı titreşim seviyeleri sunar
- Kullanıcıya ayarlardan açma/kapama imkanı verir

---

## 2. Haptic Feedback Tipleri

| Tip | Kullanım Yeri | Flutter Karşılığı |
|-----|--------------|-------------------|
| `tap` | Normal buton tıklama | `HapticFeedback.lightImpact()` |
| `selection` | Liste seçimi, tab değişimi | `HapticFeedback.selectionClick()` |
| `success` | Başarılı işlem, onay | `HapticFeedback.mediumImpact()` |
| `warning` | Uyarı dialog, kritik aksiyon | `HapticFeedback.heavyImpact()` |
| `error` | Hata, yanlış giriş | `HapticFeedback.vibrate()` |

---

## 3. Bileşenler

### 3.1 HapticType Enum

**Dosya:** `lib/core/service/haptic/haptic_type.dart`

```dart
enum HapticType {
  tap,
  selection,
  success,
  warning,
  error,
  none,
}
```

`none` değeri haptic istenmeyen butonlar için kullanılır.

### 3.2 HapticFeedbackManager (Singleton)

**Dosya:** `lib/core/service/haptic/haptic_feedback_manager.dart`

Sorumluluklar:
- `HapticType` enum'una göre doğru Flutter HapticFeedback
  metodunu çağırır
- `HapticSettingsCubit` state'ini kontrol eder; kapalıysa
  early return yapar
- Her çağrıyı `MyLog.d` ile loglar (debug modda)
- `registerLazySingleton` ile GetIt'e register edilir

Metotlar:
- `void trigger(HapticType type)` — ana metot.
  İlk kontrol: `if (type == HapticType.none) return;`
  İkinci kontrol: `if (!cubit.state) return;` (kapalıysa)
  Sonra ilgili HapticFeedback metodunu çağırır.
- `void tap()` — kısayol: `trigger(HapticType.tap)`
- `void selection()` — kısayol: `trigger(HapticType.selection)`
- `void success()` — kısayol: `trigger(HapticType.success)`
- `void warning()` — kısayol: `trigger(HapticType.warning)`
- `void error()` — kısayol: `trigger(HapticType.error)`

State okuma:
- Manager constructor'ında `locator<HapticSettingsCubit>()`
  referansını alır
- `trigger()` içinde `cubit.state` kontrol edilir

### 3.3 HapticSettingsCubit (HydratedBloc)

**Dosya:** `lib/core/bloc/cubit/haptic_settings_cubit.dart`

- `HydratedCubit<bool>` extend eder
- Varsayılan state: `true` (haptic açık)
- `toggle()` metodu: `emit(!state)`
- `fromJson` / `toJson`: `bool` serialize
- GetIt'e `registerLazySingleton` ile register edilir
- HapticFeedbackManager'dan önce register edilmeli
  (bağımlılık sırası)

### 3.4 AppButton Entegrasyonu

**Dosya:** `lib/core/shared/buttons/app_button.dart`

Değişiklikler:
- `hapticType` parametresi eklenir (varsayılan: `HapticType.tap`)
- `onPressed` callback'i `build()` içinde sarmalanır: önce
  haptic trigger, sonra orijinal callback. `const`
  constructor uyumluluğu korunur — haptic çağrısı
  constructor'da değil `build()` metodunda gerçekleşir.
- Static metotlara göre varsayılan haptic tipi:

| Static Metot | Varsayılan HapticType |
|-------------|----------------------|
| `primaryFilled()` | `tap` |
| `secondaryFilled()` | `tap` |
| `outline()` | `tap` |
| `textOnly()` | `tap` |
| `iconOnly()` | `tap` |
| `small()` | `tap` |
| `medium()` | `tap` |
| `large()` | `tap` |
| `floating()` | `tap` |
| `custom()` | `tap` |
| `error()` | `error` |
| `success()` | `success` |
| `startGame()` | `success` |
| `joinGame()` | `success` |
| `createRoom()` | `success` |
| `ready()` | `success` |
| `playNow()` | `success` |

Widget seviyesinde override:
```dart
AppButton.primaryFilled(
  hapticType: HapticType.none, // bu butonda haptic yok
  onPressed: () => ...,
)
```

### 3.5 Ayarlar Toggle

**Dosya:** `lib/core/shared/sheets/settings_menu_sheet.dart`

- Lokalizasyon anahtarı: `S.current.haptic_feedback`
- Toggle widget: `Switch` veya mevcut settings tile pattern
- `HapticSettingsCubit.toggle()` çağırır

---

## 4. DI Registration Sırası

`locator.dart` içinde registration sırası:

```
1. HapticSettingsCubit  (HydratedCubit, state persist)
2. HapticFeedbackManager (HapticSettingsCubit'e bağımlı)
```

Her ikisi de `registerLazySingleton` ile register edilir.

---

## 5. Mevcut Kodun Temizliği

~11 dosyada doğrudan `HapticFeedback.*` çağrısı var. Bunlar:
- `import 'package:flutter/services.dart'` kaldırılır
  (başka kullanım yoksa)
- `HapticFeedback.lightImpact()` →
  `locator<HapticFeedbackManager>().tap()`
- `HapticFeedback.selectionClick()` →
  `locator<HapticFeedbackManager>().selection()`
- `HapticFeedback.mediumImpact()` →
  `locator<HapticFeedbackManager>().success()`

AppButton içindeki butonlar zaten otomatik haptic alacağı
için, bu dosyalarda tekrar eden çağrılar silinir.

---

## 6. Lokalizasyon

`intl_tr.arb` (birincil):
```json
"haptic_feedback": "Titreşim geri bildirimi"
```

`intl_en.arb`:
```json
"haptic_feedback": "Haptic feedback"
```

---

## 7. Etki Alanı

- **Değişen dosyalar:** ~16 dosya (manager, cubit, AppButton,
  settings, locator, ~11 temizlik)
- **Yeni dosyalar:** 3 (haptic_type.dart,
  haptic_feedback_manager.dart, haptic_settings_cubit.dart)
- **Paket bağımlılığı:** Yok — Flutter native
  `HapticFeedback` yeterli
- **Platform:** iOS + Android (Flutter HapticFeedback her
  ikisini destekler)
- **Breaking change:** Yok — mevcut davranış korunur,
  sadece merkezileştirilir

---

## 8. Kısıtlamalar ve Kararlar

- **Harici paket kullanılmıyor:** `flutter/services.dart`
  içindeki `HapticFeedback` yeterli. Özel titreşim
  pattern'ları gerekirse ileride `vibration` paketi
  eklenebilir.
- **Manager stateless:** Kendi state'i yok, sadece
  `HapticSettingsCubit` okur. Bu sayede test edilmesi kolay.
- **AppButton dışındaki widget'lar:** GestureDetector veya
  InkWell kullanan özel widget'larda manager doğrudan
  çağrılır: `locator<HapticFeedbackManager>().selection()`
- **Performans:** HapticFeedback çağrıları platform
  channel üzerinden gider, senkron ve hafif. Performans
  etkisi yok.
