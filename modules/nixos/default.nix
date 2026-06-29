{...}: {
  imports = [
    ./boot.nix
    ./networking.nix
    ./audio.nix
    ./fonts.nix
    ./niri.nix
    ./noctalia.nix
    ./desktop.nix
    ./stylix.nix
    ./users.nix
  ];

  # Flakes + the modern nix CLI.
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # (allowUnfree + overlays are set in flake.nix where the inputs are in scope.)

  # A lean system-wide package set; everything user-facing lives in home-manager.
  environment.systemPackages = [];
}
