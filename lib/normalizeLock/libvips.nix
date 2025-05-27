_: {
  all = [
    "@img/sharp-libvips-darwin-arm64"
    "@img/sharp-libvips-darwin-x64"
    "@img/sharp-libvips-linux-arm"
    "@img/sharp-libvips-linux-arm64"
    "@img/sharp-libvips-linux-ppc64"
    "@img/sharp-libvips-linux-s390x"
    "@img/sharp-libvips-linux-x64"
    "@img/sharp-libvips-linuxmusl-arm64"
    "@img/sharp-libvips-linuxmusl-x64"
  ];

  supportedSystems = {
    "aarch64-darwin" = "@img/sharp-libvips-darwin-arm64";
    "x86_64-darwin" = "@img/sharp-libvips-darwin-x64";
    "aarch64-linux" = "@img/sharp-libvips-linux-arm64";
    "x86_64-linux" = "@img/sharp-libvips-linux-x64";
  };
}
