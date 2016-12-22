#!/bin/sh
fay src/Client.hs -o Client.js --base-path $(dirname /nix/store/*fay-base-0.20.0.1/share/*/fay-base-*/src)
