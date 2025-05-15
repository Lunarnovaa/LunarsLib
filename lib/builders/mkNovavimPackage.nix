{lib, ...}: let
  inherit (lib.lists) flatten;
in
  {
    pkgs,
    inputs,
    moduleDir,
    languages ? ["nix"],
  }: (inputs.nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = flatten [
        (moduleDir + /common)
        (moduleDir + /options)
        (map (lang: (moduleDir + /languages + /${lang})) languages)
      ];
    })
    .neovim
