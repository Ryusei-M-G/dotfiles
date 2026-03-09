{ pkgs, ... }: {
  nix.enable = false;
  nixpkgs.config.allowUnfree = true;

  system.defaults = {
    dock.autohide = true;
    finder.AppleShowAllExtensions = true;
  };

  environment.systemPackages = with pkgs; [
    git
  ];

  system.stateVersion = 6;
}
