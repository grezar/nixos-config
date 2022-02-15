{
  description = "NixOS systems configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      vm-aarch64 = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          {
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
            i18n.defaultLocale = "ja_JP.UTF-8";

            # Hostname.
            networking.hostName = "dev";

            # Disable the firewall since we're in a VM and we want to make it
            # easy to visit stuff in here. We only use NAT networking anyways.
            networking.firewall.enable = false;
          }
          ./configuration.nix
          ./hardware-configuration.nix
        ];
      };
    };
  };
}
