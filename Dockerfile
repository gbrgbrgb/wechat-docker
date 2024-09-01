FROM ubuntu:24.04

ENV VNC_PASSWORD=password

RUN apt update && \
  apt install -y wget && \
  wget -c -O atzlinux-v12-archive-keyring_lastest_all.deb https://www.atzlinux.com/atzlinux/pool/main/a/atzlinux-archive-keyring/atzlinux-v12-archive-keyring_lastest_all.deb && \
  apt -y install ./atzlinux-v12-archive-keyring_lastest_all.deb && \
  apt update

RUN apt install -y xvfb xauth x11-utils fluxbox
RUN apt install -y tightvncserver
RUN apt install -y  \
  libatomic1 \
  libxkbcommon0 \
  libxkbcommon-x11-0 \
  libx11-xcb1 \
  libxcb-icccm4 \
  libxcb-image0 \
  libxcb-keysyms1 \
  libxcb-randr0 \
  libxcb-render-util0 \
  libxcb-xinerama0 \
  libxcb-xfixes0 \
  libxcb-shape0 \
  libxcb-sync1 \
  libxcb-cursor0 \
  libxcb-util1 \
  libxcb-glx0 \
  libfontconfig1 \
  libfreetype6 \
  libxi6 \
  libsm6 \
  libxrender1 \
  libpulse0 \
  libdbus-1-3 \
  libglib2.0-0 \
  libnspr4 \
  libnss3 \
  libgtk-3-0 \
  libcanberra-gtk3-module

RUN apt install -y x11vnc 

RUN apt install -y novnc

RUN apt install -y \
  fonts-zh-cn-misc-atzlinux \
  ttf-mscorefonts-atzlinux \
  fonts-lxgw-wenkai

RUN apt install -y \
  electronic-wechat-icons-atzlinux \
  com.tencent.wechat
RUN apt install -y libgbm1 libgl1 libgl1-mesa-dri mesa-vulkan-drivers iproute2

RUN apt install -y dbus dbus-x11 libdbus-glib-1-2

RUN apt install -y fcitx fcitx-googlepinyin fcitx-config-gtk

RUN apt install -y locales language-pack-zh-hans

RUN apt-get clean && \
  rm -rf /var/lib/apt/lists/*

EXPOSE 6080

COPY --chmod=0755 start.sh /tmp/start.sh

ENTRYPOINT ["/tmp/start.sh"]
