# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./nox.nix
      ./wx.nix
    ];

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "thinkbad-XY"; # Define your hostname.
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp0s20f3.useDHCP = true;
  networking.networkmanager.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.defaultUserShell = "/run/current-system/sw/bin/zsh";
  users.users = {
    baroud = {
      isNormalUser = true;
      extraGroups = [ "wheel" "disk" "audio" "video" "networkmanager"
                      "systemd-journal" "sudo" ];
      createHome = true;
      home = "/home/baroud";
    };
    claire = {
      isNormalUser = true;
      extraGroups = [ "wheel" "disk" "audio" "video" "networkmanager"
                      "systemd-journal"];
      createHome = true;
      home = "/home/claire";
    };
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.autoUpgrade.channel =  "http://nixos.org/channels/nixpkgs-unstable";
system.stateVersion = "19.09"; # Did you read the comment?
}
