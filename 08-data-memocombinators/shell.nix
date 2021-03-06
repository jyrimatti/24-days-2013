{ nixpkgs ? import <nixpkgs> {}, compiler ? "default" }:

with import <nixpkgs/pkgs/development/haskell-modules/lib.nix> { pkgs = nixpkgs; };

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, base, data-memocombinators, monad-memo, timeit
      , stdenv
      }:
      mkDerivation {
        pname = "x08-data-memocombinators";
        version = "0.1.0.0";
        src = ./.;
        isLibrary = false;
        isExecutable = true;
        executableHaskellDepends = [
          # testit rikki joten skipataan ne
          base data-memocombinators (dontCheck monad-memo) timeit
        ];
        license = stdenv.lib.licenses.mit;
      };

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  drv = haskellPackages.callPackage f {};

in

  if pkgs.lib.inNixShell then drv.env else drv
