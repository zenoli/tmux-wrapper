{
  pkgs ? import <nixpkgs>,
}:
let
  lib = pkgs.lib;
  socket = "dev";

  # Builds the wrapper and starts it on a dedicated socket with a fresh
  # server, so the new config is loaded and the main tmux is left alone.
  dev-run = pkgs.writeShellApplication {
    name = "dev-run";
    text = ''
      out=$(nix build --no-link --print-out-paths | grep -v -- '-man$')
      tmux="$out/bin/tmux"

      # tmux only reads its config when the server starts.
      "$tmux" -L ${socket} kill-server 2>/dev/null || true
      while "$tmux" -L ${socket} list-sessions &>/dev/null; do
        sleep 0.1
      done

      unset TMUX
      exec "$tmux" -L ${socket} new-session
    '';
  };

  scripts = [
    dev-run
    (pkgs.writeShellApplication {
      name = "dev";
      runtimeInputs = with pkgs; [ watchexec ];
      text = ''
        watchexec \
          --restart \
          --clear \
          --stop-signal=SIGHUP \
          --stop-timeout=1s \
          --wrap-process=none \
          ${lib.getExe dev-run}
      '';
    })
    (pkgs.writeShellApplication {
      name = "dev2";
      runtimeInputs = with pkgs; [ watchexec ];
      text = ''
        watchexec \
          --restart \
          --clear \
          --stop-signal=SIGHUP \
          --stop-timeout=1s \
          --wrap-process=none \
          ${lib.getExe dev-run}
      '';
    })
    (pkgs.writeShellApplication {
      name = "dev-kill";
      text = ''
        out=$(nix build --no-link --print-out-paths | grep -v -- '-man$')
        "$out/bin/tmux" -L ${socket} kill-server
      '';
    })
  ];
in
pkgs.mkShell {
  packages = scripts;
}
