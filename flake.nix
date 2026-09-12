{
  description = "Effekt re-JIT";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    effekt-nix = {
      url = "github:jiribenes/effekt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, effekt-nix }:
    let
      ## Builds only for AArch64.
      systems = ["aarch64-linux" "aarch64-darwin"];

      forAllSystems = nixpkgs.lib.genAttrs systems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });

      ## Project configuration
      pname = "effekt-rejit";        # package name
      version = "0.1.0";             # package version
      mainFile = "rejit.effekt";     # relative path to entrypoint (as a string)
      testFiles = [ "test.effekt" ]; # relative paths to tests (as a string)

      ## Effekt configuration
      effektConfig = {
        ## Uncomment and set a specific version if needed:
        # version = "0.10.0";

        ## Select the backends that your project works on:
        backends = bs: [ bs.llvm ];
      };
    in {
      packages = forAllSystems (system:
        let
          effekt-lib = effekt-nix.lib.mkLib nixpkgsFor.${system};

          # Chooses the correct Effekt package.
          effektBuild = effekt-lib.getEffekt effektConfig;
        in {
          default = (effekt-lib.buildEffektPackage {
            inherit pname version;
            src = ./.;
            main = mainFile;
            tests = testFiles;

            effekt = effektBuild;
            inherit (effektConfig) backends;
          }).overrideAttrs (final: old: {
            buildPhase = ''
              make jitlib.ll
              ${old.buildPhase or ""}
            '';
          });
        }
      );

      devShells = forAllSystems (system:
        let
          effekt-lib = effekt-nix.lib.mkLib nixpkgsFor.${system};

          # Chooses the correct Effekt package.
          effektBuild = effekt-lib.getEffekt effektConfig;
        in {
          default = effekt-lib.mkDevShell {
            effekt = effektBuild;
            inherit (effektConfig) backends;
          };
        }
      );
    };
}
