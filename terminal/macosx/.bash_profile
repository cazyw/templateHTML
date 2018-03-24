# For terminal on Mac OSX 
# ~/.bash_profile

alias brewup='brew update; brew upgrade; brew prune; brew cleanup; brew doctor'

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1/'
}

parse_symbol_arrow() {
  if git rev-parse --git-dir > /dev/null 2>&1; then
    printf '=>' 
  fi
}

parse_git_remote_branch() {
  git rev-parse --abbrev-ref --symbolic-full-name @{u} 2> /dev/null | sed -e 's/\(.*\)/\1)/'
}

PS1='\[\033]0;$TITLEPREFIX:$PWD\007\]' # set window title
PS1="$PS1"'\n'                 # new line
PS1="$PS1"'\[\033[32m\]'       # change to green
PS1="$PS1"'\u@\h '             # user@host<space>
PS1="$PS1"'\[\033[33m\]'       # change to brownish yellow
PS1="$PS1"'\w'                 # current working directory
PS1="$PS1"'\[\033[36m\]'       # change color to cyan
PS1="$PS1"" \$(parse_git_branch)" # branch (local => remote)
PS1="$PS1"" \$(parse_symbol_arrow)" # branch (local => remote)
PS1="$PS1"" \$(parse_git_remote_branch)" # branch (local => remote)
PS1="$PS1"'\[\033[0m\]'        # change color to grey
PS1="$PS1"'\n'                 # new line
PS1="$PS1"'$ '                 # prompt: always $
