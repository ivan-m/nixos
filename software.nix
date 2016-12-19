{ config, pkgs, ... }:

let
  kdePackages = with pkgs.kde5; [
      ark
      breeze
      breeze-grub
      breeze-gtk
      breeze-icons
      breeze-plymouth
      breeze-qt4
      breeze-qt5
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
      kde-cli-tools
      kde-gtk-config
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
      okular
      plasma-desktop
      plasma-integration
      plasma-pa
      plasma-workspace
      plasma-workspace-wallpapers
      systemsettings
      ];

  games = with pkgs; [
      zeroad
      steam
      wesnoth
      ];

in
{

  environment.systemPackages = with pkgs; [
    nix

    atool
    bashCompletion
    emacs25
    ffmpeg
    file
    firefox
    fish
    flpsed
    ghostscript
    gitAndTools.darcsToGit
    gitAndTools.gitFull
    graphviz
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-good
    guvcview
    haskellPackages.ghc
    haskellPackages.cabal-install
    haskellPackages.stack
    haskellPackages.pandoc
    hexchat
    htop
    hunspell
    kdeconnect
    kde4.picmi
    libreoffice
    lshw
    nix-repl
    nox
    paprefs
    pavucontrol
    playonlinux
    pstree
    python27Packages.tvnamer
    python35Packages.youtube-dl
    qbittorrent
    skype
    stow
    texlive.combined.scheme-full
    usbutils
    utillinux
    vlc
    xorg.xkill
    zip
    ] ++ kdePackages
      ++ games;

}
