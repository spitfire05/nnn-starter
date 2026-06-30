{...}: {
  # Zed — the GUI code editor. Neovim stays the terminal `$EDITOR`
  # (see modules/home/neovim.nix); Zed is what opens when you double-click a
  # text file in Nautilus or pick "open with default" from anywhere else.
  #
  # Theming is automatic: Stylix has a zed target (enabled by stylix.enable in
  # modules/nixos/stylix.nix) that, once programs.zed-editor is on, writes a
  # Base16 Kanagawa theme + our Maple Mono / Noto fonts into userSettings, so
  # Zed tracks the same palette as everything else — no theme config needed here.
  programs.zed-editor = {
    enable = true;

    userSettings = {
      # Nix owns the package; don't let Zed try to update itself.
      auto_update = false;

      # No phone-home.
      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      # Pick up per-project toolchains from the direnv shells managed in
      # modules/home/direnv.nix.
      load_direnv = "shell_hook";
    };
  };

  # Make Zed the default GUI handler for plain-text and source files. The
  # zen-browser module (modules/home/apps.nix) also claims text/plain, but only
  # with lib.mkDefault, so these plain assignments win. We deliberately leave
  # text/html and application/json to Zen.
  xdg.mimeApps = {
    enable = true;
    defaultApplications = let
      zed = "dev.zed.Zed.desktop";
    in {
      "text/plain" = zed;
      "text/markdown" = zed;
      "text/x-readme" = zed;
      "text/x-python" = zed;
      "text/x-shellscript" = zed;
      "text/x-csrc" = zed;
      "text/x-chdr" = zed;
      "text/rust" = zed;
      "application/x-shellscript" = zed;
      "application/toml" = zed;
      "application/x-yaml" = zed;
      "application/xml" = zed;
    };
  };
}
