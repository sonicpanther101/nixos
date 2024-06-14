{
  config,
  lib,
  pkgs,
  modulesPath,
  options,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    neofetch
    git
    wget
    usbutils
    alejandra
    spotify
    prismlauncher
    jre8
    mangohud
    bottles
    #hyprland
  ];

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  services.xserver.enable = false;
  services.displayManager.sddm.wayland.enable = true;

  # Enable the GNOME Desktop Environment.
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;
  #services.xserver.desktopManager.default = "gnome";

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.flatpak.enable = true;
}
