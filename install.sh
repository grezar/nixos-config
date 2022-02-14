#!/bin/bash
set -eo pipefail

NIXPORT=22
NIXBLOCKDEVICE=nvme0n1
NIXADDR=$NIXADDR
NIXNAME=vm-aarch64

[ -z "$NIXADDR" ] && echo "NIXADDR is required." && exit 1

SSH_OPTIONS="-o PubkeyAuthentication=no -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"

function pre-bootstrap() {
  ssh ${SSH_OPTIONS} -p$NIXPORT root@${NIXADDR} " \
    parted /dev/${NIXBLOCKDEVICE} -- mklabel gpt; \
    parted /dev/${NIXBLOCKDEVICE} -- mkpart primary 512MiB -8GiB; \
    parted /dev/${NIXBLOCKDEVICE} -- mkpart primary linux-swap -8GiB 100\%; \
    parted /dev/${NIXBLOCKDEVICE} -- mkpart ESP fat32 1MiB 512MiB; \
    parted /dev/${NIXBLOCKDEVICE} -- set 3 esp on; \
    mkfs.ext4 -L nixos /dev/${NIXBLOCKDEVICE}p1; \
    mkswap -L swap /dev/${NIXBLOCKDEVICE}p2; \
    mkfs.fat -F 32 -n boot /dev/${NIXBLOCKDEVICE}p3; \
    mount /dev/disk/by-label/nixos /mnt; \
    mkdir -p /mnt/boot; \
    mount /dev/disk/by-label/boot /mnt/boot; \
    nixos-generate-config --root /mnt; \
    sed --in-place '/system\.stateVersion = .*/a \
    nix.package = pkgs.nixUnstable;\n \
    nix.extraOptions = \"experimental-features = nix-command flakes\";\n \
    services.openssh.enable = true;\n \
    services.openssh.passwordAuthentication = true;\n \
    services.openssh.permitRootLogin = \"yes\";\n \
    users.users.root.initialPassword = \"root\";\n \
    ' /mnt/etc/nixos/configuration.nix; \
    nixos-install --no-root-passwd; \
    reboot; \
  "
}

function bootstrap() {
  rsync -av -e "ssh ${SSH_OPTIONS} -p${NIXPORT}" \
    --exclude='.git/' \
    --rsync-path="sudo rsync" \
    ${PWD}/ root@${NIXADDR}:/nix-config
    # switch
    ssh ${SSH_OPTIONS} -p${NIXPORT} root@${NIXADDR} " \
      sudo NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1 nixos-rebuild switch --flake \"/nix-config#${NIXNAME}\" \
    "
}

case $1 in
  "pre-bootstrap") pre-bootstrap ;;
  "bootstrap") bootstrap ;;
  *) echo "Please specify a task to execute: ./install.sh <task>"
esac
