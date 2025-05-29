{lib, ...}: let
  inherit (lib.attrsets) genAttrs;
in
  inputs: let
    systems = import inputs.systems;
  in
    function:
      genAttrs systems (system: function inputs.nixpkgs.legacyPackages.${system})
