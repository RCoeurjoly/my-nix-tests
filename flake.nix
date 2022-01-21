{
  description = "Poetry shell with cmake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/de287abdd11c3c20af0877a729ed1d2b8f311e26";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      myPoetryEnv = pkgs.poetry2nix.mkPoetryEnv {
        projectDir = ./.;
        pyproject = ./pyproject.toml;
        poetrylock = ./poetry.lock;
      };

    in {
      devShell.x86_64-linux = myPoetryEnv.env.overrideAttrs (oldAttrs: {
        buildInputs = with pkgs; [ hello ];
      });
    };
}
