{ pkgs ? import <nixpkgs> {} }:

let

  this = ./.;

in

  pkgs.writeShellScriptBin "haskell-project-tags" ''
    nix-build --out-link dependencies --arg cabalProject ./. ${this}
    nix-shell -p haskellPackages.fast-tags --run "fast-tags -R ."
  ''
