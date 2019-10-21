# haskell-sources-tags-nix

Get the sources for all transitive dependencies of a set of haskell packages, and generate a `tags` file.

## Example usage

### From a command line

Tags for all dependencies of a cabal project:

```bash
nix-build --arg cabalProject ./. path/to/haskell-sources-tags-nix/
```

### From nix

Tags for a given set of packages:

```nix
let
  config = {
    packageOverrides = pkgs: rec {
      haskellPackages = pkgs.haskell.packages.ghc865.override {
        overrides = haskellPackagesNew: haskellPackagesOld: {
          my-custom-library = haskellPackagesOld.callCabal2nix "my-custom-library" ../my-custom-ibrary {};
        };
      };
    };
  };
  pkgs = import <nixpkgs> { inherit config; };
  haskellPackages = pkgs.haskellPackages;

in
  pkgs.callPackage ../haskell-sources-tags-nix/tag-sources.nix {
    inherit pkgs haskellPackages;
    packages = (with haskellPackages; [ turtle lens my-custom-library ]);
  }

```

## Vim configuration

```
set tags+=result/tags
```

## Similar projects

- https://github.com/aloiscochard/codex

Advantages of this project compared to codex:

- Simplicity: all the heavy lifting is done by Nix
- Not limited to downloading sources from Hackage: correct sources are used even if a dependency is modified locally (like `my-custom-library` in the example above)

Disadvantages compared to codex:

- Requires Nix
