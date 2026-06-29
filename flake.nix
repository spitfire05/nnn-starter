{
  description = "nnn-starter — an opinionated NixOS starter for the NNN stack (NixOS + Niri + Noctalia)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Scrollable-tiling Wayland compositor + NixOS/home-manager modules.
    niri.url = "github:sodiboo/niri-flake";

    # Noctalia desktop shell. Pinned to the v5 line: upstream develops v5 on
    # `main` and preserves the old series on the `legacy-v4` branch. Switch the
    # ref to a `v5.x.x` tag once one is published.
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # System-wide base16 theming.
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      niri,
      noctalia,
      stylix,
      ...
    }@inputs:
    let
      # The platform the NNN machine runs on.
      hostSystem = "x86_64-linux";

      # ⇩ EDIT ME: pick your login username.
      username = "nnn";

      # Helper so `nix fmt` / `nix develop` work from macOS or Linux.
      devSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs devSystems;
      pkgsFor = system: nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.nnn = nixpkgs.lib.nixosSystem {
        system = hostSystem;
        specialArgs = { inherit inputs username; };
        modules = [
          niri.nixosModules.niri
          noctalia.nixosModules.default
          stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager

          ./hosts/nnn
          ./modules/nixos

          {
            nixpkgs.config.allowUnfree = true;
            nixpkgs.overlays = [
              niri.overlays.niri
              noctalia.overlays.default
            ];

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-bak";
            home-manager.extraSpecialArgs = { inherit inputs username; };
            # niri-flake auto-imports its home modules (config + stylix) into
            # every user when home-manager runs as a NixOS module, so we only
            # add noctalia's here. Importing the niri ones again double-declares
            # `programs.niri.finalConfig`.
            home-manager.sharedModules = [
              noctalia.homeModules.default
            ];
            home-manager.users.${username} = import ./modules/home;
          }
        ];
      };

      # `nix fmt`
      formatter = forAllSystems (system: (pkgsFor system).alejandra);

      # `nix develop` — tooling for hacking on this repo.
      devShells = forAllSystems (system: {
        default = (pkgsFor system).mkShell {
          packages = with pkgsFor system; [
            alejandra
            statix
            deadnix
            nh
            nix-output-monitor
          ];
        };
      });
    };
}
