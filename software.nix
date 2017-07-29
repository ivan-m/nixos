{ config, pkgs, nixpkgsFun, ... }:

let
  kdePackages = with pkgs.kdeApplications;
                with pkgs.kdeFrameworks;
                with pkgs.plasma5; [
      dolphin
      dolphin-plugins
      ffmpegthumbs
      filelight
      gwenview
      kactivities
      karchive
      kate
      kcalc
      kcompletion
      kconfig
      kdecoration
      kdenetwork-filesharing
      kdeplasma-addons
      kdesu
      kgpg
      kguiaddons
      kinfocenter
      kio
      kio-extras
      kmediaplayer
      kmenuedit
      knewstuff
      knotifications
      knotifyconfig
      kompare
      konsole
      krunner
      kscreen
      kscreenlocker
      ksshaskpass
      ktexteditor
      ktextwidgets
      kwallet
      kwallet-pam
      kwalletmanager
      okular
      plasma-desktop
      plasma-integration
      plasma-pa
      plasma-workspace
      plasma-workspace-wallpapers
      polkit-kde-agent
      systemsettings
      ];

  games = with pkgs; [
      zeroad
      freeorion
      steam
      wesnoth
      ];

  unstable = (import <unstable> {
    config = {allowUnfree = true;};
  });
in
{

  nixpkgs.config = {
   allowUnfree = true;
   wine.build = "wine32";

    packageOverrides = pkgs: {
      firefox-unwrapped = pkgs.firefox-unwrapped.override {
        enableGTK3 = true;
        enableOfficialBranding = true;
      };

      wine = unstable.wineUnstable;
    };

    firefox = {
      ffmpegSupport = true;
      gecko_mediaplayer = true;
      gst_all = true;
      libpulseaudio = true;
    };
  };

  environment.systemPackages = with pkgs; [
    nix

    unstable.google-play-music-desktop-player
    unstable.google-musicmanager

    ark
    breeze-grub
    breeze-gtk
    breeze-icons
    breeze-plymouth
    breeze-qt4
    breeze-qt5
    kde-cli-tools
    kde-gtk-config
    kdeconnect
    krename
    #kde4.picmi

    atool
    bashCompletion
    binutils
    chromium
    emacs25
    ffmpeg
    file
    firefox
    fish
    flpsed
    ghostscript
    gitAndTools.darcsToGit
    gitAndTools.gitFull
    glibcLocales
    graphviz
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-good
    guvcview
    haskellPackages.ghc
    haskellPackages.cabal-install
    haskellPackages.stack
    haskellPackages.structured-haskell-mode
    haskellPackages.stylish-haskell
    haskellPackages.pandoc
    hexchat
    htop
    hunspell
    iftop
    iotop
    libreoffice
    lshw
    mono
    mtpfs
    multi-ghc-travis
    ncdu
    nethogs
    nix-repl
    nox
    ntfs3g
    pam_ssh_agent_auth
    paprefs
    pavucontrol
    playonlinux
    psmisc
    pstree
    python27Packages.tvnamer
    python35Packages.youtube-dl
    qbittorrent
    samba
    skype
    #skypeforlinux
    smbnetfs
    stow
    texlive.combined.scheme-full
    travis
    units
    unzip
    usbutils
    utillinux
    vlc
    wget
    wine
    winetricks
    xorg.xkill
    zip
    ] ++ kdePackages
      ++ games;

}
