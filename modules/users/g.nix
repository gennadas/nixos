{ config, lib, pkgs, pkgs-stable, ... }:

{
  users.users.g = {
    isNormalUser = true;
    description = "g";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    initialPassword = "j";
  };
  
}
