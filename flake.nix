{
  description = "Lunar's (Nix) Library";

  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

  outputs = {nixpkgs, ...}: import ./. nixpkgs.lib;
}
