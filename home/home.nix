{ config, pkgs, ... }:

{
  home.username = "lauda";
  home.homeDirectory = "/home/lauda";

  home.stateVersion = "25.05";

  nixpkgs.config.allowUnfree = true;

  home.sessionVariables = {
    SHELL = "${pkgs.zsh}/bin/zsh";
  };

  home.packages = with pkgs; [
    kitty
    git
    vim
    wget
    rofi-wayland
    waybar
    hack-font
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

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {

      exec-once = [
        "waybar"
      ];

      monitor = [
        "DP-1,2560x1440@165,1440x440,1"
        "HDMI-A-1,2560x1440@144,0x0,1,transform,3"
      ];

      misc = {
        disable_hyprland_logo = true;
	disable_splash_rendering = true;
      };

      # Key bindings
      "$mod" =  "SUPER";

      bind = [
        # Application shortcuts
        "$mod, Return, exec, kitty"
	"$mod, Q, killactive"
        "$mod, D, exec, rofi -show drun"

        # Move focus with mainMod + hjkl
        "$mod, m, movefocus, l"
        "$mod, i, movefocus, r"
        "$mod, e, movefocus, u"
        "$mod, n, movefocus, d"

        # Move window with mainMod + hjkl
        "$mod SHIFT, m, movewindow, l"
        "$mod SHIFT, i , movewindow, r"
        "$mod SHIFT, e, movewindow, u"
        "$mod SHIFT, n, movewindow, d"

        # Switch workspaces with mainMod + [0-9]
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  fonts.fontconfig.enable = true;
  
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.kitty = {
    enable = true;
    settings = {
      font_family = "Hack";
    };
  };

  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
	position = "top";
	height = 30;
	spacing = 4;

        modules-left = [ "hyprland/workspaces" "hyprland/mode" ];
	modules-center = [ "hyprland/window" ];
	modules-right = [ "battery" "clock" ];
      };
    };

    style = builtins.readFile ./waybar/style.css;
  };

}
