_: {
  all = [
    "lightningcss-darwin-arm64"
    "lightningcss-darwin-x64"
    "lightningcss-freebsd-x64"
    "lightningcss-linux-arm-gnueabihf"
    "lightningcss-linux-arm64-gnu"
    "lightningcss-linux-arm64-musl"
    "lightningcss-linux-x64-gnu"
    "lightningcss-linux-x64-musl"
    "lightningcss-win32-arm64-msvc"
    "lightningcss-win32-x64-msvc"
  ];

  supportedSystems = {
    "aarch64-darwin" = "lightningcss-darwin-arm64";
    "x86_64-darwin" = "lightningcss-darwin-x64";
    "aarch64-linux" = "lightningcss-linux-arm64-gnu";
    "x86_64-linux" = "lightningcss-linux-x64-gnu";
  };
}
