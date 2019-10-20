{ lib, stdenv, pkgs, haskellPackages, packages }:

let

  allDeps = [ haskellPackages.ghc ] ++ (pkgs.lib.closePropagation packages);

  fast-tags = haskellPackages.fast-tags;
in

  stdenv.mkDerivation {

    name = "haskell-sources-tags";

    passAsFile = ["buildCommand"];

    buildCommand = ''
      mkdir -p $out

      function unpackOrLink {
      local path=$1
      local name=$2
      if [[ -f "$path" ]]; then
        ${pkgs.gnutar}/bin/tar -C $out -xf $path
      else
        ln -sfn $path $out/$name
      fi
      }

      ${lib.concatMapStringsSep "\n" (el: "unpackOrLink ${el.src} ${el.name}") (lib.filter (el: el ? src) allDeps)}

      echo building tags

      ( cd $out; ${fast-tags}/bin/fast-tags --follow-symlinks -R . )
    '';

  }
