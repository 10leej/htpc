FROM ghcr.io/ublue-os/base-main:latest
run rpm-ostree install rpmfusion-free-release-tainted rpmfusion-nonfree-release-tainted
RUN rpm-ostree install cage kodi kodi-inputstream-adaptive kodi-firewalld libbluray libbluray-utils libdvdcss nfs-utils samba

RUN rpm-ostree install fedora-packager rpmdevtools gcc
RUN wget https://github.com/avibrazil/kodi-inputstream-ffmpegdirect/releases/download/19.0.3/kodi-inputstream-ffmpegdirect-19.0.3-4.fc36.src.rpm
RUN rpmbuild  kodi-inputstream-ffmpegdirect-19.0.3-4.fc36.src.rpm 
RUN rpm-ostree install kodi-inputstream-ffmpegdirect-19.0.3-4.fc36.rpm 
RUN rpm-ostree remove fedora-packager rpmdevtools gcc

#RUN rpm-ostree install https://github.com/avibrazil/kodi-inputstream-ffmpegdirect/releases/download/19.0.3/kodi-inputstream-ffmpegdirect-debuginfo-19.0.3-4.fc36.x86_64.rpm
#RUN rpm-ostree install kodi-pvr-iptvsimple

WORKDIR /
RUN git clone https://github.com/graysky2/kodi-standalone-service.git
WORKDIR kodi-standalone-service
RUN make install
RUN systemctl enable kodi-wayland.service
RUN systemctl enable sshd.service

RUN rm -rf /tmp /var
