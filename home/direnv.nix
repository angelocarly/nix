{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
