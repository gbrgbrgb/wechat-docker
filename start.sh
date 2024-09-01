#!/bin/bash

# language
locale-gen zh_CN.UTF-8 > /dev/null 2>&1
export LANG=zh_CN.UTF-8
export LANGUAGE=zh_CN:en_US:en
export LC_ALL=zh_CN.UTF-8

# timezone
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
echo "Asia/Shanghai" > /etc/timezone

# display and vnc
export DISPLAY=:1
export SCREEN=0

# log
mkdir -p /tmp/log
chmod -R 777 /tmp/log

# dbus
dbus-daemon --system --fork --nosyslog --print-address > /tmp/log/dbus.log 2>&1 &

# X server
Xvfb $DISPLAY -screen $SCREEN 1920x960x24 > /tmp/log/xvfb.log 2>&1 &

# fluxbox
fluxbox > /tmp/log/fluxbox.log 2>&1 &

# fcitx
export XMODIFIERS="@im=fcitx"
export QT_IM_MODULE=fcitx
export GTK_IM_MODULE=fcitx
fcitx -d > /tmp/log/fcitx.log 2>&1 &

# x11vnc
mkdir -p /tmp/.vnc
echo $VNC_PASSWORD | vncpasswd -f > /tmp/.vnc/passwd
chmod 600 /tmp/.vnc/passwd
x11vnc -display $DISPLAY -xkb -forever -shared -rfbauth /tmp/.vnc/passwd > /tmp/log/x11vnc.log 2>&1 &

# novnc
websockify --web /usr/share/novnc 6080 localhost:5900 > /tmp/log/novnc.log 2>&1 &

# wechat
export XDG_RUNTIME_DIR=/tmp/runtime-$USER_ID
export LIBGL_ALWAYS_SOFTWARE=1
export QT_XCB_GL_INTEGRATION=xcb_glx
export GALLIUM_DRIVER=llvmpipe
export MESA_GL_VERSION_OVERRIDE=3.3
wechat > /tmp/log/wechat.log 2>&1 &

# fcitx-config
fcitx-config-gtk3 > /tmp/log/fcitx-config.log 2>&1 &

# keep container running
tail -f /dev/null