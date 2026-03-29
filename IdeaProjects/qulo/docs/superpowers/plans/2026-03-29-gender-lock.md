# Cinsiyet & Yönelim Kilitleme — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Cinsiyet ve cinsel yönelim değişikliğini engelleyerek yeşil elmas ekonomisindeki haksız avantajı önlemek.

**Architecture:** Server'da `gender_pref` alanını profil güncelleme schema'sından kaldır, admin-only endpoint ekle. Flutter'da gender_pref edit widget'ını bilgilendirme mesajıyla değiştir.

**Tech Stack:** Node.js/Express/Zod (server), Flutter/Riverpod (mobile)

---

## File Structure

| File | Action | Responsibility |
|------|--------|---------------|
| `qulo-server/src/validators/user.validator.ts` | Modify | `gender_pref` satırını sil |
| `qulo-server/src/admin/admin.service.ts` | Modify | `updateGenderPref()` metodu ekle |
| `qulo-server/src/admin/admin.controller.ts` | Modify | `updateUserGenderPref()` handler ekle |
| `qulo-server/src/admin/admin.routes.ts` | Modify | PATCH route ekle |
| `qulov2/lib/features/profile/widgets/edit_profile_preferences_section.dart` | Modify | Gender pref widget → info text |
| `qulov2/lib/features/profile/mixins/edit_profile_screen_mixin.dart` | Modify | `gender_pref` key'ini profileData'dan sil |
| `qulov2/lib/providers/edit_profile_provider.dart` | Modify | `setGenderPref` metodunu ve state field'ı temizle |

---

### Task 1: Server — `gender_pref` alanını updateProfileSchema'dan kaldır

**Files:**
- Modify: `qulo-server/src/validators/user.validator.ts:9`

- [ ] **Step 1: `gender_pref` satırını schema'dan sil**

`user.validator.ts` dosyasında 9. satırdaki `gender_pref` satırını kaldır:

```typescript
// KALDIR: gender_pref: z.enum(["MAN", "WOMAN", "BOTH"]).optional(),
```

Sonuç — `updateProfileSchema` şöyle olacak:

```typescript
export const updateProfileSchema = z.object({
  name: z.string().min(1).max(50).optional(),
  surname: z.string().min(1).max(50).optional(),
  bio: z.string().max(500).optional(),
  age: z.number().int().min(18).max(99).optional(),
  match_radius_km: z.number().int().min(5).max(500).optional(),
  age_pref_min: z.number().int().min(18).max(99).optional(),
  age_pref_max: z.number().int().min(18).max(99).optional(),
  city: z.string().max(100).optional(),
  country: z.string().max(100).optional(),
  locale: z.enum(SUPPORTED_LOCALES as unknown as [string, ...string[]]).optional(),
  photos: z.array(z.string().url()).max(6).optional(),
  relationship_goal: z.enum(["SERIOUS", "FRIENDSHIP", "NOT_SURE"]).optional(),
  preferred_languages: z.array(z.enum(["tr", "en", "de", "fr", "ar", "ru", "es"])).min(1).max(7).optional(),
  strict_language_mode: z.boolean().optional(),
});
```

- [ ] **Step 2: Server'ın hatasız derlediğini doğrula**

Run: `cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server && npx tsc --noEmit`
Expected: Hata yok. `gender_pref` zaten optional olduğu için hiçbir servis dosyası kırılmaz.

- [ ] **Step 3: Commit**

```bash
git add qulo-server/src/validators/user.validator.ts
git commit -m "feat(server): remove gender_pref from updateProfileSchema to lock preference changes"
```

---

### Task 2: Server — Admin gender_pref güncelleme endpoint'i

**Files:**
- Modify: `qulo-server/src/admin/admin.service.ts`
- Modify: `qulo-server/src/admin/admin.controller.ts`
- Modify: `qulo-server/src/admin/admin.routes.ts`

- [ ] **Step 1: Admin service'e `updateGenderPref` metodu ekle**

`admin.service.ts` dosyasının sonuna (class kapanmadan önce) ekle:

```typescript
async updateGenderPref(userId: string, genderPref: "MAN" | "WOMAN" | "BOTH", adminEmail: string): Promise<void> {
  const { error } = await supabase
    .from("users")
    .update({ gender_pref: genderPref })
    .eq("id", userId)
    .eq("is_deleted", false);

  if (error) throw new Error(`gender_pref update failed: ${error.message}`);

  console.log(`[ADMIN] gender_pref updated: user=${userId} newPref=${genderPref} by=${adminEmail}`);
}
```

- [ ] **Step 2: Admin controller'a handler ekle**

`admin.controller.ts` dosyasının sonuna (class kapanmadan önce) ekle:

```typescript
async updateUserGenderPref(req: Request, res: Response) {
  try {
    const { id } = req.params;
    const { gender_pref } = req.body;

    if (!["MAN", "WOMAN", "BOTH"].includes(gender_pref)) {
      return res.redirect(`/admin/users/${id}?error=${encodeURIComponent("Invalid gender_pref value")}`);
    }

    await adminService.updateGenderPref(id, gender_pref, req.session.adminEmail!);
    res.redirect(`/admin/users/${id}?success=${encodeURIComponent("Gender preference updated")}`);
  } catch (err: any) {
    const { id } = req.params;
    res.redirect(`/admin/users/${id}?error=${encodeURIComponent(err.message)}`);
  }
}
```

