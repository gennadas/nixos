{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, ... }: {
    nixosConfigurations = {
      surface = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { 
          inherit nixpkgs-stable;
          inherit (self) inputs;
        };
        modules = [
          ./hardware-configuration.nix
          ./configuration.nix
          ./modules/hardware/surface.nix
          ./modules/desktop/hyprland.nix
          ./modules/desktop/wayland.nix
          ./modules/services/virtualization.nix
          ./modules/services/audio.nix
          ./modules/services/zapret.nix
          ./modules/users/g.nix
          
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              users.g = import ./home.nix;
            };
          }
        ];
      };
    };
  };
}
