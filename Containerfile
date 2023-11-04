FROM ghcr.io/ublue-os/base-main:latest
run rpm-ostree install rpmfusion-free-release-tainted rpmfusion-nonfree-release-tainted
RUN rpm-ostree install cage kodi kodi-inputstream-adaptive kodi-firewalld libbluray libbluray-utils libdvdcss nfs-utils samba flatpak autofs

# lets get kodi-inputstream-ffmpegdirect -- THIS DOESN'T WORK
#RUN rpm-ostree install fedora-packager rpmdevtools gcc cmake
#WORKDIR /
#RUN git clone https://github.com/xbmc/inputstream.ffmpegdirect.git
#RUN git clone --branch master https://github.com/xbmc/xbmc.git
#WORKDIR inputstream.ffmpegdirect
#RUN ls .
#RUN mkdir build && cd build
#RUN cmake -DADDONS_TO_BUILD=inputstream.ffmpegdirect -DADDON_SRC_PREFIX=../.. -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=../../xbmc/build/addons -DPACKAGE_ZIP=1 ../../xbmc/cmake/addons
#RUN make install

#RUN rpm-ostree install https://github.com/avibrazil/kodi-inputstream-ffmpegdirect/releases/download/19.0.3/kodi-inputstream-ffmpegdirect-debuginfo-19.0.3-4.fc36.x86_64.rpm
#RUN rpm-ostree install kodi-pvr-iptvsimple

# now we need to get kodi to automagically launch on boot
WORKDIR /
RUN git clone https://github.com/graysky2/kodi-standalone-service.git
WORKDIR kodi-standalone-service
RUN make install
RUN systemctl enable kodi-wayland.service
RUN systemctl enable sshd.service

# set the nfs share
RUN echo "media -fstpe=nfs4,rw 192.168.0.2:/mnt/media/" >> /etc/auto.nfs
RUN echo "/mnt/nfs /etc/auto.nfs --ghost --timeout=60" >> /etc/auto.master

RUN rm -rf /tmp /var

