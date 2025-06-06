{
  description = "Lunar's (Nix) Library";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = inputs: let
    importFunction = location: (import (./lib + /${builtins.concatStringsSep "/" location} + ".nix") {
      inherit (inputs.nixpkgs) lib;
      inherit (inputs) self;
    });
  in {
    builders = {
      mkHost = importFunction ["builders" "mkHost"];
      mkNovavimPackage = importFunction ["builders" "mkNovavimPackage"];
    };
    generators = {
      mkCosmicSettings = importFunction ["generators" "mkCosmicSettings"];
      ron = importFunction ["generators" "ron"];
      toHyprconf = importFunction ["generators" "toHyprconf"];
      toSwaylockConf = importFunction ["generators" "toSwaylockConf"];
    };
    importers = {
      listFilesRecursiveClean = importFunction ["importers" "listFilesRecursiveClean"];
      listNixRecursive = importFunction ["importers" "listNixRecursive"];
      packagesFromDirectoryRecursive = importFunction ["importers" "packagesFromDirectoryRecursive"];
    };
    systems = {
      forAllSystems = importFunction ["systems" "forAllSystems"];
    };
  };
}
