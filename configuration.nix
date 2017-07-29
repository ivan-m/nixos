# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./software.nix
    ];

  # 4.8 seems buggy
  # boot.kernelPackages = pkgs.linuxPackages_4_8;

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/disk/by-id/ata-WDC_WD1002FAEX-00Z3A0_WD-WCATR1627472";
  boot.supportedFilesystems = [ "btrfs" ];
  boot.tmpOnTmpfs = true;

  fonts.enableFontDir = true;
  fonts.fontconfig.cache32Bit = true;

  # Conflicts with OpenSSH
  # gnu = true;

  hardware.cpu.intel.updateMicrocode = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

  networking.hostName = "Sniper"; # Define your hostname.
  networking.extraHosts =
    "
      192.168.1.1 r7000

      141.101.118.194 thepiratebay.org
      104.31.16.3 thepiratebay.se
    ";

  networking.firewall.allowedTCPPorts = [ 1714:1764 ];
  networking.firewall.allowedUDPPorts = [ 1714:1764 ];
  networking.firewall.allowPing = true;
  networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;

  nix.buildCores = 4;
  nix.gc.automatic = true;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    # consoleKeyMap = "us";
    consoleUseXkbConfig = true;
    defaultLocale = "en_AU.UTF-8";
  };

  programs.nano.nanorc = ''
    set nowrap
    set tabstospaces
    set tabsize 4
  '';

  programs.ssh.startAgent = true;
  programs.ssh.setXAuthLocation = true;

  security.apparmor.enable = true;

  # security.grsecurity.enable = true;

  security.pam.enableSSHAgentAuth = true;

  services.locate.enable = true;
  services.gpm.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Sydney";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # environment.systemPackages = with pkgs; [
  #   wget
  # ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;


  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.kde4.enable = false;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.windowManager.xmonad.enable = false;
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;
  services.xserver.modules = [ pkgs.xf86_input_wacom ];
  services.xserver.wacom.enable = true;
  #services.xserver.xkbOptions = "";

  sound = {
    mediaKeys.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.ivan = {
    isNormalUser = true;
    description = "Ivan Lazar Miljenovic";
    extraGroups = [ "wheel" "networkmanager"];
    uid = 1000;
  };

  system.autoUpgrade.enable = true;

#  systemd.user.services.emacs = {
##    description = "Emacs Daemon";
#    environment = {
##      GTK_DATA_PREFIX = config.system.path;
#      SSH_AUTH_SOCK = "%t/ssh-agent";
#      GTK_PATH = "${config.system.path}/lib/gtk-3.0:${config.system.path}/lib/gtk-2.0";
#      NIX_PROFILES = "${pkgs.lib.concatStringsSep ":" config.environment.profiles}";
#      TERMINFO_DIRS = "/run/current-system/sw/share/terminfo";
#      ASPELL_CONF = "dict-dir /run/current-system/sw/lib/aspell";
#    };
#    serviceConfig = {
#      Type = "forking";
#      ExecStart = "${pkgs.emacs}/bin/emacs --daemon";
#      ExecStop = "${pkgs.emacs}/bin/emacsclient --eval (kill-emacs)";
#      Restart = "always";
#    };
#    wantedBy = [ "default.target" ];
#  };

  # systemd.services.emacs.enable = true;

  # The NixOS release to be compatible with for stateful data such as databases.
  # system.stateVersion = "16.09";

}
