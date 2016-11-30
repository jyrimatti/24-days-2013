#!/bin/sh

nix-shell -p cabal2nix --command 'cabal2nix --shell . > shell.nix'
nix-shell -p bashInteractive cabal-install --command 'nix-shell'
