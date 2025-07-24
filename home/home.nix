{ config, pkgs, nix-colors, ... }:

{

  imports = [
    nix-colors.homeManagerModules.default
    ./hyprland
    ./kitty.nix
    ./neovim
    ./steam.nix
    ./waybar
  ];

  colorScheme = nix-colors.lib.schemeFromYAML "belge" (builtins.readFile ./colorschemes/belge.yaml);

  home.username = "lauda";
  home.homeDirectory = "/home/lauda";

  home.stateVersion = "25.05";

  nixpkgs.config.allowUnfree = true;

  home.sessionVariables = {
    SHELL = "${pkgs.zsh}/bin/zsh";
  };

  home.packages = with pkgs; [
    git
    vim
    gotop
    ranger
    wget
    rofi-wayland
    discord
    vivaldi
    firefox
    spotify
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  
  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/lauda/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Software configuration

  programs.zsh = {
    enable = true;

    oh-my-zsh = {
      enable = true;
      custom = "/etc/nixos/home/zsh/themes";
      theme = "blinks-mag";
      plugins = [
        "git"
	"sudo"
	"docker"
      ];
    };

    syntaxHighlighting.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  fonts.fontconfig.enable = true;

}
