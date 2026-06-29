{pkgs, ...}: {
  # One palette to rule them all. Stylix derives colors for niri, noctalia,
  # ghostty, bat, btop, neovim, GTK/Qt and more from a single base16 scheme.
  stylix = {
    enable = true;
    polarity = "dark";

    # Kanagawa, vendored in-repo so the build never depends on whatever version
    # of `base16-schemes` happens to be pinned. To use an upstream scheme
    # instead: stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
    base16Scheme = ../../themes/kanagawa.yaml;

    # A subtle Kanagawa-toned gradient wallpaper, generated at build time so we
    # don't have to vendor a binary image. Drop in your own with a path here.
    image = pkgs.runCommand "kanagawa-wallpaper.png" {nativeBuildInputs = [pkgs.imagemagick];} ''
      magick -size 3840x2160 gradient:'#16161D'-'#1F1F28' "$out"
    '';

    # A hint of terminal transparency for that layered desktop look.
    opacity.terminal = 0.95;

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    fonts = {
      monospace = {
        package = pkgs.maple-mono.NF;
        name = "Maple Mono NF";
      };
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        terminal = 12;
        applications = 11;
        desktop = 11;
        popups = 11;
      };
    };
  };
}
