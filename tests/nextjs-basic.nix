{
  applyPatches,
  buildDockerImage,
  buildNextJsPackage,
  fetchFromGitHub,
  mkSrc,
}: let
  src = fetchFromGitHub {
    owner = "vercel";
    repo = "vercel";
    rev = "da235a22fe391fbce5c18f2972ef7a15361fc219";
    hash = "sha256-p08zxWjeftrsaYS2mkM3ZzEVsbVanHrvgY9Eh+c9W9Y=";
  };

  patchedTemplate = applyPatches {
    inherit src;

    patches = [
      ./0001-remove-remote-fonts.patch
      ./0002-standalone-build.patch
    ];
  };

  package = buildNextJsPackage {
    src = mkSrc {
      root = "${patchedTemplate}/examples/nextjs";
    };
  };
in
  buildDockerImage {
    inherit package;
  }
