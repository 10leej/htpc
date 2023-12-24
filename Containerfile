FROM ghcr.io/ublue-os/base-main:latest
run rpm-ostree install rpmfusion-free-release-tainted rpmfusion-nonfree-release-tainted
RUN rpm-ostree install cage kodi kodi-inputstream-adaptive kodi-pvr-iptvsimple kodi-firewalld nfs-utils flatpak samba

# now we need to get kodi to automagically launch on boot
WORKDIR /
# RUN rpm-ostree install make automake gcc gcc-c++ kernel-devel
# RUN git clone https://github.com/graysky2/kodi-standalone-service.git
# WORKDIR kodi-standalone-service
# RUN make install
COPY kodi-wayland.service /etc/systemd/system/kodi-wayland.service
RUN systemctl enable kodi-wayland.service
RUN systemctl enable sshd.service

# this is just for me mostly
# COPY var-mnt-media.mount /etc/systemd/system/var-mnt-media.mount
# RUN systemctl enable mnt-media.mount

RUN rm -rf /tmp /var

