{ config, pkgs, ... }:

let
  secrets = import ./secrets.nix;
in
{
  imports = [ ./hardware-configuration.nix ];

  console.keyMap = "dvorak";

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
    git 
    gh
    vim
    firefox
  ];

  ################################################################
  # Sway config
  ################################################################
  programs.sway.enable = true;
  environment.etc."sway/config.d/10-input.conf".text = ''
    input * {
      xkb_layout  us
      xkb_variant dvorak
      xkb_options ctrl:nocaps
    }
    # launch terminal
    bindsym $mod+Return exec alacritty
  '';

  ################################################################
  # Graphics stuff
  ################################################################
  # We’re not running X.org
  services.xserver.enable = false;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    #extraPackages = with pkgs; [
    #  vulkan-tools
    #  gamescope
    #  mangohud
    #];
    #extraPackages32 = with pkgs.pkgsi686Linux; [
    #  vulkan-tools
    #];
  #hardware.amdgpu.amdvlk.enable = true;
  };

  ################################################################
  # Sound stuff
  ################################################################
  services.pipewire.enable = true;
  services.pipewire.pulse.enable = true;
  ################################################################
  # Steam stuff
  ################################################################
  nixpkgs.config.allowUnfree = true;
  #nixpkgs.config.allowUnfreePredicate = pkg:
  #  builtins.elem  ( lib.getName pkg ) [
  #    "steam"
  #    "steam-original"
  #    "steam-unwrapped"
  #    "steam-run"
  #  ];
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  
}
