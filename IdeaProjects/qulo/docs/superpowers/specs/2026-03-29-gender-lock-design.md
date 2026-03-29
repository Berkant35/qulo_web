# Cinsiyet & Yonelim Kilitleme — Tasarim Spec

**Tarih:** 2026-03-29
**Branch:** APP-1915
**Durum:** Onaylandi

## Problem

Kadinin daha degerli oldugu bir platformda, erkekler ilk basta kadin olarak kayit olup yesil elmas biriktirdikten sonra profili erkege cevirme girisiminde bulunabilir. Bu, haksiz ekonomik avantaj yaratir.

Asimetri mekanizmasi: Kadinlar dogal olarak daha yuksek desirability score alir (like/shown ratio) → discover'da ust siralarda cikar → daha fazla quiz cozulmesi → daha fazla yesil elmas kazanir.

## Mevcut Durum

| Alan | Kayit | Profil Guncelleme | Durum |
|------|-------|-------------------|-------|
| `gender` | Secilir (MAN, WOMAN, OTHER) | Schema'da YOK | Zaten kilitli |
| `gender_pref` | Secilir (MAN, WOMAN, BOTH) | Schema'da VAR | Degistirilebilir |

## Karar

- `gender`: Mevcut koruma yeterli (validator seviyesi). Ekstra DB trigger eklenmeyecek.
- `gender_pref`: Kilitlenecek. Normal kullanici degistiremeyecek. Sadece admin endpoint ile degistirilebilecek.
- Destek hatti entegrasyonu ayri session'da yapilacak, simdilik admin endpoint hazir olacak.

## Tasarim

### Server Degisiklikleri

**1. `gender_pref` alanini updateProfileSchema'dan kaldir**
- Dosya: `qulo-server/src/validators/user.validator.ts`
- `gender_pref` satirini schema'dan sil
- Boylece normal PATCH /users/profile isteginde gender_pref degisikligi reddedilir

**2. Admin endpoint ekle**
- Yeni route: `PATCH /api/v1/admin/users/:id/gender-pref`
- Body: `{ gender_pref: "MAN" | "WOMAN" | "BOTH" }`
- Auth: Sadece admin token (mevcut admin middleware)
- Loglama: Kim, ne zaman, hangi kullanici icin degistirdi (audit trail)
- Bu endpoint destek hatti entegrasyonu icin hazir olacak

### Flutter Degisiklikleri

**3. Gender pref edit widget'ini kaldir**
- Dosya: `qulov2/lib/features/profile/widgets/edit_profile_preferences_section.dart`
- Gender pref secim widget'ini kaldir
- Yerine bilgilendirme metni goster: "Cinsiyet tercihinizi degistirmek icin destek ekibine basvurun"

**4. Provider'dan gender_pref guncelleme logigini temizle**
- Dosya: `qulov2/lib/providers/edit_profile_provider.dart`
- gender_pref ile ilgili state/update kodlarini kaldir

### Dokunulmayacaklar

- Kayit akisi (register_step_gender.dart) — aynen kalir
- Discover algoritmasi — degisiklik yok
- Ekonomi sistemi — degisiklik yok
- DB trigger/policy — eklenmeyecek
- Profil ekraninda gender_pref gosterimi — read-only olarak kalir

## Gelecek Entegrasyon

Destek hatti gelistirmesi tamamlaninca:
- Admin endpoint'i destek hatti UI'indan cagrilabilir hale gelecek
- Kullanici destek talebi olusturur → admin onaylar → endpoint cagirilir → gender_pref guncellenir

## Dosya Listesi

| Dosya | Islem |
|-------|-------|
| `qulo-server/src/validators/user.validator.ts` | gender_pref kaldir |
| `qulo-server/src/routes/admin.routes.ts` | Yeni endpoint ekle |
| `qulo-server/src/controllers/admin.controller.ts` | Handler ekle |
| `qulov2/lib/features/profile/widgets/edit_profile_preferences_section.dart` | Widget degistir |
| `qulov2/lib/providers/edit_profile_provider.dart` | gender_pref logigi temizle |
