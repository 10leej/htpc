# pull in the ublue minimal image
FROM ghcr.io/ublue-os/base-main:latest
# setup rpmfusion repos
RUN rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# because kodi we need these repo packages as well
RUN rpm-ostree install rpmfusion-free-release-tainted rpmfusion-nonfree-release-tainted

# lets install the fundemental packages
RUN rpm-ostree install cage kodi kodi-inputstream-adaptive kodi-pvr-iptvsimple kodi-firewalld nfs-utils samba podman
# install some practical tools
RUN rpm-ostree install tmux vim nano
# some sysadmin tools
RUN rpm-ostree install cockpit cockpit-networkmanager cockpit-podman cockpit-storaged cockpit-files cockpit-ostree cockpit-packagekit
RUN systemctl enable cockpit.socket
# allow cockpit to not be blocked by the system firewall
RUN firewall-cmd --zone=public --add-service=cockpit

# now we need to get kodi to automagically launch on boot
WORKDIR /
COPY systemd/kodi-wayland.service /etc/systemd/system/kodi-wayland.service
# and let tell it to go
RUN systemctl enable kodi-wayland.service

# copy over out example mounts
COPY systemd/var-mnt-nfs-media.mount /etc/systemd/system/var-mnt-nfs-media.mount.example
COPY systemd/var-mnt-smb-media.mount /etc/systemd/system/var-mnt-smb-media.mount.example

# enable ssh access
RUN systemctl enable sshd.service

# yeah disable this
# # ok lets add user accounts
# 
# COPY systemd/generate-user-admin.service /etc/systemd/system/generate-user-admin.service
# COPY systemd/generate-user-kodi.service /etc/systemd/system/generate-user-kodi.service
# RUN systemctl enable generate-user-admin.service
# RUN systemctl enable generate-user-kodi.service
# 
# # lets see if restorecon can save us
# RUN restorecon -Rv /etc/systemd/system/generate-user-admin.service
# RUN restorecon -Rv /etc/systemd/system/generate-user-kodi.service

# and now thats done lets ensure the default target is graphical
RUN systemctl set-default graphical.target

# then lets cleaup after ourselves
RUN rm -rf /tmp /var
