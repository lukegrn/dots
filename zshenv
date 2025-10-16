export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
. "$HOME/.cargo/env"
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:~/go/bin
export PATH=$PATH:/usr/local/bin
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/Users/lukegreen/.opam/opam-init/init.zsh' ]] || source '/Users/lukegreen/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration
