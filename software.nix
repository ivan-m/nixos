{ config, pkgs, nixpkgsFun, stdenv, callPackage, ... }:

let

  unstable = (import <unstable> {
    config = {allowUnfree = true;};
  });

  broken = (import <nixpkgs> {
    config = {allowBroken = true;};
  });

  kdePackages = with pkgs;
                with pkgs.kdeApplications;
                with pkgs.kdeFrameworks;
                with pkgs.plasma5; [
      arc-kde-theme
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
      kdegraphics-thumbnailers
      kdenetwork-filesharing
      kdeplasma-addons
      kdesu
      kgpg
      kguiaddons
      ki18n
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
      krita
      krunner
      kscreen
      kscreenlocker
      ksshaskpass
      ktexteditor
      ktextwidgets
      kwallet
      kwallet-pam
      kwalletmanager
      kwin
      kwindowsystem
      latte-dock
      okular
      phonon-backend-gstreamer
      #phonon-backend-vlc
      oxygen
      oxygen-icons5
      plasma-desktop
      plasma-integration
      plasma-pa
      plasma-workspace
      plasma-workspace-wallpapers
      polkit-kde-agent
      systemsettings
      ];

  games = with pkgs; [
      commandergenius
      zeroad
      freeorion
      lgogdownloader
      openra
      unstable.steam
      tintin
      wesnoth
      ];
in
{

  nixpkgs.config = {
    allowUnfree = true;

    wine = {
      release           = "staging";
      build             = "wineWow";
      pngSupport        = true;
      jpegSupport       = true;
      tiffSupport       = true;
      gettextSupport    = true;
      fontconfigSupport = true;
      alsaSupport       = true;
      gtkSupport        = true;
      openglSupport     = true;
      tlsSupport        = true;
      gstreamerSupport  = true;
      dbusSupport       = true;
      cairoSupport      = true;
      pulseaudioSupport = true;

      override = {
        wineBuild = "wineWow";
        wineRelease = "staging";
      };
    };

    packageOverrides = super: let self = super.pkgs; in {
      firefox-unwrapped = super.firefox-unwrapped.override {
        #drmSupport             = true;
        #enableOfficialBranding = true;
        gtk3Support            = true;
        #safeBrowsingSupport    = true;
      };

      keepassxc = unstable.keepassxc.override {
        withKeePassBrowser    = true;
        withKeePassNetworking = true; # To get favicons
        withKeePassSSHAgent   = true;
      };

      # hunspellDicts = self.hunspellDicts.override {
      #   overrides = self: super: {
      #     en-au = self.callPackage
      #       ({ mkDictFromWordList }:
      #       hunspellDicts.mkDictFromWordlist {
      #         shortName = "en-au";
      #         shortDescription = "English (Australian)";
      #         dictFileName = "en_AU";
      #         src = fetchurl {
      #           url = mirror://sourceforge/wordlist/speller/2017.08.24/hunspell-en_AU-2017.08.24.zip;
      #           sha256 = "4ce88a1af457ce0e256110277a150e5da798213f611929438db059c1c81e20f2";
      #         };
      #       });
      #   };
      # };

      profiledHaskellPackages = self.haskellPackages.override {
        overrides = self: super: {
          mkDerivation = args: super.mkDerivation (args // {
            enableLibraryProfiling = true;
          });
        };
      };

      haskellPackages = super.haskellPackages.override {
        overrides = self: super: {

          # # Until jbi arrives in a package set
          # "jbi" = self.callPackage
          #   ({ mkDerivation, aeson, aeson-pretty, base, Cabal, directory
          #    , filepath, optparse-applicative, process, tagged, text
          #    }:
          #    mkDerivation {
          #      pname = "jbi";
          #      version = "0.1.0.0";
          #      sha256 = "13jswxfka5v8n2sdxg0p75ykhgvb351cih2zlid8x05lpiqlw87c";
          #      isLibrary = true;
          #      isExecutable = true;
          #      libraryHaskellDepends = [
          #        aeson base Cabal directory filepath process tagged
          #      ];
          #      executableHaskellDepends = [
          #        aeson-pretty base optparse-applicative text
          #      ];
          #      description = "Just Build It - a \"do what I mean\" abstraction for Haskell build tools";
          #      license = stdenv.lib.licenses.mit;
          #    }) {};

        };
      };


    };

    firefox = {
      ffmpeg        = true;
      gst_all       = true;
      libpulseaudio = true;
    };

  };

  environment.systemPackages = with pkgs; [
    nix

    ark
    breeze-grub
    breeze-gtk
    breeze-icons
    breeze-plymouth
    breeze-qt5
    kde-cli-tools
    kde-gtk-config
    kdeconnect
    krename
    #kde4.picmi

    atool
    unrar
    bashCompletion
    bind
    binutils
    chromium
    cuetools
    darcs
    emacs25
    enca
    ffmpeg
    file
    firefox
    fish
    flac
    flpsed
    ghostscript
    gimp
    gitAndTools.darcsToGit
    gitAndTools.gitFull
    glibcLocales
    gnumake
    graphviz
    gsmartcontrol
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-good
    gst-ffmpeg
    gst-plugins-good
    guvcview

    unstable.cabal2nix
    (haskellPackages.ghcWithPackages (pkgs: [pkgs.pandoc-types]))
    haskellPackages.cabal-install
    haskellPackages.jbi
    haskellPackages.stack
    haskellPackages.structured-haskell-mode
    haskellPackages.stylish-haskell
    haskellPackages.pandoc
    haskellPackages.hdevtools
    haskellPackages.hasktags
    haskellPackages.hlint
    haskellPackages.pointfree
    multi-ghc-travis

    hexchat
    htop
    hunspell
    hunspellDicts.en-gb-ise
    iftop
    inkscape
    iotop
    #jre
    keepassxc
    libreoffice
    lshw
    man
    manpages
    mono
    mp3splt
    mtpfs
    ncdu
    nethogs
    nextcloud-client
    nix-repl
    nox
    ntfs3g
    pam_ssh_agent_auth
    papirus-icon-theme
    paprefs
    pavucontrol
    playonlinux
    psmisc
    pstree
    python27Packages.tvnamer
    python35Packages.youtube-dl
    python36Packages.chardet
    puddletag
    qbittorrent
    samba
    shntool
    skype
    skypeforlinux
    smartmontools
    smbnetfs
    sox
    sshfs-fuse
    stow
    syncthing
    #syncthing-inotify
    python27Packages.syncthing-gtk
    qsyncthingtray
    texlive.combined.scheme-full
    traceroute
    travis
    tree
    units
    unzip
    usbutils
    utillinux
    vlc
    wavpack
    wget
    wine
    winetricks
    xclip
    xlsfonts
    xorg.xkill
    zip
    ] ++ kdePackages
      ++ games;
}
