#!/bin/sh

nix-shell -p cabal2nix --command 'cabal2nix --shell . > shell.nix'
nix-shell -p bashInteractive cabal-install -p haskellPackages.stylish-haskell -p haskellPackages.hdevtools -p haskellPackages.ghc-mod -p haskellPackages.hoogle -p haskellPackages.hasktags -p haskellPackages.apply-refact -p haskellPackages.pointfree -p ctags -p haskellPackages.scan --command 'nix-shell'
