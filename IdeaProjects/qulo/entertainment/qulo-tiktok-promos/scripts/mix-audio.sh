#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")/.."

RAW=public/audio/raw
SFX=$RAW/sfx
TMP=tmp
OUT=public/audio/qulo-full-app-intro-mix.mp3
DURATION=115  # video target duration (seconds)

mkdir -p $TMP public/audio

# Detect whether SFX directory has any *.mp3 files (optional layer)
HAS_SFX=false
if [ -d "$SFX" ] && ls $SFX/*.mp3 >/dev/null 2>&1; then
  HAS_SFX=true
fi

echo "→ Stage 1: BGM loop + VO with sidechain ducking (target ${DURATION}s)..."
ffmpeg -y -hide_banner -loglevel warning \
  -stream_loop -1 -i $RAW/bgm.mp3 \
  -i $RAW/vo.mp3 \
  -filter_complex "
    [0:a]volume=0.7,atrim=duration=${DURATION},asetpts=PTS-STARTPTS[bgm_trim];
    [bgm_trim][1:a]sidechaincompress=threshold=0.05:ratio=8:attack=20:release=400[bgm_ducked];
    [bgm_ducked][1:a]amix=inputs=2:duration=longest:dropout_transition=0[vox_bgm]
  " \
  -map "[vox_bgm]" -c:a libmp3lame -b:a 192k -ar 44100 \
  $TMP/stage1.mp3

if [ "$HAS_SFX" = true ]; then
  echo "→ Stage 2: Layer SFX onto timeline..."
  ffmpeg -y -hide_banner -loglevel warning \
    -i $TMP/stage1.mp3 \
    -i $SFX/swoosh.mp3 \
    -i $SFX/diamond_ting.mp3 \
    -i $SFX/correct_ding.mp3 \
    -i $SFX/match_chime.mp3 \
    -i $SFX/ghost_silence.mp3 \
    -i $SFX/type_tap.mp3 \
    -filter_complex "
      [1:a]adelay=8000|8000,volume=0.5[swoosh_s3];
      [2:a]adelay=10500|10500,volume=0.6[ting_s3];
      [3:a]adelay=30000|30000,volume=0.55[ding_q1];
      [3:a]adelay=37500|37500,volume=0.55[ding_q2];
      [3:a]adelay=44500|44500,volume=0.55[ding_q3];
      [2:a]adelay=30000|30000,volume=0.5[ting_q1];
      [2:a]adelay=37500|37500,volume=0.5[ting_q2];
      [4:a]adelay=45500|45500,volume=0.75[match];
      [2:a]adelay=46000|46000,volume=0.7[ting_match];
      [5:a]adelay=5500|5500,volume=0.4[ghost];
      [6:a]adelay=65500|65500,volume=0.35[tap1];
      [6:a]adelay=67500|67500,volume=0.35[tap2];
      [6:a]adelay=69500|69500,volume=0.35[tap3];
      [2:a]adelay=107500|107500,volume=0.7[ting_finale];
      [0:a][swoosh_s3][ting_s3][ding_q1][ding_q2][ding_q3][ting_q1][ting_q2][match][ting_match][ghost][tap1][tap2][tap3][ting_finale]amix=inputs=15:duration=longest:dropout_transition=0,volume=1.3[mixed]
    " \
    -map "[mixed]" -c:a libmp3lame -b:a 192k -ar 44100 \
    $TMP/stage2.mp3
  STAGE2=$TMP/stage2.mp3
else
  echo "→ Stage 2: SFX directory empty — skipping SFX overlay."
  STAGE2=$TMP/stage1.mp3
fi

echo "→ Stage 3: Loudness normalize to -16 LUFS (TikTok target)..."
ffmpeg -y -hide_banner -loglevel warning \
  -i $STAGE2 \
  -af "loudnorm=I=-16:TP=-1:LRA=11" \
  -c:a libmp3lame -b:a 192k -ar 44100 \
  $OUT

echo ""
echo "✓ Master: $OUT"
ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1 $OUT
ls -lh $OUT

rm -f $TMP/stage1.mp3 $TMP/stage2.mp3
