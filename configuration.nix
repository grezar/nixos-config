{ config, pkgs, ... }:

{
  imports = [
    ./modules/vmware-guest.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = true;
  # FIXME: shouldn't be allowed
  services.openssh.permitRootLogin = "yes";

  # My timezone
  time.timeZone = "Asia/Tokyo";

  # Don't require password for sudo.
  security.sudo.wheelNeedsPassword = false;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Hostname.
  networking.hostName = "dev";

  # Disable the firewall since we're in a VM and we want to make it
  # easy to visit stuff in here. We only use NAT networking anyways.
  networking.firewall.enable = false;

  # We require 5.14+ for VMware Fusion on M1.
  boot.kernelPackages = pkgs.linuxPackages_5_15;

  # We expect to run the VM on hidpi machines.
  hardware.video.hidpi.enable = true;

  # Disable the default module and import our override. We have
  # customizations to make this work on aarch64.
  disabledModules = [ "virtualisation/vmware-guest.nix" ];

  # Enable VMWare guest support
  virtualisation.vmware.guest.enable = true;

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = ["JetBrainsMono"]; })
  ];

  services.xserver = {
    enable = true;
    dpi = 240;
    windowManager.awesome.enable = true;
    desktopManager.xterm.enable = false;
    resolutions = [{ x = 1920; y = 1080; }];
    displayManager = {
      defaultSession = "none+awesome";
      lightdm.enable = true;
      autoLogin.enable = true;
      autoLogin.user = "grezar";
      sessionCommands = ''
        ${pkgs.xlibs.xset}/bin/xset r rate 200 40
        ${pkgs.xorg.xrandr}/bin/xrandr -s '1920x1080'
      '';
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

  environment.systemPackages = with pkgs; [
    xclip
    tree
    ripgrep
    fzf
    gcc
  ];
}
