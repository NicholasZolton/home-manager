# What is this?

Using the power of Nix, Home Manager allows me to easily transport all of my dotfiles and tools to any machine I want to use.

# How do I use it?

## Installing

First, you need to install [Nix](https://nixos.org/nix/download.html).

Then, you need to install [Home Manager](https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone).

After that, you need to clone this repo (with submodules):

```bash
git clone --recurse-submodules https://github.com/NicholasZolton/home-manager.git ~/.config/home-manager
```

Then, make sure to create the `paths.nix` and `secrets.nix` files 

Lastly, you need to run the following:

```bash
home-manager switch
```

You should now be in a shell with all of the tools installed.

## Updating

To update your machine, run the following:

```bash
home-manager switch
```

This will update all of your dotfiles to the latest version.

In the future, you will be able to update your dotfiles by running the following:

```bash
updateh
```

# Notes and Quirks

Since I have updated this to use symlinks back to the files in this repo, you should be able to run any command as you would normally.

This could cause some merge conflicts in the future, however, so be careful.

You may have to manually switch to the zsh shell.

## Switching The Shell

Add following to your `/etc/shells`:
```txt
/home/nicholas/.nix-profile/bin/zsh
```

And then run:
```bash
chsh -s /home/nicholas/.nix-profile/bin/zsh
```

And add the following to your `~/.zprofile` if it is unable to see nix things:
```txt
if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi
```

Ghostty is not working, so I will try to fix that later. I recommend Zsh in the meantime.
