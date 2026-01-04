{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs-unstable = nixpkgs.legacyPackages.${system};
      pkgs-stable = nixpkgs-stable.legacyPackages.${system};
    in {
      nixosConfigurations = {
        surface = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { 
            inherit pkgs-stable;
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
            
            # Add module to inject pkgs-stable into module args
            ({ pkgs, ... }: {
              _module.args.pkgs-stable = pkgs-stable;
            })
            
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                extraSpecialArgs = { inherit pkgs-stable; };
                users.g = import ./home.nix;
              };
            }
          ];
        };
      };
    };
}
