{
  writeShellApplication,
  writeText,
}: let
  nixGitIgnore = writeText "nix-gitignore" ''
    # Nix
    /.direnv
    /result
  '';
in
  writeShellApplication {
    name = "common-nix-postinstall";

    text = ''
      if [ -w ".gitignore" ]; then
        cat ${nixGitIgnore} >> .gitignore
      fi
    '';
  }
