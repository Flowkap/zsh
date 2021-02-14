# Requires powerlevel 10k + oh-my-zsh

###############################################################################
# PATH etc.
###############################################################################

function git_recursive() {
    # Update all git directories below current directory or specified directory
    # Skips directories that contain a file called .ignore
    #
    # Originally: https://stackoverflow.com/questions/11981716/how-to-quickly-find-all-git-repos-under-a-directory

    HIGHLIGHT="\e[01;34m"
    NORMAL='\e[00m'

    OPERATION=status
    if [ "$1" != "" ]; then OPERATION=$@ > /dev/null; fi

    function update {
    local d="$1"
    if [ -d "$d" ]; then
        if [ -e "$d/.ignore" ]; then
            echo -e "\n${HIGHLIGHT}Ignoring $d${NORMAL}"
        else
        cd $d > /dev/null
        if [ -d ".git" ]; then
            echo -e "\n${HIGHLIGHT}Updating `pwd`$NORMAL"
            # echo $operation
            git $OPERATION
        else
            scan * || true
        fi
        cd .. > /dev/null
        fi
    fi
    }

    function scan () {
        for x in $*; do
            update "$x" operation=$operation
        done
    }

    echo -e "${HIGHLIGHT}Scanning ${PWD}${NORMAL}"
    scan *
}

###############################################################################
# custom extensions
###############################################################################

# Dock Settings
# defaults write com.apple.Dock autohide-delay -float 0; defaults write com.apple.dock autohide-time-modifier -float 0.5; killall Dock

#History bash_history 10Million
HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000

PROMPT_COMMAND='echo -en "\033]0; $("pwd") \a"'

# Standard stuff
alias ll='ls -ls'
alias la='ls -la'
alias uuid='cat /proc/sys/kernel/random/uuid'

# make search up and down work, so partially type and hit up/down to find relevant stuff
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# Git stuff
alias git='hub'
alias gitr='git_recursive'
alias push='git push'
alias pull='git pull'
git config --global alias.open '!f() { chromium $(cat .git/config | grep url | sed -r "s/.+url =//g" | sed -r "s/git@(.*):/http:\/\/\1\//g"); }; f'
git config --global alias.co 'checkout'

# FUN
alias csn='echo H4sIAG9GYVsAA51Yba7sIAj9P6swMRJiDGzB/a/qAmprp0o7l+S9O231HMAjfnw+n0/4txEDQAKUX/KE5X9QBWq3GEJqvyCXnH+Ho1RnC6GjIQXCWn9GvMKpcacQVxWx1t8gb3hmidoHZkgo6ZBs/uTqGlW9bOEzSYpTDKUyAr9Hvod/AUfo8JrpLA/4GtoFNvAuChQnsvkBL8EpAHjI3VpsJeX+8x16KZGqjNILgu5/b0rv8HPNMvop1McQ4Pib3utQswoIRSN/l6Ck0smio1eyiXj4Fh3oUmMMFXMjMKL4LkXEU2oX2TiMITDcgnzBMBHMo3wPJ6ZUSZR/5XhRA7OTmW8OrQWl4pXjkaJ86/PynLIMVBRoS5rUbS3eBZGYSumTPj1x0CoKjCmeky/hMr1AIwVPHGk7zdTlYkMic/FoLk+IHAqryuVffCAovMJOgWowbQm/KVleGN7sWg1Q1YEn0S6ngQyAJOeiWV0BbP2ilkhjlih7ifVZyqpaaF4UIVi6Tdck7rCwxFwUH4qIIGuD3v+BZRWKfjgSQ2hZSg00ckBRBBJw+zwGz6fBBYvh5fjlzoCl/pzb80iGS7PKGAzgcjTjadTH66bro5dfGPc0asTJHLnOlFITK1eWdJYTweOhE/0igC9LMD/FmZZe8eSFnuN3o1j1f84T9BzcMagu0bm+bQPK9qIkqcQBOWphmZhOT13BrWrMFxEPUBJvuujCmckpEx7RStdwbVKXHYfRO6K43DpcFHYbsauNlAgQefVtxVMvZVJNaz2dTzDpZYqokjOPNkS2lEw2pi0mKIY+XswZCfsVekdzCeBCGCFRmV5cFkXYCtzf3H1xnQTTgnoVU9oxuTxqGNaRbRE22XuzIXaZ7s3Xax7uc3fxoazZaNlzyfQiouHp4CIav3b5WDFBrsXbLd+s7bJla1ho7+VGET9sPk9rlXX3cafyn6mym7rqlb1faKAvTKuCPGxf9n7ZvR++peVOU83ZaD/Bh1M0UiKwL0y79DkHk4fJq6vhsWrTYy+HaD37DuvYGlY81tl9tfQWQZdnrLpYxSM6Q9o75q3rHhOOJhq7BFae8uDuIDzpWRCyJTYmxW9dtrp72B47TJY52bYi1wx2iCwPPfzTixsUVQkaEZj0Aksqnq9V//Tt9YQWRdTwOGVW2flTHe83p/ZaTp/QRpi1wqQ2U1Rz7TAZ+um0nflq7xcA7GUCsMKkj2gjHpfXU/WcirWPQNK/7aqs1bbG1b7EmSvYhDZxot7A2LqVzUm6c51qOnpr42iERkeXuCDsuWqLe2T2powRyyIsOwmFg4qZaeK4U/Xqa2EtLwPUAb1iaP62PMfO1+M+MmjGo1VeRYU9g3bQvl+rR70o1ePToLYfYAKpPURgjgddbeJBe6G5sqvE206vttuQ0F3h7hW3/dBXg9bBPmC/Hs8d5L6F7HElCzWFMdG5jgp6NuiPJrIBbO/SrqTZteJAOBufjtIphTEOTx7XcSetwWnfMUQdWCGjHY8mj1sYYdJANjITaTGhy2B+/gAOXKA2KRkAAA== | base64 -d | gunzip && sleep 5s && clear'
alias sw='telnet towel.blinkenlights.nl'
alias shruggie="echo -n '¯\_(ツ)_/¯' | xclip -selection clipboard; xclip -o -selection clipboard; echo -e '\n'"

###############################################################################
# Kubernetes
###############################################################################
export KUBE_EDITOR="nano"

# kc because reason
source <(kubectl completion zsh) programm &> /dev/null
source <(kubectl completion zsh | sed 's/kubectl/kc/g') &> /dev/null
alias kc='kubectl'

# Kube Operational view
# Multi cluster UI
alias kube-ops-view='docker run -it -p 8080:8080 -v ~/.kube:/kube hjacobs/kube-ops-view --kubeconfig-path=/kube/config'
alias ko="kube-ops-view"

###############################################################################
# Powerlevel10k
###############################################################################

# The list of segments shown on the left. Fill it with the most important segments.
typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    # =========================[ Line #1 ]=========================
    dir                     # current directory
    vcs                     # git status
    # =========================[ Line #2 ]=========================
    newline                 # \n
    prompt_char             # prompt symbol
)

typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    # =========================[ Line #1 ]=========================
    status                  # exit code of the last command
    time                    # current time
    wifi                    # wifi speed
    battery                 # internal battery
    # =========================[ Line #2 ]=========================
    newline                 # \n
    kubecontext             # current kubernetes context (https://kubernetes.io/)
    load                    # CPU load
    ram                     # free RAM
    disk_usage              # disk usage
)

POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|kc'
#typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=always
