{
  description = "Lunar's (Nix) Library";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = {nixpkgs, ...}:
    import ./. {
      inherit (nixpkgs) lib;
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
    };
}
