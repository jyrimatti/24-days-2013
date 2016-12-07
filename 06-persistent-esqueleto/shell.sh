#!/bin/sh
export NIX_PATH=nixpkgs=https://github.com/NixOS/nixpkgs/archive/e5d40c6fa3cf11b7e06e6fe09ab0dc249ab436d2.tar.gz

nix-shell -p cabal2nix --command 'cabal2nix --shell . > shell.nix'
nix-shell -p bashInteractive --command "nix-shell --command 'nix-shell -p bashInteractive -p cabal-install -p haskellPackages.stylish-haskell -p haskellPackages.hdevtools -p haskellPackages.hsdev -p haskellPackages.ghc-mod -p haskellPackages.hoogle -p haskellPackages.hasktags -p haskellPackages.pointfree -p ctags -p haskellPackages.scan -p haskellPackages.hdocs'"
