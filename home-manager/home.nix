{ config, pkgs, ... }:
let
  system = builtins.currentSystem;
  username = if system == "x86_64-darwin" then "mikaelsilva" else "mikael";
  homeDir = if system == "x86_64-darwin" then "/Users/${username}" else "/home/${username}";
in
{
  home.username = username;
  home.homeDirectory = homeDir;
  home.stateVersion = "23.05";
  home.packages = [
    pkgs.helix
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
      source = homeDir + "/dotfiles/nvim/init.lua";
      target = ".config/nvim/init.lua";
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    PATH = "~/bin:$PATH";
  };

  home.shellAliases = {
    hm = "nvim ~/dotfiles/home-manager/home.nix && home-manager -f ~/dotfiles/home-manager/home.nix switch";
  };

  programs.home-manager.enable = true;
  programs.zsh.enable = true;
  programs.bash.enable = true;
  programs.git = {
    enable = true;
    userName = "Mikael Souza";
    userEmail = "mikael.souza.cc@gmail.com";
  };
}

