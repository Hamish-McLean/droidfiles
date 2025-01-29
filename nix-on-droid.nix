{
  pkgs,
  ...
}:
{
  imports = [
    #../../modules/catppuccin.nix
  ];

  environment.packages = with pkgs; [
    # fish
    # gh
    # git
    curl
    nano
    nh
  ]; # add nerdfonts here

  #cat-colours.enable = true;

  terminal = {
    font = ~/.local/state/nix/profiles/home-manager/home-path/share/fonts/truetype/NerdFonts/JetBrainsMonoNerdFont-Regular.ttf;
    colors = {
      background = "#1e1e2e";
      foreground = "#cdd6f4"; # Main text colour
      cursor = "#cdd6f4";
    };
  };

  android-integration = {
    termux-open.enable = true;
    termux-open-url.enable = true;
    termux-reload-settings.enable = true;
    termux-setup-storage.enable = true;
  }; # There are a few more integrations

  # user.shell = pkgs.fish;

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  system.stateVersion = "24.05";
}
