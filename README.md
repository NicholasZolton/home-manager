# What is this?

Using the power of Nix, Home Manager allows me to easily transport all of my dotfiles and tools to any machine I want to use.

# How do I use it?

## Installing

First, you need to install [Nix](https://nixos.org/nix/download.html).

Then, you need to install [Home Manager](https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone).

## Updating

To update your machine, run the following:

```bash
home-manager switch
```

This will update all of your dotfiles to the latest version.
