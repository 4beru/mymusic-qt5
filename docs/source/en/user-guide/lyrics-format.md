# Lyric file formats

MyMusic supports time-synchronized lyrics in LRC (`.lrc`) and JSON (`.json`) files. The following examples use original placeholder text rather than commercial song lyrics.

## LRC

A lyric line begins with a timestamp in the form `[mm:ss.xx]`, where `mm` is minutes, `ss` is seconds and `xx` is hundredths of a second. Metadata tags are optional. A second line with the same timestamp can provide a translation.

```text
[ti:Timing Demo]
[ar:Example Artist]
[au:Example Author]
[al:Example Album]

[00:12.00]First example line
[00:15.30]Second example line
[00:15.30]第二行示例
[01:02.30]Third example line
```

See the [LRC format overview](https://en.wikipedia.org/wiki/LRC_(file_format)) for general background.

## JSON

Each object key is a timestamp in seconds, represented as a string. Its value is an array containing the original line, optionally followed by a translation.

```json
{
  "1.86": ["Timing Demo"],
  "3.70": ["Example Artist"],
  "28.22": ["First example line", "第一行示例"],
  "34.36": ["Second example line", "第二行示例"]
}
```

Use valid JSON syntax: double quotes and no trailing comma after the final entry.
