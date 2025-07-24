{
  lib,
  pkgs,
  ...
}: let
  inherit (builtins) concatStringsSep;
  inherit (lib.attrsets) mapAttrsToList getBin;
  inherit (lib.strings) getName getVersion makeBinPath escapeShellArgs;
  inherit (lib.trivial) pipe;

  wrapPackage = package: {
    args ? [],
    env ? {},
    extraPackages ? [],
  }: let
    pname = getName package;
    ver = getVersion package;

    envArgs = pipe env [
      (mapAttrsToList (n: v: "${n}=${v}"))
      (concatStringsSep " ")
    ];
  in
    pkgs.symlinkJoin {
      name = concatStringsSep "-" [pname "wrapped" ver];
      paths = [package];
      preferLocalBuild = true;
      nativeBuildInputs = [pkgs.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/${pname} \
          ${map (n: "--add-flag" n) args} \
          --add-flags ${escapeShellArgs args} \
          --set ${envArgs} \
          --prefix PATH : ${makeBinPath extraPackages}
      '';
    };
in
  wrapPackage
