### YOU'LL WANT TO CHANGE THIS ###
export DEFAULT_USER=dylan

### ENVIRONMENT ###
# Skip all this for non-interactive shells
[[ -z "$PS1" ]] && return
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Editor defaults to nvim
export EDITOR="nvim"
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR

# History
export SAVEHIST=15000
export HISTSIZE=15000
export HISTFILE=~/.zsh_history

# Set less options
if [[ -x $(which less 2> /dev/null) ]]
then
    export PAGER="less"
    export LESS="--ignore-case --LONG-PROMPT --QUIET --chop-long-lines -Sm --RAW-CONTROL-CHARS --quit-if-one-screen --no-init"
    export LESSHISTFILE='-'
    if [[ -x $(which lesspipe 2> /dev/null) ]]
    then
	LESSOPEN="| lesspipe %s"
	export LESSOPEN
    fi
fi

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi


# Say how long a command took, if it took more than 10 seconds
export REPORTTIME=10


### OPTIONS ###
# Option list is at http://linux.die.net/man/1/zshoptions or man zshoptions
# Opts that are on by default are explicitely set here, and marked if unchanged. Opts that are off by default are ignored.

## Directories ##

# This allows you to use popd to move back to wherever you were before.
# cd /foo; cd /bar/baz; popd; pwd; # would print /foo (assuming dirs exist)
setopt auto_pushd
# Ignore duplicate directories being pushed onto the stack (in a row)
setopt pushd_ignore_dups

## Completion ##
# Default: Key functions that list completions try to return to the last prompt if given a numeric argument.
setopt always_last_prompt
# Default: List available completions on ambiguous attempt
setopt auto_list
# Replace ~/ with /home/whoever when using completion
setopt auto_name_dirs
# Default: Show the completion menu automatically after two attempts
setopt auto_menu
# Default: Get rid of automatically added spaces in some cases
setopt auto_param_keys
# Default: Adds a slash at the end of a completed directory, instead of a space
setopt auto_param_slash
# Default: Removes a slash next to a characters it would be invalid next to (such as a semicolon)
setopt auto_remove_slash
# Prevents aliases from being automatically substituted before complete.
setopt complete_aliases
# Allows you to use glob patterns to bring up a menu (*.txt)
setopt glob_complete
# Default: Forces the command path to be hashed before a completion is attempted
setopt hash_list_all
# Default: Auto-listing behaviour only takes place when nothing would be inserted
setopt list_ambiguous
# Prevent beep when listing
unsetopt list_beep
# Try and have lists take up less space
setopt list_packed
# Default: Show filetype when listing completions
setopt list_types

## Expansion and Globbing ##
# Default: If a pattern for filename generation is badly formed, print an error message.
setopt bad_pattern
# Default: In a glob pattern, treat a trailing set of parentheses as a qualifier list, if it contains no '|', '(' or (if special) '~' characters. 
setopt bare_glob_qual
# Default: Make globbing (filename generation) sensitive to case.
setopt case_glob
# Default: Make regular expressions using the zsh/regex module (including matches with =~) sensitive to case.
setopt case_match
# Default: Perform = filename expansion.
setopt equals
# Treat the '#', '~' and '^' characters as part of patterns for filename generation, etc.
setopt extended_glob
# Default: Perform filename generation (globbing).
setopt glob
# Append a trailing '/' to all directory names resulting from filename generation (globbing).
setopt mark_dirs
# Default: Respect multibyte characters when found in strings.
setopt multibyte
# Default: If a pattern for filename generation has no matches, print an error, instead of leaving it unchanged in the argument list. 
setopt nomatch
# Default: Treat unset parameters as if they were empty when substituting.
setopt unset

## History ##
# Default: Append to history list, rather than replace it.
setopt append_history
# Default: Perform textual history expansion, treating the character '!' specially. 
setopt bang_hist
# Save timestamp with history
setopt extended_history
# Turn off beeping
unsetopt hist_beep
# When trimming history, delete duplicate lines first
setopt hist_expire_dups_first
# Ignore contiguous duplicates
setopt hist_ignore_dups
# Remove command lines from the history list when the first character on the line is a space
setopt hist_ignore_space
# Default: Don't overwrite when saving history
setopt hist_save_by_copy
# Periodically share history between shells
setopt inc_append_history

