{ config, lib, pkgs, pkgs-stable, ... }:

{
  imports = [
    # Hardware modules will be included via flake.nix
  ];

  networking.hostName = "surface";
  networking.networkmanager.enable = true;
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  i18n.defaultLocale = "C.UTF-8";

  # Security
  security.polkit.enable = true;
  security.rtkit.enable = true;
  
  # Nix settings
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  system.stateVersion = "25.11";
}
