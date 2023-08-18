{ config, pkgs, ... }:

let unstable = import <nixos-unstable> {
  config = {
    allowUnfree = true;
  };
};
in {
  imports =
    [
      /etc/nixos/hardware-configuration.nix
      <home-manager/nixos>
    ];

  boot = {
   loader.systemd-boot.enable = true;
   loader.efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "nixos"; # Define your hostname.
    networkmanager.enable = true;
  };
  time.timeZone = "America/Manaus";
  
  i18n = {
    defaultLocale = "pt_BR.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "pt_BR.UTF-8";
      LC_IDENTIFICATION = "pt_BR.UTF-8";
      LC_MEASUREMENT = "pt_BR.UTF-8";
      LC_MONETARY = "pt_BR.UTF-8";
      LC_NAME = "pt_BR.UTF-8";
      LC_NUMERIC = "pt_BR.UTF-8";
      LC_PAPER = "pt_BR.UTF-8";
      LC_TELEPHONE = "pt_BR.UTF-8";
      LC_TIME = "pt_BR.UTF-8";
    };
  };

  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    desktopManager.cinnamon.enable = true;
    layout = "us";
    xkbVariant = "alt-intl";
  };

  console.keyMap = "dvorak";
  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
 };

  users.users.mikael = {
    isNormalUser = true;
    description = "Mikael Souza";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager.useUserPackages = true;
  home-manager.users.mikael = { pkgs, ... }: {
    home.packages = [
      unstable.neovim
      unstable.firefox
      unstable.vscode
      unstable.gcc
      unstable.nodejs
      unstable.rustc
      unstable.cargo
      unstable.rust-analyzer
      unstable.rustfmt
      unstable.pyright
      unstable.black
      unstable.lua-language-server
      unstable.nodePackages.lua-fmt
      unstable.ripgrep
      unstable.fd
      unstable.discord
      unstable.telegram-desktop
      unstable.spotify
      unstable.obsidian
    ];
    home.stateVersion = "23.05";
    home.sessionVariables = {
      EDITOR = "nvim";
      RUST_SRC_PATH = "${unstable.rust.packages.stable.rustPlatform.rustLibSrc}";
    };
    home.shellAliases = {
      vi = "nvim";
      vim = "nvim";
      hm = "nvim ~/Code/dotfiles/nixos/configuration.nix && sudo nixos-rebuild switch";
    };
    programs = {
      home-manager.enable = true;
      bash.enable = true;
      git = {
        enable = true;
	userName = "Mikael Souza";
	userEmail = "mikael.souza.cc@gmail.com";
      };
    };
  };
  
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    neovim
  ];

 system.stateVersion = "23.05";
}
