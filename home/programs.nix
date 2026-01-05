{ pkgs, pkgs-stable, lib, ... }:

{
  home.packages = with pkgs; [
    krita
    ffmpeg
    mpvpaper
    neovim
    codeblocks
    obsidian
    brightnessctl
    vscode
    wofi
    swww
    prismlauncher
    fastfetch
    telegram-desktop
    blueman
    gcc
    gdb
    clang-tools
    nemo
    qbittorrent
    vlc
    brave
    ripgrep
    fd
    lazygit
    grim
    slurp
    v4l-utils
    (python3.withPackages (python-pkgs: [
      python-pkgs.pandas
      python-pkgs.numpy
      python-pkgs.matplotlib
    ]))
    lua
    luajitPackages.luarocks
    pkgs-stable.vesktop
    wl-clipboard
    mako
    glib
    waybar
  ];
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi
      obs-gstreamer
      obs-vkcapture
    ];
  };
}
