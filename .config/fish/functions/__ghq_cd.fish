function __ghq_cd
    set -l repo (ghq list -p | fzf)
    if test -n "$repo"
        cd $repo
        eza -lah
    end
    commandline -f repaint
end
