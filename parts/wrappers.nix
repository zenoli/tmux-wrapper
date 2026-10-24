{ self, ... }:
{
  flake.wrappers.tmux = self + /config;
}
