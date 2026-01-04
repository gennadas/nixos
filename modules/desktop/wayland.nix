{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    foot
    swaylock
    swayidle
    wl-clipboard
    mako
    grim
  ];

  environment.sessionVariables = {
    GTK_THEME = "Adwaita:dark";
    QT_QPA_PLATFORMTHEME = "qt6ct";
  };
}
