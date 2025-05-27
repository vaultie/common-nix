_: {
  all = [
    "@img/sharp-darwin-arm64"
    "@img/sharp-darwin-x64"
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

  supportedSystems = {
    "aarch64-darwin" = "@img/sharp-darwin-arm64";
    "x86_64-darwin" = "@img/sharp-darwin-x64";
    "aarch64-linux" = "@img/sharp-linux-arm64";
    "x86_64-linux" = "@img/sharp-linux-x64";
  };
}
