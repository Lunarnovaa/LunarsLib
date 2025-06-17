{
  lib,
  self,
}: let
  inherit (lib.lists) flatten;
  inherit (self.importers) listNixRecursive;
in
  {
    pkgs,
    nvf,
    lunarsLib,
    moduleDir,
  }: config:
    (nvf.lib.neovimConfiguration {
      inherit pkgs;
      extraSpecialArgs = {inherit lunarsLib;};
      modules = flatten [
        (listNixRecursive moduleDir)
        config
      ];
    })
    .neovim
