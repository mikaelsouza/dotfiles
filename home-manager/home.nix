{ config, pkgs, ... }:

{
  home.username = "mikael";
  home.homeDirectory = "/home/mikael";

  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.packages = [
    pkgs.python311
    pkgs.direnv
    pkgs.neovim
    pkgs.tmux
    pkgs.gcc
    pkgs.nodejs
    pkgs.rustc
    pkgs.cargo
    pkgs.rust-analyzer
    pkgs.rustfmt
    pkgs.pyright
    pkgs.black
    pkgs.lua-language-server
    pkgs.nodePackages.lua-fmt
    pkgs.ripgrep
    pkgs.fd
    pkgs.nixpkgs-fmt
    pkgs.lazydocker
  ];

  home.file = {
    nvim = {
      enable = true;
      source = "/home/mikael/dotfiles/nvim/init.lua";
      target = ".config/nvim/init.lua";
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    PATH = "/home/mikael/bin:$PATH";
  };

  home.shellAliases = {
    hm = "nvim ~/.config/home-manager/home.nix && home-manager switch";
  };

  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" ];
    };
  };
  programs.bash.enable = true;
  programs.git = {
    enable = true;
    userName = "Mikael Souza";
    userEmail = "mikael.souza.cc@gmail.com";
  };
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}

