FROM ghcr.io/ublue-os/base-main:latest
run rpm-ostree install rpmfusion-free-release-tainted rpmfusion-nonfree-release-tainted
RUN rpm-ostree install cage kodi kodi-inputstream-adaptive kodi-firewalld libbluray libbluray-utils libdvdcss nfs-utils samba flatpak
RUN flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
RUN flatpak install flathub tv.kodi.Kodi

# lets get kodi-inputstream-ffmpegdirect -- THIS DOESN'T WORK
# RUN rpm-ostree install fedora-packager rpmdevtools gcc
# WORKDIR /
# RUN git clone https://github.com/avibrazil/kodi-inputstream-ffmpegdirect.git
# WORKDIR kodi-inputstream-ffmpegdirect
# RUN ls .
# RUN rpmbuild kodi-inputstream-ffmpegdirect.spec 
# RUN rpm-ostree install kodi-inputstream-ffmpegdirect.rpm 
# RUN rpm-ostree remove fedora-packager rpmdevtools gcc

#RUN rpm-ostree install https://github.com/avibrazil/kodi-inputstream-ffmpegdirect/releases/download/19.0.3/kodi-inputstream-ffmpegdirect-debuginfo-19.0.3-4.fc36.x86_64.rpm
#RUN rpm-ostree install kodi-pvr-iptvsimple

# now we need to get kodi to automagically launch on boot
WORKDIR /
RUN git clone https://github.com/graysky2/kodi-standalone-service.git
WORKDIR kodi-standalone-service
RUN make install
RUN systemctl enable kodi-wayland.service
RUN systemctl enable sshd.service

RUN rm -rf /tmp /var
