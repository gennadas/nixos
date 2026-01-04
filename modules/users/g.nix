{ config, lib, pkgs, pkgs-stable, ... }:

{
  users.users.g = {
    isNormalUser = true;
    description = "g";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    initialPassword = "j";
  };
  
  environment.systemPackages = with pkgs; [
    pkgs-stable.webcord
    pkgs-stable.webcord-vencord
    pkgs-stable.vesktop
    vim
    git
    curl
    wget
    foot
    swaylock
    swayidle
    wl-clipboard
    mako
    alacritty
    kitty
    zapret
    wireguard-go
    wireguard-tools
    v4l-utils
  ];
}
