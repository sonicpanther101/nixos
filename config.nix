{ config, lib, pkgs, modulesPath, options, ... }:

{

    environment.systemPackages = with pkgs; [
            pkgs.neofetch
            pkgs.git
            pkgs.wget
            pkgs.usbutils
            pkgs.alejandra
        ];

    services.flatpak.enable = true;

}
