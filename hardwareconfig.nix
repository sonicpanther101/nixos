{
  config,
  lib,
  pkgs,
  modulesPath,
  options,
  ...
}: {

    #------------------------------------------------------------
    # [4070]

# normal setup (flickers on vivaldi and minecraft)
  #hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
#  hardware.opengl = {
#    enable = true;
#    driSupport = true;
#    driSupport32Bit = true;
#  };
#  services.xserver.videoDrivers = ["nvidia"];
#  hardware.nvidia = {
#    modesetting.enable = true;
#    nvidiaSettings = true;
#  };


# Nouveau setup hopefully no flickering
# Ensure the Nouveau module is loaded
  boot.kernelModules = [ "nouveau" ];

  # Blacklist the proprietary NVIDIA driver, if needed
  boot.blacklistedKernelModules = [ "nvidia" "nvidia_uvm" "nvidia_drm" "nvidia_modeset" ];

  # Configure Xorg to use the Nouveau driver
  services.xserver = {
    enable = true;
    videoDrivers = [ "nouveau" ];

    # Optional: Configure display settings, if necessary
    # displayManager = {
    #   ...
    # };
    # desktopManager = {
    #   ...
    # };
  };

  # Enable hardware acceleration for Nouveau
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      # Add packages needed for Nouveau acceleration here
      # For example, Mesa for OpenGL:
      mesa
      mesa.drivers
    ];
  };


    #------------------------------------------------------------
    # [B550]

  systemd.services.bugfixSuspend-GPP0 = {
    enable            = lib.mkDefault true;
    description       = "Fix crash on wakeup from suspend/hibernate (b550 bugfix)";
    unitConfig = {
      Type            = "oneshot";
    };
    serviceConfig = {
      User            = "root"; # root may not be necessary
      # check for gppN, disable if enabled
      # lifted from  https://www.reddit.com/r/gigabyte/comments/p5ewjn/comment/ksbm0mb/ /u/Demotay
      ExecStart       = "-${pkgs.bash}/bin/bash -c 'if grep 'GPP0' /proc/acpi/wakeup | grep -q 'enabled'; then echo 'GPP0' > /proc/acpi/wakeup; fi'";
      RemainAfterExit = "yes";  # required to not toggle when `nixos-rebuild switch` is ran

    };
    wantedBy = ["multi-user.target"];
  };

  systemd.services.bugfixSuspend-GPP8 = {
    enable            = lib.mkDefault true;
    description       = "Fix crash on wakeup from suspend/hibernate (b550 bugfix)";
    unitConfig = {
      Type            = "oneshot";
    };
    serviceConfig = {
      User            = "root";
      ExecStart       = "-${pkgs.bash}/bin/bash -c 'if grep 'GPP8' /proc/acpi/wakeup | grep -q 'enabled'; then echo 'GPP8' > /proc/acpi/wakeup; fi''";
      RemainAfterExit = "yes";
    };
    wantedBy = ["multi-user.target"];
  };
}
