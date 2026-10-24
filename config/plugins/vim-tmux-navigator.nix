{ pkgs, ... }:
{
  plugins = [
    {
      plugin = pkgs.tmuxPlugins.vim-tmux-navigator;
      configBefore = ''
        set -g @vim_navigator_mapping_left 'M-h'
        set -g @vim_navigator_mapping_down 'M-j'
        set -g @vim_navigator_mapping_up 'M-k'
        set -g @vim_navigator_mapping_right 'M-l'
      '';
    }
  ];
}
