{ config, pkgs, ... }:

{
  imports = [
    ./paths.nix
    ./secrets.nix
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (nerdfonts.override { fonts = [ "JetBrainsMono" "RobotoMono" ]; })
    nerd-fonts.jetbrains-mono
    nerd-fonts.roboto-mono

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    git
    tmux
    neovim
    oh-my-zsh
    zsh
    wget
    curl
    btop
    devenv
    cachix
    direnv
    taskwarrior3
    taskwarrior-tui
    firefox-unwrapped
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    ".config/tmux/tmux.conf".source = files/tmux/tmux.conf;
    ".config/pypoetry/config.toml".source = files/pypoetry/config.toml;
    ".config/nix/nix.conf".source = files/nix/nix.conf;
    ".config/kitty/kitty.conf".source = files/kitty/kitty.conf;
    ".config/alacritty/alacritty.toml".source = files/alacritty/alacritty.toml;
    ".config/zed".source = files/zed;
    ".config/zed".recursive = true;
    ".gitconfig".source = files/.gitconfig;
    ".inputrc".source = files/.inputrc;
    ".zshrc".source = files/.zshrc;
    ".zshenv".source = files/.zshenv;
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
  #  /etc/profiles/per-user/nicholas/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
  };

  programs.git = {
    enable = true;
    userName = "Nicholas";
    userEmail = "nicholaszolton@gmail.com";
  };

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
    };
  };

  systemd.user.startServices = "sd-switch";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
