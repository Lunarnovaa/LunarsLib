{
  lib,
  self,
}: let
  inherit (lib) nixosSystem;
  inherit (lib.modules) mkDefault;
  inherit (lib.lists) flatten singleton;
  inherit (self.importers) listNixRecursive;
  inherit (builtins) map concatLists;
in
  {
    # Please note, this fucked up function was inspired by notashelf/nyx,
    # especially the module importing function.
    # Basically, to minimize the re-use of code, I created a custom function
    # calling for all the special details I would need per host.
    # Mainly, it's useful with my flake-parts system to reduce the clutter
    # induced by "withSystem," but the module importing function especially
    # is unique, which imports only the modules needed for the profiles and desktops declared
    inputs,
    withSystem,
    system,
    hostName,
    moduleDir,
    hostDir,
    desktops ? [],
    profiles ? [],
    extraImports ? [],
  }:
    withSystem system ({
      self',
      config,
      inputs',
      ...
    }:
      nixosSystem {
        specialArgs = {
          inherit lib inputs;
          inherit self' inputs';
          inherit (config._module.args) theme lunixpkgs;
        };
        modules = flatten (
          concatLists [
            # singleton just makes a list with one element
            (singleton {
              # Declare the hostName c:
              networking.hostName = hostName;

              nixpkgs = {
                hostPlatform = mkDefault system;
              };
            })

            # Import desktop and profile config modules
            (map (n: (moduleDir + /desktops + /${n} + /module.nix)) desktops)
            (map (n: (moduleDir + /profiles + /${n} + /module.nix)) profiles)

            # All hosts import the common modules
            (listNixRecursive (moduleDir + /common))

            # Import host modules
            (listNixRecursive (hostDir + /${hostName}))

            # Additional modules for importation can be declared as well.
            # This is usually system specific stuff.
            extraImports
          ]
        );
      })
