{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
        golings = pkgs.buildGoModule {
          pname = "golings";
          version = "0.0.0-dev";
          src = ./.;
          subPackages = [ "golings" ];
          vendorHash = "sha256-l7DjKhUNJumHpRiA0fMlNC2B1oqG7LoIv5hjJwA4O88=";
        };
      in
      {
        packages.default = golings;
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            go
            golings
          ];
        };
      }
    );
}
