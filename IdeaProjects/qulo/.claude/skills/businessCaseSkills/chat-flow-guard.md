---
name: chat-flow-guard
description: Use when brainstorming a new feature to check if it could break the chat/messaging flow. Triggers during brainstorming skill, before spec is finalized. Dynamically scans qulo-server API routes, qulov2 Flutter chat providers/screens, and DB migrations to detect conflicts. Returns BLOCKER or SAFE.
---

# Chat Flow Guard

Yeni feature tasarlanırken chat akışını bozma riskini tespit eden analiz skill'i.

## Ne Zaman Tetiklenir

Brainstorming skill'inde spec yazılmadan hemen önce — yeni feature açıklaması hazır olduğunda.

## Nasıl Kullanılır

1. Feature spec taslağını oku (brainstorming'den gelen)
2. Aşağıdaki analiz adımlarını Explore subagent ile çalıştır
3. Sonuca göre SAFE veya BLOCKER raporla

## Analiz Adımları

Bir Explore subagent dispatch et. Subagent'a şu prompt'u ver:

```
Yeni feature açıklaması: [FEATURE_SPEC]

Bu feature'ın Qulo chat/messaging akışını bozup bozmayacağını analiz et.

## Taranacak Alanlar

### 1. Server (qulo-server)
Dizin: /Users/berkantcalikusu/IdeaProjects/qulo-server/src/

Oku ve analiz et:
- routes/chat.routes.ts — tüm chat endpoint'leri
- controllers/chat.controller.ts — mesaj CRUD logic
- controllers/chat-question.controller.ts — soru lifecycle
- controllers/media.controller.ts — medya paylaşım
- services/chat.service.ts — iş mantığı (verifyMatchAccess, sendMessage, chat lock, media permission)
- services/chat-question.service.ts — soru oluşturma/cevaplama/güç kullanımı/rescue/timeout
- services/media.service.ts — medya request/respond/disable
- validators/chat.validator.ts — mesaj/reaction validation
- validators/chat-question.validator.ts — soru/cevap/güç validation

### 2. Mobile (qulov2)
Dizin: /Users/berkantcalikusu/IdeaProjects/qulo/qulov2/lib/

Oku ve analiz et:
- features/chat/screens/ — tüm chat ekranları
- features/chat/mixins/ — ChatScreenMixin, CreateChatQuestionScreenMixin, SolveChatQuestionScreenMixin
- features/chat/widgets/ — chat UI bileşenleri
- providers/chat_provider.dart — ChatNotifier state management
- data/repositories/chat_repository.dart — API çağrıları
- data/models/message_model.dart — mesaj modeli
- data/models/chat_question_model.dart — soru modeli
- core/network/services/chat_service.dart — Retrofit API client

### 3. DB / Realtime
- Supabase migration dosyaları (qulov2/supabase/migrations/ veya qulo-server/migrations/)
- Realtime kanalları: chat:{matchId}, typing:{matchId}, media:{matchId}

## Kontrol Edilecek Invariant'lar

Feature'ın bu invariant'lardan herhangi birini bozup bozmadığını kontrol et:

### Mesaj Akışı
- [ ] Chat lock aktifken sadece __QUESTION__: prefixli mesaj gönderilebilir
- [ ] Medya paylaşımı bilateral consent gerektirir (both users enabled)
- [ ] Mesaj soft delete kullanır (deleted_at), hard delete yok
- [ ] Pagination offset-limit tabanlı, max 50 mesaj/sayfa
- [ ] Optimistic UI: mesaj anında prepend, hata durumunda rollback

### Realtime
- [ ] messages kanalı INSERT event'lerini dinler
- [ ] typing kanalı broadcast event kullanır (3s debounce)
- [ ] media kanalı ALL event'lerini dinler (500ms debounce)
- [ ] Soru güncellemeleri FCM ile gelir (Realtime değil)

### Soru Lifecycle
- [ ] create → answer → (power/rescue/timeout) sırası bozulmaz
- [ ] Cevaplayan kişiye correct_option gizlenir (sanitization)
- [ ] Power block aktifken sadece POWER_UNBLOCK kullanılabilir
- [ ] Unmatch risk: yanlış cevap = eşleşme biter
- [ ] Günlük soru limitleri subscription tier'a bağlı (Free:4, Plus:6, Premium:10)

### Elmas Ekonomisi
- [ ] Güç maliyetleri dinamik hesaplanır (soru sayısı çarpanı)
- [ ] Yeşil elmas soru sahibine verilir (sender reward)
- [ ] SKIP güç kullanımı auto-correct + green reward tetikler

### State Management
- [ ] ChatProvider family notifier (matchId bazlı)
- [ ] ChatState: messages, total, page, mediaEnabled, pendingMediaRequest, hasChatLock
- [ ] chatQuestionCacheProvider: soru cache, notification ile invalidate

### Güvenlik
- [ ] verifyMatchAccess: her işlemde match ownership + is_active kontrol
- [ ] sendMessage: sender_id otomatik set (client'tan gelmez)
- [ ] Rate limiting: chatLimiter middleware tüm route'larda aktif

## Çıktı Formatı

Analiz sonucunda şu formatlardan birini kullan:

### Eğer etki yoksa:
SAFE — Bu feature chat akışını etkilemiyor.

### Eğer risk varsa:
BLOCKER — Bu feature chat akışını bozabilir!

ETKILENEN ALANLAR:
1. [Server/Mobile/DB] dosya:satır — açıklama
2. ...

BOZULAN INVARIANT'LAR:
- [invariant açıklaması]

ÇÖZÜM ÖNERİLERİ:
- ...

Bu riskler spec'e eklenmeden plana geçilmemeli.
```

## Brainstorming Entegrasyonu

Brainstorming skill'inde spec yazıldıktan sonra, plan'a geçmeden önce:

1. Feature spec'ini oku
2. Yukarıdaki prompt'u Explore subagent'a dispatch et
3. Sonuç SAFE ise → sessizce devam et
4. Sonuç BLOCKER ise:
   - Kullanıcıya uyarı ver
   - Spec'e "## Chat Impact Analysis" bölümü ekle
   - Etkilenen alanları ve çözüm önerilerini spec'e yaz
   - Kullanıcı onayı olmadan plana geçme

## Dikkat

- Bu skill her zaman GÜNCEL kodu tarar — snapshot kullanmaz
- Server ve mobile tarafı birlikte analiz edilmeli (tek taraf yetmez)
- DB migration'ları da dahil — yeni kolon/tablo chat tablolarını etkileyebilir
- Realtime kanal değişiklikleri özellikle kritik — hem server hem mobile kırılır
