{ pkgs, lib, ... }:

{
  imports = [
    ./home/programs.nix
    ./home/editor.nix
    ./home/themes.nix
  ];

  home = {
    username = "g";
    homeDirectory = "/home/g";
    stateVersion = "24.11";
  };
  
  # Home Manager activation
  programs.home-manager.enable = true;
}
