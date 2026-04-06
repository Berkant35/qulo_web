# Login Ekranına Dil Değiştirme Erişimi — Tasarım

**Tarih:** 2026-04-06
**Branch:** APP-1915

## Özet

Login ekranının sağ üst köşesine dil değiştirme ikonu eklenerek, giriş yapmadan önce uygulama dilinin değiştirilebilmesi sağlanır.

## Tasarım

- `LoginScreen`'in `AppScaffold`'una sağ üst köşeye bir `IconButton` eklenir (globe ikonu)
- Tıklanınca mevcut `LanguagePickerSheet` (projede zaten var olan dil seçim widget'ı) açılır
- Kullanıcı dil seçince `LocaleNotifier.setLocale()` tetiklenir → login ekranı seçilen dilde yeniden render olur
- Seçim SharedPreferences'a kaydedilir, uygulama genelinde kalıcı olur

## Yaklaşım

Mevcut dil seçim mekanizmasını yeniden kullan. Yeni widget veya sayfa oluşturmaya gerek yok. Tek değişiklik login ekranına bir giriş noktası (ikon butonu) eklemek.

## Kapsam

**Dahil:**
- `login_screen.dart` — AppBar/AppScaffold actions'a globe IconButton ekleme

**Kapsam dışı:**
- Yeni widget/sayfa yazmak
- Register, forgot password ekranlarına aynı ekleme (istenirse sonra yapılır)

## Etkilenen Dosyalar

- `qulov2/lib/features/auth/screens/login_screen.dart`
