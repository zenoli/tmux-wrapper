{ ... }:
{
  perSystem =
    { self', ... }:
    {
      packages.default = self'.packages.tmux;
    };
}
