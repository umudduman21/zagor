# Sahne 5: Final

| | |
|---|---|
| Süre | 8 sn + 2 sn son kare dondurma (mesajı okumak için) |
| Kamera | Arkadan geniş plan, çok yavaş geri çekilme (pull-back) ve hafif yükselme |
| Karakter | Yan yana, gün batımına bakıyorlar |
| Referans | `keyframes/umut_sheet.png`, `keyframes/sibel_sheet.png` |
| Çıktı | `keyframes/scene_05.png`, `clips/scene_05.mp4` |

Süreklilik notu: Sahne 1-4 gece, bu sahne gün batımı. Bu bir zaman atlaması
("ertesi akşam") olarak okunuyor; geçiş çapraz çözülme (dissolve) ile yapılıyor.

Kompozisyon notu: Karakterler karenin ALT yarısında dursun. Üst yarı boş
gökyüzü kalmalı, çünkü mesaj oraya yazılacak.

## Image prompt

```
[STYLE bloğu]
[CHARACTER A — UMUT bloğu]
[CHARACTER B — SIBEL bloğu]

Golden hour sunset over the water with a suspension bridge silhouette on the
horizon. UMUT and SIBEL seen from behind in a wide shot, standing side by side
on a hillside garden in the lower third of the frame, his arm around her
shoulders, her head resting lightly on his shoulder, the red rose in her hand.
The upper two thirds of the frame is open sky with soft orange and pink clouds
and plenty of empty space. Warm backlight, long soft shadows, a few petals
floating. No text.
```

## Image-to-video prompt

```
Very slow camera pull-back and gentle rise. The couple stand still watching the
sunset, SIBEL leans her head a little closer, their hair and clothes move
slightly in a light breeze. The sun sinks slowly, clouds drift, a few rose petals
float past. Peaceful, quiet ending. No text.
```

## Ekrandaki mesaj (AI üretmeyecek, sonradan eklenecek)

> Sibel'im, bazen seni üzebiliyorum ama kalbimdeki yerin hiç değişmiyor.
> Seni kırdığım için özür dilerim gülümm. İyi ki hayatımdasın.
> Seni çok seviyorum. ❤️

`pipeline/final_text.png` olarak hazır. `build.sh` bunu sahne 5'in üstüne
yumuşak bir geçişle bindiriyor.