## Initialisation ##
# Default: Globalize declare, float, integer, readonly and typeset.
setopt global_export
# Default: Run /etc/zprofile, /etc/zshrc, /etc/zlogin, /etc/zlogout
setopt global_rcs
# Default: Run local dotfiles (doesn't do much of anything setting it here, but it's a default)
setopt rcs

## Input/Output ##
# Default: Expand aliases
setopt aliases
# >! to overwrite files, >>! to create files
unsetopt clobber
# Default: Output flow control via start/stop characters is enabled.
setopt flow_control
# Allow comments even in interactive shell (turning this on so copy/pasting from scripts is easier?)
setopt interactive_comments
# Default: Note the location of each command the first time it is executed.
setopt hash_cmds
# Default: Whenever a command name is hashed, hash the directory containing it, as well as all directories that occur earlier in the path.
setopt hash_dirs
# Default: Allows the short forms of for, repeat, select, if and function.
setopt short_loops

## Job Control ##
# Default: Runs background jobs at low priority
setopt bg_nice
# Default: Reports status of background jobs before exiting
setopt check_jobs
# Default: Sends HUP signal to background jobs before exiting
setopt hup
# Default: Report the status of background jobs immediately
setopt notify

## Prompting ##
# Default: Print a carriage return just before printing a prompt in the line editor.
setopt prompt_cr
# Default: Attempt to preserve a partial line (i.e. a line that did not end with a newline) that would otherwise be covered up by the command prompt due to the PROMPT_CR option.
setopt prompt_sp
# Default: If set, '%' is treated specially in prompt expansion.
setopt prompt_percent

## Scripts and Functions ##
# Hex/Octal in 0x77 style instead of 16#77, 8#77
setopt c_bases
# Default: Line numbers of expressions evaluated using the builtin eval are tracked separately of the enclosing environment
setopt eval_lineno
# Default: Without this option, commands are read and checked for syntax errors, but not executed. Can't be turned off in interactive mode.
setopt exec
# Default: When executing a shell function or sourcing a script, set $0 temporarily to the name of the function/script.
setopt function_argzero
# Default: Allow definitions of multiple functions at once in the form 'fn1 fn2...()';
setopt multi_func_def
# Default: Perform implicit tees or cats when multiple redirections are attempted
setopt multios

## Zle ##
# meep meep
unsetopt beep

### PLUGINS ###
# https://github.com/zplug/zplug
# https://github.com/unixorn/awesome-zsh-plugins

# # Setup zplug
source ~/.zplug/init.zsh

## Git ##
# Adds update_branch and merge_branch commands for git
zplug "elstgav/branch-manager"

# Adds gprune command to delete merged branches
zplug "Seinh/git-prune"


# A nicer cd that integrates with peco for fuzzy finding directories
export ENHANCD_FILTER=peco
zplug "b4b4r07/enhancd", use:init.sh

## Completions ##
# Adds extra completions for, like, everything
zplug "zsh-users/zsh-completions"

## Prompt ##
# zplug "mafredri/zsh-async", on:sindresorhus/pure
# zplug "sindresorhus/pure", use:pure.zsh
# zplug "simnalamburt/shellder"

zplug "zplug/zplug"
# Install and load plugins
if ! zplug check; then
  zplug install
fi

zplug load

# Up/Down Arrow Search History
autoload -U history-search-end

zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

[[ -n "${key[Up]}" ]] && bindkey "${key[Up]}" history-beginning-search-backward-end
[[ -n "${key[Down]}" ]] && bindkey "${key[Down]}" history-beginning-search-forward-end 
# ls colors
alias ls='ls --color=auto'
# export LS_COLORS='di=1;34:fi=0:ln=35:pi=5:so=4;31:bd=5:cd=4;33:or=41;37:mi=41;37:ex=35'
# Prompt
source ~/.config/zsh/pufflehuff.zsh-theme
# zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# VTE setup should be run each time a shell loads, for better terminal compatibility
# source /etc/profile.d/vte-2.91.sh

# Node Version Manager setup
export NVM_DIR=~/.nvm
. "$NVM_DIR/nvm.sh"
source ~/.gvm/scripts/gvm

export GIT_SSH_COMMAND='ssh -i ~/.ssh/github.key'
