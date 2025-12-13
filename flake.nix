{
  description = "top level nix flake";

  # ============================================================
  #    ▄▖      ▗
  #    ▐ ▛▌▛▌▌▌▜▘▛▘
  #    ▟▖▌▌▙▌▙▌▐▖▄▌
  #        ▌
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
    };

    iio-hyprland = {
      url = "github:JeanSchoeller/iio-hyprland";
    };

    hyprgrass = {
      url = "github:horriblename/hyprgrass";
      inputs.hyprland.follows = "hyprland"; # IMPORTANT
    };

    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # ============================================================
  #    ▄▖  ▗     ▗
  #    ▌▌▌▌▜▘▛▌▌▌▜▘▛▘
  #    ▙▌▙▌▐▖▙▌▙▌▐▖▄▌
  #          ▌

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      caelestia-shell,
      hyprgrass,
      iio-hyprland,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;

      laptopModules = import ./nixos/hosts/laptop/common.nix {
        inherit home-manager;
      };
      yogaModules = import ./nixos/hosts/laptop/len-yoga-7/common.nix;
    in
    {
      nixosConfigurations = {

        # ———————————————————————————————————
        #
        #    ▜     ▗       ▗▘          ▘  ▝▖
        #    ▐ ▀▌▛▌▜▘▛▌▛▌  ▐ ▛▌█▌▛▌█▌▛▘▌▛▘ ▌
        #    ▐▖█▌▙▌▐▖▙▌▙▌  ▐ ▙▌▙▖▌▌▙▖▌ ▌▙▖ ▌
        #        ▌     ▌   ▝▖▄▌           ▗▘

        laptop = lib.nixosSystem {
          inherit system;
          specialArgs = {
            host = "laptop";
          };
          modules = laptopModules;
        };

        # —————————————————————————
        #
        #    ▖▖        ▄▖  ▄▖▖  ▖▄
        #    ▌▌▛▌▛▌▀▌   ▌  ▌▌▛▖▞▌▌▌
        #    ▐ ▙▌▙▌█▌   ▌  ▛▌▌▝ ▌▙▘
        #        ▄▌

        yoga7amd =
          let
            host = "yoga7amd";
          in
          lib.nixosSystem {
            inherit system;

            # 🔑 This makes `inputs` (and/or specific inputs) visible inside all modules
            specialArgs = {
              inherit inputs host;
            };

            modules =
              laptopModules
              ++ yogaModules
              ++ [
                ./nixos/hosts/laptop/len-yoga-7/default.nix
                {
                  # 👇 pass inputs into HM modules
                  home-manager.extraSpecialArgs = {
                    inherit host;
                    inherit (inputs)
                      caelestia-shell
                      hyprgrass
                      iio-hyprland
                      ;
                  };
                }
              ];
          };

        #————————————————————————————
        #
        #    ▖▖        ▄▖  ▄▖  ▗   ▜
        #    ▌▌▛▌▛▌▀▌   ▌  ▐ ▛▌▜▘█▌▐
        #    ▐ ▙▌▙▌█▌   ▌  ▟▖▌▌▐▖▙▖▐▖
        #        ▄▌

        yoga7intel =
          let
            host = "yoga7intel";
          in
          lib.nixosSystem {
            inherit system;

            specialArgs = {
              inherit inputs host;
            };

            modules =
              laptopModules
              ++ yogaModules
              ++ [
                ./nixos/hosts/laptop/len-yoga-7/default.nix
                {
                  # 👇 pass inputs into HM modules
                  home-manager.extraSpecialArgs = {
                    inherit host;
                    inherit (inputs)
                      caelestia-shell
                      hyprgrass
                      iio-hyprland
                      ;
                  };
                }
              ];
          };
        #————————————————————————————
        #    ▄▖          ▗ ▄▖
        #    ▌▌▛▘▌▌▛▘  ▛▌▜ ▙▖
        #    ▛▌▄▌▙▌▄▌  ▙▌▟▖▙▌
        #              ▄▌

        asus_g16 = lib.nixosSystem {
          inherit system;
          specialArgs = {
            host = "g16";
          };

          modules = laptopModules ++ [
            ./nixos/hosts/laptop/asus-g16/default.nix
          ];
        };

        #————————————————————————————
        #    ▄▖        ▄▖▗ ▄▖
        #    ▌▌▛▘▌▌▛▘  ▗▘▜ ▄▌
        #    ▛▌▄▌▙▌▄▌  ▙▖▟▖▄▌
        #

        asus_z13 = lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            host = "z13";
          };

          modules = laptopModules ++ [
            ./nixos/hosts/laptop/asus-z13/default.nix
          ];
        };

        #————————————————————————————
        #    ▄▖        ▘    ▖▖
        #    ▌ ▛▌▛▘▛▘▀▌▌▛▘  ▌▌█▌▛▌▛▌█▌▀▌▛▌▛▘█▌
        #    ▙▖▙▌▌ ▄▌█▌▌▌   ▚▘▙▖▌▌▙▌▙▖█▌▌▌▙▖▙▖
        #                         ▄▌

        vengeance =
          let
            host = "vengeance";
          in
          lib.nixosSystem {
            inherit system;
            specialArgs = {
              inherit inputs host;
            };

            modules = [
              ./nixos/hosts/desktop/corsair-vengeance/default.nix
              {
                # 👇 pass inputs into HM modules
                home-manager.extraSpecialArgs = {
                  inherit host;
                  inherit (inputs)
                    caelestia-shell
                    ;
                };
              }
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.dylan = import ./home/dylan/home.nix;
                home-manager.backupFileExtension = "backup";
              }
            ];
          };
        #————————————————————————————
      };
    };
}
