# mpv yapılandırması

Windows'taki mpv ayarlarım: uosc arayüzü (YouTube tarzı), thumbfast önizleme, pil profili ve YouTube'u indirmeden oynatma.

## Gereken programlar

- mpv: `winget install shinchiro.mpv`
- yt-dlp: `scoop install yt-dlp`
- Node.js (yt-dlp YouTube için kullanıyor): `winget install OpenJS.NodeJS.LTS`

## Geri yükleme

```powershell
git clone git@github.com:r0madeus/mpv_config.git "$env:APPDATA\mpv"
```

Klasör zaten varsa önce yedeğini al ya da sil.

## İçerik

- `mpv.conf`: genel ayarlar ve `[pil]` profili
- `input.conf`: uosc menüsü, Ctrl+V ile panodan açma, ğ/ü ile hız
- `scripts/pil-profili.lua`: fişte mi pilde mi olduğunu izleyip `[pil]` profilini açıp kapatır
- `scripts/uosc`, `script-opts/uosc.conf`, `fonts/`: uosc ve ayarları, Roboto fontu
- `scripts/thumbfast.lua`, `script-opts/thumbfast.conf`: ilerleme çubuğu önizlemesi

uosc, menüdeki Araçlar > uosc güncelle ile güncellenir. Güncellemeden sonra `git diff` ile `uosc.conf`'un korunduğunu kontrol et.
