# dotfiles

Personal dotfiles managed with [Nix](https://nixos.org/) + [Home Manager](https://github.com/nix-community/home-manager) / [nix-darwin](https://github.com/LnL7/nix-darwin).

## What's included

- Fish shell (abbreviations, ghq+fzf integration)
- Starship prompt
- Git (ghq, credential helper)
- tmux
- Neovim (LazyVim)
- GitHub CLI
- btop

## Setup

### 1. Install Nix

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh
```

### 2. Clone

```bash
git clone https://github.com/Ryusei-M-G/dotfiles.git ~/dev/github/Ryusei-M-G/dotfiles
cd ~/dev/github/Ryusei-M-G/dotfiles
```

### 3. Apply

**Linux / WSL:**

```bash
nix run .#switch
```

**macOS:**

```bash
sudo nix run nix-darwin -- switch --flake .#Ryusei-M-G
```
