{ wlib, ... }:
{
  # Every other .nix file under ./config is pulled in by import-tree
  # (see parts/wrappers.nix).
  imports = [ wlib.wrapperModules.tmux ];

  terminal = "tmux-256color";
  escapeTime = 0;
  statusKeys = "vi";
  modeKeys = "vi";
  # Keep the home-manager module's behaviour where the wrapper's defaults
  # differ.
  clock24 = true;
  disableConfirmationPrompt = false;
  secureSocket = true;

}
