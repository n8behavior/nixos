{ config, pkgs, ... }:

let
  secrets = import ./secrets.nix;
in
{
  imports = [ ./hardware-configuration.nix ];

  ################################################################
  # Bootloader
  ################################################################
  boot.loader.systemd-boot.enable      = true;
  boot.loader.efi.canTouchEfiVariables = true;

  ################################################################
  # Networking & Time
  ################################################################
  networking.hostName       = "thelio";
  networking.networkmanager.enable = true;
  time.timeZone             = "America/New_York";

  ################################################################
  # Users & Authentication
  ################################################################
  users.users.sandman = {
    isNormalUser        = true;
    extraGroups         = [ "wheel" "networkmanager" "video" ];
    # generate this with `openssl passwd -6` on the live media
    initialHashedPassword = secrets.userPasswordHash;
  };

  # Require a password for sudo
  security.sudo.enable           = true;
  security.sudo.wheelNeedsPassword = true;

  # Don’t enable SSH at all (you won’t SSH into this machine)
  services.openssh.enable = false;
  services.getty.autologinUser = null;

  ################################################################
  # System packages
  ################################################################
  environment.systemPackages = with pkgs; [
    sway
    wayland-utils
    alacritty
    nerd-fonts.ubuntu-mono
    fontconfig
    wofi
    git vim
  ];

  # We’re not running X.org
  services.xserver.enable = false;

  hardware.graphics.enable = true;
  hardware.amdgpu.amdvlk.enable = true;

  ################################################################
  # Drop-in Sway config
  ################################################################
  environment.etc."sway/config".text = ''
    # modifier key
    set $mod Mod4

    # launch terminal
    bindsym $mod+Return exec alacritty

    # Dvorak layout + Caps→Ctrl
    input * {
      xkb_layout  us
      xkb_variant dvorak
      xkb_options ctrl:nocaps
    }

    # …you can add more sway bindings here…
  '';

  console.keyMap = "dvorak";
}
