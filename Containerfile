FROM ghcr.io/ublue-os/base-main:latest
RUN rpm-ostree install greetd cage kodi
COPY etc /etc
WORKDIR /
RUN git clone https://github.com/graysky2/kodi-standalone-service.git
WORKDIR kodi-standalone-service
RUN make install
RUN systemctl enable kodi-wayland.service
