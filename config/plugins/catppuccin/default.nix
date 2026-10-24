{ pkgs, ... }:
{
  plugins = [
    {
      plugin = pkgs.tmuxPlugins.catppuccin;
      configBefore = builtins.readFile ./before.tmux;
      configAfter = builtins.readFile ./after.tmux;
    }
  ];
}
