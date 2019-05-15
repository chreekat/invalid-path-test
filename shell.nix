let
  pkgs = import (builtins.fetchGit {
    url = "https://github.com/NixOS/nixpkgs";
    ref  = "release-19.03";
    name = "nixos-19.03";
  }) {};
in
  pkgs.mkShell {
    helloPath = "${pkgs.hello}";
    buildInputs = [
        pkgs.vagrant
    ];
  }
