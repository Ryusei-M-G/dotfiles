fish_add_path /usr/local/bin /usr/bin /bin /usr/sbin /sbin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/bin

set -gx NVM_DIR $HOME/.nvm

if not status is-interactive
    return
end

abbr -a ll 'eza -lah'
abbr -a la 'eza -A'
abbr -a l 'eza -CF'
abbr -a grep 'rg'
abbr -a cl 'claude'
abbr -a cld 'claude --dangerously-skip-permissions'
abbr -a g 'git'
abbr -a gaa 'git add -A'
abbr -a gcm 'git commit -m'
abbr -a gp 'git push'
abbr -a gl 'git pull'

bind \cg __ghq_cd

starship init fish | source
