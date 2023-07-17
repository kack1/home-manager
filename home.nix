{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "kyle";
  home.homeDirectory = "/home/kyle";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    btop
    emacs29
    ripgrep
    python311Packages.python-lsp-server
    python311Packages.python-lsp-black
    pipenv
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
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
  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/kyle/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home = {
    sessionVariables = {
      EDITOR = "vim";
    };
    sessionPath = [
      "~/.config/emacs/bin/"
    ];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Kyle Ackerman";
    userEmail = "108965613+kack1@users.noreply.github.com";
    extraConfig.init = {
      defaultBranch = "main"; 
    };
};
  programs.bash = {
    enable = true;
  };
  programs.xmobar = {
    enable = true;
    extraConfig = builtins.readFile /home/kyle/.dotfiles/.xmobarrc;
};
  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = /home/kyle/.dotfiles/xmonad.hs;
};
  programs.alacritty = {
    enable = true;
    settings = {
      title = "Alacritty";
      window = {
        padding = {
	  x = 10;
	  y = 10;
        };
        opacity = 1;
      };
    };
};
  services.picom = {
    enable = true;
    fade = false;
    opacityRules = [
	"90:class_g = 'Alacritty'"
    ];
  };
}
