# An Image based HTPC

This is a silverblue-like variant distribution that's literally an imaged based fedora instalation with minimum viable kodi.

## Installation
From any silverblue/kinoite/servicea/ublue image just run this command to make your system a dedicated htpc

`` rpm-ostree rebase ostree-unverified-registry:ghcr.io/10leej/htpc:latest  ``

The image ships with NFS/SMB support (not enabled) with ssh enabled out of the box.

## Mounting network shares
It's preferabble you mount the NFS shares using systemd, I included a basic example mount file in the root of this repository you can write your own. Just remember you mount the drives in /var since /mnt is a symlink.
This is a Silverblue thing, I don't know why they do it like this myself.

## Disclaimer
This is purely for my own use, PR's are acceptable however we will not ship the questionably legal stuff that you may or may not use kodi for.

## Hardware Support
This image ships with mesa-freeworld and the intel media driver, it currently does not support nvidia since I don't own that kind of hardware.

## ToDo
- Setup Steam-link to do this we might have to change off cage for a different compositor.
- Slim the image down as much as we can for a true minimum viable kodi experience
- Consider flatpaks
- Confirm network storage and optical drive things work

## Why can't I insatll iptvsimple
The fedora package kodi-pvr-iptvsimple depends on kodi-inputstream-ffmpegdirect which is not available in either rpmfusion or fedora's repositories. I'm working on figuring out what to do about this but I'm still learning rpm-ostree here too. However the folks [at rpmfusion are aware of this](https://bugzilla.rpmfusion.org/show_bug.cgi?id=6387).
I did [fork Avi's repo](https://github.com/10leej/kodi-inputstream-ffmpegdirect) which has a src.rpm file but working on figuring out how to get it working with the github action script has been. interesting.
