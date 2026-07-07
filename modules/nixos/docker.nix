{username, ...}: {
  # Docker daemon + CLI (`docker`, `docker compose`).
  virtualisation.docker = {
    enable = true;

    # Reclaim disk from dangling images/containers/volumes weekly, mirroring the
    # Nix store GC in ./default.nix. Without this, stale image layers pile up
    # unbounded until they eat the disk.
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };

  # Let the user drive Docker without sudo. NOTE: membership in the `docker`
  # group is root-equivalent (you can bind-mount `/` into a container as root),
  # so this trades isolation for convenience — the same trade this config
  # already makes with passwordless sudo in ./users.nix. Want real isolation?
  # Drop this line and switch to `virtualisation.docker.rootless` instead.
  users.users.${username}.extraGroups = ["docker"];
}
