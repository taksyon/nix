{
  description = "top level nix flake";

  # inputs is an attribute set
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    qylock = {
      url = "github:Darkkal44/qylock";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # For Star Citizen
    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-citizen = {
      url = "github:LovingMelody/nix-citizen";
      inputs.nix-gaming.follows = "nix-gaming";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;

      hmModule =
        { host, ... }:
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";

          home-manager.extraSpecialArgs = {
            inherit host inputs;
          };
          home-manager.users.dylan = import ./30-home/dylan/default.nix;
        };

      mkHost =
        hostName: hostPath:
        lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit inputs;
            host = hostName;
          };

          modules = [
            hostPath
            home-manager.nixosModules.home-manager
            hmModule
            inputs.qylock.nixosModules.default
          ];
        };
    in
    {
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-tree;

      nixosConfigurations = {
        yoga9intel = mkHost "yoga9intel" ./40-hosts/yoga9intel/default.nix;
        vengeance = mkHost "vengeance" ./40-hosts/corsair-vengeance/default.nix;
      };
    };
}
