# Login Ekranına Dil Değiştirme Erişimi — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Login ekranının sağ üst köşesine globe ikonu ekleyerek, giriş yapmadan dil değiştirmeye erişim sağlamak.

**Architecture:** Mevcut `LanguagePickerSheet` widget'ı `multiSelect: false` modunda bottom sheet olarak açılır. Seçilen dil `LocaleNotifier.setLocale()` ile uygulanır. Tek dosya değişikliği.

**Tech Stack:** Flutter, Riverpod, SharedPreferences, mevcut LanguagePickerSheet

---

## File Structure

- **Modify:** `qulov2/lib/features/auth/screens/login_screen.dart` — SafeArea içine globe IconButton ekleme

Yeni dosya oluşturmaya gerek yok.

---

### Task 1: Login Ekranına Dil Değiştirme IconButton Ekleme

**Files:**
- Modify: `qulov2/lib/features/auth/screens/login_screen.dart:1-21` (import ekleme)
- Modify: `qulov2/lib/features/auth/screens/login_screen.dart:79-223` (build metodu)

- [ ] **Step 1: Import ekle**

`login_screen.dart` dosyasının import bölümüne şu iki satırı ekle:

```dart
import 'package:qulo_v2/core/constants/app_constants.dart';
import 'package:qulo_v2/core/widgets/language_picker_sheet.dart';
import 'package:qulo_v2/providers/locale_provider.dart';
```

- [ ] **Step 2: Dil değiştirme metodunu ekle**

`_LoginScreenState` sınıfına (dispose metodundan sonra, `_onVideoInitialized` öncesine) şu metodu ekle:

```dart
Future<void> _showLanguagePicker() async {
  final currentLocale = ref.read(localeProvider).languageCode;
  final result = await showModalBottomSheet<List<String>>(
    context: context,
    builder: (_) => LanguagePickerSheet(
      selectedLanguages: [currentLocale],
      multiSelect: false,
    ),
  );
  if (result != null && result.isNotEmpty && mounted) {
    ref.read(localeProvider.notifier).setLocale(Locale(result.first));
  }
}
```

- [ ] **Step 3: SafeArea içine Positioned globe IconButton ekle**

`build` metodundaki `SafeArea` widget'ını düzenle. Mevcut `Center` widget'ını bir `Stack` ile sar ve sağ üst köşeye globe butonunu ekle:

Mevcut kod (satır 97-219):
```dart
SafeArea(
  child: Center(
    child: ConstrainedBox(
      ...
    ),
  ),
),
```

Yeni kod:
```dart
SafeArea(
  child: Stack(
    children: [
      Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
              maxWidth: AppSpacing.maxContentWidth),
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.all(AppSpacing.pagePadding),
            child: Form(
              key: formKey,
              child: StaggeredColumn(
                key: _staggeredKey,
                children: [
                  // ... mevcut children aynen kalır ...
                ],
              ),
            ),
          ),
        ),
      ),
      // Dil değiştirme butonu — sağ üst köşe
      Positioned(
        top: AppSpacing.sm,
        right: AppSpacing.sm,
        child: IconButton(
          icon: const Icon(Icons.language),
          color: Colors.white70,
          tooltip: context.tr('language'),
          onPressed: _showLanguagePicker,
        ),
      ),
    ],
  ),
),
```

- [ ] **Step 4: Uygulamayı çalıştır ve test et**

1. Login ekranını aç
2. Sağ üst köşede globe ikonunun göründüğünü doğrula
3. İkona tıkla → LanguagePickerSheet açılmalı (tek seçim modu)
4. Farklı bir dil seç → login ekranındaki tüm metinler seçilen dilde güncellenmeli
5. Uygulamayı kapat-aç → seçilen dil kalıcı olmalı

- [ ] **Step 5: Commit**

```bash
git add qulov2/lib/features/auth/screens/login_screen.dart
git commit -m "feat(auth): add language switcher to login screen"
```
