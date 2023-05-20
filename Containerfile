FROM ghcr.io/ublue-os/base-main:latest
RUN rpm-ostree install greetd cage kodi
COPY etc /etc
