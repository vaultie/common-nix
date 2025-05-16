{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix2container = {
      url = "github:nlewo/nix2container";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
    nix-filter.url = "github:numtide/nix-filter";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };

        scope = pkgs.callPackage ./scope.nix {
          inherit inputs;
        };
      in {
        lib = {
          inherit
            (scope)
            buildDockerImage
            buildNextJsPackage
            mkSrc
            ;
        };

        packages = {
          inherit (scope) postInstall;
        };

        checks = {
          inherit (scope) test-nextjs-basic;
        };

        formatter = pkgs.alejandra;
      }
    )
    // {
      templates.nextjs = {
        path = ./templates/nextjs;
        description = "Next.js skeleton template";
        welcomeText = ''
          # Nix Next.js skeleton template

          ## Next steps

          Please run the following command:

          ```sh
          nix run .#postInstall
          ```
        '';
      };
    };
}
