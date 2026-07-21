{local, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = local.hostName;

  # ⇩ Timezone comes from local.nix; locale/keyboard layout below.
  time.timeZone = local.timeZone;
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.xkb = {
    layout = "pl";
    variant = "";
    # options = "grp:alt_shift_toggle"; # Alt+Shift switches US <-> Russian
  };
  console.keyMap = "pl2";
  
  # EDIT ME: edit external filesystems to match your system (if any)
  fileSystems."/mnt/sda1" = {
    device = "/dev/sda1";
    fsType = "btrfs";
    options = [ "ssd" "noatime" "nofail" ];
  };
  fileSystems."/mnt/sdb1" = {
    device = "/dev/sdb1";
    fsType = "btrfs";
    options = [ "ssd" "noatime" "nofail" ];
  };

  # The release this config was written against. Do NOT bump casually after
  # first install — read the NixOS release notes first.
  system.stateVersion = "25.05";
}
