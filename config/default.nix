{ lib, wlib, ... }:
{
  imports = [
    wlib.wrapperModules.tmux
  ]
  # Every entry in ./plugins is a module: either `<name>.nix` or a
  # `<name>/` directory with a default.nix (plus before.tmux/after.tmux).
  ++ map (name: ./plugins + "/${name}") (lib.attrNames (builtins.readDir ./plugins));

  terminal = "tmux-256color";
  escapeTime = 0;
  statusKeys = "vi";
  modeKeys = "vi";
  # Keep the home-manager module's behaviour where the wrapper's defaults
  # differ.
  clock24 = true;
  disableConfirmationPrompt = false;
  secureSocket = true;
  configAfter = ''
    # Split windows
    bind-key h split-window -c "#{pane_current_path}"
    bind-key v split-window -h -c "#{pane_current_path}"
    bind-key H split-window -f -c "#{pane_current_path}"
    bind-key V split-window -f -h -c "#{pane_current_path}"

    # Select pre-defined windows
    bind-key -T prefix e switch-client -T window-selector
    bind-key -T window-selector w select-window -t "vimwiki"
    bind-key -T window-selector d select-window -t "dotfiles"

    bind-key S set -w synchronize-panes
    bind-key q display-panes -d 5000

    bind-key = select-layout even-horizontal

    # Resize panes
    bind-key -n C-Down resize-pane -D 5
    bind-key -n C-Up resize-pane -U 5
    bind-key -n C-Left resize-pane -L 5
    bind-key -n C-Right resize-pane -R 5

    # Shift + Alt to switch windows or sessions
    bind-key -n M-H previous-window
    bind-key -n M-L next-window
    bind-key -n M-N switch-client -n
    bind-key -n M-P switch-client -p

    # Swap windows
    bind-key -r "<" swap-window -d -t -1
    bind-key -r ">" swap-window -d -t +1
  '';
}
