{
  pkgs,
  username,
  ...
}:
{
  # ⇩ EDIT ME: the username comes from `username` in flake.nix. Change it there.
  users.users.${username} = {
    isNormalUser = true;
    description = "NNN";
    extraGroups = [
      "wheel" # sudo
      "networkmanager"
      "video"
      "audio"
      "input"
    ];
    shell = pkgs.zsh;
  };

  # zsh must be enabled at the system level to be a valid login shell.
  programs.zsh.enable = true;

  # Passwordless sudo for the wheel group keeps `nixos-rebuild` snappy. Drop the
  # `wheelNeedsPassword = false` line if you'd rather be prompted.
  security.sudo.wheelNeedsPassword = false;
}
