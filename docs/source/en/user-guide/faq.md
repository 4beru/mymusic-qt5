# Frequently asked questions

## Why does dragging the window stutter on Windows?

The acrylic window effect may reduce responsiveness on some Windows 10 versions. Install supported system updates, disable **Show window contents while dragging** in the advanced system performance settings, or disable acrylic in MyMusic's settings.

## Why does GStreamer report "No decoder available for type ..."?

A decoder plugin may be missing. On Ubuntu and similar Debian-based systems, one possible fix is:

```bash
sudo apt-get install gstreamer1.0-libav
```

On other distributions, install the equivalent plugin package. In the Nix development shell the project already provides GStreamer plugins, including libav.

## Which lyric files are supported?

LRC and JSON. See [Lyric file formats](lyrics-format.md) for syntax and examples.
