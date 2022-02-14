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
            services.openssh.permitRootLogin = "yes";
          }
          ./hardware-configuration.nix
        ];
      };
    };
  };
}
