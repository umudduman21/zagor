# Master tanımlar

Bu blokları her sahne promptunun başına AYNEN yapıştır. Kelimeleri sahneden sahneye
değiştirme; tutarlılığın yarısı referans görselden, yarısı aynı metinden gelir.

Not: Promptlarda stüdyo adı ("Pixar" gibi) yazma. Birçok araç marka adını engelliyor
ya da görmezden geliyor. Aşağıdaki stil tarifi aynı görünümü veriyor.

## STYLE (her promptta)

```
Stylized 3D animated feature film look, high-end CGI render, appealing slightly
exaggerated proportions (larger eyes, soft rounded features) while keeping each
character's real facial identity, subsurface skin scattering, detailed hair
strands, soft cinematic lighting, shallow depth of field, warm romantic color
grade, vertical 9:16 composition.
```

## CHARACTER A — UMUT (erkek)

```
UMUT: a man in his mid-20s, slim build, light olive skin. Short dark-brown-to-black
hair with a clean low fade on the sides and a longer textured top swept up and to
the side. Thick straight dark eyebrows, dark brown eyes, a thin well-groomed
moustache and a short trimmed beard along the jawline with a small chin patch.
Small tattoos on the left forearm. Wearing a white short-sleeve knit polo with
thin vertical beige stripes, beige trousers, white sneakers, a thin silver chain.
Calm, warm, sincere expression.
```

## CHARACTER B — SIBEL (kadın)

```
SIBEL: a woman in her early-to-mid 20s, light-to-olive skin with soft freckles,
a soft rounded face with full cheeks. Very long straight dark brown hair with a
middle part, falling past her chest. Large dark brown eyes, softly arched dark
eyebrows, natural rosy lips. Wearing a brown fitted one-shoulder top, light blue
high-waisted jeans, small gold hoop earrings and a thin gold necklace with a
script name pendant. Gentle, slightly shy smile.
```

## NEGATIVE (aracın negatif prompt alanı varsa)

```
different person, changed face, changed hairstyle, extra fingers, deformed hands,
extra limbs, text, watermark, logo, subtitles, photorealistic live action,
anime 2D, crying, exaggerated sobbing, kissing, distorted face, morphing
```

## Kurallar

- Ekrandaki Türkçe yazıyı AI'a ÜRETTİRME. Türkçe harfleri (ş, ğ, ı) bozuyor.
  Yazı sonradan `pipeline/build.sh` ile ya da CapCut'ta ekleniyor.
- Her sahnede karakter sayfalarını (`keyframes/umut_sheet.png`,
  `keyframes/sibel_sheet.png`) referans görsel olarak ver.
- Kıyafet tüm sahnelerde aynı kalsın. Değiştirmek istersen burada değiştir,
  sahne dosyalarında değil.
- Ton: samimi ve sade. Ağlama, yalvarma, abartılı jest yok.
