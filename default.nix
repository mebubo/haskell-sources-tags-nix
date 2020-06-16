{ cabalProject,
  pkgs ? import <nixpkgs> {},
  haskellPackages ? pkgs.haskellPackages
}:

let

  package = haskellPackages: haskellPackages.callCabal2nix "" cabalProject {};

  packages = haskellPackages: (pkgs.haskell.lib.getBuildInputs (package haskellPackages)).haskellBuildInputs;

in

  pkgs.callPackage ./tag-sources.nix {
    inherit haskellPackages packages;
  }
