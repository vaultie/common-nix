{
  emptyFile,
  lib,
  stdenvNoCC,
}:
{
  packageLock,
  minimizeSwc,
  removeSharpBinaries,
}:
let
  inherit (lib)
    listToAttrs
    nameValuePair
    optionalAttrs
    optionals
    remove
    ;

  swcBinaries = [
    "@next/swc-darwin-arm64"
    "@next/swc-darwin-x64"
    "@next/swc-linux-arm64-gnu"
    "@next/swc-linux-arm64-musl"
    "@next/swc-linux-x64-gnu"
    "@next/swc-linux-x64-musl"
    "@next/swc-win32-arm64-msvc"
    "@next/swc-win32-x64-msvc"
  ];

  supportedSystems = {
    "aarch64-darwin" = "@next/swc-darwin-arm64";
    "x86_64-darwin" = "@next/swc-darwin-x64";
    "aarch64-linux" = "@next/swc-linux-arm64-gnu";
    "x86_64-linux" = "@next/swc-linux-x64-gnu";
  };

  selectedSwc = supportedSystems.${stdenvNoCC.buildPlatform.system} or null;

  minimizedSwcBinaries =
    if (selectedSwc != null) then remove selectedSwc swcBinaries else swcBinaries;

  sharpBinaries = [
    "@img/sharp-darwin-arm64"
    "@img/sharp-darwin-x64"
    "@img/sharp-libvips-darwin-arm64"
    "@img/sharp-libvips-darwin-x64"
    "@img/sharp-libvips-linux-arm"
    "@img/sharp-libvips-linux-arm64"
    "@img/sharp-libvips-linux-s390x"
    "@img/sharp-libvips-linux-x64"
    "@img/sharp-libvips-linuxmusl-arm64"
    "@img/sharp-libvips-linuxmusl-x64"
    "@img/sharp-linux-arm"
    "@img/sharp-linux-arm64"
    "@img/sharp-linux-s390x"
    "@img/sharp-linux-x64"
    "@img/sharp-linuxmusl-arm64"
    "@img/sharp-linuxmusl-x64"
    "@img/sharp-wasm32"
    "@img/sharp-win32-ia32"
    "@img/sharp-win32-x64"
  ];

  droppedDependencies =
    optionals minimizeSwc minimizedSwcBinaries
    ++ optionals removeSharpBinaries sharpBinaries;
in
{
  packageSourceOverrides = listToAttrs (
    map (p: nameValuePair "node_modules/${p}" emptyFile) droppedDependencies
  );
}
