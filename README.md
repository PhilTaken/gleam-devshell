# Gleam flake

This is a dev-shell that provides all required packages for working on the gleam language (https://github.com/gleam-lang/gleam).
It is somewhat inspired by https://github.com/vic/gleam-nix but easier to use since it doesnt require keeping a Cargo.nix up-to-date.

## Example use case

When in your local checkout of the gleam language (with [nix-direnv](https://github.com/nix-community/nix-direnv) installed and set-up for your shell)
paste this into a file called `.envrc`:

```sh
use flake github:philtaken/gleam-devshell --override-input gleam path:$PWD
```

Then enter `direnv allow` and wait while nix configures your devshell.
