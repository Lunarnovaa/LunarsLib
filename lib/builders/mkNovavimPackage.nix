{
  lib,
  self,
}: let
  inherit (lib.lists) flatten;
  inherit (self.importers) listNixRecursive;
in
  {
    pkgs,
    inputs,
    moduleDir,
    languages ? ["nix"],
  }:
    (inputs.nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = flatten [
        (listNixRecursive (moduleDir + /common))
        (listNixRecursive (moduleDir + /options))
        (map (lang: (moduleDir + /languages + /${lang} + "module.nix")) languages)
      ];
    })
    .neovim
