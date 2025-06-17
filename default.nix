lib: let
  importFunction = location: (import (./lib + /${builtins.concatStringsSep "/" location} + ".nix") {inherit lib self;});
  self = {
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
in
  self
