{ ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "nnn";

  # ⇩ EDIT ME: set your timezone, locale and console/keyboard layout.
  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  console.keyMap = "us";

  # The release this config was written against. Do NOT bump casually after
  # first install — read the NixOS release notes first.
  system.stateVersion = "25.05";
}
