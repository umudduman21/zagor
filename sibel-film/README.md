# Sibel: Bizim Hikâyemiz (3D animasyon kısa film)

Dikey 9:16, 1080x1920, 28 saniyelik romantik kısa film. 5 sahne, sonunda Türkçe mesaj.

## Durum

| Adım | Durum |
|---|---|
| Proje yapısı, karakter tanımları, sahne promptları | Hazır |
| Çekim listesi, süreler, kamera hareketleri | Hazır (`shotlist.md`) |
| Birleştirme hattı (FFmpeg) ve final mesaj görseli | Hazır, sahte kliplerle test edildi |
| Referans fotoğraflar | 8 çift fotoğrafı var, tek kişilik yüz fotoğrafları eksik |
| Karakter sayfaları, sahne kareleri, video klipler | ÜRETİLMEDİ |

Önemli: Bu depoda gerçek AI görsel ya da video üretimi yapılmadı. Bu ortamda
görsel/video üreten bir servise erişim yok. Üretimi aşağıdaki araçlardan biriyle
senin yapman gerekiyor; promptlar ve birleştirme hattı bunun için hazır.

## Klasörler

```
references/   Gerçek fotoğraflar (depoya girmez)
prompts/      00_master, 01_character_sheets, scene_01..05
keyframes/    Üretilen karakter sayfaları ve sahne başlangıç kareleri
clips/        Üretilen video klipler: scene_01.mp4 ... scene_05.mp4
music/        Müzik dosyası (mp3, m4a ya da wav)
pipeline/     build.sh ve final mesaj görseli
output/       Bitmiş film
```

## İş akışı

1. Fotoğrafları tamamla: `references/README.md`.
2. Karakter sayfalarını üret: `prompts/01_character_sheets.md`.
   Çıktılar `keyframes/umut_sheet.png` ve `keyframes/sibel_sheet.png`.
3. Her sahne için başlangıç karesini üret (sahne dosyasındaki "Image prompt").
   İki karakter sayfasını referans görsel olarak ekle. En boy oranı 9:16.
4. Her kareyi videoya çevir (sahne dosyasındaki "Image-to-video prompt").
   Klipleri `clips/scene_0N.mp4` adıyla kaydet.
5. `music/` klasörüne bir müzik dosyası koy.
6. `bash pipeline/build.sh` çalıştır.
7. İstersen `output/` içindeki yazısız sürümü CapCut'ta düzenle.

## Hangi araçlar

İki tür araç gerekiyor. Aynı kategoriden birini seçmen yeterli.

Görsel üretimi (fotoğraftan stilize karakter, referanslı sahne karesi):

- Google Gemini uygulamasındaki görsel üretimi: referans fotoğrafla yüz koruma konusunda güçlü.
- ChatGPT görsel üretimi: fotoğraf yükleyip aynı kişiyi stilize etmek kolay.
- Midjourney: karakter referansı özelliği var, en "film karesi" görünümünü verir, öğrenmesi biraz daha zor.

Görselden videoya (image-to-video):

- Kling: karakter tutarlılığı ve doğal hareket için iyi, başlangıç karesi veriliyor.
- Runway: kamera hareketi kontrolü iyi.
- Google Veo (Gemini ya da Flow içinden): görüntü kalitesi yüksek.
- Luma Dream Machine, Hailuo: daha ucuz alternatifler.

Önerim: görsel için Gemini ya da ChatGPT, video için Kling. Sebep: yüz tutarlılığı
bu filmin en kritik şartı ve "önce kare, sonra kareden video" yöntemi doğrudan
metinden video üretmekten çok daha tutarlı sonuç veriyor.

## Maliyet

Güncel fiyatları doğrulayamadım; satın almadan önce aracın fiyat sayfasına bak.
Planlama için gereken üretim miktarı:

| Kalem | Adet | Not |
|---|---|---|
| Karakter sayfası | 2 final, yaklaşık 6-10 deneme | Benzerlik tutana kadar |
| Sahne karesi | 5 final, yaklaşık 10-15 deneme | Sahne başına 2-3 deneme |
| Video klip | 5 final, yaklaşık 10-15 deneme | Her biri 5-10 sn, 1080p |

- Görsel üretimi çoğu araçta ücretsiz kotayla ya da mevcut aboneliğinle karşılanabilir.
- Video üretimi genelde ücretli: araçların çoğu aylık kredi paketi satıyor.
  Bu film için tek bir aracın en düşük ücretli paketi büyük olasılıkla yeterli.
- Bazı araçlar ücretsiz deneme kredisi veriyor ama filigranlı ve düşük çözünürlüklü olabiliyor.
- Müzik: CapCut'un içindeki ücretsiz müzik kütüphanesi yeterli.

Şu ana kadar hiçbir ücretli işlem yapılmadı.

## CapCut

`build.sh` üç çıktı üretir:

- `output/sibel_film_final.mp4`: mesaj ve müzik eklenmiş, doğrudan gönderilebilir.
- `output/sibel_film_notext.mp4`: yazısız ve sessiz. CapCut'a at, kendi yazını ve müziğini ekle.
- `output/normalized/scene_0N.mp4`: aynı boyut ve kare hızına getirilmiş tek tek sahneler.

CapCut'ta proje oranını 9:16, dışa aktarmayı 1080p 30 fps seç.

## Bilinen riskler

- Yüz kayması: video araçları 5 saniyenin sonuna doğru yüzü değiştirebilir.
  Klibi kısa tut ve kayan klibi yeniden üret; `build.sh` kısa klibi süreye tamamlar.
- Eller: el ele tutuşma (sahne 4) en çok bozulan yer. Gerekirse bel üstü yerine omuz üstü kadraj kullan.
- Türkçe yazı: AI'a yazdırma, harfleri bozuyor. Yazı sonradan ekleniyor.
