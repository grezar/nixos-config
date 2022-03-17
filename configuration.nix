{ config, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = true;
  services.openssh.permitRootLogin = "no";

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

  # Enable docker
  virtualisation.docker.enable = true;

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = ["JetBrainsMono"]; })
  ];

  services.spice-vdagentd.enable = true;

  services.xserver = {
    enable = true;
    dpi = 140;
    desktopManager.xterm.enable = false;
    resolutions = [{ x = 1920; y = 1080; }];
    displayManager = {
      lightdm.enable = true;
      autoLogin.enable = true;
      autoLogin.user = "grezar";
      # Use a fake session. The actual session is managed by Home Manager.
      # https://discourse.nixos.org/t/opening-i3-from-home-manager-automatically/4849/11
      defaultSession = "none+fake";
      session = [
        {
          manage = "window";
          name = "fake";
          start = "";
        }
      ];
    };
  };

  services.globalprotect = {
    enable = true;
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
    delta
    bind
    globalprotect-openconnect
  ];
}
