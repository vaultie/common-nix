_: {
  all = [
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
}
