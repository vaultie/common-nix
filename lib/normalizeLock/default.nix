{
  buildPlatform,
  callPackage,
  emptyFile,
  lib,
}:
{
  packageLock,
}:
let
  inherit (lib)
    any
    flatten
    hasAttr
    listToAttrs
    nameValuePair
    remove
    ;

  binaryPackages = [
    "swc"
    "libvips"
    "sharp"
    "oxide"
    "lightningcss"
  ];

  infos = map (p: callPackage ./${p}.nix { }) binaryPackages;

  minimizePackage =
    package:
    let
      selectedNodePackage = package.supportedSystems.${buildPlatform.system} or null;
    in
    if (selectedNodePackage != null) then remove selectedNodePackage package.all else package.all;

  minimizedPackages = flatten (map minimizePackage infos);
in
{
  packageSourceOverrides = listToAttrs (
    map (p: nameValuePair "node_modules/${p}" emptyFile) minimizedPackages
  );
}
