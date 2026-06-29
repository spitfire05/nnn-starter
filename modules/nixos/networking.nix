{...}: {
  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [];
    allowedUDPPorts = [];
  };

  # Faster name resolution / mDNS for `.local` hosts.
  services.resolved.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };
}
