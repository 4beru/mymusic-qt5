# Supported audio formats

The library filters files by extension. The documented extension list is shown below; successful decoding also depends on the operating system and the installed Qt Multimedia backend.

| Extension | Format |
| --- | --- |
| `.mp3`, `.m4a`, `.mp4` | MPEG media |
| `.tta` | True Audio |
| `.wav` | WAVE audio |
| `.wv` | WavPack |
| `.ac3` | Audio Codec 3 |
| `.opus` | Ogg Opus |
| `.ogg` | Ogg Vorbis |
| `.wma` | Windows Media Audio |
| `.aac` | Advanced Audio Coding |
| `.asf` | Advanced Systems Format |
| `.aiff` | Audio Interchange File Format |
| `.flac` | Free Lossless Audio Codec |
| `.mpc` | Musepack |
| `.ape` | Monkey's Audio |

If a recognized file does not play, check the decoder configuration described in [Getting started](quick-start.md) and the [FAQ](faq.md).
