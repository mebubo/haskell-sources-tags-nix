{ pkgs ? import <nixpkgs> {} }:

  pkgs.writeShellScriptBin "cabal-sources-tags" ''
    nix-build --out-link dependencies --arg cabalProject ./. ${./.}
    nix-shell -p haskellPackages.fast-tags --run "fast-tags -R ."
  ''
