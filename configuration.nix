{ config, pkgs, ... }:

let
  secrets = import ./secrets.nix;
in
{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable      = true;
  console.keyMap = "dvorak";
  environment.systemPackages = with pkgs; [ alacritty discord firefox fontconfig gh git nerd-fonts.ubuntu-mono sway vim wayland-utils wofi xclip wl-clipboard-x11 ];
  hardware.amdgpu.amdvlk.enable = false;
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  networking.hostName       = "thelio";
  networking.networkmanager.enable = true;
  nixpkgs.config.allowUnfree = true;
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  security.sudo.enable           = true;
  security.sudo.wheelNeedsPassword = true;
  services.getty.autologinUser = null;
  services.openssh.enable = false;
  services.pipewire.enable = true;
  services.pipewire.pulse.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.defaultSession = "xfce";
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "ctrl:nocaps";
  services.xserver.xkbVariant = "dvorak";
  time.timeZone             = "America/New_York";
  users.users.sandman.extraGroups         = [ "wheel" "networkmanager" "video" ];
  users.users.sandman.initialHashedPassword = secrets.userPasswordHash;
  users.users.sandman.isNormalUser        = true;
  
}
