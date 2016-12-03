#!/bin/sh
export NIX_PATH=nixpkgs=https://github.com/NixOS/nixpkgs/archive/d5fd65df4e84b2d06606c70a5e7ee39daf1ddc73.tar.gz

nix-shell -p cabal2nix --command 'cabal2nix --shell . > shell.nix'
nix-shell -p bashInteractive --command "nix-shell --command 'nix-shell -p bashInteractive -p cabal-install -p haskellPackages.stylish-haskell -p haskellPackages.hdevtools -p haskellPackages.hsdev -p haskellPackages.ghc-mod -p haskellPackages.hoogle -p haskellPackages.hasktags -p haskellPackages.pointfree -p ctags -p haskellPackages.scan -p haskellPackages.hdocs'"
