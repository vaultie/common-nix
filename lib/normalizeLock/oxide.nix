_: {
  all = [
    "@tailwindcss/oxide-android-arm64"
    "@tailwindcss/oxide-darwin-arm64"
    "@tailwindcss/oxide-darwin-x64"
    "@tailwindcss/oxide-freebsd-x64"
    "@tailwindcss/oxide-linux-arm-gnueabihf"
    "@tailwindcss/oxide-linux-arm64-gnu"
    "@tailwindcss/oxide-linux-arm64-musl"
    "@tailwindcss/oxide-linux-x64-gnu"
    "@tailwindcss/oxide-linux-x64-musl"
    "@tailwindcss/oxide-wasm32-wasi"
    "@tailwindcss/oxide-win32-arm64-msvc"
    "@tailwindcss/oxide-win32-x64-msvc"
  ];

  supportedSystems = {
    "aarch64-darwin" = "@tailwindcss/oxide-darwin-arm64";
    "x86_64-darwin" = "@tailwindcss/oxide-darwin-x64";
    "aarch64-linux" = "@tailwindcss/oxide-linux-arm64-gnu";
    "x86_64-linux" = "@tailwindcss/oxide-linux-x64-gnu";
  };
}
