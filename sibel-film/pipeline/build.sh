#!/usr/bin/env bash
# clips/scene_01..05.mp4 dosyalarını 1080x1920 tek filme birleştirir.
# Kullanım:  bash pipeline/build.sh
# İsteğe bağlı: CLIPS=başka/klasör  MUSIC=music/sarki.mp3  OUT=output
set -euo pipefail
cd "$(dirname "$0")/.."

CLIPS="${CLIPS:-clips}"
OUT="${OUT:-output}"
MUSIC="${MUSIC:-$(ls music/*.mp3 music/*.m4a music/*.wav 2>/dev/null | head -1 || true)}"
TEXT="pipeline/final_text.png"
DUR=(3.5 5.5 6 5 12)  # sahne süreleri (sn); 5. sahne son kare dondurmayı içerir
START=(1 1.5 1 0.5 0) # her klibin kullanılacak başlangıç anı (sn)
SPEED=(2 1.18 1.17 1 1) # hızlandırma katsayısı (1 = gerçek hız)
TEXT_DELAY=4.5        # mesaj 5. sahne başladıktan kaç sn sonra belirsin
XF=0.5                # sahneler arası çapraz çözülme
FPS=30

mkdir -p "$OUT/normalized"
for i in 1 2 3 4 5; do
  [ -f "$CLIPS/scene_0$i.mp4" ] || { echo "EKSİK: $CLIPS/scene_0$i.mp4"; exit 1; }
done

# 1) Her klibi aynı boyut, kare hızı ve süreye getir (kısa klibin son karesi dondurulur)
for i in 1 2 3 4 5; do
  ffmpeg -y -loglevel error -ss "${START[$((i-1))]}" -i "$CLIPS/scene_0$i.mp4" -an \
    -vf "setpts=PTS/${SPEED[$((i-1))]},scale=1080:1920:force_original_aspect_ratio=increase:flags=lanczos,crop=1080:1920,fps=$FPS,tpad=stop_mode=clone:stop_duration=12,format=yuv420p" \
    -t "${DUR[$((i-1))]}" -c:v libx264 -crf 16 -preset medium "$OUT/normalized/scene_0$i.mp4"
done

# 2) Çapraz çözülmelerle birleştir, sonda siyaha karart
o1=$(echo "${DUR[0]} - $XF" | bc -l)
o2=$(echo "$o1 + ${DUR[1]} - $XF" | bc -l)
o3=$(echo "$o2 + ${DUR[2]} - $XF" | bc -l)
o4=$(echo "$o3 + ${DUR[3]} - $XF" | bc -l)
TOTAL=$(echo "$o4 + ${DUR[4]}" | bc -l)
FO=$(echo "$TOTAL - 1" | bc -l)
N="$OUT/normalized"
ffmpeg -y -loglevel error -i $N/scene_01.mp4 -i $N/scene_02.mp4 -i $N/scene_03.mp4 -i $N/scene_04.mp4 -i $N/scene_05.mp4 \
  -filter_complex "[0][1]xfade=transition=fade:duration=$XF:offset=$o1[a];[a][2]xfade=transition=fade:duration=$XF:offset=$o2[b];[b][3]xfade=transition=fade:duration=$XF:offset=$o3[c];[c][4]xfade=transition=fade:duration=$XF:offset=$o4,fade=t=out:st=$FO:d=1,format=yuv420p[v]" \
  -map "[v]" -c:v libx264 -crf 22 -preset medium -movflags +faststart "$OUT/sibel_film_notext.mp4"

# 3) Mesajı bindir ve müziği ekle
TS=$(echo "$o4 + $TEXT_DELAY" | bc -l)
if [ -n "$MUSIC" ] && [ -f "$MUSIC" ]; then
  AUDIO=(-stream_loop -1 -i "$MUSIC")
  AF="afade=t=in:d=1,afade=t=out:st=$(echo "$TOTAL - 2" | bc -l):d=2"
else
  echo "Müzik bulunamadı (music/ boş): film sessiz üretiliyor."
  AUDIO=(-f lavfi -i anullsrc=r=44100:cl=stereo)
  AF="anull"
fi
ffmpeg -y -loglevel error -i "$OUT/sibel_film_notext.mp4" -loop 1 -i "$TEXT" "${AUDIO[@]}" \
  -filter_complex "[1:v]format=rgba,fade=t=in:st=$TS:d=1.2:alpha=1,fade=t=out:st=$FO:d=1:alpha=1[t];[0:v][t]overlay=0:0:enable='gte(t,$TS)',format=yuv420p[v];[2:a]$AF[a]" \
  -map "[v]" -map "[a]" -t "$TOTAL" -c:v libx264 -crf 22 -preset medium -c:a aac -b:a 192k -movflags +faststart "$OUT/sibel_film_final.mp4"

echo "Hazır:"
echo "  $OUT/sibel_film_final.mp4    (mesaj + müzik, doğrudan gönderilebilir)"
echo "  $OUT/sibel_film_notext.mp4   (yazısız, CapCut için)"
echo "  $OUT/normalized/             (tek tek sahneler, CapCut için)"
