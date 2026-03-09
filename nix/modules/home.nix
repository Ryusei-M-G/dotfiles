{ pkgs, ... }: {
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    eza
    fzf
    ghq
    git
    gh
    ripgrep
    bat
    btop
    starship
    tmux
  ];

  xdg.configFile = {
    "fish/config.fish".source = ../../.config/fish/config.fish;
    "fish/functions/__ghq_cd.fish".source = ../../.config/fish/functions/__ghq_cd.fish;
    "starship.toml".source = ../../.config/starship.toml;
    "git/config".source = ../../.config/git/config;
    "git/ignore".source = ../../.config/git/ignore;
    "gh/config.yml".source = ../../.config/gh/config.yml;
    "btop/btop.conf".source = ../../.config/btop/btop.conf;
    "tmux/tmux.conf".source = ../../.config/tmux/tmux.conf;
    "nvim" = {
      source = ../../.config/nvim;
      recursive = true;
    };
  };
}
