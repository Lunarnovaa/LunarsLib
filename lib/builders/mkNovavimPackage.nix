{
  lib,
  self,
  ...
}: let
  inherit (lib.lists) flatten;
  inherit (self.importers) listNixRecursive;
in
  {
    pkgs,
    inputs,
    moduleDir,
  }: config:
    (inputs.nvf.lib.neovimConfiguration {
      inherit pkgs;
      extraSpecialArgs = {inherit (inputs) lunarsLib;};
      modules = flatten [
        (listNixRecursive moduleDir)
        config
      ];
    })
    .neovim
