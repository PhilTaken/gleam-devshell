{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";

    gleam.url = "github:gleam-lang/gleam/v1.1.0";
    gleam.flake = false;

    nci.url = "github:yusdacra/nix-cargo-integration";
    nci.inputs.nixpkgs.follows = "nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ {
    self,
    gleam,
    nixpkgs,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [inputs.nci.flakeModule];
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin"];

      perSystem = {
        config,
        pkgs,
        ...
      }: {
        nci = {
          toolchainConfig = ./rust-toolchain.toml;
          projects."gleam" = {
            path = inputs.gleam;
            export = true;
          };
        };

        devShells.default = config.nci.outputs."gleam".devShell.overrideAttrs (old: {
          packages =
            (old.packages or [])
            ++ [
              pkgs.cargo-bloat
              pkgs.cargo-audit
              pkgs.erlang_26
              pkgs.rebar3
              pkgs.nodejs
              pkgs.deno
              pkgs.elixir
            ];
        });
      };
    };
}
