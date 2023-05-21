FROM ghcr.io/ublue-os/base-main:latest
RUN rpm-ostree install cage kodi kodi-inputstream-adaptive kodi-firewalld 
#RUN rpm-ostree install https://github.com/avibrazil/kodi-inputstream-ffmpegdirect/releases/download/19.0.3/kodi-inputstream-ffmpegdirect-debuginfo-19.0.3-4.fc36.x86_64.rpm
#RUN rpm-ostree install kodi-pvr-iptvsimple

RUN git clone --branch master https://github.com/xbmc/xbmc.git
RUN git clone https://github.com/xbmc/inputstream.ffmpegdirect.git
RUN cd inputstream.ffmpegdirect && mkdir build && cd build
RUN cmake -DADDONS_TO_BUILD=inputstream.ffmpegdirect -DADDON_SRC_PREFIX=../.. -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=../../xbmc/build/addons -DPACKAGE_ZIP=1 ../../xbmc/cmake/addons
RUN make

WORKDIR /
RUN git clone https://github.com/graysky2/kodi-standalone-service.git
WORKDIR kodi-standalone-service
RUN make install
RUN systemctl enable kodi-wayland.service
RUN systemctl enable sshd.service

RUN rm -rf /tmp /var
