# ElevenLabs Music

**Hedef dosya:** `public/audio/music_15s_arc.mp3`
**Süre:** 15.0 saniye, iki-bölümlü ark

## Yapı

| Bölüm | Süre | Karakter |
|---|---|---|
| Bölüm 1 | 0–7s | Cinematic indie piano + low strings drone, melancholic, A minor, 70bpm |
| Bridge | 6.5–7s | Sustained note (musical breath, Pause Beat ile sync) |
| Bölüm 2 | 7–15s | Soft beat enters (kick + snap), warm pad layer, A major modulation, hopeful |
| Fade | 13.5–15s | Gradual fade out |

## ElevenLabs Music Prompt (tek-prompt yöntemi — birincil)

```
Cinematic 15-second instrumental track in two halves. The first 7 seconds: a sparse melancholy solo piano in A minor at 70 BPM, accompanied by a low sustained string drone, creating a feeling of quiet emotional weight (think Past Lives, Aftersun, Phoebe Bridgers acoustic intros). At the 7-second mark, a soft warm beat enters — a gentle kick drum and a finger-snap rhythm — and the harmony shifts toward A major with a soft warm synth pad. The second half feels like emotional release and hope (think Bonobo, Tycho, gentle electronic). The track gradually fades to silence over the last 1.5 seconds. No vocals, no melody changes (just harmonic shift). 9:16 vertical video soundtrack, instrumental only.
```

## Fallback yöntemi (eğer tek-prompt zayıfsa)

İki ayrı 8sn track üret:

**Track A — `music_part1_melancholy.mp3` (8sn):**
```
A sparse, melancholic solo piano in A minor at 70 BPM, with a low sustained string drone. Indie cinematic feel (Past Lives, Aftersun aesthetic). 8 seconds, no vocals, instrumental only.
```

**Track B — `music_part2_release.mp3` (8sn):**
```
A warm, hopeful instrumental in A major at 70 BPM, with a gentle kick drum, finger-snap rhythm, and warm synth pad. Bonobo and Tycho influence, electronic indie. 8 seconds, no vocals, instrumental only.
```

Sonra Audacity'de:
1. Track A'yı 0-7sn'ye yerleştir, 6-7sn arası 1sn fade out
2. Track B'yi 6.5-15sn'ye yerleştir, 6.5-7.5sn arası 1sn fade in (crossfade), 13.5-15sn arası fade out
3. Master export: `music_15s_arc.mp3`

## Beklenen output

- Format: MP3, 44.1kHz, stereo, 256kbps
- Dosya: `public/audio/music_15s_arc.mp3`
- Toplam süre: 15.0sn

## Yerleşim

```bash
mv ~/Downloads/music_15s_arc.mp3 entertainment/qulo-stop-swiping/public/audio/music_15s_arc.mp3
```

## Retry kriteri

- ✅ İlk yarı melankolik ama melodramatik değil
- ✅ 7. saniyedeki geçiş hissedilir ama abrupt değil
- ✅ İkinci yarı umut verir ama saf "happy" değil — emotional release
- ❌ Vokaller varsa REJECT (instrumental only)
- ❌ Beat çok loud / club-style ise REJECT (subtle olmalı)
