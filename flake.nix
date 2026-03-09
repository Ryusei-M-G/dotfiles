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
    username = "Ryusei-M-G";
    linuxUser = "yuuseiorishima";
  in {
    # macOS: sudo nix run nix-darwin -- switch --flake .#Ryusei-M-G
    darwinConfigurations.${username} = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./nix/modules/darwin.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ./nix/modules/home.nix;
        }
      ];
    };

    # Linux/WSL: nix run .#switch
    homeConfigurations.${linuxUser} = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        ./nix/modules/home.nix
        {
          home.username = linuxUser;
          home.homeDirectory = "/home/${linuxUser}";
        }
      ];
    };

    packages.x86_64-linux.switch = let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      hm = home-manager.packages.x86_64-linux.home-manager;
      nix = pkgs.nix;
    in pkgs.writeShellScriptBin "switch" ''
      export PATH="${nix}/bin:$PATH"
      exec ${hm}/bin/home-manager switch -b backup --flake "path:$(pwd)#${linuxUser}" "$@"
    '';
  };
}
