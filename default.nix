{ cabalProject,
  pkgs ? import <nixpkgs> {},
  haskellPackages ? pkgs.haskellPackages
}:

let

  package = hp: hp.callCabal2nix "" cabalProject {};
  packages = hp: (pkgs.haskell.lib.getBuildInputs (package hp)).haskellBuildInputs;

in

  pkgs.callPackage ./tag-sources.nix {
    inherit haskellPackages packages;
  }
