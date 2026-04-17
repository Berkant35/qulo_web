# Qulo Workspace — Root Kurallar

## Projeye Ozel Skill Sistemi (businessCaseSkills)
- **Konum:** `.claude/skills/businessCaseSkills/` altindaki tum skill dosyalari projeye ozel is kurallaridir
- **KURAL:** Her session basinda ve her yeni task oncesinde, bu dizindeki skill'leri kontrol et
- **KURAL:** Bir task baslatildiginda, ilgili businessCaseSkills skill'i varsa OTOMATIK calistir — kullaniciya sorma
- **KURAL:** Yeni skill eklendikce bu dizini tara ve ilgili tetikleyicileri ogre
- Bu skill'ler hem mobile (qulov2) hem server (qulo-server) hem de DB (Supabase) katmanlarini kapsayan monorepo seviyesinde calisir

## Alt Proje CLAUDE.md Dosyalari
- `qulov2/CLAUDE.md` — Flutter mobile kurallari (review, conventions, patterns)
- Alt proje kurallari bu root kurallara ek olarak gecerlidir
