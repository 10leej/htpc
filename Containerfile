FROM ghcr.io/ublue-os/base-main:latest
run rpm-ostree install rpmfusion-free-release-tainted rpmfusion-nonfree-release-tainted
RUN rpm-ostree install cage kodi kodi-inputstream-adaptive kodi-pvr-iptvsimple kodi-firewalld nfs-utils flatpak samba

# now we need to get kodi to automagically launch on boot
WORKDIR /
COPY systemd/kodi-wayland.service /etc/systemd/system/kodi-wayland.service
RUN systemctl enable kodi-wayland.service

# copy over out example nfs mount
COPY systemd/var-mnt-media.mount /etc/systemd/system/var-mnt-media.mount


RUN systemctl enable sshd.service

RUN rm -rf /tmp /var

