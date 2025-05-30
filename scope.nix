{
  buildPlatform,
  inputs,
  lib,
  newScope,
}:
lib.makeScope newScope (self: {
  inherit inputs;

  nix2container = inputs.nix2container.packages.${buildPlatform.system}.nix2container;

  mkSrc = self.callPackage ./lib/mkSrc.nix { };
  buildDockerImage = self.callPackage ./lib/buildDockerImage.nix { };
  buildNextJsPackage = self.callPackage ./lib/buildNextJsPackage.nix { };
  normalizeLock = self.callPackage ./lib/normalizeLock { };

  postInstall = self.callPackage ./packages/postInstall.nix { };

  test-nextjs-basic = self.callPackage ./tests/nextjs-basic.nix { };
})
