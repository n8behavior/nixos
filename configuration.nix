{ config, pkgs, ... }:

let
  secrets = import ./secrets.nix;
in
{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  console.keyMap = "dvorak";
  environment.systemPackages = with pkgs; [];
  hardware.amdgpu.amdvlk.enable = false;
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings.LC_ADDRESS = "en_US.UTF-8";
  i18n.extraLocaleSettings.LC_IDENTIFICATION = "en_US.UTF-8";
  i18n.extraLocaleSettings.LC_MEASUREMENT = "en_US.UTF-8";
  i18n.extraLocaleSettings.LC_MONETARY = "en_US.UTF-8";
  i18n.extraLocaleSettings.LC_NAME = "en_US.UTF-8";
  i18n.extraLocaleSettings.LC_NUMERIC = "en_US.UTF-8";
  i18n.extraLocaleSettings.LC_PAPER = "en_US.UTF-8";
  i18n.extraLocaleSettings.LC_TELEPHONE = "en_US.UTF-8";
  i18n.extraLocaleSettings.LC_TIME = "en_US.UTF-8";
  networking.hostName = "thelio";
  networking.networkmanager.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  programs.firefox.enable = true;
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  security.rtkit.enable = true;
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = true;
  services.getty.autologinUser = null;
  services.openssh.enable = false;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.enable = true;
  services.pipewire.pulse.enable = true;
  services.printing.enable = true;
  services.pulseaudio.enable = false;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.defaultSession = "gnome";
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.setupCommands = "${pkgs.xorg.xrandr}/bin/xrandr --output DP-3 --mode 3440x1440 --rate 120.00";
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "dvorak";
  services.xserver.xkb.options = "ctrl:nocaps";
  system.stateVersion = "25.05";
  time.timeZone = "America/New_York";
  users.users.sandman.description = "Mike Sandman";
  users.users.sandman.extraGroups = [ "wheel" "networkmanager" "video" ];
  users.users.sandman.initialHashedPassword = secrets.userPasswordHash;
  users.users.sandman.isNormalUser = true;
  users.users.sandman.packages = with pkgs; [ alacritty discord firefox fontconfig gh git nerd-fonts.ubuntu-mono sway vim wayland-utils wofi xclip wl-clipboard-x11 unzip ];
  
}
