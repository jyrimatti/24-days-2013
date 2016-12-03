{ nixpkgs ? import <nixpkgs> {}, compiler ? "default" }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, base, stdenv, tasty, tasty-ant-xml
      , tasty-golden, tasty-hspec, tasty-hunit, tasty-program
      , tasty-quickcheck, tasty-smallcheck, tasty-th
      }:
      mkDerivation {
        pname = "x03-tasty";
        version = "0.1.0.0";
        src = ./.;
        isLibrary = false;
        isExecutable = true;
        executableHaskellDepends = [
          base tasty tasty-ant-xml tasty-golden tasty-hspec tasty-hunit
          tasty-program tasty-quickcheck tasty-smallcheck tasty-th
        ];
        license = stdenv.lib.licenses.mit;
      };

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  drv = haskellPackages.callPackage f {};

in

  if pkgs.lib.inNixShell then drv.env else drv
