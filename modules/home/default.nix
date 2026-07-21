{config, username, ...}: {
  imports = [
    ./cli.nix
    ./fish.nix
    ./starship.nix
    ./git.nix
    ./ghostty.nix
    ./zed.nix
    ./gtk.nix
    ./niri.nix
    ./noctalia.nix
    ./direnv.nix
    ./claude-code.nix
    ./apps.nix
    ./media.nix
    ./discord.nix
    ./helix.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  # Match system.stateVersion in hosts/nnn/default.nix. Don't bump casually.
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  # Custom symlink to external drive, for convinience:
  home.file = {
    dev.source = config.lib.file.mkOutOfStoreSymlink "/mnt/sda1";
  };
}
