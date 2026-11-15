# Todo Convert

Todo Convert, Todo Pictures için macOS'ta çalışan bir dosya dönüştürme ve düzenleme uygulamasıdır. Finder'dan dosya sürüklerken bir tuşa basınca açılan **çark** menüsüyle görselleri, PDF'leri, Office belgelerini, ses ve videoları dönüştürür, kırpar ve düzenler.

> Todo Convert, açık kaynaklı [Nashi](https://github.com/orkunisitmak/nashi-app) uygulamasının (MIT lisansı, © Orkun Işıtmak ve Nashi katkıcıları) bir fork'udur. Orijinal lisans metni [LICENSE](LICENSE) dosyasında korunmaktadır.

## Özellikler

- 27 araç, 46 girdi formatı, 276 dönüşüm yolu
- Finder'da sürüklerken **Shift** dönüştürme, **Command** araçlar, **Control** dosya işlemleri çarkını açar
- Görsel kırpma ve üzerine not alma, video kesme (In/Out), PDF sayfa düzenleme
- Web'den medya indirme (**Control–Shift–D**), QR okuma
- Bütün işlemler bilgisayarda yapılır. Analytics veya bulut hesabı yoktur.

## Kısayollar

Medya editörlerinde **Space** oynat/duraklat, **←/→** bir saniye ileri/geri, **I/O** aralık başı/sonu. Crop'ta sürükleyerek seç, **Shift** oranı kilitler, **Enter** kaydeder.

## Derleme (Apple Silicon, macOS 13+)

Gerekenler: Xcode (veya Xcode Command Line Tools) ve Swift 6.

```sh
scripts/setup-exiftool.sh          # ExifTool'u indirir (bir kere)
scripts/build-app.sh release       # build/TodoConvert.app oluşturur
open build/TodoConvert.app
```

İlk açılışta **Kurulumu tamamla → Eksik araçları indir** ile ffmpeg ve LibreOffice indirilir. Bu araçları uygulamanın içine gömmek istersen `scripts/setup-tools.sh` ve `scripts/setup-web-download-tools.py` çalıştırıp `TODOCONVERT_BUNDLE_TOOLS=1 scripts/build-app.sh release` kullan.

Uygulama ad-hoc imzalanır. macOS ilk açılışta uyarı verirse: Finder'da uygulamaya sağ tıkla → **Aç**.

Testler: `swift test`

## Marka

- Logo `Sources/TodoConvertApp/TodoConvertArtwork.swift` içinde kodla çizilir. Renkleri değiştirmek için dosyanın başındaki `tileTop`, `tileBottom` ve `accent` değerlerini düzenle.
- Hazır görseller: `Resources/Brand/` ve `Resources/TodoConvertIcon.icns`
- Bundle ID: `com.todopictures.todoconvert`

## Güncellemeler

Otomatik güncelleme şimdilik **kapalı**. Kendi GitHub Releases kanalını açmak için bir Sparkle imza anahtarı oluşturulup `Configuration/Updates.plist` eklenmesi gerekiyor.

## Lisans

[MIT](LICENSE). Üçüncü taraf bileşenler kendi lisanslarıyla gelir: [Resources/THIRD-PARTY-NOTICES.txt](Resources/THIRD-PARTY-NOTICES.txt).
