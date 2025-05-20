{
  cairo,
  buildNpmPackage,
  importNpmLock,
  lib,
  normalizeLock,
  pango,
  pkg-config,
  pixman,
}: {
  src,
  distDir ? ".next",
  useImportNpmLock ? true,
  packageOverrides ? {},

  # QoL configuration flags
  minimizeSwc ? true,
  removeSharpBinaries ? true
} @ args: let
  inherit
    (builtins)
    fromJSON
    pathExists
    readFile
    removeAttrs
    ;

  inherit (lib) optionalAttrs;

  filteredArgs = removeAttrs args [
    "distDir"
    "packageJson"
    "packageLock"
    "useImportNpmLock"
    "minimizeSwc"
    "removeSharpBinaries"
    "packageOverrides"
  ];

  parseJSONFile = arg: name: let
    missingFile = file:
      throw ''
        Unable to find the `${file}` file.
      '';

    path = args.${arg} or "${src}/${name}";

    fileContents =
      if pathExists path
      then readFile path
      else missingFile name;
  in
    fromJSON fileContents;

  parsedPackageJson = parseJSONFile "packageJson" "package.json";
  parsedPackageLock = parseJSONFile "packageLock" "package-lock.json";

  normalizedLock = normalizeLock {
    inherit minimizeSwc removeSharpBinaries;
    packageLock = parsedPackageLock;
  };

  packageSourceOverrides = normalizedLock.packageSourceOverrides // packageOverrides;

  importNpmLockArgs = optionalAttrs useImportNpmLock {
    inherit (importNpmLock) npmConfigHook;

    npmDeps = importNpmLock {
      inherit packageSourceOverrides;

      npmRoot = src;
    };
  };
in
  buildNpmPackage (
    importNpmLockArgs
    // {
      pname = args.pname or parsedPackageJson.name;
      version = args.version or parsedPackageJson.version;

      # NextJS attempts to install some random binaries during the build stage
      # if this is missing.
      NEXT_IGNORE_INCORRECT_LOCKFILE = true;
      NEXT_TELEMETRY_DISABLED = true;

      # .env is not available during the build process.
      SKIP_ENV_VALIDATION = true;

      buildInputs = [
        cairo
        pango
        pixman
      ];

      nativeBuildInputs = [pkg-config];

      installPhase =
        args.installPhase or ''
          runHook preInstall

          if [ -d "${distDir}/standalone" ]; then
            echo "Found standalone output"

            mkdir $out

            shopt -s dotglob
            mv ${distDir}/standalone/* $out
            mv ${distDir}/static $out/${distDir}
            mv public $out
          else
            echo "Standalone output not found"
            exit 1
          fi

          runHook postInstall
        '';
    }
    // filteredArgs
  )
