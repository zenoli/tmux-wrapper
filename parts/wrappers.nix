{ inputs, ... }:
{
  flake.wrappers.tmux = inputs.import-tree ../config;
}
