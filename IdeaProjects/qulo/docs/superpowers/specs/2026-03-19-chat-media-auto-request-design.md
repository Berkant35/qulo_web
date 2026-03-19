# Chat Media Auto-Request — Design Spec

## Overview

Chat ekranında fotoğraf/ses butonuna basıldığında consent dialog yerine otomatik `requestMedia()` çağrısı yapılacak. Karşı tarafın kabul/red akışı (MediaRequestBanner) aynen kalacak.

## Mevcut Durum

- `handlePhotoTap()`: `mediaEnabled` false ise → `_showMediaConsentDialog()` açılıyor
- `startVoiceRecording()`: `mediaEnabled` false ise → aynı dialog
- Dialog: "Medya paylaşmak için karşı tarafın da onay vermesi gerekiyor. İstek gönderilsin mi?" → Evet → `requestMedia()`
- UX sorunu: Kullanıcı zaten göndermek istiyor, gereksiz dialog friction yaratıyor

## Tasarım

### Yeni Akış

Fotoğraf/ses butonuna basıldığında `mediaEnabled` false ise:

1. Pending request **yoksa** → arka planda `requestMedia()` çağır + snackbar göster
2. Pending request **varsa** → sadece "İstek zaten gönderildi" snackbar'ı göster
3. `mediaEnabled` true ise → mevcut davranış (fotoğraf seç / ses kaydet)

### Değişiklikler

**Tek dosya:** `lib/features/chat/mixins/chat_screen_mixin.dart`

**`handlePhotoTap()` (satır 346-354):**
- `_showMediaConsentDialog()` çağrısı kaldırılacak
- Yerine `_autoRequestMedia()` çağrılacak

**`startVoiceRecording()` (satır 494-502):**
- `_showMediaConsentDialog()` çağrısı kaldırılacak
- Yerine `_autoRequestMedia()` çağrılacak

**Yeni metot: `_autoRequestMedia()`:**
- Pending request varsa → snackbar ("Medya isteği zaten gönderildi, yanıt bekleniyor")
- Yoksa → `requestMedia()` çağır → success: snackbar ("Medya paylaşım isteği gönderildi") / failure: hata snackbar'ı

**`_showMediaConsentDialog()` (satır 356-412):**
- Tamamen kaldırılacak (dead code)

### Dokunulmayacaklar

- Backend (media.service.ts, chat.service.ts)
- Karşı tarafın kabul/red akışı (MediaRequestBanner, MediaRequestCard)
- chat_provider.dart (requestMedia, respondToMediaRequest, loadMediaStatus)
- Models (MediaRequestModel, MediaStatusResponse)
- Fotoğraf seçme/gönderme akışı (_showPhotoSourceSheet, _pickAndSendPhoto)
- Ses kaydetme/gönderme akışı (handleVoiceComplete)

### i18n

Mevcut snackbar mesajları Türkçe hardcoded. Bu spec kapsamında aynen kalacak — i18n ayrı iş.
