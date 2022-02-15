{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    windowManager.awesome.enable = true;
    displayManager.defaultSession = "none+awesome";
    desktopManager.xterm.enable = false;
  };
}
