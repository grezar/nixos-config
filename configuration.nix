{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    windowManager.awesome.enable = true;
    displayManager.defaultSession = "none+awesome";
    desktopManager.xterm.enable = false;
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
