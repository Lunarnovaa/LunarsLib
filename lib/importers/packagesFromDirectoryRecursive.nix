{lib, ...}: let
  /*
    This is a partially rewritten lib.filesystem.packagesFromDirectoryRecursive, mainly
  to make it a bit more readable, slightly more optimized, and allow me to pass in my
  specialArgs.
  */
  inherit (builtins) pathExists hasAttr readDir;
  inherit (lib.path) append;
  inherit (lib.attrsets) concatMapAttrs recurseIntoAttrs;
  inherit (lib.customisation) makeScope;
  inherit (lib.strings) removeSuffix hasSuffix;
  inherit (lib.trivial) pipe;

  processDir = {
    callPackage,
    directory,
    specialArgs ? {},
    ...
  } @ args:
    pipe directory [
      readDir
      (concatMapAttrs (
        name: type:
        # for each directory entry
        let
          path = append directory name;
        in
          if type == "directory"
          then {
            # recurse into directories
            "${name}" = packagesFromDirectoryRecursive (
              args
              // {
                directory = path;
              }
            );
          }
          else if type == "regular" && hasSuffix ".nix" name
          then {
            #call .nix files
            "${removeSuffix ".nix" name}" = callPackage path specialArgs;
          }
          # Don't call non-nix files
          # Why was there a check for anything else? readDir can only output either
          # directory or regular.
          else {}
      ))
    ];

  packagesFromDirectoryRecursive = {
    callPackage,
    newScope ? throw "lunarsLib.importers.packagesFromDirectoryRecursive: newScope wasn't passed in args",
    directory,
    specialArgs ? {},
    ...
  } @ args: let
    defaultPath = append directory "package.nix";
  in
    if pathExists defaultPath
    then callPackage defaultPath specialArgs
    else if args ? newScope
    then
      # Create a new scope and mark it as `recursiveForDerivations`,
      # allowing packages to refer to each other.
      # See: lib.customisations.makeScope and lib.attrsets.recurseIntoAttrs
      recurseIntoAttrs (
        makeScope newScope (
          attrs:
          # generate the attrset representing the directory,
          # using the new scope's `callPackage` and `newScope`
            processDir (
              args
              // {
                inherit (attrs) callPackage newScope specialArgs;
              }
            )
        )
      )
    else processDir args;
in
  packagesFromDirectoryRecursive
