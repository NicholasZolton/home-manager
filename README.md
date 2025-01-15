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
