# Luke Green's dotfiles

These are some pretty simple dotfile configs that get my development setup 90%
of the way there. I live in Neovim, Tmux, and Bash for all of my work, which
allows me to spin up my setup with just a few files.

If you find these useful to you, that's great, but don't count on them not to
change. In fact, count on them to change often and without warning.

Okay, if you still want to use them just clone this repo and `./setup.sh` -
theoretically that should back up any config this would normally overwrite and
install this instead.

## Customization

Don't be silly and commit sensitive keys to your bashrc - this looks for a
~/.custom.sh file to be optionally provided per-machine. You can put any env
vars you may need there so that you don't put anything you shouldn't in a public
git repo.
