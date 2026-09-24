{ pkgs, lib, config, ... }:

let
  # X11/xcb runtime libraries needed by PyQt5's bundled Qt5 and by `xcffib`.
  # (top-level names, the `xorg.*` set is deprecated in current nixpkgs)
  xcbLibs = with pkgs; [
    libxcb
    libx11
    libxext
    libxrender
    libxfixes
    libxdamage
    libxrandr
    libxcomposite
    libxi
    libxtst
    libxcursor
    libxkbfile
    libxcb-util
    libxcb-image
    libxcb-keysyms
    libxcb-render-util
    libxcb-wm
  ];

  # GStreamer is the multimedia backend used by Qt5's QtMultimedia on Linux.
  # It is required for audio/MV playback and cannot be installed by uv/pip.
  gstLibs = with pkgs.gst_all_1; [
    gstreamer
    gst-plugins-base
    gst-plugins-good
    gst-plugins-bad
    gst-plugins-ugly
    gst-libav
  ];

  qtRuntimeLibs = with pkgs; [
    libxkbcommon
    libGL
    fontconfig
    freetype
    zlib
    dbus
    openssl
    # QtMultimedia audio backends (pulseaudio + alsa)
    pulseaudio
    alsa-lib
    # glib (required by QtMultimedia / libpulse)
    glib
    # gssapi/krb5 (transitive dep of gst-libav/ffmpeg, split lib output)
    libkrb5
  ];
in
{
  languages.python = {
    enable = true;
    package = pkgs.python311;
    venv.enable = true;
    uv = {
      enable = true;
      sync.enable = true;
    };
  };

  packages = xcbLibs ++ gstLibs ++ qtRuntimeLibs ++ (with pkgs; [
    hicolor-icon-theme
    adwaita-icon-theme
  ]);

  env = {
    # Force the xcb Qt platform plugin (the wheel ships its own plugins).
    QT_QPA_PLATFORM = "xcb";
    QT_ENABLE_HIGHDPI_SCALING = "0";
  };

  enterShell = ''
    export LD_LIBRARY_PATH="${lib.makeLibraryPath (xcbLibs ++ gstLibs ++ qtRuntimeLibs)}:$LD_LIBRARY_PATH"
    export GST_PLUGIN_SYSTEM_PATH_1_0="${lib.getOutput "out" pkgs.gst_all_1.gstreamer}/lib/gstreamer-1.0:${lib.makeSearchPath "lib/gstreamer-1.0" (with pkgs.gst_all_1; [
      gst-plugins-base
      gst-plugins-good
      gst-plugins-bad
      gst-plugins-ugly
      gst-libav
    ])}"
    echo "Groove Music environment ready. Run 'run-app' (or 'cd app && python Groove.py')."
  '';

  scripts.run-app.exec = ''
    cd "$DEVENV_ROOT/app"
    exec python Groove.py
  '';
}