- [ ] **Step 3: Admin route ekle**

`admin.routes.ts` dosyasında mevcut user action route'unun yakınına ekle (adminAuth korumalı bölüme):

```typescript
router.post("/users/:id/gender-pref", csrfValidate, (req, res) => adminController.updateUserGenderPref(req, res));
```

- [ ] **Step 4: Server'ın hatasız derlediğini doğrula**

Run: `cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server && npx tsc --noEmit`
Expected: Hata yok.

- [ ] **Step 5: Commit**

```bash
git add qulo-server/src/admin/admin.service.ts qulo-server/src/admin/admin.controller.ts qulo-server/src/admin/admin.routes.ts
git commit -m "feat(admin): add gender_pref update endpoint for support team"
```

---

### Task 3: Flutter — Gender pref edit widget'ını kaldır, info text göster

**Files:**
- Modify: `qulov2/lib/features/profile/widgets/edit_profile_preferences_section.dart`

- [ ] **Step 1: SegmentedButton'ı bilgilendirme metniyle değiştir**

`edit_profile_preferences_section.dart` dosyasında 32-54 arası (gender preference label + SegmentedButton + SizedBox) şu kodla değiştir:

```dart
          // Gender preference (locked)
          Text(
            context.tr('gender_preference'),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: context.appColors.border),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lock_outline,
                  size: 18,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    _genderPrefLabel(context, epState.selectedGenderPref),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            context.tr('gender_pref_locked_info'),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
```

- [ ] **Step 2: `_genderPrefLabel` helper metodu ekle**

Dosyanın sonuna, class kapanmadan önce ekle:

```dart
  String _genderPrefLabel(BuildContext context, String? pref) {
    switch (pref) {
      case 'MAN':
        return context.tr('male');
      case 'WOMAN':
        return context.tr('female');
      case 'BOTH':
        return context.tr('all');
      default:
        return context.tr('all');
    }
  }
```

- [ ] **Step 3: `editProfileProvider` import'undaki `setGenderPref` çağrısını kaldır**

Widget artık `onSelectionChanged` yok — `ref.read(editProfileProvider.notifier).setGenderPref(...)` çağrısı zaten silindi (SegmentedButton kaldırıldığında otomatik gitti).

- [ ] **Step 4: i18n key ekle**

`gender_pref_locked_info` key'ini her iki locale dosyasına ekle:

- `qulov2/lib/core/l10n/locales/tr.json`: `"gender_pref_locked_info": "Cinsiyet tercihinizi değiştirmek için destek ekibine başvurun."`
- `qulov2/lib/core/l10n/locales/en.json`: `"gender_pref_locked_info": "Contact support to change your gender preference."`

- [ ] **Step 5: Commit**

```bash
git add qulov2/lib/features/profile/widgets/edit_profile_preferences_section.dart qulov2/lib/core/l10n/locales/tr.json qulov2/lib/core/l10n/locales/en.json
git commit -m "feat(flutter): replace gender_pref selector with locked info display"
```

---

### Task 4: Flutter — Provider ve mixin'den gender_pref yazma logiğini temizle

**Files:**
- Modify: `qulov2/lib/features/profile/mixins/edit_profile_screen_mixin.dart:267`
- Modify: `qulov2/lib/providers/edit_profile_provider.dart`

- [ ] **Step 1: Mixin'den `gender_pref` key'ini sil**

`edit_profile_screen_mixin.dart` dosyasında 267. satırdaki şu satırı kaldır:

```dart
// KALDIR: 'gender_pref': epState.selectedGenderPref,
```

- [ ] **Step 2: Provider'dan `setGenderPref` metodunu sil**

`edit_profile_provider.dart` dosyasında 97-98. satırdaki şu metodu kaldır:

```dart
// KALDIR:
// void setGenderPref(String? v) =>
//     state = state.copyWith(selectedGenderPref: () => v);
```

NOT: `selectedGenderPref` state field'ı ve `copyWith` parametresi KALACAK — read-only olarak widget'ta gösterilmeye devam ediyor. Sadece setter siliniyor.

- [ ] **Step 3: Flutter analyze çalıştır**

Run: `cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2 && flutter analyze`
Expected: Hata yok. `setGenderPref` artık hiçbir yerden çağrılmıyor.

- [ ] **Step 4: Commit**

```bash
git add qulov2/lib/features/profile/mixins/edit_profile_screen_mixin.dart qulov2/lib/providers/edit_profile_provider.dart
git commit -m "feat(flutter): remove gender_pref write logic from provider and mixin"
```

---

### Task 5: Doğrulama

- [ ] **Step 1: Server derleme doğrulaması**

Run: `cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server && npx tsc --noEmit`
Expected: Hata yok.

- [ ] **Step 2: Flutter analyze doğrulaması**

Run: `cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2 && flutter analyze`
Expected: Hata yok.

- [ ] **Step 3: Manuel test senaryosu**

1. Server'ı başlat, `PATCH /api/v1/users/profile` body'sine `gender_pref: "MAN"` ekleyerek çağır → Zod validation hatası dönmeli (field tanınmıyor, strip edilir)
2. Admin panelden `/admin/users/:id/gender-pref` POST çağrısı → Başarılı güncelleme
3. Flutter'da profil düzenle → Gender preference alanı kilit ikonu + info text göstermeli, değiştirilemez olmalı
4. Profili kaydet → `gender_pref` key'i request body'de olmamalı
