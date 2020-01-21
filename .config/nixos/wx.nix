{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    # XORG
    arandr autorandr

    xorg.xbacklight

    xclip

    rxvt_unicode
    nextcloud-client

    # GUI
    firefox
    libreoffice
    emacs
    evince

    # SOCIAL
    wire-desktop slack tdesktop zoom-us

    # VIDEO
    mplayer
  ];

# Enable the X11 windowing system.
services.xserver.enable = true;
services.xserver.layout = "fr";
services.xserver.xkbOptions = "eurosign:e";
# Enable touchpad support.
services.xserver.libinput.enable = true;

services.xserver.displayManager.gdm.enable = true;

services.xserver.desktopManager.gnome3.enable = true;

services.xserver.windowManager.i3 = {
  enable = true;
  package = pkgs.i3-gaps;
  extraPackages = with pkgs; [
    i3lock
    polybar
    rofi
  ];
};


services.emacs.enable = true;

hardware.sensor.iio.enable = true;

}
