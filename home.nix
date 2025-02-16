# Check out the different options for configuring home-manager with `:Man home-configuration.nix`!
{ config, pkgs, ... }:

let
  isMac = builtins.match ".*darwin.*" builtins.currentSystem != null;
  isLinux = builtins.match ".*linux.*" builtins.currentSystem != null;
  pathsConfig = import ./paths.nix;
  homeManagerPath = "${pathsConfig.home.homeDirectory}/.config/home-manager";
  homeUsername = pathsConfig.home.username;
  homeDirectory = pathsConfig.home.homeDirectory;
in
{
  imports = [
    ./secrets.nix
    ./tmux.nix
  ];
  home.username = homeUsername;
  home.homeDirectory = homeDirectory;

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
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    (pkgs.writeShellScriptBin "my-hello" ''
      echo "Hello, ${config.home.username}!"
    '')

    # fonts
    nerd-fonts.jetbrains-mono
    nerd-fonts.roboto-mono

    # basic utils
    wget
    curl
    fd
    ripgrep
    git-filter-repo
    sleek

    # dev environments
    devenv
    cachix
    direnv

    # languages
    lua
    python314
    gcc14
    nodejs_23

  ] ++ (if isMac then [
    # Mac-specific packages
  ] else if isLinux then [
    # Linux-specific packages
    pipewire
    cozy
    btop

    # task warrior
    taskwarrior3
    taskwarrior-tui

    # app launcher
    ulauncher

    # terminal
    kitty
  ] else [ ]);

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/pypoetry/config.toml".source = config.lib.file.mkOutOfStoreSymlink "${homeManagerPath}/files/pypoetry/config.toml";
    ".config/nix/nix.conf".source = config.lib.file.mkOutOfStoreSymlink "${homeManagerPath}/files/nix/nix.conf";
    ".config/kitty/kitty.conf".source = config.lib.file.mkOutOfStoreSymlink "${homeManagerPath}/files/kitty/kitty.conf";
    ".config/alacritty/alacritty.toml".source = config.lib.file.mkOutOfStoreSymlink "${homeManagerPath}/files/alacritty/alacritty.toml";
    ".config/zed".source = config.lib.file.mkOutOfStoreSymlink "${homeManagerPath}/files/zed";
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${homeManagerPath}/files/nvim";
    ".gitconfig".source = config.lib.file.mkOutOfStoreSymlink "${homeManagerPath}/files/.gitconfig";
    ".inputrc".source = config.lib.file.mkOutOfStoreSymlink "${homeManagerPath}/files/.inputrc";
    ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${homeManagerPath}/files/.zshrc";
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  # or
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  # or
  #  /etc/profiles/per-user/nicholas/etc/profile.d/hm-session-vars.sh
  home.sessionVariables = {
    EDITOR = "nvim";
    NIXHELLO = "Hello, world!";
  };

  programs =
    let
      crossPlatformPrograms = {
        neovim = {
          enable = true;
          extraLuaPackages = ps: [ ps.magick ];
          extraPackages = [ pkgs.imagemagick ];
        };

        # ABSOLUTELY NECESSARY!!
        home-manager.enable = true;
      };

      macPrograms = {
        ghostty = {
          enable = true;
        };

        git = {
          enable = true;
          userName = "Nicholas";
          userEmail = "nicholaszolton@gmail.com";
        };
      };

      linuxPrograms = {
        zsh = {
          enable = true;
          oh-my-zsh = {
            enable = true;
          };
        };

        git = {
          enable = true;
          userName = "Nicholas";
          userEmail = "nicholaszolton@gmail.com";
        };

        firefox = {
          enable = false; # this can be problematic if you have firefox installed
        };
      };
    in
    crossPlatformPrograms // (if isMac then macPrograms else if isLinux then linuxPrograms else { });

  systemd.user.startServices = if isLinux then "sd-switch" else true;

  manual.manpages.enable = true;

  # garbage collection options
  nix.gc =
    let
      baseConfig = {
        automatic = true;
        options = "--delete-older-than 5d";
      };
      macConfig = {
        # mac only options
      };
      linuxConfig = {
        # linux only options
      };
    in
    baseConfig // (if isMac then macConfig else if isLinux then linuxConfig else { });
}
