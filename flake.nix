{
  description = "who needs a description anyway";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = import nixpkgs {
        inherit system;
      };
    in {
    nixosConfigurations = {
      g = nixpkgs.lib.nixosSystem {
        modules = [./configuration.nix];
      };
      specialArgs = { inherit inputs; };
    };
    homeConfigurations.g = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./home-manager/home.nix ];
      extraSpecialArgs = { inherit inputs; };
    };
  };
}
