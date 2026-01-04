{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    neovim
    codeblocks
    obsidian
    brightnessctl
    vscode
    rofi
    wofi
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
    fzf
    grim
    (python3.withPackages (python-pkgs: [
      python-pkgs.pandas
      python-pkgs.numpy
      python-pkgs.matplotlib
    ]))
    lua
    luajitPackages.luarocks
    discord
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
