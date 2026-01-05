{ config, lib, pkgs, ... }:

{
  programs.hyprland.enable = true;
  
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
    config.common.default = "*";
  };

  programs.dconf.profiles.user.databases = [{
    #https://discourse.nixos.org/t/help-setting-some-boring-dark-theme/61891/4
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  }];
  environment.sessionVariables = {
    #https://discourse.nixos.org/t/help-setting-some-boring-dark-theme/61891/4
    GTK_THEME = "Adwaita:dark";
    QT_QPA_PLATFORMTHEME = "qt6ct";
  };
}
