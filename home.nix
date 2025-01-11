{ config, pkgs, ... }:

let
  pathsConfig = import ./paths.nix;
  homeManagerPath = "${pathsConfig.home.homeDirectory}/.config/home-manager";
  homeUsername = pathsConfig.home.username;
  homeDirectory = pathsConfig.home.homeDirectory;
in
{
  imports = [
    ./secrets.nix
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
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    nerd-fonts.jetbrains-mono
    nerd-fonts.roboto-mono
    tmux
    wget
    curl
    btop
    devenv
    cachix
    direnv
    taskwarrior3
    taskwarrior-tui
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/tmux/tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "${homeManagerPath}/files/tmux/tmux.conf";
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
    NIXHELLO = "Hello, world!";
  };

  programs.firefox.enable = true;
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

  programs.neovim = {
    enable = true;
    extraLuaPackages = ps: [ ps.magick ];
    extraPackages = [ pkgs.imagemagick ];
  };

  systemd.user.startServices = "sd-switch";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
