{
  description = "top level nix flake";

  # inputs is an attribute set
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    iio-hyprland.url = "github:JeanSchoeller/iio-hyprland";

    hyprgrass = {
      url = "github:horriblename/hyprgrass";
      inputs.hyprland.follows = "hyprland";
    };

    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # For Star Citizen
    nix-citizen.url = "github:LovingMelody/nix-citizen";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-citizen.inputs.nix-gaming.follows = "nix-gaming";
  };

  /**
    
   */
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

          home-manager.users.dylan = import ./30-home/30.1-dylan/default.nix;

          home-manager.extraSpecialArgs = {
            inherit host inputs;
            inherit (inputs) caelestia-shell iio-hyprland;
          };
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
          ];
        };
    in
    {
      nixosConfigurations = {
        yoga7amd = mkHost "yoga7amd" ./40-hosts/40.2-yoga7amd/default.nix;
        yoga9intel = mkHost "yoga9intel" ./40-hosts/40.3-yoga9intel/default.nix;
        asusG16 = mkHost "asusG16" ./40-hosts/40.5-asusG16/default.nix;
        vengeance = mkHost "vengeance" ./40-hosts/40.6-corsair-vengeance/default.nix;
      };
    };
}
