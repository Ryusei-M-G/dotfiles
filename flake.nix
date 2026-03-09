{
  description = "Ryusei-M-G dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nix-darwin, ... }: let
    mkHome = { system, username }: home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [
        ./nix/modules/home.nix
        {
          home.username = username;
          home.homeDirectory = "/home/${username}";
        }
      ];
    };

    mkDarwin = { username, system ? "aarch64-darwin" }: nix-darwin.lib.darwinSystem {
      inherit system;
      modules = [
        ./nix/modules/darwin.nix
        home-manager.darwinModules.home-manager
        {
          system.primaryUser = username;
          users.users.${username}.home = "/Users/${username}";
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users.${username} = import ./nix/modules/home.nix;
        }
      ];
    };
  in {
    # macOS: sudo nix --impure run nix-darwin -- switch --flake .#default
    darwinConfigurations.default = mkDarwin { username = builtins.getEnv "SUDO_USER"; };

    # Linux/WSL: nix run .#switch
    # Add your username here:
    homeConfigurations.klran = mkHome { system = "x86_64-linux"; username = "klran"; };

    packages.x86_64-linux.switch = let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      hm = home-manager.packages.x86_64-linux.home-manager;
      nix = pkgs.nix;
    in pkgs.writeShellScriptBin "switch" ''
      export PATH="${nix}/bin:$PATH"
      exec ${hm}/bin/home-manager switch -b backup --flake "path:$(pwd)#$USER" "$@"
    '';
  };
}
