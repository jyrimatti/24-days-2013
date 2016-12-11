{ nixpkgs ? import <nixpkgs> {}, compiler ? "default" }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, base, esqueleto, monad-logger, persistent
      , persistent-sqlite, persistent-template, stdenv, text, time
      , transformers
      }:
      mkDerivation {
        pname = "x06-persistent-esqueleto";
        version = "0.1.0.0";
        src = ./.;
        isLibrary = false;
        isExecutable = true;
        executableHaskellDepends = [
          base esqueleto monad-logger persistent persistent-sqlite
          persistent-template text time transformers
        ];
        license = stdenv.lib.licenses.mit;
      };

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  drv = haskellPackages.callPackage f {};

in

  if pkgs.lib.inNixShell then drv.env else drv
