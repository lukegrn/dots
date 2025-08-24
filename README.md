# Luke Green's dotfiles

These are some pretty simple dotfile configs that get my development setup 90%
of the way there. I live in Neovim, Tmux, and ~~Bash~~ Zsh for all of my work,
which allows me to spin up my setup with just a few files.

If you find these useful to you, that's great, but don't count on them not to
change. In fact, count on them to change often and without warning.

Okay, if you still want to use them just clone this repo and `./setup.sh` -
theoretically that should back up any config this would normally overwrite and
install this instead.

## On keybindings

In general, these are tailored to give a similar experience across my Linux
machine as work, and my personal Mac. The key to a consistent experience is
mapping some third key (I use caps lock) to command on Mac, and control on
Linux. This way I can always use caps lock when I expect to press control (or
command, but I came from Windows/Linux before Mac so control is my muscle
memory). Then, in my terminal config I rebind command _back_ to control since
those keybinds are the same across systems. Just always use caps lock and don't
worry about the nitty gritty.

## Customization

Don't be silly and commit sensitive keys to your shellrc - this looks for a
~/.custom.sh file to be optionally provided per-machine. You can put any env
vars you may need there so that you don't put anything you shouldn't in a public
git repo.
