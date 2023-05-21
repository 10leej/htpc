# An Image based HTPC

This is a silverblue-like variant distribution that's literally an imaged based fedora instalation with minimum viable kodi.

## Instalation
From any silverblue/kinoite/servicea/ublue image just run this command to make your system a dedicated htpc

`` rpm-ostree rebase ostree-unverified-registry:ghcr.io/10leej/htpc:latest  ``

## Disclaimer
This is purely for my own use, PR's are acceptable however we will not ship the questionably legal stuff that you may or may not use kodi for.

## Hardware Support
This image ships with mesa-freeworld and the intel media driver, it currently does not support nvidia since I don't own that kind of hardware.

## ToDo
Setup Steam-link to do this we might have to change off cage for a different compositor.
Slim the image down as much as we can for a true minimum viable kodi experience
Consider flatpaks
Confirm network storage and optical drive things work
