{ lib, wlib, ... }: {
  configAfter = ''
    ${builtins.readFile ./options.tmux}
    ${builtins.readFile ./keybindings.tmux}
  '';

}
