{ config, pkgs, ... }:

{
  # We require 5.14+ for VMware Fusion on M1.
  boot.kernelPackages = pkgs.linuxPackages_5_15;

  # We expect to run the VM on hidpi machines.
  hardware.video.hidpi.enable = true;

  services.xserver = {
    enable = true;
    dpi = 220;
    windowManager.awesome.enable = true;
    desktopManager.xterm.enable = false;
    resolutions = [{ x = 2880; y = 1800; }];
    displayManager = {
      defaultSession = "none+awesome";
      lightdm.enable = true;
      autoLogin.enable = true;
      autoLogin.user = "grezar";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.grezar = {
    isNormalUser = true;
    home = "/home/grezar";
    description = "grezar";
    shell = pkgs.zsh;
    extraGroups = ["wheel"];
  };
}
