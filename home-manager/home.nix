{ config, pkgs, ... }:

{
  home = {
    username = "mikael";
    homeDirectory = "/home/mikael";
    stateVersion = "23.05";
    packages = [
      pkgs.neovim
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
    ];
    file = { 
    };
    sessionVariables = {
      EDITOR = "nvim";
    };
    shellAliases = {
      sw = "home-manager switch";
      hm = "nvim ~/.config/home-manager/home.nix";
    };
  };
  programs = {
    bash.enable = true;
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "Mikael Souza";
      userEmail = "mikael.souza.cc@gmail.com";
    };
  };
}
