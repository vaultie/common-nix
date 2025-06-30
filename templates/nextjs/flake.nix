{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    common-nix = {
      url = "github:vaultie/common-nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
  };

  outputs =
    {
      nixpkgs,
      common-nix,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        commonLib = common-nix.lib.${system};

        src = commonLib.mkSrc {
          root = ./.;
        };

        default = commonLib.buildNextJsPackage {
          inherit src;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [ pkgs.nodejs ];
        };

        packages = {
          # Passthrough postInstall for easier usage.
          inherit (common-nix.packages.${system}) postInstall;

          inherit default;

          docker = commonLib.buildDockerImage {
            package = default;
          };
        };

        formatter = pkgs.nixfmt-tree;
      }
    );
}
