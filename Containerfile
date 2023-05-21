FROM ghcr.io/ublue-os/base-main:latest
RUN rpm-ostree install cage kodi kodi-inputstream-adaptive kodi-firewalld 
RUN rpm-ostree install https://github.com/avibrazil/kodi-inputstream-ffmpegdirect/releases/download/19.0.3/kodi-inputstream-ffmpegdirect-19.0.3-4.fc36.src.rpm
run rpm-ostree install kodi-pvr-iptvsimple
WORKDIR /
RUN git clone https://github.com/graysky2/kodi-standalone-service.git
WORKDIR kodi-standalone-service
RUN make install
RUN systemctl enable kodi-wayland.service
RUN systemctl enable sshd.service

RUN rm -rf /tmp /var
