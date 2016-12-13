{ nixpkgs ? import <nixpkgs> {}, compiler ? "default" }:

with import <nixpkgs/pkgs/development/haskell-modules/lib.nix> { pkgs = nixpkgs; };

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, base, blaze-builder, bytestring, either
      , heist, stdenv, transformers, xmlhtml, lens, map-syntax
      }:
      mkDerivation {
        pname = "x11-heist";
        version = "0.1.0.0";
        src = ./.;
        isLibrary = false;
        isExecutable = true;
        executableHaskellDepends = [
          base blaze-builder bytestring either (dontCheck heist) transformers xmlhtml lens map-syntax
        ];
        license = stdenv.lib.licenses.mit;
      };

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  drv = haskellPackages.callPackage f {};

in

  if pkgs.lib.inNixShell then drv.env else drv
