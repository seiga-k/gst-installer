#!/bin/bash
set -e

printf "password: "
read password

srcbranch="origin/1.12"

mkdir gst
cd gst

echo "$password" | sudo -S apt install bison flex autoconf liborc*
git clone https://github.com/GStreamer/gstreamer.git
cd gstreamer
git checkout ${srcbranch}
./autogen.sh
./configure
make -j4
echo "$password" | sudo -S make install
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
cd ../

git clone https://github.com/GStreamer/gst-plugins-base.git
cd gst-plugins-base
git checkout ${srcbranch}
./autogen.sh
./configure
make -j4
echo "$password" | sudo -S make install
cd ../

echo "$password" | sudo -S apt install libjpeg-dev libvpx-dev
git clone https://github.com/GStreamer/gst-plugins-good.git
cd gst-plugins-good
git checkout ${srcbranch}
./autogen.sh
./configure
make -j4
echo "$password" | sudo -S make install
cd ../

echo "$password" | sudo -S apt install x265
git clone https://github.com/GStreamer/gst-plugins-bad.git
cd gst-plugins-bad
git checkout ${srcbranch}
./autogen.sh
./configure
make -j4
echo "$password" | sudo -S make install
cd ../

echo "$password" | sudo -S apt install libx264-dev libmpg123-dev
git clone https://github.com/GStreamer/gst-plugins-ugly.git
cd gst-plugins-ugly
git checkout ${srcbranch}
./autogen.sh
./configure
make -j4
echo "$password" | sudo -S make install
cd ../

git clone https://github.com/GStreamer/gst-libav.git
cd gst-libav
git checkout ${srcbranch}
./autogen.sh
./configure
make -j4
echo "$password" | sudo -S make install
cd ../

git clone https://anongit.freedesktop.org/git/gstreamer/gst-ffmpeg.git
cd gst-ffmpeg
git checkout ${srcbranch}
./autogen.sh
./configure
make -j4
echo "$password" | sudo -S make install
cd ../

git clone https://github.com/GStreamer/gst-rtsp-server.git
cd gst-rtsp-server
git checkout ${srcbranch}
./autogen.sh
./configure
make -j4
echo "$password" | sudo -S make install
cd ../

git clone https://github.com/GStreamer/gst-omx.git
cd gst-omx
git checkout ${srcbranch}
./autogen.sh
LIBS="$LIBS -L/usr/loca/lib" \
LDFLAGS='-L/opt/vc/lib -lGLESv2 -lbcm_host -lEGL -lm -lstdc++' \
CPPFLAGS='-I/opt/vc/include -I/opt/vc/include/IL -I/opt/vc/include/interface/vcos/pthreads -I/opt/vc/include/interface/vmcs_host/linux' \
./configure \
--with-omx-target=rpi
make -j4
echo "$password" | sudo -S make install
cd ../
