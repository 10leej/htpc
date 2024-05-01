# An Atomic HTPC

This is a image that builds upon the [Fedora Atomic Desktops](https://fedoraproject.org/atomic-desktops/) using the core image thats actually made by [Universal Blue](https://universal-blue.org/). This project is not part of the uBlue team and I Joshua Lee am not a team member. If anything I get into debates with uBlue team memebrs since I tend to disagree with them.

## Installation
### This be important
Make sure there's a user account called "kodi" on the system with a home directory who uses BASH as the system $SHELL

`` useradd -m -s /bin/bash kodi ``

### Rebase
First remove any installed flatpaks to save some disk space saince you wont easily be able to launch them post rebase

`` flatpak remove --all``

Then from any Atomic Desktop image just run this command to make your system a dedicated htpc

`` rpm-ostree rebase ostree-unverified-registry:ghcr.io/10leej/htpc:latest  ``

## Mounting network shares
It's preferabble you mount the NFS shares using systemd, I included a basic example mount file in the root of this repository you can write your own. Just remember you mount the drives in /var since /mnt is a symlink.
This is an Atomic Desktop thing, I don't know why they do it like this myself.

Anyways you need a user with root access I'm including vim in this in case you don't want to use nano

## Extra tools included
You have htop, tmux, iftop, bmon, and vim.

## Disclaimer
This is purely for my own use, PR's are acceptable however we will not ship the questionably legal stuff that you may or may not use kodi for.

## Hardware Support
This image ships with mesa-freeworld and the intel media driver, it currently does not support nvidia since I don't own that kind of hardware.

## ToDo
- Slim the image down as much as we can for a true minimum viable kodi experience
- Optical drive support
- ISO we can install from
- Setup cockpit as a system management tool
- Give the project a more proper name
- Make this a good LibreElec Alternative as thats the current gold standard.
