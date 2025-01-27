{ pkgs, ... }:
# let
#   tmux-tpm = pkgs.tmuxPlugins.mkTmuxPlugin
#     {
#       pluginName = "tpm";
#       src = pkgs.fetchFromGitHub {
#         owner = "tmux-plugins";
#         repo = "tpm";
#       };
#     };
# in
{
  programs.tmux = {
    enable = true;
    historyLimit = 10000;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      continuum
      yank
      prefix-highlight
      open
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavour 'mocha'
        '';
      }
    ];
    extraConfig = ''
      # fix window indexing
      set -g base-index 1
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      set -g mouse on
      set -g history-limit 10000
      set -gq allow-passthrough on
      set -g visual-activity off
      set-option -ga terminal-overrides ",xterm*:Tc"

      # custom bindings
      bind -n M-H previous-window
      bind -n M-L next-window

      # set vi keys
      setw -g mode-keys vi
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi 'a' send-keys q
      bind-key -T copy-mode-vi 'i' send-keys q

      # open panes in the same directory as the current pane
      bind \\ split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"


      # set window title
      set-window-option -g automatic-rename on
    '';
  };
}
