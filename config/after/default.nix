{ lib, wlib, ... }: {
  configAfter = ''
    ${builtins.readFile ./keybindings.tmux}
  '';

}
