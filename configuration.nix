{ config, lib, pkgs, pkgs-stable, ... }:

{
  imports = [
    # Hardware modules will be included via flake.nix
  ];
  time.timeZone = "Etc/GMT-2";
  networking.hostName = "surface";
  networking.networkmanager.enable = true;
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  i18n.defaultLocale = "C.UTF-8";

  environment.systemPackages = with pkgs; [
    vim
    git
    curl
    wget
    foot
    tree
    bat
    fzf
    alacritty
    kitty
    zapret
    wireguard-go
    wireguard-tools
  ];
  programs.steam.enable = true;

  # Security
  security.polkit.enable = true;
  security.rtkit.enable = true;
  
  # Nix settings
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  system.stateVersion = "24.11";
}
