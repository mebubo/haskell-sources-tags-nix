{ cabalProject,
  pkgs ? import <nixpkgs> {},
  haskellPackages ? pkgs.haskellPackages
}:

let

  package = haskellPackages.callCabal2nix "" cabalProject {};

  packages = (pkgs.haskell.lib.getBuildInputs package).haskellBuildInputs;

in

  pkgs.callPackage ./tag-sources.nix {
    inherit haskellPackages packages;
  }
