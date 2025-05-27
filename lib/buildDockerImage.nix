{
  dockerTools,
  lib,
  nix2container,
  nodejs-slim,
}:
{
  package,
  nodejs ? nodejs-slim,
}@args:
let
  filteredArgs = builtins.removeAttrs args [
    "nodejs"
    "package"
  ];
in
nix2container.buildImage (
  lib.recursiveUpdate {
    name = package.pname;
    tag = "latest";
    maxLayers = 122;

    copyToRoot = [ dockerTools.caCertificates ];

    config.Entrypoint = [
      (lib.getExe nodejs)
      "${package}/server.js"
    ];
  } filteredArgs
)
