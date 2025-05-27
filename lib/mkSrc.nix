{ inputs }:
{
  root,
  extraInclude ? [ ],
  extraExclude ? [ ],
}:
let
  matchPrefix =
    prefix: _: path: _:
    inputs.nix-filter.lib._hasPrefix prefix (builtins.baseNameOf path);
in
inputs.nix-filter {
  inherit root;

  include = [
    "app"
    "public"
    "src"

    "package.json"
    "package-lock.json"

    (matchPrefix "next.config.")
    (matchPrefix "postcss.config.")
    (matchPrefix "tailwind.config.")
    "tsconfig.json"
  ] ++ extraInclude;

  exclude = extraExclude;
}
